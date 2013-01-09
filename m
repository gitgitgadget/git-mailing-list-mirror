From: Martin von Zweigbergk <martinvonz@gmail.com>
Subject: [PATCH 18/19] reset: allow reset on unborn branch
Date: Wed,  9 Jan 2013 00:16:15 -0800
Message-ID: <1357719376-16406-19-git-send-email-martinvonz@gmail.com>
References: <1357719376-16406-1-git-send-email-martinvonz@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Martin von Zweigbergk <martinvonz@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 09 09:25:28 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TsqyS-0003Bu-C9
	for gcvg-git-2@plane.gmane.org; Wed, 09 Jan 2013 09:25:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757349Ab3AIIZC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Jan 2013 03:25:02 -0500
Received: from mail-qa0-f74.google.com ([209.85.216.74]:57927 "EHLO
	mail-qa0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757411Ab3AIIZA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Jan 2013 03:25:00 -0500
Received: by mail-qa0-f74.google.com with SMTP id r4so88004qaq.3
        for <git@vger.kernel.org>; Wed, 09 Jan 2013 00:24:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:x-gm-message-state;
        bh=x17HSHBFgf5YO3gIv8Lr0GdZAXO687bmIPBSfPikv/E=;
        b=jjrWkG6E/G51wjHwhogk8fDKMP8151ZMc7xAA4OhtD6llAriAB7AO3R7BvBqQ7e1Y3
         Nj0yoKhYEdnfcL/V7FcVCseYGybZ81nbhUf4qpavI5oy6zksiH/cRB5xBWCSKivb5jmr
         JqQqoG7YIQFxcGg0u5CkDostxcYJB5AnB+JbrCQlhSeOpHX0TzvtSTjo0i+q3YYwNPWM
         MqwtFn3ZL+uUzlnL4Yk4EZRlW6pi+N5uFs8VLAqa3rcctR6XGe0Ja8Qoo+LkHVa5/ohu
         0jzaAdeekjvM3wFOy5qEHrMlLv3N8vvWU8i4tV7gEYbKSh6BlFUrgQ6ZwUZZKn1GLNog
         rr1g==
X-Received: by 10.236.127.144 with SMTP id d16mr34404787yhi.15.1357719426041;
        Wed, 09 Jan 2013 00:17:06 -0800 (PST)
Received: from wpzn3.hot.corp.google.com (216-239-44-65.google.com [216.239.44.65])
        by gmr-mx.google.com with ESMTPS id i27si5738038yhe.4.2013.01.09.00.17.05
        (version=TLSv1/SSLv3 cipher=AES128-SHA);
        Wed, 09 Jan 2013 00:17:06 -0800 (PST)
Received: from handduk2.mtv.corp.google.com (handduk2.mtv.corp.google.com [172.18.144.137])
	by wpzn3.hot.corp.google.com (Postfix) with ESMTP id 15161100049;
	Wed,  9 Jan 2013 00:17:05 -0800 (PST)
Received: by handduk2.mtv.corp.google.com (Postfix, from userid 151024)
	id A0282102B64; Wed,  9 Jan 2013 00:17:04 -0800 (PST)
X-Mailer: git-send-email 1.8.1.rc3.331.g1ef2165
In-Reply-To: <1357719376-16406-1-git-send-email-martinvonz@gmail.com>
X-Gm-Message-State: ALoCoQnaMFoP/k62znj+QGpDJRZL8EIgvcAdtyMtqKphAbXykaL0d1dnifCcBgGFWi66ofsfjH4nKUMPS1ZmMKE8yyly+bNQj7pVtaDrPdW/U43WGYWS+gQ0y8MaxChKOSUsm4YHs6mNZHcxZ1eQQCXj/2KPgFPfb3fbseDROEGG4wjtK5WHVGHIP9uSws3+R++fh6HpAr5b
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213049>

Some users seem to think, knowingly or not, that being on an unborn
branch is like having a commit with an empty tree checked out, but
when run on an unborn branch, "git reset" currently fails with:

  fatal: Failed to resolve 'HEAD' as a valid ref.

Instead of making users figure out that they should run

 git rm --cached -r .

, let's teach "git reset" without a revision argument, when on an
unborn branch, to behave as if the user asked to reset to an empty
tree. Don't take the analogy with an empty commit too far, though, but
still disallow explictly referring to HEAD in "git reset HEAD".
---
 builtin/reset.c                | 17 ++++++++------
 t/t7106-reset-unborn-branch.sh | 52 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 62 insertions(+), 7 deletions(-)
 create mode 100755 t/t7106-reset-unborn-branch.sh

diff --git a/builtin/reset.c b/builtin/reset.c
index 4c223bd..5cd48ac 100644
--- a/builtin/reset.c
+++ b/builtin/reset.c
@@ -239,7 +239,7 @@ static int update_refs(const char *rev, const unsigned char *sha1) {
 int cmd_reset(int argc, const char **argv, const char *prefix)
 {
 	int reset_type = NONE, update_ref_status = 0, quiet = 0;
-	int patch_mode = 0;
+	int patch_mode = 0, unborn;
 	const char *rev;
 	unsigned char sha1[20];
 	const char **pathspec = NULL;
@@ -264,8 +264,11 @@ int cmd_reset(int argc, const char **argv, const char *prefix)
 	argc = parse_options(argc, argv, prefix, options, git_reset_usage,
 						PARSE_OPT_KEEP_DASHDASH);
 	pathspec = parse_args(argc, argv, prefix, &rev);
-
-	if (!pathspec) {
+	unborn = !strcmp(rev, "HEAD") && get_sha1("HEAD", sha1);
+	if (unborn) {
+		/* reset on unborn branch: treat as reset to empty tree */
+		hashcpy(sha1, EMPTY_TREE_SHA1_BIN);
+	} else if (!pathspec) {
 		if (get_sha1_committish(rev, sha1))
 			die(_("Failed to resolve '%s' as a valid revision."), rev);
 		commit = lookup_commit_reference(sha1);
@@ -285,7 +288,7 @@ int cmd_reset(int argc, const char **argv, const char *prefix)
 	if (patch_mode) {
 		if (reset_type != NONE)
 			die(_("--patch is incompatible with --{hard,mixed,soft}"));
-		return run_add_interactive(rev, "--patch=reset", pathspec);
+		return run_add_interactive(sha1_to_hex(sha1), "--patch=reset", pathspec);
 	}
 
 	/* git reset tree [--] paths... can be used to
@@ -337,16 +340,16 @@ int cmd_reset(int argc, const char **argv, const char *prefix)
 			die(_("Could not write new index file."));
 	}
 
-	if (!pathspec) {
+	if (!pathspec && !unborn) {
 		/* Any resets without paths update HEAD to the head being
 		 * switched to, saving the previous head in ORIG_HEAD before. */
 		update_ref_status = update_refs(rev, sha1);
 
 		if (reset_type == HARD && !update_ref_status && !quiet)
 			print_new_head_line(commit);
-
-		remove_branch_state();
 	}
+	if (!pathspec)
+		remove_branch_state();
 
 	return update_ref_status;
 }
diff --git a/t/t7106-reset-unborn-branch.sh b/t/t7106-reset-unborn-branch.sh
new file mode 100755
index 0000000..4ff6af4
--- /dev/null
+++ b/t/t7106-reset-unborn-branch.sh
@@ -0,0 +1,52 @@
+#!/bin/sh
+
+test_description='git reset should work on unborn branch'
+. ./test-lib.sh
+
+test_expect_success 'setup' '
+	echo a >a &&
+	echo b >b
+'
+
+test_expect_success 'reset' '
+	git add a b &&
+	git reset &&
+	test "$(git ls-files)" == ""
+'
+
+test_expect_success 'reset HEAD' '
+	rm .git/index &&
+	git add a b &&
+	test_must_fail git reset HEAD
+'
+
+test_expect_success 'reset $file' '
+	rm .git/index &&
+	git add a b &&
+	git reset a &&
+	test "$(git ls-files)" == "b"
+'
+
+test_expect_success 'reset -p' '
+	rm .git/index &&
+	git add a &&
+	echo y | git reset -p &&
+	test "$(git ls-files)" == ""
+'
+
+test_expect_success 'reset --soft is a no-op' '
+	rm .git/index &&
+	git add a &&
+	git reset --soft
+	test "$(git ls-files)" == "a"
+'
+
+test_expect_success 'reset --hard' '
+	rm .git/index &&
+	git add a &&
+	git reset --hard &&
+	test "$(git ls-files)" == "" &&
+	test_path_is_missing a
+'
+
+test_done
-- 
1.8.1.rc3.331.g1ef2165
