From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] add: make "add -u/-A" update full tree without pathspec
Date: Tue, 22 Mar 2011 17:02:32 -0700
Message-ID: <7vtyeuiu07.fsf@alter.siamese.dyndns.org>
References: <7vy649vah1.fsf@alter.siamese.dyndns.org>
 <7vtyexv6wl.fsf@alter.siamese.dyndns.org>
 <7vpqplv65o.fsf@alter.siamese.dyndns.org> <vpqlj09a303.fsf@bauges.imag.fr>
 <7vhbaxuyk7.fsf@alter.siamese.dyndns.org>
 <20110321111643.GE16334@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Mar 23 01:03:29 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q2BXt-0001EH-3R
	for gcvg-git-2@lo.gmane.org; Wed, 23 Mar 2011 01:03:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755999Ab1CWACp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Mar 2011 20:02:45 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:63064 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755970Ab1CWACn (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Mar 2011 20:02:43 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 9F0DA44BF;
	Tue, 22 Mar 2011 20:04:23 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=PYjmnaG93geesqmU51pKtqPNr14=; b=jZf/8DG/DU2R9NPvSGTE
	mw6KK46ik34M1WGTt6gA9O995k3Y3YdRjaW4lZGmv1SyCqFIJTBg1DBqzymKj1oV
	b33TBhEUmLBpqQ3lm3fb8akH6dLNMRc1bicevStIGwre892yuZUxVhXRxFe+MD33
	BEz8f8SkSnQrGP2kLcX+U1U=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=PWkpb6URRhWTgHtHHSNrRD1SCPFTiR4SwGpoPmnsIOloVS
	yXgYmEFgcLcgYdL/9FbFipg7aJMKo27JGvFVFYZ2ilaEy4LzvGgUazpbSiattO+V
	sE9nY+gv/7kWpsd2hg/wDlHIV3p2lyInl7AjRrl6Zld6PSWPm8jN1/bX8og20=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 6B45444B7;
	Tue, 22 Mar 2011 20:04:19 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id D4A8344A9; Tue, 22 Mar 2011
 20:04:14 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 1980A5A8-54E1-11E0-8BFB-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169788>

When -u was introduced in dfdac5d (git-add -u: match the index with
working tree., 2007-04-20), "add -u" (without pathspec) added
everything. Shortly after, 2ed2c22 (git-add -u paths... now works from
subdirectory, 2007-08-16) broke it while fixing something related.

This makes -u and -A inconsistent with some other options, namely -p.
It's been four years since the unintentional breakage and people are
probably used to "git add -u" updating only current directory.

Let's plan in 1.8.0 to change its behaviour in such a way that does
not hurt existing users too badly during the transition period.

 - A new add.treewideupdate configuration variable can be set to
   "true" to make "add -u/-A" that is ran without any pathspec from
   a subdirectory to affect the whole tree.  When the variable is
   set to "false", the operation is limited to the current working
   directory.

 - Missing configuration variable means the same thing as setting it
   to "false" for now, but the user will be given a warning about
   the transition plan, and an advise to either set the variable or
   to say "."

 - In 1.8.0, the warning message needs to be rephrased, the added
   test needs to be updated, and the default value for the variable
   needs to be flipped to "true".  In a few releases after that, we
   would remove the warning message.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * So how about an alternative with a bit saner migration path?
   The message would need rewording, though.

 builtin/add.c         |   47 ++++++++++++++++++++++++++++++++++++++++++-----
 t/t2200-add-update.sh |   49 +++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 91 insertions(+), 5 deletions(-)

diff --git a/builtin/add.c b/builtin/add.c
index e127d5a..595f5cc 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -310,6 +310,7 @@ static const char ignore_error[] =
 
 static int verbose = 0, show_only = 0, ignored_too = 0, refresh_only = 0;
 static int ignore_add_errors, addremove, intent_to_add, ignore_missing = 0;
+static int default_tree_wide_update = -1;
 
 static struct option builtin_add_options[] = {
 	OPT__DRY_RUN(&show_only, "dry run"),
@@ -335,6 +336,10 @@ static int add_config(const char *var, const char *value, void *cb)
 		ignore_add_errors = git_config_bool(var, value);
 		return 0;
 	}
+	if (!strcasecmp(var, "add.treewideupdate")) {
+		default_tree_wide_update = git_config_bool(var, value);
+		return 0;
+	}
 	return git_default_config(var, value, cb);
 }
 
@@ -359,6 +364,29 @@ static int add_files(struct dir_struct *dir, int flags)
 	return exit_status;
 }
 
+static const char *warn_add_uA_180_migration_msg[] = {
+	"In release 1.8.0, running 'git add -u' (or 'git add -A') from",
+	"a subdirectory without giving any pathspec WILL take effect",
+	"on the whole working tree, not just the part under the current",
+	"directory. You can set add.treewideupdate configuration variable",
+	"to 'false' to keep the current behaviour.",
+	"You can set the configuration variable to 'true' to make the",
+	"'git add -u/-A' command without pathspec take effect on the whole",
+	"working tree now. If you do so, you can use '.' at the end of",
+	"the command, e.g. 'git add -u .' when you want to limit the",
+	"operation to the current directory.",
+	"This warning will be issued until you set the configuration variable",
+	"to either 'true' or 'false'."
+};
+
+static int warn_180_migration(void)
+{
+	int i;
+	for (i = 0; i < ARRAY_SIZE(warn_add_uA_180_migration_msg); i++)
+		warning("%s", warn_add_uA_180_migration_msg[i]);
+	return 0; /* default to "no" (not tree-wide, i.e. local) */
+}
+
 int cmd_add(int argc, const char **argv, const char *prefix)
 {
 	int exit_status = 0;
@@ -368,6 +396,7 @@ int cmd_add(int argc, const char **argv, const char *prefix)
 	int flags;
 	int add_new_files;
 	int require_pathspec;
+	int whole_tree_add = 0;
 	char *seen = NULL;
 
 	git_config(add_config, NULL);
@@ -389,9 +418,13 @@ int cmd_add(int argc, const char **argv, const char *prefix)
 	if (!show_only && ignore_missing)
 		die("Option --ignore-missing can only be used together with --dry-run");
 	if ((addremove || take_worktree_changes) && !argc) {
-		static const char *here[2] = { ".", NULL };
-		argc = 1;
-		argv = here;
+		whole_tree_add = 1;
+		if (prefix) {
+			if (default_tree_wide_update < 0)
+				default_tree_wide_update = warn_180_migration();
+			if (!default_tree_wide_update)
+				whole_tree_add = 0;
+		}
 	}
 
 	add_new_files = !take_worktree_changes && !refresh_only;
@@ -406,12 +439,16 @@ int cmd_add(int argc, const char **argv, const char *prefix)
 		 (!(addremove || take_worktree_changes)
 		  ? ADD_CACHE_IGNORE_REMOVAL : 0));
 
-	if (require_pathspec && argc == 0) {
+	if (require_pathspec && !(argc || whole_tree_add)) {
 		fprintf(stderr, "Nothing specified, nothing added.\n");
 		fprintf(stderr, "Maybe you wanted to say 'git add .'?\n");
 		return 0;
 	}
-	pathspec = validate_pathspec(argc, argv, prefix);
+
+	if (whole_tree_add)
+		pathspec = NULL;
+	else
+		pathspec = validate_pathspec(argc, argv, prefix);
 
 	if (read_cache() < 0)
 		die("index file corrupt");
diff --git a/t/t2200-add-update.sh b/t/t2200-add-update.sh
index 0692427..7ac8b70 100755
--- a/t/t2200-add-update.sh
+++ b/t/t2200-add-update.sh
@@ -80,6 +80,55 @@ test_expect_success 'change gets noticed' '
 
 '
 
+test_expect_success 'update from a subdirectory without pathspec (no config)' '
+	# This test needs to be updated to expect the whole tree
+	# update after 1.8.0 migration.
+	test_might_fail git config --remove add.treewideupdate &&
+	test_might_fail git reset check dir1 &&
+	echo changed >check &&
+	(
+		cd dir1 &&
+		echo even more >sub2 &&
+		git add -u 2>../expect.warning
+	) &&
+	git diff-files --name-only dir1 check >actual &&
+	echo check >expect &&
+	test_cmp expect actual &&
+	grep warning expect.warning
+'
+
+test_expect_success 'update from a subdirectory without pathspec (local)' '
+	test_when_finished "git config --remove add.treewideupdate; :" &&
+	git config add.treewideupdate false &&
+	test_might_fail git reset check dir1 &&
+	echo changed >check &&
+	(
+		cd dir1 &&
+		echo even more >sub2 &&
+		git add -u 2>../expect.warning
+	) &&
+	git diff-files --name-only dir1 check >actual &&
+	echo check >expect &&
+	test_cmp expect actual &&
+	! grep warning expect.warning
+'
+
+test_expect_success 'update from a subdirectory without pathspec (global)' '
+	test_when_finished "git config --remove add.treewideupdate; :" &&
+	git config add.treewideupdate true &&
+	test_might_fail git reset check dir1 &&
+	echo changed >check &&
+	(
+		cd dir1 &&
+		echo even more >sub2 &&
+		git add -u 2>../expect.warning
+	) &&
+	git diff-files --name-only dir1 check >actual &&
+	: >expect &&
+	test_cmp expect actual &&
+	! grep warning expect.warning
+'
+
 test_expect_success SYMLINKS 'replace a file with a symlink' '
 
 	rm foo &&
-- 
1.7.4.1.559.ga7cf60f
