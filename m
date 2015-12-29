From: Jeff King <peff@peff.net>
Subject: [RFC/PATCH 4/3] create_symref: drop support for writing symbolic
 links
Date: Tue, 29 Dec 2015 01:00:55 -0500
Message-ID: <20151229060055.GA17047@sigill.intra.peff.net>
References: <20151229055558.GA12848@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 29 07:01:07 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aDnLG-0002Ja-1R
	for gcvg-git-2@plane.gmane.org; Tue, 29 Dec 2015 07:01:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753640AbbL2GBB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Dec 2015 01:01:01 -0500
Received: from cloud.peff.net ([50.56.180.127]:46513 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753566AbbL2GA5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Dec 2015 01:00:57 -0500
Received: (qmail 14192 invoked by uid 102); 29 Dec 2015 06:00:58 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 29 Dec 2015 00:00:57 -0600
Received: (qmail 18447 invoked by uid 107); 29 Dec 2015 06:01:09 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 29 Dec 2015 01:01:09 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 29 Dec 2015 01:00:55 -0500
Content-Disposition: inline
In-Reply-To: <20151229055558.GA12848@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283071>

I'm iffy on this one, just because it drops a user-visible feature with
no deprecation. For the reasons given below, I doubt anybody is using it
for the original intended purpose, but maybe there is some crazy person
whose workflow revolves around core.preferSymlinkRefs.

A conservative choice would probably be to issue a deprecation warning
when we see it defined, wait a few versions, and then apply the patch
below.

-- >8 --
Long ago, in 2fabd21 (Disable USE_SYMLINK_HEAD by default,
2005-11-15), we switched git's default behavior to writing
text symrefs instead of symbolic links. Any scripts
accustomed to looking directly at .git/HEAD were updated to
use `rev-parse` instead. The Linux kernel's setlocalversion
script was one, and it was fixed in 117a93d (kbuild: Use git
in scripts/setlocalversion, 2006-01-04).

However, the problem still happened when bisecting the
kernel; pre-117a93d kernels would not build properly with a
newer git, because they wanted to look directly at HEAD. To
solve this, we added 9f0bb90 (core.prefersymlinkrefs: use
symlinks for .git/HEAD, 2006-05-02), which lets the user
turn on the old behavior, theoretically letting you bisect
older kernel history.

But there are a few complications with this solution:

  - packed-refs means you are limited in what you can do
    with .git/HEAD. If it is a symlink, you may `readlink`
    it to see where it points, but you cannot necessarily
    `cat .git/HEAD` to get the sha1, as the pointed-to ref
    may be packed.

    In particular, this means that the pre-117a93d kbuild
    script would sometimes work and sometimes not.

  - These days, we bisect on a detached HEAD. So during
    bisection, .git/HEAD _is_ a regular file with the
    sha1, and it works to `cat` it, whether or not you set
    core.preferSymlinkRefs.

Such scripts will all be broken again if we move to
alternate ref backends. They should have learned to use
`rev-parse` long ago, and it is only bisecting ancient
history that is a problem.

Now that almost ten years have passed, it seems less likely
that developers will bisect so far back in history. And
moreover, this is but one of many possible problems
developers run into when trying to build versions. The
standard solution is to apply a "fixup" patch or other
workaround while test-building the project, and that would
work here, too.

This patch therefore drops core.preferSymlinkRefs
completely. There are a few reasons to want to do so:

  1. It drops some code that is probably exercised very
     rarely.

  2. The symlink code is not up to the same standards as the
     rest of the ref code. In particular, it is racy with
     respect to simultaneous readers and writers.

  3. If we want to eventually drop the symlink-reading code,
     this is a good first step to deprecating it.

Signed-off-by: Jeff King <peff@peff.net>
---
 Documentation/config.txt               |  6 ------
 cache.h                                |  1 -
 config.c                               |  5 -----
 contrib/completion/git-completion.bash |  1 -
 environment.c                          |  1 -
 refs/files-backend.c                   | 20 --------------------
 t/t7201-co.sh                          | 12 ------------
 t/t9903-bash-prompt.sh                 |  9 ---------
 8 files changed, 55 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index f617886..06a2f2a 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -433,12 +433,6 @@ CIFS/Microsoft Windows.
 +
 False by default.
 
-core.preferSymlinkRefs::
-	Instead of the default "symref" format for HEAD
-	and other symbolic reference files, use symbolic links.
-	This is sometimes needed to work with old scripts that
-	expect HEAD to be a symbolic link.
-
 core.bare::
 	If true this repository is assumed to be 'bare' and has no
 	working directory associated with it.  If this is the case a
diff --git a/cache.h b/cache.h
index c63fcc1..5ff7df2 100644
--- a/cache.h
+++ b/cache.h
@@ -625,7 +625,6 @@ extern int has_symlinks;
 extern int minimum_abbrev, default_abbrev;
 extern int ignore_case;
 extern int assume_unchanged;
-extern int prefer_symlink_refs;
 extern int log_all_ref_updates;
 extern int warn_ambiguous_refs;
 extern int warn_on_object_refname_ambiguity;
diff --git a/config.c b/config.c
index 86a5eb2..f479eaa 100644
--- a/config.c
+++ b/config.c
@@ -726,11 +726,6 @@ static int git_default_core_config(const char *var, const char *value)
 		return 0;
 	}
 
-	if (!strcmp(var, "core.prefersymlinkrefs")) {
-		prefer_symlink_refs = git_config_bool(var, value);
-		return 0;
-	}
-
 	if (!strcmp(var, "core.logallrefupdates")) {
 		log_all_ref_updates = git_config_bool(var, value);
 		return 0;
diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 6956807..31d517d 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -2046,7 +2046,6 @@ _git_config ()
 		core.packedGitLimit
 		core.packedGitWindowSize
 		core.pager
-		core.preferSymlinkRefs
 		core.preloadindex
 		core.quotepath
 		core.repositoryFormatVersion
diff --git a/environment.c b/environment.c
index 2da7fe2..80a1c0c 100644
--- a/environment.c
+++ b/environment.c
@@ -19,7 +19,6 @@ int has_symlinks = 1;
 int minimum_abbrev = 4, default_abbrev = 7;
 int ignore_case;
 int assume_unchanged;
-int prefer_symlink_refs;
 int is_bare_repository_cfg = -1; /* unspecified */
 int log_all_ref_updates = -1; /* unspecified */
 int warn_ambiguous_refs = 1;
diff --git a/refs/files-backend.c b/refs/files-backend.c
index 180c837..6e19953 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -2811,21 +2811,6 @@ static int commit_ref_update(struct ref_lock *lock,
 	return 0;
 }
 
-static int create_ref_symlink(struct ref_lock *lock, const char *target)
-{
-	int ret = -1;
-#ifndef NO_SYMLINK_HEAD
-	char *ref_path = get_locked_file_path(lock->lk);
-	unlink(ref_path);
-	ret = symlink(target, ref_path);
-	free(ref_path);
-
-	if (ret)
-		fprintf(stderr, "no symlink - falling back to symbolic ref\n");
-#endif
-	return ret;
-}
-
 static void update_symref_reflog(struct ref_lock *lock, const char *refname,
 				 const char *target, const char *logmsg)
 {
@@ -2841,11 +2826,6 @@ static void update_symref_reflog(struct ref_lock *lock, const char *refname,
 static int create_symref_locked(struct ref_lock *lock, const char *refname,
 				const char *target, const char *logmsg)
 {
-	if (prefer_symlink_refs && !create_ref_symlink(lock, target)) {
-		update_symref_reflog(lock, refname, target, logmsg);
-		return 0;
-	}
-
 	if (!fdopen_lock_file(lock->lk, "w"))
 		return error("unable to fdopen %s: %s",
 			     lock->lk->tempfile.filename.buf, strerror(errno));
diff --git a/t/t7201-co.sh b/t/t7201-co.sh
index 8859236..715dc00 100755
--- a/t/t7201-co.sh
+++ b/t/t7201-co.sh
@@ -427,18 +427,6 @@ test_expect_success 'checkout w/--track from tag fails' '
     test "z$(git rev-parse master^0)" = "z$(git rev-parse HEAD)"
 '
 
-test_expect_success 'detach a symbolic link HEAD' '
-    git checkout master &&
-    git config --bool core.prefersymlinkrefs yes &&
-    git checkout side &&
-    git checkout master &&
-    it=$(git symbolic-ref HEAD) &&
-    test "z$it" = zrefs/heads/master &&
-    here=$(git rev-parse --verify refs/heads/master) &&
-    git checkout side^ &&
-    test "z$(git rev-parse --verify refs/heads/master)" = "z$here"
-'
-
 test_expect_success \
     'checkout with --track fakes a sensible -b <name>' '
     git config remote.origin.fetch "+refs/heads/*:refs/remotes/origin/*" &&
diff --git a/t/t9903-bash-prompt.sh b/t/t9903-bash-prompt.sh
index af82049..25066f35 100755
--- a/t/t9903-bash-prompt.sh
+++ b/t/t9903-bash-prompt.sh
@@ -46,15 +46,6 @@ test_expect_success 'prompt - branch name' '
 	test_cmp expected "$actual"
 '
 
-test_expect_success SYMLINKS 'prompt - branch name - symlink symref' '
-	printf " (master)" >expected &&
-	test_when_finished "git checkout master" &&
-	test_config core.preferSymlinkRefs true &&
-	git checkout master &&
-	__git_ps1 >"$actual" &&
-	test_cmp expected "$actual"
-'
-
 test_expect_success 'prompt - unborn branch' '
 	printf " (unborn)" >expected &&
 	git checkout --orphan unborn &&
-- 
2.7.0.rc2.368.g1cbb535
