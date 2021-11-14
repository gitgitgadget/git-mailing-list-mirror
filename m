Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E78CC433EF
	for <git@archiver.kernel.org>; Sun, 14 Nov 2021 21:27:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3BEF861104
	for <git@archiver.kernel.org>; Sun, 14 Nov 2021 21:27:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236366AbhKNV3w (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 14 Nov 2021 16:29:52 -0500
Received: from ring.crustytoothpaste.net ([172.105.110.227]:42788 "EHLO
        ring.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236403AbhKNV3l (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 14 Nov 2021 16:29:41 -0500
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:a6ae:7d13:8741:9028])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by ring.crustytoothpaste.net (Postfix) with ESMTPSA id 386F45D403
        for <git@vger.kernel.org>; Sun, 14 Nov 2021 21:26:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1636925203;
        bh=FKgcsM6+AfCIZ1UncJ+bErj90GPgr/Le+F5HOQdgcGY=;
        h=From:To:Subject:Date:In-Reply-To:References:From:Reply-To:Subject:
         Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:
         References:Content-Type:Content-Disposition;
        b=y8jIRUr8KfGQOgvrKcA0tqIIQ2QPT+w2ejvMx9tsM65WtbMcy9B1o1dN1WBfxYS+R
         VOtIS/4//vC47OMuSMq1fg/ZY8YXwvgMokGTqB5+avTVB8ZfIjP88XVdCGdlxPGSma
         ZgocV2f3G17H3Prgbe3maKqIkVYLPqiSM01vTZ3raGuuFjNQWIosBJAyJ2C4E6BapP
         aHHiIPyLnPDMAUC3g3ofUZtHPUV70qOaprbcWtVAHgxmhYPev7WWfN59ss8NUmL2FW
         gwaUkvmaKrO7sAvUnbWutQKp8SA/ARDwT1eworUvIcDtoNJw85GPj7JWfuydFwACDu
         H9OwWNd+i44HOmh0n1fqaENR11Ail2QIxVfRZo+GRldQ1jRhhyRUF6jmAIaaDwiXtt
         Isu9Lb2hMCFkDTRzBiZ+p0zpDql2nHq3BV4Ps1KfpyHTDtLtEZl3FgJTi6nzynajam
         hX15kOP1M52Nw6y5V73wjokXhA6bRJBBpRJW231XfMRzhtm8rPe
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Subject: [PATCH 1/1] git-compat-util: add a test balloon for C99 support
Date:   Sun, 14 Nov 2021 21:24:37 +0000
Message-Id: <20211114212437.1466695-2-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.33.1.1089.g2158813163f
In-Reply-To: <20211114212437.1466695-1-sandals@crustytoothpaste.net>
References: <20211114212437.1466695-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The C99 standard was released in January 1999, now 22 years ago.  It
provides a variety of useful features, including variadic arguments for
macros, declarations after statements, variable length arrays, and a
wide variety of other useful features, many of which we already use.

We'd like to take advantage of these features, but we want to be
cautious.  As far as we know, all major compilers now support C99 or a
later C standard, such as C11 or C17.  POSIX has required C99 support as
a requirement for the 2001 revision, so we can safely assume any POSIX
system which we are interested in supporting has C99.

Even MSVC, long a holdout against modern C, now supports both C11 and
C17 with an appropriate update.  Moreover, even if people are using an
older version of MSVC on these systems, they will generally need some
implementation of the standard Unix utilities for the testsuite, and GNU
coreutils, the most common option, has required C99 since 2009.
Therefore, we can safely assume that a suitable version of GCC or clang
is available to users even if their version of MSVC is not sufficiently
capable.

Let's add a test balloon to git-compat-util.h to see if anyone is using
an older compiler.  We'll add a comment telling people how to enable
this functionality on GCC and Clang, even though modern versions of both
will automatically do the right thing, and ask people still experiencing
a problem to report that to us on the list.

Note that C89 compilers don't provide the __STDC_VERSION__ macro, so we
use a well-known hack of using "- 0".  On compilers with this macro, it
doesn't change the value, and on C89 compilers, the macro will be
replaced with nothing, and our value will be 0.

Sparse is also updated with a reference to the gnu99 standard, without
which it defaults to C89.

Update the cmake configuration to require C11 for MSVC.  We do this
because this will make MSVC to use C11, since it does not explicitly
support C99.  We do this with a compiler options because setting the
C_STANDARD option does not work in our CI on MSVC and at the moment, we
don't want to require C11 for Unix compilers.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 Makefile                            |  4 ++--
 contrib/buildsystems/CMakeLists.txt |  3 +--
 git-compat-util.h                   | 12 ++++++++++++
 3 files changed, 15 insertions(+), 4 deletions(-)

diff --git a/Makefile b/Makefile
index 12be39ac49..22d9e67542 100644
--- a/Makefile
+++ b/Makefile
@@ -1204,7 +1204,7 @@ endif
 # Set CFLAGS, LDFLAGS and other *FLAGS variables. These might be
 # tweaked by config.* below as well as the command-line, both of
 # which'll override these defaults.
-CFLAGS = -g -O2 -Wall
+CFLAGS = -g -O2 -Wall -std=gnu99
 LDFLAGS =
 CC_LD_DYNPATH = -Wl,-rpath,
 BASIC_CFLAGS = -I.
@@ -1215,7 +1215,7 @@ ARFLAGS = rcs
 PTHREAD_CFLAGS =
 
 # For the 'sparse' target
-SPARSE_FLAGS ?=
+SPARSE_FLAGS ?= -std=gnu99
 SP_EXTRA_FLAGS = -Wno-universal-initializer
 
 # For informing GIT-BUILD-OPTIONS of the SANITIZE=leak target
diff --git a/contrib/buildsystems/CMakeLists.txt b/contrib/buildsystems/CMakeLists.txt
index fd1399c440..91e8525fa9 100644
--- a/contrib/buildsystems/CMakeLists.txt
+++ b/contrib/buildsystems/CMakeLists.txt
@@ -208,7 +208,7 @@ endif()
 if(CMAKE_C_COMPILER_ID STREQUAL "MSVC")
 	set(CMAKE_RUNTIME_OUTPUT_DIRECTORY_DEBUG ${CMAKE_BINARY_DIR})
 	set(CMAKE_RUNTIME_OUTPUT_DIRECTORY_RELEASE ${CMAKE_BINARY_DIR})
-	add_compile_options(/MP)
+	add_compile_options(/MP /std:c11)
 endif()
 
 #default behaviour
@@ -600,7 +600,6 @@ endif()
 list(REMOVE_DUPLICATES excluded_progs)
 list(REMOVE_DUPLICATES PROGRAMS_BUILT)
 
-
 foreach(p ${excluded_progs})
 	list(APPEND EXCLUSION_PROGS --exclude-program ${p} )
 endforeach()
diff --git a/git-compat-util.h b/git-compat-util.h
index d70ce14286..6d995bdc0f 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -1,6 +1,18 @@
 #ifndef GIT_COMPAT_UTIL_H
 #define GIT_COMPAT_UTIL_H
 
+#if __STDC_VERSION__ - 0 < 199901L
+/*
+ * Git is in a testing period for mandatory C99 support in the compiler.  If
+ * your compiler is reasonably recent, you can try to enable C99 support (or,
+ * for MSVC, C11 support).  If you encounter a problem and can't enable C99
+ * support with your compiler and don't have access to one with this support,
+ * such as GCC or Clang, you can remove this #if directive, but please report
+ * the details of your system to git@vger.kernel.org.
+ */
+#error "Required C99 support is in a test phase.  Please see git-compat-util.h for more details."
+#endif
+
 #ifdef USE_MSVC_CRTDBG
 /*
  * For these to work they must appear very early in each
