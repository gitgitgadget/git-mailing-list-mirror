Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DD94C433F5
	for <git@archiver.kernel.org>; Tue, 16 Nov 2021 05:10:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 40DD261A6C
	for <git@archiver.kernel.org>; Tue, 16 Nov 2021 05:10:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229815AbhKPFNm (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Nov 2021 00:13:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245753AbhKPFNg (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Nov 2021 00:13:36 -0500
Received: from ring.crustytoothpaste.net (ring.crustytoothpaste.net [IPv6:2600:3c04::f03c:92ff:fe9e:c6d8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4B04C0B193E
        for <git@vger.kernel.org>; Mon, 15 Nov 2021 18:12:56 -0800 (PST)
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:a6ae:7d13:8741:9028])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by ring.crustytoothpaste.net (Postfix) with ESMTPSA id D24495D469;
        Tue, 16 Nov 2021 02:12:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1637028775;
        bh=27i9Bvw396hV/Ir/g6rU3b+bEw1Riui5nE9Awf2i2Uo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=oQDjhAOkpW2jgYvqF/y5JCiFLM3z/9tqm9WQc12xWYv0eQBlHS4wuXmKdk53RQOtn
         KnemfzMhZYbk9Y2nX44MR+uOXoYLhWjNm+LmapPC858c0FRYp9rUAQS4ul1aEAqtWH
         d4aeOPkExzgx3QNh8glYLwbckpPcYFrs1dR1ZtC1V9V+kl+euy991efv6RNjvIaqVk
         6Hg8HAFx8jkv9elYIqy+MJvlbIxGAFXZk9OuUoeUoPE9wxIyMrMVosJDWELKZ9v3N+
         kdwQpwbnD2Ud7EyP1tsOj7WLBsOKAx+LJ+nvQPyzyexINKYaqwmjyKPteFS4JE+Unk
         vny1TIJlpfBhYQa2+MYpQ+JU0RK4W+IBEYwRgIcbHSU73ZdsHw9MLP2RoARk8b0gyh
         BS8e0R2B3dj4OWjpKSdiSnbj94luVh3+BPTbV/HARMpOH3wNzXxGRYoe02RaTd/Wmm
         eIgsmcHhMcvPsOeEiJ9rbPKLN62UwPbvpMagDNndAf8DoosmxRe
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 1/1] git-compat-util: add a test balloon for C99 support
Date:   Tue, 16 Nov 2021 02:12:41 +0000
Message-Id: <20211116021241.1565740-2-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.33.1.1089.g2158813163f
In-Reply-To: <20211116021241.1565740-1-sandals@crustytoothpaste.net>
References: <20211114212437.1466695-1-sandals@crustytoothpaste.net>
 <20211116021241.1565740-1-sandals@crustytoothpaste.net>
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

We explicitly request the gnu99 style because we've traditionally taken
advantage of some GCC- and clang-specific extensions when available and
we'd like to retain the ability to do that, especially now that we're
building with -pedantic in developer mode.  Older compilers may in fact
support C99 just fine, but default to C89 without an option, so the
option is necessary.  Allow it to be overridden by the user or
config.mak.uname to ensure that people using other compilers can make it
work.

Update the cmake configuration to require C11 for MSVC.  We do this
because this will make MSVC to use C11, since it does not explicitly
support C99.  We do this with a compiler options because setting the
C_STANDARD option does not work in our CI on MSVC and at the moment, we
don't want to require C11 for Unix compilers.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 Makefile                            |  2 +-
 contrib/buildsystems/CMakeLists.txt |  2 +-
 git-compat-util.h                   | 12 ++++++++++++
 3 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/Makefile b/Makefile
index 12be39ac49..893d533d22 100644
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
diff --git a/contrib/buildsystems/CMakeLists.txt b/contrib/buildsystems/CMakeLists.txt
index fd1399c440..07b6c5494b 100644
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
