From: Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 00/20] rid git-checkout of too-intimate knowledge of new worktree
Date: Thu, 16 Jul 2015 04:20:05 -0400
Message-ID: <1437034825-32054-1-git-send-email-sunshine@sunshineco.com>
Cc: Junio C Hamano <gitster@pobox.com>, Duy Nguyen <pclouds@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Eric Sunshine <sunshine@sunshineco.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 16 10:22:25 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZFeQy-0000Py-CC
	for gcvg-git-2@plane.gmane.org; Thu, 16 Jul 2015 10:22:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753789AbbGPIUx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Jul 2015 04:20:53 -0400
Received: from mail-ig0-f182.google.com ([209.85.213.182]:33308 "EHLO
	mail-ig0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751411AbbGPIUs (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Jul 2015 04:20:48 -0400
Received: by iggp10 with SMTP id p10so8070711igg.0
        for <git@vger.kernel.org>; Thu, 16 Jul 2015 01:20:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id;
        bh=tZTAOyC/Q5NeJ35vitkBc3TvWNlApelu+uJ+n92GSOY=;
        b=PNpHJ7PuiWvORPaWT6fVQN67RQg+OV8SwPg99UX0c+8fX1lWWYiE+EiCrLIq0DWSxl
         kQQy5Vynp/huwO2hNwHxUKv5qTx5CLsTWe3LOqRbRjOgHWrNt9LC7qppi+7LlC6ooU2N
         TLHT3ipqLMAzTidC6KcHm+82n+PL6QLZ4dH0QGeLhpkYWzcsljwWJMPtOib7dBqzu5tm
         JHV1loOcK6JxP0I+nAsNOBHpPiqf909N9D+Z/uV+M7VtSd8MVPW33jxLOE48vdjAThK0
         BJ9B4o6wBD78LjYZwCKftOCoc+qMH2riph/Yy/K6H/RJkKMU+bf5PIcXZP9CIqsbE3oU
         of3Q==
X-Received: by 10.107.134.96 with SMTP id i93mr10027042iod.139.1437034848110;
        Thu, 16 Jul 2015 01:20:48 -0700 (PDT)
Received: from localhost.localdomain (user-12l3cpl.cable.mindspring.com. [69.81.179.53])
        by smtp.gmail.com with ESMTPSA id j83sm4581146iod.25.2015.07.16.01.20.47
        (version=TLSv1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 16 Jul 2015 01:20:47 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.rc2.378.g0af52e8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274024>

This is v2 of [1] which rids git-checkout of the need to have
specialized knowledge that it's operating in a newly created linked
worktree, and decouples git-worktree from git-checkout. Thanks to Duy
and Junio for reviews.

A v1 to v2 interdiff is included below.

Changes since v1:

* patch 03/20: relocate from caller to callee a comment explaining why
  check_linked_checkout() resolves HEAD manually[2]

* patch 06/20 (new): drop "/.git" from "'blorp' already checked out at
  '/foo/bar/.git'" diagnostic[3]

* patch 07/20 & 08/20 (new): teach checked_linked_checkout() about
  symbolic-link HEAD[2] (to augment its existing symref-style HEAD
  knowledge)

* patch 14/20 (new): take advantage of 'struct child_process.env' to
  make it obvious that assigned environment variables are intended for
  child process invocations[2]

* patch 16/20: side-step potential problem with future pluggable
  backends answering ref_exists() incorrectly from cached information
  after we've invoked git-branch behind their backs[4,5], and add a few
  in-code comments explaining the logic

* reword several commit messages to avoid stressing "git reset --hard"
  as endgame, and instead emphasize removal of specialized worktree
  creation knowledge from git-checkout[2], and resolve conflation of new
  branch creation, setting of worktree HEAD, and new worktree
  population.

[1]: http://thread.gmane.org/gmane.comp.version-control.git/273856
[2]: http://article.gmane.org/gmane.comp.version-control.git/273921
[3]: http://thread.gmane.org/gmane.comp.version-control.git/274001
[4]: http://article.gmane.org/gmane.comp.version-control.git/273885
[5]: http://article.gmane.org/gmane.comp.version-control.git/273901

Eric Sunshine (20):
  checkout: avoid resolving HEAD unnecessarily
  checkout: name check_linked_checkouts() more meaningfully
  checkout: improve die_if_checked_out() robustness
  checkout: die_if_checked_out: simplify strbuf management
  checkout: generalize die_if_checked_out() branch name argument
  checkout: check_linked_checkout: improve "already checked out"
    aesthetic
  checkout: check_linked_checkout: simplify symref parsing
  checkout: teach check_linked_checkout() about symbolic link HEAD
  branch: publish die_if_checked_out()
  worktree: simplify new branch (-b/-B) option checking
  worktree: introduce options container
  worktree: make --detach mutually exclusive with -b/-B
  worktree: make branch creation distinct from worktree population
  worktree: elucidate environment variables intended for child processes
  worktree: add_worktree: construct worktree-population command locally
  worktree: detect branch-name/detached and error conditions locally
  worktree: make setup of new HEAD distinct from worktree population
  worktree: avoid resolving HEAD unnecessarily
  worktree: populate via "git reset --hard" rather than "git checkout"
  checkout: drop intimate knowledge of newly created worktree

 branch.c                |  67 +++++++++++++++++++++++++++
 branch.h                |   7 +++
 builtin/checkout.c      |  82 +++------------------------------
 builtin/worktree.c      | 120 ++++++++++++++++++++++++++++++++----------------
 t/t2025-worktree-add.sh |   8 ++++
 5 files changed, 169 insertions(+), 115 deletions(-)

-- 
2.5.0.rc2.378.g0af52e8


---- 8< ----
diff --git a/branch.c b/branch.c
index 7b8b9a3..dfd7698 100644
--- a/branch.c
+++ b/branch.c
@@ -315,22 +315,28 @@ static void check_linked_checkout(const char *branch, const char *id)
 	struct strbuf sb = STRBUF_INIT;
 	struct strbuf path = STRBUF_INIT;
 	struct strbuf gitdir = STRBUF_INIT;
-	const char *start, *end;
 
+	/*
+	 * $GIT_COMMON_DIR/HEAD is practically outside
+	 * $GIT_DIR so resolve_ref_unsafe() won't work (it
+	 * uses git_path). Parse the ref ourselves.
+	 */
 	if (id)
 		strbuf_addf(&path, "%s/worktrees/%s/HEAD", get_git_common_dir(), id);
 	else
 		strbuf_addf(&path, "%s/HEAD", get_git_common_dir());
 
-	if (strbuf_read_file(&sb, path.buf, 0) < 0 ||
-	    !skip_prefix(sb.buf, "ref:", &start))
+	if (!strbuf_readlink(&sb, path.buf, 0)) {
+		if (!starts_with(sb.buf, "refs/") ||
+		    check_refname_format(sb.buf, 0))
+			goto done;
+	} else if (strbuf_read_file(&sb, path.buf, 0) >= 0 &&
+	    starts_with(sb.buf, "ref:")) {
+		strbuf_remove(&sb, 0, strlen("ref:"));
+		strbuf_trim(&sb);
+	} else
 		goto done;
-	while (isspace(*start))
-		start++;
-	end = start;
-	while (*end && !isspace(*end))
-		end++;
-	if (strncmp(start, branch, end - start) || branch[end - start] != '\0')
+	if (strcmp(sb.buf, branch))
 		goto done;
 	if (id) {
 		strbuf_reset(&path);
@@ -341,6 +347,7 @@ static void check_linked_checkout(const char *branch, const char *id)
 	} else
 		strbuf_addstr(&gitdir, get_git_common_dir());
 	skip_prefix(branch, "refs/heads/", &branch);
+	strbuf_strip_suffix(&gitdir, "/.git");
 	die(_("'%s' is already checked out at '%s'"), branch, gitdir.buf);
 done:
 	strbuf_release(&path);
@@ -354,11 +361,6 @@ void die_if_checked_out(const char *branch)
 	DIR *dir;
 	struct dirent *d;
 
-	/*
-	 * $GIT_COMMON_DIR/HEAD is practically outside
-	 * $GIT_DIR so resolve_ref_unsafe() won't work (it
-	 * uses git_path). Parse the ref ourselves.
-	 */
 	check_linked_checkout(branch, NULL);
 
 	strbuf_addf(&path, "%s/worktrees", get_git_common_dir());
diff --git a/builtin/worktree.c b/builtin/worktree.c
index 51c57bc..2873064 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -188,6 +188,7 @@ static int add_worktree(const char *path, const char *refname,
 	const char *name;
 	struct stat st;
 	struct child_process cp;
+	struct argv_array child_env = ARGV_ARRAY_INIT;
 	int counter = 0, len, ret;
 	struct strbuf symref = STRBUF_INIT;
 	struct commit *commit = NULL;
@@ -195,11 +196,14 @@ static int add_worktree(const char *path, const char *refname,
 	if (file_exists(path) && !is_empty_dir(path))
 		die(_("'%s' already exists"), path);
 
-	if (!opts->detach && !strbuf_check_branch_ref(&symref, refname) &&
-	    ref_exists(symref.buf)) {
+	/* is 'refname' a branch or commit? */
+	if (opts->force_new_branch) /* definitely a branch */
+		;
+	else if (!opts->detach && !strbuf_check_branch_ref(&symref, refname) &&
+		 ref_exists(symref.buf)) { /* it's a branch */
 		if (!opts->force)
 			die_if_checked_out(symref.buf);
-	} else {
+	} else { /* must be a commit */
 		commit = lookup_commit_reference_by_name(refname);
 		if (!commit)
 			die(_("invalid reference: %s"), refname);
@@ -262,8 +266,8 @@ static int add_worktree(const char *path, const char *refname,
 
 	fprintf_ln(stderr, _("Enter %s (identifier %s)"), path, name);
 
-	setenv(GIT_DIR_ENVIRONMENT, sb_git.buf, 1);
-	setenv(GIT_WORK_TREE_ENVIRONMENT, path, 1);
+	argv_array_pushf(&child_env, "%s=%s", GIT_DIR_ENVIRONMENT, sb_git.buf);
+	argv_array_pushf(&child_env, "%s=%s", GIT_WORK_TREE_ENVIRONMENT, path);
 	memset(&cp, 0, sizeof(cp));
 	cp.git_cmd = 1;
 
@@ -273,6 +277,7 @@ static int add_worktree(const char *path, const char *refname,
 	else
 		argv_array_pushl(&cp.args, "symbolic-ref", "HEAD",
 				 symref.buf, NULL);
+	cp.env = child_env.argv;
 	ret = run_command(&cp);
 	if (ret)
 		goto done;
@@ -280,6 +285,7 @@ static int add_worktree(const char *path, const char *refname,
 	cp.argv = NULL;
 	argv_array_clear(&cp.args);
 	argv_array_pushl(&cp.args, "reset", "--hard", NULL);
+	cp.env = child_env.argv;
 	ret = run_command(&cp);
 	if (!ret) {
 		is_junk = 0;
@@ -292,6 +298,7 @@ done:
 	strbuf_reset(&sb);
 	strbuf_addf(&sb, "%s/locked", sb_repo.buf);
 	unlink_or_warn(sb.buf);
+	argv_array_clear(&child_env);
 	strbuf_release(&sb);
 	strbuf_release(&symref);
 	strbuf_release(&sb_repo);
diff --git a/t/t2025-worktree-add.sh b/t/t2025-worktree-add.sh
index ead8aa2..9e30690 100755
--- a/t/t2025-worktree-add.sh
+++ b/t/t2025-worktree-add.sh
@@ -83,6 +83,14 @@ test_expect_success 'die the same branch is already checked out' '
 	)
 '
 
+test_expect_success SYMLINKS 'die the same branch is already checked out (symlink)' '
+	head=$(git -C there rev-parse --git-path HEAD) &&
+	ref=$(git -C there symbolic-ref HEAD) &&
+	rm "$head" &&
+	ln -s "$ref" "$head" &&
+	test_must_fail git -C here checkout newmaster
+'
+
 test_expect_success 'not die the same branch is already checked out' '
 	(
 		cd here &&
---- 8< ----
