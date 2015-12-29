From: Jeff King <peff@peff.net>
Subject: Re: [RFC/PATCH 4/3] create_symref: drop support for writing symbolic
 links
Date: Tue, 29 Dec 2015 01:03:58 -0500
Message-ID: <20151229060358.GB12848@sigill.intra.peff.net>
References: <20151229055558.GA12848@sigill.intra.peff.net>
 <20151229060055.GA17047@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 29 07:04:11 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aDnOE-00055x-M3
	for gcvg-git-2@plane.gmane.org; Tue, 29 Dec 2015 07:04:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753333AbbL2GEG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Dec 2015 01:04:06 -0500
Received: from cloud.peff.net ([50.56.180.127]:46519 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752973AbbL2GEB (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Dec 2015 01:04:01 -0500
Received: (qmail 14327 invoked by uid 102); 29 Dec 2015 06:04:01 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 29 Dec 2015 00:04:01 -0600
Received: (qmail 18468 invoked by uid 107); 29 Dec 2015 06:04:13 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 29 Dec 2015 01:04:13 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 29 Dec 2015 01:03:58 -0500
Content-Disposition: inline
In-Reply-To: <20151229060055.GA17047@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283072>

On Tue, Dec 29, 2015 at 01:00:55AM -0500, Jeff King wrote:

> --- a/refs/files-backend.c
> +++ b/refs/files-backend.c
> @@ -2811,21 +2811,6 @@ static int commit_ref_update(struct ref_lock *lock,
>  	return 0;
>  }
>  
> -static int create_ref_symlink(struct ref_lock *lock, const char *target)
> -{
> -	int ret = -1;
> -#ifndef NO_SYMLINK_HEAD
> -	char *ref_path = get_locked_file_path(lock->lk);
> -	unlink(ref_path);
> -	ret = symlink(target, ref_path);
> -	free(ref_path);
> -
> -	if (ret)
> -		fprintf(stderr, "no symlink - falling back to symbolic ref\n");
> -#endif

I forgot the build-time knob, which becomes a noop after this patch. If
we choose to apply this patch, we'd want to squash this in, too:

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
