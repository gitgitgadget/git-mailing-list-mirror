From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 3/3] setup: always honor GIT_WORK_TREE and core.worktree
Date: Wed, 19 Jan 2011 06:42:30 -0600
Message-ID: <20110119124230.GD23222@burratino>
References: <1290785563-15339-1-git-send-email-pclouds@gmail.com>
 <1290785563-15339-40-git-send-email-pclouds@gmail.com>
 <20110118074400.GA4185@burratino>
 <7v1v4aknij.fsf@alter.siamese.dyndns.org>
 <20110119123732.GA23222@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 19 13:42:51 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PfXNC-0004V3-QJ
	for gcvg-git-2@lo.gmane.org; Wed, 19 Jan 2011 13:42:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754173Ab1ASMmo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Jan 2011 07:42:44 -0500
Received: from mail-qw0-f46.google.com ([209.85.216.46]:54244 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752527Ab1ASMmn (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Jan 2011 07:42:43 -0500
Received: by qwa26 with SMTP id 26so786110qwa.19
        for <git@vger.kernel.org>; Wed, 19 Jan 2011 04:42:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=VasMyorvdiMIunbrDKPfDJgueo+pUTFbw83/1lc/7IM=;
        b=UWv8Qgzmu5QIOeU/q+MHiJKFWk6YAXnOz5BAY1pGaJtFYzUb0P7rInM+P7CX0KOkuS
         TfDlBMbcDPZoiuPyX2thbNO1+UN22e1x7Htfr3ONBrRa6ijNdr31DgvlAJwn+NEmALQJ
         pHnhNJwj5zl/1m/NuvLtxpvbE/rZNgJ2esrTY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=TDSBSOsdgXlUjdyR8kj6yQ8V0+1Tjtg8ZVFIXOrQKtGm9vri5/15mPtfveHAFXm72q
         LrkuT95xFxAvR2HImY8HMdFctOLAbnXtvRua+cse/2w5BvhmjF3Be/rHdRDTWFrTsjeh
         f+ehOAqq/ALcMWn05aV/nC15NtHz7D79pOymo=
Received: by 10.229.233.142 with SMTP id jy14mr571656qcb.239.1295440962186;
        Wed, 19 Jan 2011 04:42:42 -0800 (PST)
Received: from burratino (adsl-69-209-76-37.dsl.chcgil.ameritech.net [69.209.76.37])
        by mx.google.com with ESMTPS id s10sm4683561qco.35.2011.01.19.04.42.40
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 19 Jan 2011 04:42:41 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20110119123732.GA23222@burratino>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165265>

In the usual case, git commands are run from within a git worktree.
The toplevel directory and associated .git dir are found by chdir-ing
to .. repeatedly until .git is a valid repository.

That behavior can be overridden in two ways.

 (1) By setting GIT_DIR (through the environment or the --git-dir
     command line option), one can keep the repository somewhere
     unrelated to the worktree.

 (2) By setting GIT_WORK_TREE (through the environment, --work-tree
     command line option, or [core] worktree configuration) in
     addition to GIT_DIR, one can use a directory other than the cwd
     as toplevel of the worktree.

Unfortunately the existence of GIT_WORK_TREE makes it tempting to
use without setting GIT_DIR.  Until v1.7.4-rc0~4^2~9 (setup: limit
get_git_work_tree()'s to explicit setup case only, 2010-11-26), that
only happened to work, sometimes:

 - if .git is in the current directory, it might work;
 - otherwise, git would fail to discover the .git directory.

Ouch.  It would be better to forbid setting a work tree without git
dir entirely, except that due to this accidental support some scripts
(e.g., git-buildpackage, gitolite) learned to use rely on it over the
years.

Instead (1) first run discovery as though within a worktree trying to
find the .git dir, and (2) only once discovery is finished, check the
GIT_WORK_TREE setting to see if the worktree is declared to be
somewhere else entirely.

Also print a warning when GIT_WORK_TREE is set and GIT_DIR not, to
prevent nonportable scripts relying on this new behavior.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 setup.c               |   27 +++++++-
 t/t1510-repo-setup.sh |  199 ++++++++++++++++++++++++++----------------------
 2 files changed, 134 insertions(+), 92 deletions(-)

diff --git a/setup.c b/setup.c
index 3d73269..c0f5846 100644
--- a/setup.c
+++ b/setup.c
@@ -411,6 +411,16 @@ static const char *setup_discovered_git_dir(const char *gitdir,
 	if (check_repository_format_gently(gitdir, nongit_ok))
 		return NULL;
 
+	/* Accept --work-tree to support old scripts that played with fire. */
+	if (getenv(GIT_WORK_TREE_ENVIRONMENT) || git_work_tree_cfg) {
+		warning("pretending GIT_DIR was supplied alongside GIT_WORK_TREE");
+		if (offset != len && !is_absolute_path(gitdir))
+			gitdir = xstrdup(make_absolute_path(gitdir));
+		if (chdir(cwd))
+			die_errno("Could not come back to cwd");
+		return setup_explicit_git_dir(gitdir, cwd, len, nongit_ok);
+	}
+
 	/* #16.2, #17.2, #20.2, #21.2, #24, #25, #28, #29 (see t1510) */
 	if (is_bare_repository_cfg > 0) {
 		set_git_dir(offset == len ? gitdir : make_absolute_path(gitdir));
@@ -443,6 +453,19 @@ static const char *setup_bare_git_dir(char *cwd, int offset, int len, int *nongi
 	if (check_repository_format_gently(".", nongit_ok))
 		return NULL;
 
+	/*
+	 * Accept --work-tree, reluctantly.
+	 */
+	if (getenv(GIT_WORK_TREE_ENVIRONMENT) || git_work_tree_cfg) {
+		const char *gitdir;
+
+		warning("pretending GIT_DIR was supplied alongside GIT_WORK_TREE");
+		gitdir = offset == len ? "." : xmemdupz(cwd, offset);
+		if (chdir(cwd))
+			die_errno("Could not come back to cwd");
+		return setup_explicit_git_dir(gitdir, cwd, len, nongit_ok);
+	}
+
 	inside_git_dir = 1;
 	inside_work_tree = 0;
 	if (offset != len) {
@@ -509,8 +532,10 @@ static const char *setup_git_directory_gently_1(int *nongit_ok)
 	 * validation.
 	 */
 	gitdirenv = getenv(GIT_DIR_ENVIRONMENT);
-	if (gitdirenv)
+	if (gitdirenv) {
+		trace_printf("trace: gitdirenv = %s\n", gitdirenv);
 		return setup_explicit_git_dir(gitdirenv, cwd, len, nongit_ok);
+	}
 
 	ceil_offset = longest_ancestor_length(cwd, env_ceiling_dirs);
 	if (ceil_offset < 0 && has_dos_drive_prefix(cwd))
diff --git a/t/t1510-repo-setup.sh b/t/t1510-repo-setup.sh
index 4f8f976..b8a1b02 100755
--- a/t/t1510-repo-setup.sh
+++ b/t/t1510-repo-setup.sh
@@ -16,8 +16,9 @@ A few rules for repo setup:
 4. GIT_WORK_TREE is relative to user's cwd. --work-tree is
    equivalent to GIT_WORK_TREE.
 
-5. GIT_WORK_TREE/core.worktree is only effective if GIT_DIR is set
-   Uneffective worktree settings should be warned.
+5. GIT_WORK_TREE/core.worktree is only meant to work if GIT_DIR is set.
+   Otherwise there is a warning and a best effort is made to follow
+   historical behavior.
 
 6. Effective GIT_WORK_TREE overrides core.worktree and core.bare
 
@@ -224,13 +225,16 @@ try_repo () {
 test_expect_success '#0: nonbare repo, no explicit configuration' '
 	try_repo 0 unset unset unset "" unset \
 		.git "$here/0" "$here/0" "(null)" \
-		.git "$here/0" "$here/0" sub/
+		.git "$here/0" "$here/0" sub/ 2>messages &&
+	! grep "warning:.*GIT_DIR.*GIT_WORK_TREE" messages
 '
 
-test_expect_success '#1: GIT_WORK_TREE without explicit GIT_DIR is ignored' '
-	try_repo 1 non-existent unset unset "" unset \
-		.git "$here/1" "$here/1" "(null)" \
-		.git "$here/1" "$here/1" sub/
+test_expect_success '#1: GIT_WORK_TREE without explicit GIT_DIR is reluctantly accepted' '
+	mkdir -p wt &&
+	try_repo 1 "$here" unset unset "" unset \
+		"$here/1/.git" "$here" "$here" 1/ \
+		"$here/1/.git" "$here" "$here" 1/sub/ 2>message &&
+	grep "warning:.*GIT_DIR.*GIT_WORK_TREE" message
 '
 
 test_expect_success '#2: worktree defaults to cwd with explicit GIT_DIR' '
@@ -251,17 +255,24 @@ test_expect_success '#3: setup' '
 '
 run_wt_tests 3
 
-test_expect_success '#4: core.worktree without GIT_DIR set is ignored' '
-	try_repo 4 unset unset non-existent "" unset \
-		.git "$here/4" "$here/4" "(null)" \
-		.git "$here/4" "$here/4" sub/
+test_expect_success '#4: core.worktree without GIT_DIR set is reluctantly accepted' '
+	setup_repo 4 ../sub "" unset &&
+	mkdir -p 4/sub sub &&
+	try_case 4 unset unset \
+		.git "$here/4/sub" "$here/4" "(null)" \
+		"$here/4/.git" "$here/4/sub" "$here/4/sub" "(null)" 2>message &&
+	grep "warning:.*GIT_DIR.*GIT_WORK_TREE" message
 '
 
-test_expect_success '#5: core.worktree + GIT_WORK_TREE is still ignored' '
+test_expect_success '#5: core.worktree + GIT_WORK_TREE is reluctantly accepted' '
 	# or: you cannot intimidate away the lack of GIT_DIR setting
-	try_repo 5 non-existent-too unset non-existent "" unset \
-		.git "$here/5" "$here/5" "(null)" \
-		.git "$here/5" "$here/5" sub/
+	try_repo 5 "$here" unset "$here/5" "" unset \
+		"$here/5/.git" "$here" "$here" 5/ \
+		"$here/5/.git" "$here" "$here" 5/sub/ 2>message &&
+	try_repo 5a .. unset "$here/5a" "" unset \
+		"$here/5a/.git" "$here" "$here" 5a/ \
+		"$here/5a/.git" "$here/5a" "$here/5a" sub/ &&
+	grep "warning:.*GIT_DIR.*GIT_WORK_TREE" message
 '
 
 test_expect_success '#6: setting GIT_DIR brings core.worktree to life' '
@@ -353,10 +364,12 @@ test_expect_success '#8: gitfile, easy case' '
 		"$here/8.git" "$here/8" "$here/8" sub/
 '
 
-test_expect_success '#9: GIT_WORK_TREE ignored even with gitfile' '
-	try_repo 9 non-existent unset unset gitfile unset \
-		"$here/9.git" "$here/9" "$here/9" "(null)" \
-		"$here/9.git" "$here/9" "$here/9" sub/
+test_expect_success '#9: GIT_WORK_TREE reluctantly accepted with gitfile' '
+	mkdir -p 9/wt &&
+	try_repo 9 wt unset unset gitfile unset \
+		"$here/9.git" "$here/9/wt" "$here/9" "(null)" \
+		"$here/9.git" "$here/9/sub/wt" "$here/9/sub" "(null)" 2>message &&
+	grep "warning:.*GIT_DIR.*GIT_WORK_TREE" message
 '
 
 test_expect_success '#10: GIT_DIR can point to gitfile' '
@@ -378,17 +391,19 @@ test_expect_success '#11: setup' '
 '
 run_wt_tests 11 gitfile
 
-test_expect_success '#12: core.worktree with gitfile is still ignored' '
-	try_repo 12 unset unset non-existent gitfile unset \
+test_expect_success '#12: core.worktree with gitfile is reluctantly accepted' '
+	try_repo 12 unset unset "$here/12" gitfile unset \
 		"$here/12.git" "$here/12" "$here/12" "(null)" \
-		"$here/12.git" "$here/12" "$here/12" sub/
+		"$here/12.git" "$here/12" "$here/12" sub/ 2>message &&
+	grep "warning:.*GIT_DIR.*GIT_WORK_TREE" message
 '
 
-test_expect_success '#13: core.worktree+GIT_WORK_TREE ignored (with gitfile)' '
+test_expect_success '#13: core.worktree+GIT_WORK_TREE relucantly accepted (with gitfile)' '
 	# or: you cannot intimidate away the lack of GIT_DIR setting
 	try_repo 13 non-existent-too unset non-existent gitfile unset \
-		"$here/13.git" "$here/13" "$here/13" "(null)" \
-		"$here/13.git" "$here/13" "$here/13" sub/
+		"$here/13.git" "$here/13/non-existent-too" "$here/13" "(null)" \
+		"$here/13.git" "$here/13/sub/non-existent-too" "$here/13/sub" "(null)" 2>message &&
+	grep "warning:.*GIT_DIR.*GIT_WORK_TREE" message
 '
 
 # case #14.
@@ -499,30 +514,32 @@ test_expect_success '#16c: bare .git has no worktree' '
 		"$here/16c/.git" "(null)" "$here/16c/sub" "(null)"
 '
 
-test_expect_success '#17: GIT_WORK_TREE without explicit GIT_DIR is ignored (bare case)' '
+test_expect_success '#17: GIT_WORK_TREE without explicit GIT_DIR is reluctantly accepted (bare case)' '
 	# Just like #16.
 	setup_repo 17a unset "" true &&
 	setup_repo 17b unset "" true &&
 	mkdir -p 17a/.git/wt/sub &&
 	mkdir -p 17b/.git/wt/sub &&
 
-	try_case 17a/.git non-existent unset \
-		. "(null)" "$here/17a/.git" "(null)" &&
-	try_case 17a/.git/wt non-existent unset \
-		"$here/17a/.git" "(null)" "$here/17a/.git/wt" "(null)" &&
-	try_case 17a/.git/wt/sub non-existent unset \
-		"$here/17a/.git" "(null)" "$here/17a/.git/wt/sub" "(null)" &&
+	try_case 17a/.git "$here/17a" unset \
+		"$here/17a/.git" "$here/17a" "$here/17a" .git/ \
+		2>message &&
+	try_case 17a/.git/wt "$here/17a" unset \
+		"$here/17a/.git" "$here/17a" "$here/17a" .git/wt/ &&
+	try_case 17a/.git/wt/sub "$here/17a" unset \
+		"$here/17a/.git" "$here/17a" "$here/17a" .git/wt/sub/ &&
 
-	try_case 17b/.git non-existent unset \
-		. "(null)" "$here/17b/.git" "(null)" &&
-	try_case 17b/.git/wt non-existent unset \
-		"$here/17b/.git" "(null)" "$here/17b/.git/wt" "(null)" &&
-	try_case 17b/.git/wt/sub non-existent unset \
-		"$here/17b/.git" "(null)" "$here/17b/.git/wt/sub" "(null)" &&
+	try_case 17b/.git "$here/17b" unset \
+		"$here/17b/.git" "$here/17b" "$here/17b" .git/ &&
+	try_case 17b/.git/wt "$here/17b" unset \
+		"$here/17b/.git" "$here/17b" "$here/17b" .git/wt/ &&
+	try_case 17b/.git/wt/sub "$here/17b" unset \
+		"$here/17b/.git" "$here/17b" "$here/17b" .git/wt/sub/ &&
 
-	try_repo 17c non-existent unset unset "" true \
-		.git "(null)" "$here/17c" "(null)" \
-		"$here/17c/.git" "(null)" "$here/17c/sub" "(null)"
+	try_repo 17c "$here/17c" unset unset "" true \
+		.git "$here/17c" "$here/17c" "(null)" \
+		"$here/17c/.git" "$here/17c" "$here/17c" sub/ 2>message &&
+	grep "warning:.*GIT_DIR.*GIT_WORK_TREE" message
 '
 
 test_expect_success '#18: bare .git named by GIT_DIR has no worktree' '
@@ -541,56 +558,43 @@ test_expect_success '#19: setup' '
 '
 run_wt_tests 19
 
-test_expect_success '#20a: core.worktree without GIT_DIR ignored (inside .git)' '
-	# Just like case #16a.
-	setup_repo 20a non-existent "" unset &&
+test_expect_success '#20a: core.worktree without GIT_DIR reluctantly accepted (inside .git)' '
+	# Unlike case #16a.
+	setup_repo 20a "$here/20a" "" unset &&
 	mkdir -p 20a/.git/wt/sub &&
 	try_case 20a/.git unset unset \
-		. "(null)" "$here/20a/.git" "(null)" &&
+		"$here/20a/.git" "$here/20a" "$here/20a" .git/ 2>message &&
 	try_case 20a/.git/wt unset unset \
-		"$here/20a/.git" "(null)" "$here/20a/.git/wt" "(null)" &&
+		"$here/20a/.git" "$here/20a" "$here/20a" .git/wt/ &&
 	try_case 20a/.git/wt/sub unset unset \
-		"$here/20a/.git" "(null)" "$here/20a/.git/wt/sub" "(null)"
+		"$here/20a/.git" "$here/20a" "$here/20a" .git/wt/sub/ &&
+	grep "warning:.*GIT_DIR.*GIT_WORK_TREE" message
 '
 
-test_expect_success '#20b/c: core.worktree without GIT_DIR ignored (bare repository)' '
-	# Just like case #16b/c.
+test_expect_success '#20b/c: core.worktree and core.bare conflict' '
 	setup_repo 20b non-existent "" true &&
 	mkdir -p 20b/.git/wt/sub &&
-	try_case 20b/.git unset unset \
-		. "(null)" "$here/20b/.git" "(null)" &&
-	try_case 20b/.git/wt unset unset \
-		"$here/20b/.git" "(null)" "$here/20b/.git/wt" "(null)" &&
-	try_case 20b/.git/wt/sub unset unset \
-		"$here/20b/.git" "(null)" "$here/20b/.git/wt/sub" "(null)" &&
-	try_repo 20c unset unset non-existent "" true \
-		.git "(null)" "$here/20c" "(null)" \
-		"$here/20c/.git" "(null)" "$here/20c/sub" "(null)"
+	(
+		cd 20b/.git &&
+		test_must_fail git symbolic-ref HEAD >/dev/null
+	) 2>message &&
+	grep "core.bare and core.worktree" message
 '
 
-test_expect_success '#21: core.worktree+GIT_WORK_TREE without GIT_DIR ignored (bare cases)' '
-	setup_repo 21a non-existent "" unset &&
-	mkdir -p 21a/.git/wt/sub &&
-	try_case 21a/.git non-existent-too unset \
-		. "(null)" "$here/21a/.git" "(null)" &&
-	try_case 21a/.git/wt non-existent-too unset \
-		"$here/21a/.git" "(null)" "$here/21a/.git/wt" "(null)" &&
-	try_case 21a/.git/wt/sub non-existent-too unset \
-		"$here/21a/.git" "(null)" "$here/21a/.git/wt/sub" "(null)" &&
+# Case #21: core.worktree/GIT_WORK_TREE reluctantly overrides core.bare' '
+test_expect_success '#21: setup, core.worktree warns before overriding core.bare' '
+	setup_repo 21 non-existent "" unset &&
+	mkdir -p 21/.git/wt/sub &&
+	(
+		cd 21/.git &&
+		GIT_WORK_TREE="$here/21" &&
+		export GIT_WORK_TREE &&
+		git symbolic-ref HEAD >/dev/null
+	) 2>message &&
+	grep "warning:.*GIT_DIR.*GIT_WORK_TREE" message
 
-	setup_repo 21b non-existent "" true &&
-	mkdir -p 21b/.git/wt/sub &&
-	try_case 21b/.git non-existent-too unset \
-		. "(null)" "$here/21b/.git" "(null)" &&
-	try_case 21b/.git/wt non-existent-too unset \
-		"$here/21b/.git" "(null)" "$here/21b/.git/wt" "(null)" &&
-	try_case 21b/.git/wt/sub non-existent-too unset \
-		"$here/21b/.git" "(null)" "$here/21b/.git/wt/sub" "(null)" &&
-
-	try_repo 21c non-existent-too unset non-existent "" true \
-		.git "(null)" "$here/21c" "(null)" \
-		"$here/21c/.git" "(null)" "$here/21c/sub" "(null)"
 '
+run_wt_tests 21
 
 test_expect_success '#22a: core.worktree = GIT_DIR = .git dir' '
 	# like case #6.
@@ -699,10 +703,11 @@ test_expect_success '#24: bare repo has no worktree (gitfile case)' '
 		"$here/24.git" "(null)" "$here/24/sub" "(null)"
 '
 
-test_expect_success '#25: GIT_WORK_TREE ignored if GIT_DIR unset (bare gitfile case)' '
-	try_repo 25 non-existent unset unset gitfile true \
-		"$here/25.git" "(null)" "$here/25" "(null)" \
-		"$here/25.git" "(null)" "$here/25/sub" "(null)"
+test_expect_success '#25: GIT_WORK_TREE accepted reluctantly if GIT_DIR unset (bare gitfile case)' '
+	try_repo 25 "$here/25" unset unset gitfile true \
+		"$here/25.git" "$here/25" "$here/25" "(null)"  \
+		"$here/25.git" "$here/25" "$here/25" "sub/" 2>message &&
+	grep "warning:.*GIT_DIR.*GIT_WORK_TREE" message
 '
 
 test_expect_success '#26: bare repo has no worktree (GIT_DIR -> gitfile case)' '
@@ -721,17 +726,29 @@ test_expect_success '#27: setup' '
 '
 run_wt_tests 27 gitfile
 
-test_expect_success '#28: core.worktree ignored if GIT_DIR unset (bare gitfile case)' '
-	try_repo 28 unset unset non-existent gitfile true \
-		"$here/28.git" "(null)" "$here/28" "(null)" \
-		"$here/28.git" "(null)" "$here/28/sub" "(null)"
+test_expect_success '#28: core.worktree and core.bare conflict (gitfile case)' '
+	setup_repo 28 "$here/28" gitfile true &&
+	(
+		cd 28 &&
+		test_must_fail git symbolic-ref HEAD
+	) 2>message &&
+	grep "warning:.*GIT_DIR.*GIT_WORK_TREE" message &&
+	grep "core.bare and core.worktree" message
 '
 
-test_expect_success '#29: GIT_WORK_TREE+core.worktree ignored if GIT_DIR unset (bare gitfile case)' '
-	try_repo 29 non-existent-too unset non-existent gitfile true \
-		"$here/29.git" "(null)" "$here/29" "(null)" \
-		"$here/29.git" "(null)" "$here/29/sub" "(null)"
+# Case #29: GIT_WORK_TREE(+core.worktree) reluctantly overries core.bare (gitfile case).
+test_expect_success '#29: setup' '
+	setup_repo 29 non-existent gitfile true &&
+	mkdir -p 29/sub/sub 29/wt/sub
+	(
+		cd 29 &&
+		GIT_WORK_TREE="$here/29" &&
+		export GIT_WORK_TREE &&
+		git symbolic-ref HEAD >/dev/null
+	) 2>message &&
+	grep "warning:.*GIT_DIR.*GIT_WORK_TREE" message
 '
+run_wt_tests 29 gitfile
 
 test_expect_success '#30: core.worktree and core.bare conflict (gitfile version)' '
 	# Just like case #22.
-- 
1.7.4.rc2
