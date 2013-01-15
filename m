From: Martin von Zweigbergk <martinvonz@gmail.com>
Subject: [PATCH v2 18/19] reset: allow reset on unborn branch
Date: Mon, 14 Jan 2013 21:47:50 -0800
Message-ID: <1358228871-7142-19-git-send-email-martinvonz@gmail.com>
References: <1357719376-16406-1-git-send-email-martinvonz@gmail.com>
 <1358228871-7142-1-git-send-email-martinvonz@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Matt Kraai <kraai@ftbfs.org>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	Duy Nguyen <pclouds@gmail.com>, Jeff King <peff@peff.net>,
	Martin von Zweigbergk <martinvonz@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 15 06:49:23 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TuzOe-0007Y3-EV
	for gcvg-git-2@plane.gmane.org; Tue, 15 Jan 2013 06:49:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755885Ab3AOFso (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Jan 2013 00:48:44 -0500
Received: from mail-ye0-f201.google.com ([209.85.213.201]:43447 "EHLO
	mail-ye0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755725Ab3AOFs2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Jan 2013 00:48:28 -0500
Received: by mail-ye0-f201.google.com with SMTP id r11so588151yen.2
        for <git@vger.kernel.org>; Mon, 14 Jan 2013 21:48:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:x-gm-message-state;
        bh=BM9ET+pjyJWxHU5eXMocpyytBCMGr+2KnfBASvA7aCw=;
        b=JlesK3+t4FnHymLDoqywMuMY35Jij7f8p4Hcj6nyV6Uk8pJWLj6wgaxNY23HfTjVTd
         B2rOK+hM3db6okd7mUZQOOEkz2se9z0PUNaoEvJQadJcufxZe81R6EfDSySJDsHrIhmH
         90hKWVZ41mYisbSfmolKkWludkd37GVKav3qIELSvkILi/N6CFUAli3Ifv0C0/FpIcQL
         MFEb1C/ped/OjiSk/EhBZarst/R68sVoRszE5/KNH+cDjbIn23cqIgTJwOTvRokGaJXU
         BGylf0SHBYlpK36RobylRyUo9vJzRoM6UNHDjSuxx1fc39lKNqZQiojXv8BLaSo1E0R9
         86MA==
X-Received: by 10.236.69.101 with SMTP id m65mr48831106yhd.27.1358228907249;
        Mon, 14 Jan 2013 21:48:27 -0800 (PST)
Received: from wpzn4.hot.corp.google.com (216-239-44-65.google.com [216.239.44.65])
        by gmr-mx.google.com with ESMTPS id a24si819308yhi.0.2013.01.14.21.48.27
        (version=TLSv1 cipher=AES128-SHA bits=128/128);
        Mon, 14 Jan 2013 21:48:27 -0800 (PST)
Received: from handduk2.mtv.corp.google.com (handduk2.mtv.corp.google.com [172.18.144.137])
	by wpzn4.hot.corp.google.com (Postfix) with ESMTP id 075BD820050;
	Mon, 14 Jan 2013 21:48:27 -0800 (PST)
Received: by handduk2.mtv.corp.google.com (Postfix, from userid 151024)
	id D7E28101779; Mon, 14 Jan 2013 21:48:26 -0800 (PST)
X-Mailer: git-send-email 1.8.1.1.454.gce43f05
In-Reply-To: <1358228871-7142-1-git-send-email-martinvonz@gmail.com>
X-Gm-Message-State: ALoCoQn8erJ1S8cIlQe6+ingKk+lwWuR7E0w778QEBnMS+1xjCPoKXGljs9tKbEFnHXfQPjcAx9BbYjsDjqghSp9ydiJzPqnyGH1gbqEK2P/wx2T0nIurgi0kGY7IvGMHkeCrFXl6Sv9IdpFFQXtWgzjumB5meF8y4vMuyzazzE+JLKQ9tapTgJ5ivvLpH+umyQwdslnrWOT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213585>

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

Signed-off-by: Martin von Zweigbergk <martinvonz@gmail.com>
---
 builtin/reset.c                | 16 ++++++++-----
 t/t7106-reset-unborn-branch.sh | 52 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 62 insertions(+), 6 deletions(-)
 create mode 100755 t/t7106-reset-unborn-branch.sh

diff --git a/builtin/reset.c b/builtin/reset.c
index b776867..45b01eb 100644
--- a/builtin/reset.c
+++ b/builtin/reset.c
@@ -240,7 +240,7 @@ static int update_refs(const char *rev, const unsigned char *sha1)
 int cmd_reset(int argc, const char **argv, const char *prefix)
 {
 	int reset_type = NONE, update_ref_status = 0, quiet = 0;
-	int patch_mode = 0;
+	int patch_mode = 0, unborn;
 	const char *rev;
 	unsigned char sha1[20];
 	const char **pathspec = NULL;
@@ -265,7 +265,11 @@ int cmd_reset(int argc, const char **argv, const char *prefix)
 						PARSE_OPT_KEEP_DASHDASH);
 	pathspec = parse_args(argv, prefix, &rev);
 
-	if (!pathspec) {
+	unborn = !strcmp(rev, "HEAD") && get_sha1("HEAD", sha1);
+	if (unborn) {
+		/* reset on unborn branch: treat as reset to empty tree */
+		hashcpy(sha1, EMPTY_TREE_SHA1_BIN);
+	} else if (!pathspec) {
 		struct commit *commit;
 		if (get_sha1_committish(rev, sha1))
 			die(_("Failed to resolve '%s' as a valid revision."), rev);
@@ -286,7 +290,7 @@ int cmd_reset(int argc, const char **argv, const char *prefix)
 	if (patch_mode) {
 		if (reset_type != NONE)
 			die(_("--patch is incompatible with --{hard,mixed,soft}"));
-		return run_add_interactive(rev, "--patch=reset", pathspec);
+		return run_add_interactive(sha1_to_hex(sha1), "--patch=reset", pathspec);
 	}
 
 	/* git reset tree [--] paths... can be used to
@@ -340,16 +344,16 @@ int cmd_reset(int argc, const char **argv, const char *prefix)
 			die(_("Could not write new index file."));
 	}
 
-	if (!pathspec) {
+	if (!pathspec && !unborn) {
 		/* Any resets without paths update HEAD to the head being
 		 * switched to, saving the previous head in ORIG_HEAD before. */
 		update_ref_status = update_refs(rev, sha1);
 
 		if (reset_type == HARD && !update_ref_status && !quiet)
 			print_new_head_line(lookup_commit_reference(sha1));
-
-		remove_branch_state();
 	}
+	if (!pathspec)
+		remove_branch_state();
 
 	return update_ref_status;
 }
diff --git a/t/t7106-reset-unborn-branch.sh b/t/t7106-reset-unborn-branch.sh
new file mode 100755
index 0000000..8062cf5
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
+	test "$(git ls-files)" = ""
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
+	test "$(git ls-files)" = "b"
+'
+
+test_expect_success 'reset -p' '
+	rm .git/index &&
+	git add a &&
+	echo y | git reset -p &&
+	test "$(git ls-files)" = ""
+'
+
+test_expect_success 'reset --soft is a no-op' '
+	rm .git/index &&
+	git add a &&
+	git reset --soft
+	test "$(git ls-files)" = "a"
+'
+
+test_expect_success 'reset --hard' '
+	rm .git/index &&
+	git add a &&
+	git reset --hard &&
+	test "$(git ls-files)" = "" &&
+	test_path_is_missing a
+'
+
+test_done
-- 
1.8.1.1.454.gce43f05
