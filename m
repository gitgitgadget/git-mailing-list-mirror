From: Jeff King <peff@peff.net>
Subject: Re: [RFC/PATCH 4/3] create_symref: drop support for writing symbolic
 links
Date: Wed, 30 Dec 2015 01:56:15 -0500
Message-ID: <20151230065614.GA29782@sigill.intra.peff.net>
References: <20151229055558.GA12848@sigill.intra.peff.net>
 <20151229060055.GA17047@sigill.intra.peff.net>
 <xmqqbn99hzrv.fsf@gitster.mtv.corp.google.com>
 <20151230065343.GA26964@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Dec 30 07:56:22 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aEAgH-0001bF-QK
	for gcvg-git-2@plane.gmane.org; Wed, 30 Dec 2015 07:56:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751418AbbL3G4T (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Dec 2015 01:56:19 -0500
Received: from cloud.peff.net ([50.56.180.127]:47031 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751017AbbL3G4R (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Dec 2015 01:56:17 -0500
Received: (qmail 16705 invoked by uid 102); 30 Dec 2015 06:56:17 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 30 Dec 2015 00:56:17 -0600
Received: (qmail 28408 invoked by uid 107); 30 Dec 2015 06:56:29 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 30 Dec 2015 01:56:29 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 30 Dec 2015 01:56:15 -0500
Content-Disposition: inline
In-Reply-To: <20151230065343.GA26964@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283164>

On Wed, Dec 30, 2015 at 01:53:43AM -0500, Jeff King wrote:

> On Tue, Dec 29, 2015 at 10:32:04AM -0800, Junio C Hamano wrote:
> 
> > Jeff King <peff@peff.net> writes:
> > 
> > > A conservative choice would probably be to issue a deprecation warning
> > > when we see it defined, wait a few versions, and then apply the patch
> > > below.
> > 
> > I agree with the analysis below.  And I agree that in the ideal
> > world, it would have been better not to add "prefer symlink refs"
> > configuration in the first place.  But we do not live in the ideal
> > world, and we already have it, so deprecation would need the usual
> > multi-step process.
> 
> Here's the first step of that multi-step process. The commit message
> will look familiar, as the rationale for deprecating is the same as for
> dropping.

And here's the second step, which would obviously want to wait a while
before being merged.

A third possible step would be removing the reading side from
resolve_ref(). But that would want to wait a few more cycles past this
one. And I'm hesitant to do it while the ref code is in flux. It will be
easier to just write the patch later on. :)

-- >8 --
Subject: [PATCH] create_symref: drop support for writing symbolic links

The parent commit deprecated the writing of symbolic links
for symrefs.  Now that some time has passed, we can follow
through by dropping the code.

Signed-off-by: Jeff King <peff@peff.net>
---
 Documentation/config.txt               |  6 ------
 Makefile                               |  6 ------
 cache.h                                |  1 -
 config.c                               |  5 -----
 config.mak.uname                       |  3 ---
 configure.ac                           |  3 ---
 contrib/completion/git-completion.bash |  1 -
 environment.c                          |  1 -
 refs/files-backend.c                   | 35 ----------------------------------
 t/t7201-co.sh                          | 12 ------------
 t/t9903-bash-prompt.sh                 |  9 ---------
 11 files changed, 82 deletions(-)

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
diff --git a/Makefile b/Makefile
index fd19b54..05ffd60 100644
--- a/Makefile
+++ b/Makefile
@@ -113,9 +113,6 @@ all::
 #
 # Define NO_SYS_SELECT_H if you don't have sys/select.h.
 #
-# Define NO_SYMLINK_HEAD if you never want .git/HEAD to be a symbolic link.
-# Enable it on Windows.  By default, symrefs are still used.
-#
 # Define NO_SVN_TESTS if you want to skip time-consuming SVN interoperability
 # tests.  These tests take up a significant amount of the total test time
 # but are not needed unless you plan to talk to SVN repos.
@@ -1200,9 +1197,6 @@ ifdef FREAD_READS_DIRECTORIES
 	COMPAT_CFLAGS += -DFREAD_READS_DIRECTORIES
 	COMPAT_OBJS += compat/fopen.o
 endif
-ifdef NO_SYMLINK_HEAD
-	BASIC_CFLAGS += -DNO_SYMLINK_HEAD
-endif
 ifdef GETTEXT_POISON
 	BASIC_CFLAGS += -DGETTEXT_POISON
 endif
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
diff --git a/config.mak.uname b/config.mak.uname
index f34dcaa..9b77e2c 100644
--- a/config.mak.uname
+++ b/config.mak.uname
@@ -169,7 +169,6 @@ ifeq ($(uname_O),Cygwin)
 		NO_STRCASESTR = YesPlease
 		NO_MEMMEM = YesPlease
 		NO_MKSTEMPS = YesPlease
-		NO_SYMLINK_HEAD = YesPlease
 		NO_IPV6 = YesPlease
 		OLD_ICONV = UnfortunatelyYes
 		# There are conflicting reports about this.
@@ -338,7 +337,6 @@ ifeq ($(uname_S),Windows)
 	NEEDS_CRYPTO_WITH_SSL = YesPlease
 	NO_LIBGEN_H = YesPlease
 	NO_POLL = YesPlease
-	NO_SYMLINK_HEAD = YesPlease
 	NO_IPV6 = YesPlease
 	NO_UNIX_SOCKETS = YesPlease
 	NO_SETENV = YesPlease
@@ -491,7 +489,6 @@ ifneq (,$(findstring MINGW,$(uname_S)))
 	NEEDS_CRYPTO_WITH_SSL = YesPlease
 	NO_LIBGEN_H = YesPlease
 	NO_POLL = YesPlease
-	NO_SYMLINK_HEAD = YesPlease
 	NO_UNIX_SOCKETS = YesPlease
 	NO_SETENV = YesPlease
 	NO_STRCASESTR = YesPlease
diff --git a/configure.ac b/configure.ac
index 89e2590..cad5418 100644
--- a/configure.ac
+++ b/configure.ac
@@ -1096,9 +1096,6 @@ GIT_CONF_SUBST([HAVE_BSD_SYSCTL])
 # Define USE_PIC if you need the main git objects to be built with -fPIC
 # in order to build and link perl/Git.so.  x86-64 seems to need this.
 #
-# Define NO_SYMLINK_HEAD if you never want .git/HEAD to be a symbolic link.
-# Enable it on Windows.  By default, symrefs are still used.
-#
 # Define NO_PTHREADS if we do not have pthreads.
 #
 # Define PTHREAD_LIBS to the linker flag used for Pthread support.
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
index 22b7c11..6e19953 100644
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
@@ -2860,27 +2840,12 @@ static int create_symref_locked(struct ref_lock *lock, const char *refname,
 	return 0;
 }
 
-static const char symlink_deprecation_warning[] =
-"The core.preferSymlinkRefs configuration option has been\n"
-"deprecated and will be removed in a future version of Git. If your\n"
-"workflow or script depends on '.git/HEAD' being a symbolic link,\n"
-"it should be adjusted to use:\n"
-"\n"
-"        git rev-parse HEAD\n"
-"\n"
-"        git rev-parse --symbolic-full-name HEAD\n"
-"\n"
-"to get the sha1 or branch name, respectively.";
-
 int create_symref(const char *refname, const char *target, const char *logmsg)
 {
 	struct strbuf err = STRBUF_INIT;
 	struct ref_lock *lock;
 	int ret;
 
-	if (prefer_symlink_refs)
-		warning("%s", symlink_deprecation_warning);
-
 	lock = lock_ref_sha1_basic(refname, NULL, NULL, NULL, REF_NODEREF, NULL,
 				   &err);
 	if (!lock) {
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
2.7.0.rc3.367.g09631da
