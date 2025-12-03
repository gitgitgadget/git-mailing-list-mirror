Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E2A6347BDD
	for <git@vger.kernel.org>; Wed,  3 Dec 2025 16:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764778331; cv=none; b=uXwc78m4UvaFIA5dcVq6jpQ+nip5y6QonF4VG95IBbQtMLzQfIN4Rn+eGR3vbh+BMHREpo7aniO5pJjo6Mj8vZ+oV3n0oGUm5x78q/EXdM+eYgTYdxD+sjjKRa7QYhqWmz71Z++o5ct4g+PIlR7EQbAJke2MgM1n2aWgeNp2ji4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764778331; c=relaxed/simple;
	bh=50p+HlijNNyU/H4BOwKGJjIlh3q+8oMMBm+ckTFkVhs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AsuaOi5OFis4UQqohSJ1AA1dfT9IZRGoQFn+QH5ptRiUv628WdFxq8ElrEpv5k7ww3nA2FgYVRoCFxBF7UjxJkbjPmdgvzZ+VN2VVXUhPgzGYHSX5XKmKJiphpHIUiIbR/3VserrVm1pgEFNy7jb+RUXkh6plSbTB/ArOt4o07o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=N14iaIE6; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="N14iaIE6"
Received: (qmail 241116 invoked by uid 109); 3 Dec 2025 16:11:58 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:content-transfer-encoding:in-reply-to; s=20240930; bh=50p+HlijNNyU/H4BOwKGJjIlh3q+8oMMBm+ckTFkVhs=; b=N14iaIE6H+bx2d2+42o+XBnesmY5zbCeyna7EWv0m1hTFEO/h7v6d0AUYEKJU5k1WuQAoniwXE/Rm+vu7t5GOK+1Z/uau0SK+NPJIG9flk/JM6VJgVHipukZvjHVn9NZYe3sZvBMrjYqLy0FPALkA8dcRDScjpn+3P4NXm/+pEGYsxtDPqzcCgHDW75ULAp7kL6XOda9h1X4UjTrPTNdYHIlD/6tV4v+4V5T91FD1xqJNYdpZ9cbLbKYViJVqhK/q7u+/QLD3C/2HB0mKKcBXt1SiCpAD6rEwuL4gcYbZVaHeM8jE5fJaaz1wSldz8bKlsrFSGAsTN6OuW2QFPbv4w==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 03 Dec 2025 16:11:58 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 307460 invoked by uid 111); 3 Dec 2025 16:11:55 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 03 Dec 2025 11:11:55 -0500
Authentication-Results: peff.net; auth=none
Date: Wed, 3 Dec 2025 11:11:54 -0500
From: Jeff King <peff@peff.net>
To: =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc: Git List <git@vger.kernel.org>
Subject: Re: [PATCH 2/4] compat: use git_mkdtemp()
Message-ID: <20251203161154.GA44940@coredump.intra.peff.net>
References: <784f495a-4b1a-4acf-96cd-599243ef9e27@web.de>
 <4c70b527-9c40-4396-8c8c-95177c5d92f0@web.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4c70b527-9c40-4396-8c8c-95177c5d92f0@web.de>

On Wed, Dec 03, 2025 at 11:52:30AM +0100, René Scharfe wrote:

> A file might appear at the path returned by mktemp(3) before we call
> mkdir(2).  Use the more robust git_mkdtemp() instead, which retries a
> number of times and doesn't need to call lstat(2).

This seems like a good idea. At least one of the mkdtemp() callers was
using $TMPDIR, so this was a potential security-sensitive race.

> diff --git a/compat/mkdtemp.c b/compat/mkdtemp.c
> index 1136119592..fcdd4e01e1 100644
> --- a/compat/mkdtemp.c
> +++ b/compat/mkdtemp.c
> @@ -2,7 +2,5 @@
>  
>  char *gitmkdtemp(char *template)
>  {
> -	if (!*mktemp(template) || mkdir(template, 0700))
> -		return NULL;
> -	return template;
> +	return git_mkdtemp(template);
>  }

OK, so now we have gitmkdtemp() and git_mkdtemp(), which are also now
the exact same thing. That seems overly complicated. ;)

This one is a conditionally-compiled wrapper for NO_MKDTEMP. But since
we always have git_mkdtemp() available (as of your first patch), can't
we just point at it directly with the macro?

Like this:

diff --git a/Makefile b/Makefile
index 237b56fc9d..8226aed443 100644
--- a/Makefile
+++ b/Makefile
@@ -1919,7 +1919,6 @@ ifdef NO_SETENV
 endif
 ifdef NO_MKDTEMP
 	COMPAT_CFLAGS += -DNO_MKDTEMP
-	COMPAT_OBJS += compat/mkdtemp.o
 endif
 ifdef MKDIR_WO_TRAILING_SLASH
 	COMPAT_CFLAGS += -DMKDIR_WO_TRAILING_SLASH
diff --git a/compat/mkdtemp.c b/compat/mkdtemp.c
deleted file mode 100644
index fcdd4e01e1..0000000000
--- a/compat/mkdtemp.c
+++ /dev/null
@@ -1,6 +0,0 @@
-#include "../git-compat-util.h"
-
-char *gitmkdtemp(char *template)
-{
-	return git_mkdtemp(template);
-}
diff --git a/compat/posix.h b/compat/posix.h
index 067a00f33b..245386fa4a 100644
--- a/compat/posix.h
+++ b/compat/posix.h
@@ -329,8 +329,7 @@ int gitsetenv(const char *, const char *, int);
 #endif
 
 #ifdef NO_MKDTEMP
-#define mkdtemp gitmkdtemp
-char *gitmkdtemp(char *);
+#define mkdtemp git_mkdtemp
 #endif
 
 #ifdef NO_UNSETENV
diff --git a/meson.build b/meson.build
index f1b3615659..090b1911ca 100644
--- a/meson.build
+++ b/meson.build
@@ -1401,7 +1401,6 @@ checkfuncs = {
   'strlcpy' : ['strlcpy.c'],
   'strtoull' : [],
   'setenv' : ['setenv.c'],
-  'mkdtemp' : ['mkdtemp.c'],
   'initgroups' : [],
   'strtoumax' : ['strtoumax.c', 'strtoimax.c'],
   'pread' : ['pread.c'],


We could even take it a step further and just always use git_mkdtemp(),
like we were discussing elsewhere for mkstemp(). And then the makefile
knobs can go away, too, like:

diff --git a/Makefile b/Makefile
index 8226aed443..8ef5497c10 100644
--- a/Makefile
+++ b/Makefile
@@ -68,8 +68,6 @@ include shared.mak
 #
 # Define NO_UNSETENV if you don't have unsetenv in the C library.
 #
-# Define NO_MKDTEMP if you don't have mkdtemp in the C library.
-#
 # Define MKDIR_WO_TRAILING_SLASH if your mkdir() can't deal with trailing slash.
 #
 # Define NO_GECOS_IN_PWENT if you don't have pw_gecos in struct passwd
diff --git a/compat/posix.h b/compat/posix.h
index 245386fa4a..c49d67e653 100644
--- a/compat/posix.h
+++ b/compat/posix.h
@@ -328,9 +328,7 @@ ssize_t git_pread(int fd, void *buf, size_t count, off_t offset);
 int gitsetenv(const char *, const char *, int);
 #endif
 
-#ifdef NO_MKDTEMP
 #define mkdtemp git_mkdtemp
-#endif
 
 #ifdef NO_UNSETENV
 #define unsetenv gitunsetenv
diff --git a/configure.ac b/configure.ac
index cfb50112bf..8e61186f18 100644
--- a/configure.ac
+++ b/configure.ac
@@ -1140,12 +1140,6 @@ GIT_CHECK_FUNC(unsetenv,
 [NO_UNSETENV=YesPlease])
 GIT_CONF_SUBST([NO_UNSETENV])
 #
-# Define NO_MKDTEMP if you don't have mkdtemp in the C library.
-GIT_CHECK_FUNC(mkdtemp,
-[NO_MKDTEMP=],
-[NO_MKDTEMP=YesPlease])
-GIT_CONF_SUBST([NO_MKDTEMP])
-#
 # Define NO_INITGROUPS if you don't have initgroups in the C library.
 GIT_CHECK_FUNC(initgroups,
 [NO_INITGROUPS=],
diff --git a/contrib/buildsystems/CMakeLists.txt b/contrib/buildsystems/CMakeLists.txt
index 479163ab5c..d28de227f5 100644
--- a/contrib/buildsystems/CMakeLists.txt
+++ b/contrib/buildsystems/CMakeLists.txt
@@ -374,7 +374,7 @@ endif()
 #function checks
 set(function_checks
 	strcasestr memmem strlcpy strtoimax strtoumax strtoull
-	setenv mkdtemp poll pread memmem)
+	setenv poll pread memmem)
 
 #unsetenv,hstrerror are incompatible with windows build
 if(NOT WIN32)
@@ -411,10 +411,6 @@ if(NOT HAVE_SETENV)
 	list(APPEND compat_SOURCES compat/setenv.c)
 endif()
 
-if(NOT HAVE_MKDTEMP)
-	list(APPEND compat_SOURCES compat/mkdtemp.c)
-endif()
-
 if(NOT HAVE_PREAD)
 	list(APPEND compat_SOURCES compat/pread.c)
 endif()

-Peff
