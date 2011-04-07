From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 2/4] add -u: get rid of "treewideupdate" configuration
Date: Wed,  6 Apr 2011 18:16:34 -0700
Message-ID: <1302138996-10006-3-git-send-email-gitster@pobox.com>
References: <1302138996-10006-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 07 03:17:04 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q7dqJ-0006sC-NV
	for gcvg-git-2@lo.gmane.org; Thu, 07 Apr 2011 03:17:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757194Ab1DGBQr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Apr 2011 21:16:47 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:45029 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756123Ab1DGBQq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Apr 2011 21:16:46 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id C7A844C1D
	for <git@vger.kernel.org>; Wed,  6 Apr 2011 21:18:39 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=BBgH
	gE/YUZ8InxuZ2A/fmA+4EDM=; b=gK0EnmVcuIpJulYVtFXVuBlktcmkHuA4skXt
	UpcA1sHcE1cagpdaeo9ejNFG4yQo4gsbuKXyz5wltH22ilYd8y87mJNKwsNBZc+V
	ayiWfkSaC5jXQ+WWFCJvZ67BL69Rba6Ms/qIxyy+/T2BnbVJKAFjp0zI6ldHg8tw
	M2ysWiU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=UyJqvg
	1tCXtJF32NEb641oRZO7Q8WTgz5Wb9hdnezLLpofCm/bBfEScm74jh+SWwLH6UJu
	u4ls6ceJWkPv5lXv0t2Rsq7L3z6zDLLeWxIGiqQSAlVOZiMTCHBX2ZQAobbGsaYq
	8M3o6Zi6uyABSJYe7XAD8V4z5g/Fis1h9klJw=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id C509D4C1C
	for <git@vger.kernel.org>; Wed,  6 Apr 2011 21:18:38 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id CC4184C1B for
 <git@vger.kernel.org>; Wed,  6 Apr 2011 21:18:37 -0400 (EDT)
X-Mailer: git-send-email 1.7.5.rc1
In-Reply-To: <1302138996-10006-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: F7B446AC-60B4-11E0-8995-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171038>

Thanks to the magic ":/" pathspec, it is much easier to invoke both
tree-wide operation and limited-to-cwd operation on demand from the
command line.  What remains is the downside of the configuration variable,
namely, that it makes git behave differently depending on who you are and
in which repository you are using it, hence making it harder to help
and/or teach others.

Remove the configuration variable, and adjust the warning message.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/add.c         |   26 ++++++--------------------
 t/t2200-add-update.sh |   29 +++++++++++++++++++----------
 2 files changed, 25 insertions(+), 30 deletions(-)

diff --git a/builtin/add.c b/builtin/add.c
index 595f5cc..f58d1cf 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -310,7 +310,6 @@ static const char ignore_error[] =
 
 static int verbose = 0, show_only = 0, ignored_too = 0, refresh_only = 0;
 static int ignore_add_errors, addremove, intent_to_add, ignore_missing = 0;
-static int default_tree_wide_update = -1;
 
 static struct option builtin_add_options[] = {
 	OPT__DRY_RUN(&show_only, "dry run"),
@@ -336,10 +335,6 @@ static int add_config(const char *var, const char *value, void *cb)
 		ignore_add_errors = git_config_bool(var, value);
 		return 0;
 	}
-	if (!strcasecmp(var, "add.treewideupdate")) {
-		default_tree_wide_update = git_config_bool(var, value);
-		return 0;
-	}
 	return git_default_config(var, value, cb);
 }
 
@@ -368,15 +363,10 @@ static const char *warn_add_uA_180_migration_msg[] = {
 	"In release 1.8.0, running 'git add -u' (or 'git add -A') from",
 	"a subdirectory without giving any pathspec WILL take effect",
 	"on the whole working tree, not just the part under the current",
-	"directory. You can set add.treewideupdate configuration variable",
-	"to 'false' to keep the current behaviour.",
-	"You can set the configuration variable to 'true' to make the",
-	"'git add -u/-A' command without pathspec take effect on the whole",
-	"working tree now. If you do so, you can use '.' at the end of",
-	"the command, e.g. 'git add -u .' when you want to limit the",
-	"operation to the current directory.",
-	"This warning will be issued until you set the configuration variable",
-	"to either 'true' or 'false'."
+	"directory. Please make it a habit to add '.' when you want to",
+	"limit the operation to the current directory and below.",
+	"You can use ':/' at the end of the command to affect the operation",
+	"on the whole working tree.",
 };
 
 static int warn_180_migration(void)
@@ -419,12 +409,8 @@ int cmd_add(int argc, const char **argv, const char *prefix)
 		die("Option --ignore-missing can only be used together with --dry-run");
 	if ((addremove || take_worktree_changes) && !argc) {
 		whole_tree_add = 1;
-		if (prefix) {
-			if (default_tree_wide_update < 0)
-				default_tree_wide_update = warn_180_migration();
-			if (!default_tree_wide_update)
-				whole_tree_add = 0;
-		}
+		if (prefix)
+			whole_tree_add = warn_180_migration();
 	}
 
 	add_new_files = !take_worktree_changes && !refresh_only;
diff --git a/t/t2200-add-update.sh b/t/t2200-add-update.sh
index 7ac8b70..f7711ba 100755
--- a/t/t2200-add-update.sh
+++ b/t/t2200-add-update.sh
@@ -80,10 +80,9 @@ test_expect_success 'change gets noticed' '
 
 '
 
-test_expect_success 'update from a subdirectory without pathspec (no config)' '
+test_expect_success 'update from a subdirectory without pathspec' '
 	# This test needs to be updated to expect the whole tree
 	# update after 1.8.0 migration.
-	test_might_fail git config --remove add.treewideupdate &&
 	test_might_fail git reset check dir1 &&
 	echo changed >check &&
 	(
@@ -97,15 +96,13 @@ test_expect_success 'update from a subdirectory without pathspec (no config)' '
 	grep warning expect.warning
 '
 
-test_expect_success 'update from a subdirectory without pathspec (local)' '
-	test_when_finished "git config --remove add.treewideupdate; :" &&
-	git config add.treewideupdate false &&
+test_expect_success 'update from a subdirectory with local pathspec' '
 	test_might_fail git reset check dir1 &&
 	echo changed >check &&
 	(
 		cd dir1 &&
 		echo even more >sub2 &&
-		git add -u 2>../expect.warning
+		git add -u . 2>../expect.warning
 	) &&
 	git diff-files --name-only dir1 check >actual &&
 	echo check >expect &&
@@ -113,15 +110,27 @@ test_expect_success 'update from a subdirectory without pathspec (local)' '
 	! grep warning expect.warning
 '
 
-test_expect_success 'update from a subdirectory without pathspec (global)' '
-	test_when_finished "git config --remove add.treewideupdate; :" &&
-	git config add.treewideupdate true &&
+test_expect_success 'update from a subdirectory with magic pathspec (mnemonic)' '
 	test_might_fail git reset check dir1 &&
 	echo changed >check &&
 	(
 		cd dir1 &&
 		echo even more >sub2 &&
-		git add -u 2>../expect.warning
+		git add -u :/ 2>../expect.warning
+	) &&
+	git diff-files --name-only dir1 check >actual &&
+	: >expect &&
+	test_cmp expect actual &&
+	! grep warning expect.warning
+'
+
+test_expect_success 'update from a subdirectory with magic pathspec (longhand)' '
+	test_might_fail git reset check dir1 &&
+	echo changed >check &&
+	(
+		cd dir1 &&
+		echo even more >sub2 &&
+		git add -u ":(top)" 2>../expect.warning
 	) &&
 	git diff-files --name-only dir1 check >actual &&
 	: >expect &&
-- 
1.7.5.rc1
