From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 4/4] add: make "add -u/-A" update full tree without pathspec
 (step 3)
Date: Wed,  6 Apr 2011 18:16:36 -0700
Message-ID: <1302138996-10006-5-git-send-email-gitster@pobox.com>
References: <1302138996-10006-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 07 03:17:05 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q7dqL-0006sC-16
	for gcvg-git-2@lo.gmane.org; Thu, 07 Apr 2011 03:17:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757206Ab1DGBQz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Apr 2011 21:16:55 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:45133 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757200Ab1DGBQv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Apr 2011 21:16:51 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id AD37E4C25
	for <git@vger.kernel.org>; Wed,  6 Apr 2011 21:18:44 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=jJXZ
	8e9FbsqHq2zy0kC6LEz7RxM=; b=uwWoHzdmZohLT3vyTmfeeHmqeqFTXHEnzdQO
	GCeaxkY7jNDfuVtI2NMeWgTs1BlQsckx540fSgZdSxgmmUWFvAcPzDdgPTY0LROI
	vXjdhAn358sdF72WYJ1oUKpTUEH31JVt1WGWP32fqBYr9DVFHC+J0536NV9VGP30
	ylxIp1M=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=VnEydY
	U6PPM9Bbjr/QPCszbptDFwgYPk6JPeDLmvUPw/MfzSFLHmJ9Hjxqb5qqa0MLZTJs
	nSOPAkXRqo/FF28HijWV2cXr/RfEWjrLZrIdQy/YP2nq6J3OAc1z2pAt0m/PwC2z
	8IFEn9ljlm6zu3FAYzUtbc5eXk9+vqeczZZL0=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id A8F1F4C23
	for <git@vger.kernel.org>; Wed,  6 Apr 2011 21:18:43 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id E6E714C22 for
 <git@vger.kernel.org>; Wed,  6 Apr 2011 21:18:42 -0400 (EDT)
X-Mailer: git-send-email 1.7.5.rc1
In-Reply-To: <1302138996-10006-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: FA9A5DE8-60B4-11E0-96FC-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171037>

Now long after 1.8.0 happened, people should have got used to the
new default behaviour and it is no longer necessary to give the
migration advice anymore.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/add.c         |   23 +----------------------
 t/t2200-add-update.sh |    4 +---
 2 files changed, 2 insertions(+), 25 deletions(-)

diff --git a/builtin/add.c b/builtin/add.c
index 6e6cdc0..3564d7e 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -359,24 +359,6 @@ static int add_files(struct dir_struct *dir, int flags)
 	return exit_status;
 }
 
-static const char *warn_add_uA_180_migration_msg[] = {
-	"Since release 1.8.0, running 'git add -u' (or 'git add -A')",
-	"from a subdirectory without giving any pathspec takes effect",
-	"on the whole working tree, not just the part under the current",
-	"directory. Please make it a habit to add '.' when you want to",
-	"limit the operation to the current directory and below.",
-	"You can use ':/' at the end of the command to affect the operation",
-	"on the whole working tree, if you want to be explicit.",
-};
-
-static int warn_180_migration(void)
-{
-	int i;
-	for (i = 0; i < ARRAY_SIZE(warn_add_uA_180_migration_msg); i++)
-		warning("%s", warn_add_uA_180_migration_msg[i]);
-	return 1; /* default to "true" (tree-wide, i.e. not local) */
-}
-
 int cmd_add(int argc, const char **argv, const char *prefix)
 {
 	int exit_status = 0;
@@ -407,11 +389,8 @@ int cmd_add(int argc, const char **argv, const char *prefix)
 		die("-A and -u are mutually incompatible");
 	if (!show_only && ignore_missing)
 		die("Option --ignore-missing can only be used together with --dry-run");
-	if ((addremove || take_worktree_changes) && !argc) {
+	if ((addremove || take_worktree_changes) && !argc)
 		whole_tree_add = 1;
-		if (prefix)
-			whole_tree_add = warn_180_migration();
-	}
 
 	add_new_files = !take_worktree_changes && !refresh_only;
 	require_pathspec = !take_worktree_changes;
diff --git a/t/t2200-add-update.sh b/t/t2200-add-update.sh
index a601394..3ad6bff 100755
--- a/t/t2200-add-update.sh
+++ b/t/t2200-add-update.sh
@@ -81,8 +81,6 @@ test_expect_success 'change gets noticed' '
 '
 
 test_expect_success 'update from a subdirectory without pathspec' '
-	# This test needs to be updated to expect the whole tree
-	# update after 1.8.0 migration.
 	test_might_fail git reset check dir1 &&
 	echo changed >check &&
 	(
@@ -93,7 +91,7 @@ test_expect_success 'update from a subdirectory without pathspec' '
 	git diff-files --name-only dir1 check >actual &&
 	: >expect &&
 	test_cmp expect actual &&
-	grep warning expect.warning
+	! grep warning expect.warning
 '
 
 test_expect_success 'update from a subdirectory with local pathspec' '
-- 
1.7.5.rc1
