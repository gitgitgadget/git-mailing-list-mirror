Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0660BC433EF
	for <git@archiver.kernel.org>; Wed,  1 Dec 2021 01:42:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345519AbhLABpu (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 30 Nov 2021 20:45:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231186AbhLABps (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Nov 2021 20:45:48 -0500
Received: from ring.crustytoothpaste.net (ring.crustytoothpaste.net [IPv6:2600:3c04::f03c:92ff:fe9e:c6d8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEA50C061746
        for <git@vger.kernel.org>; Tue, 30 Nov 2021 17:42:28 -0800 (PST)
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:a6ae:7d13:8741:9028])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by ring.crustytoothpaste.net (Postfix) with ESMTPSA id 2B4175D46D;
        Wed,  1 Dec 2021 01:42:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1638322948;
        bh=qawNPhOc33fLbAvDyLvYct4c/70QeejBMBUFdUwoDuo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=TWGljimhKQx7GaBzS/hxkxfvoqrUXrxFkQR9uZKcIT9W2Q/7/l9fT5uIF/8Qd6Y9W
         wKk6aOrehbJNMm92A0n3bGICV8vDxpySvxGfpgVjMiM7BZxuimcnhF7RDaI7d2PwOE
         BNRkNIGDl3p78xtaArBBTDcDhT9l+U8CY8P2ohpRXK6beDcRrTwdjELDNbSuz5ATT+
         vmjm7O72ZrQ+RWJGRB2FaGm2f1s0qSg1awgnC9+qhjGrxUOkAm35Eyj63RbSh82F+8
         nN5+cdPqKdDFi6pJD//E/cyDf8NWKHA50dHvS/vUmEjhDPkKySU2yOtD+3kqlcPeh0
         YHWg3ncHdaFFQSWK8mEe1WaOnwAhba+U7+9mLFEPT24zSy9A/vFFr47yOq6Wb82D8C
         kRhDqrQsD6q7q9m0CpjiAmlCyAKhAqKVh1z2UBpePQmf30T7dWxqTgZr40T3ezG6H/
         YSbr2QrENCBtRx00H5xfQBWGvlgNxYqZM5zdLRqv3Mzu63Sdr49
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 1/1] git-compat-util: add a test balloon for C99 support
Date:   Wed,  1 Dec 2021 01:40:50 +0000
Message-Id: <20211201014050.38002-2-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.34.0.390.gb44f4d0eb0c
In-Reply-To: <20211201014050.38002-1-sandals@crustytoothpaste.net>
References: <20211114212437.1466695-1-sandals@crustytoothpaste.net>
 <20211201014050.38002-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The C99 standard was released in January 1999, now 22 years ago.  It
provides a variety of useful features, including variadic arguments for
macros, declarations after statements, designated initializers, and a
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

For sparse, we explicitly request the gnu99 style because we've
traditionally taken advantage of some GCC- and clang-specific extensions
when available and we'd like to retain the ability to do that.  sparse
also defaults to C89 without it, so things will fail for us if we don't.

Update the cmake configuration to require C11 for MSVC.  We do this
because this will make MSVC to use C11, since it does not explicitly
support C99.  We do this with a compiler options because setting the
C_STANDARD option does not work in our CI on MSVC and at the moment, we
don't want to require C11 for Unix compilers.

In the Makefile, don't set any compiler flags for the compiler itself,
since on some systems, such as FreeBSD, we actually need C11, and asking
for C99 causes things to fail to compile.  The error message should make
it obvious what's going wrong and allow a user to set the appropriate
option when building in the event they're using a Unix compiler that
doesn't support it by default.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 Makefile                            |  2 +-
 contrib/buildsystems/CMakeLists.txt |  2 +-
 git-compat-util.h                   | 13 +++++++++++++
 3 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/Makefile b/Makefile
index 12be39ac49..3d0ce6ddf6 100644
--- a/Makefile
+++ b/Makefile
@@ -1215,7 +1215,7 @@ ARFLAGS = rcs
 PTHREAD_CFLAGS =
 
 # For the 'sparse' target
-SPARSE_FLAGS ?=
+SPARSE_FLAGS ?= -std=gnu99
 SP_EXTRA_FLAGS = -Wno-universal-initializer
 
 # For informing GIT-BUILD-OPTIONS of the SANITIZE=leak target
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
index d70ce14286..ffe70b570f 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -1,6 +1,19 @@
 #ifndef GIT_COMPAT_UTIL_H
 #define GIT_COMPAT_UTIL_H
 
+#if __STDC_VERSION__ - 0 < 199901L
+/*
+ * Git is in a testing period for mandatory C99 support in the compiler.  If
+ * your compiler is reasonably recent, you can try to enable C99 support (or,
+ * for MSVC, C11 support).  If you encounter a problem and can't enable C99
+ * support with your compiler (such as with "-std=gnu99") and don't have access
+ * to one with this support, such as GCC or Clang, you can remove this #if
+ * directive, but please report the details of your system to
+ * git@vger.kernel.org.
+ */
+#error "Required C99 support is in a test phase.  Please see git-compat-util.h for more details."
+#endif
+
 #ifdef USE_MSVC_CRTDBG
 /*
  * For these to work they must appear very early in each
