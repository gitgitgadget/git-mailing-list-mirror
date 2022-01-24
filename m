Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10003C433F5
	for <git@archiver.kernel.org>; Mon, 24 Jan 2022 02:54:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240973AbiAXCyK (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 23 Jan 2022 21:54:10 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:58619 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240920AbiAXCyK (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 23 Jan 2022 21:54:10 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 289961154B7;
        Sun, 23 Jan 2022 21:54:09 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=f2HE+ZV3AlRh
        Lc2IT5zDI+M0AnpTQZH21CCHlrMP5AI=; b=CJnlp6OA6Ih5ugwfsh/btKENaoBf
        LsU755WTpwYeReiE6wWW38Mmn6Zh2RV/2qOMgValZrq1JAcUhDlGS5PaAHQOd1NH
        o6fbnwy8fFiCk5xIzOx1zHLjvTmB+G9JL+hYRcySEZWwXbgNkQuc8kvV3lwGwAjn
        bD+HRdjnpgteX+c=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 11E051154B6;
        Sun, 23 Jan 2022 21:54:09 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 5BFBD1154B5;
        Sun, 23 Jan 2022 21:54:08 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Cc:     Beat Bolli <dev+git@drbeat.li>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        David Aguilar <davvid@gmail.com>,
        "Randall S . Becker" <randall.becker@nexbridge.ca>,
        Taylor Blau <me@ttaylorr.com>,
        Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= 
        <carenas@gmail.com>, =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Subject: [PATCH v4] compat: auto-detect if zlib has uncompress2()
References: <patch-v2-1.1-444eacf30be-20220119T094428Z-avarab@gmail.com>
        <patch-v3-1.1-e9cb8763fd4-20220120T011414Z-avarab@gmail.com>
        <xmqqr190ekrh.fsf@gitster.g>
        <74d35354-20a6-9cc1-3452-573460c694bd@drbeat.li>
        <xmqqtudu9s7k.fsf@gitster.g>
Date:   Sun, 23 Jan 2022 18:54:07 -0800
In-Reply-To: <xmqqtudu9s7k.fsf@gitster.g> (Junio C. Hamano's message of "Sun,
        23 Jan 2022 11:18:07 -0800")
Message-ID: <xmqqh79t7sj4.fsf_-_@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: E67A2D3C-7CC0-11EC-9112-CB998F0A682E-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>

We have a copy of uncompress2() implementation in compat/ so that we
can build with an older version of zlib that lack the function, and
the build procedure selects if it is used via the NO_UNCOMPRESS2
$(MAKE) variable.  This is yet another "annoying" knob the porters
need to tweak on platforms that are not common enough to have the
default set in the config.mak.uname file.

=C3=86var came up with an idea to instead ask the system header <zlib.h>
to decide if we need the compatibility implementation.  We can
compile and link compat/zlib-uncompress2.c file unconditionally, but
conditionally hide the implementation behind #if/#endif when zlib
version is 1.2.9 or newer, and unconditionally archive the resulting
object file in the libgit.a to be picked up by the linker.

There are a few things to note in the shape of the code base after
this change:

 - We no longer use NO_UNCOMPRESS2 knob; if the system header
   <zlib.h> claims a version that is more cent than the library
   actually is, this would break, but it is easy to add it back when
   we find such a system.

 - The object file compat/zlib-uncompress2.o is always compiled and
   archived in libgit.a, just like a few other compat/ object files
   already are.

 - The inclusion of <zlib.h> is done in <git-compat-util.h>; we used
   to do so from <cache.h> which includes <git-compat-util.h> as the
   first thing it does, so from the *.c codes, there is no practical
   change.

 - Beat found a trick used by OpenSSL to avoid making the
   conditionally-compiled object truly empty (apparently because
   they had to deal with compilers that do not want to see an
   effectively empty input file).  Our compat/zlib-uncompress2.c
   file borrows the same trick for portabilty.

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
Helped-by: Beat Bolli <dev+git@drbeat.li>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * So, here is an updated one, still retaining the authorship but
   adjusting for the "no empty source" trick.  v3 seems to fail
   "win+VS build" due to the use of an extra $(ZLIB_COMPAT_OBJS)
   macro, and this iteration, which just uses LIB_OBJS as everybody
   else does, should be sufficient to avoid introducing such an
   issue.

   One thing that I found a bit iffy is the use of "force z_const to
   an empty string before including <zlib.h>".  This trick to work
   around too old a version of zlib (according to Carlo) was used
   only when compat/zlib-uncompress2.c included <zlib.h> via
   <reftable/system.h>, but never done when <cache.h> included
   <zlib.h>, which means that the two parts of the code could have
   been using incompatible definitions of the same structs (many
   struct definitions zlib uses have const members).  I opted to be
   "conservative" and choose to cast away z_const before
   <git-compat-util.> includes <zlib.h>, but we may want to drop it
   to see if anybody screams.

   In any case, I think it is way too late to put this in the final.
   We may want to reroll it once more to reintroduce NO_UNCOMPRESS2
   as an escape hatch for those with zlib.h headers that lie, but
   all of that can wait until the end of the next week.

 Makefile                  |  8 +-------
 cache.h                   |  1 -
 ci/lib.sh                 |  1 -
 compat/zlib-uncompress2.c | 11 ++++++-----
 config.mak.uname          |  7 -------
 configure.ac              | 13 -------------
 git-compat-util.h         | 12 ++++++++++++
 reftable/system.h         | 11 -----------
 8 files changed, 19 insertions(+), 45 deletions(-)

diff --git c/Makefile w/Makefile
index 5580859afd..a32d278700 100644
--- c/Makefile
+++ w/Makefile
@@ -256,8 +256,6 @@ all::
 #
 # Define NO_DEFLATE_BOUND if your zlib does not have deflateBound.
 #
-# Define NO_UNCOMPRESS2 if your zlib does not have uncompress2.
-#
 # Define NO_NORETURN if using buggy versions of gcc 4.6+ and profile fee=
dback,
 # as the compiler can crash (http://gcc.gnu.org/bugzilla/show_bug.cgi?id=
=3D49299)
 #
@@ -862,6 +860,7 @@ LIB_OBJS +=3D commit-reach.o
 LIB_OBJS +=3D commit.o
 LIB_OBJS +=3D compat/obstack.o
 LIB_OBJS +=3D compat/terminal.o
+LIB_OBJS +=3D compat/zlib-uncompress2.o
 LIB_OBJS +=3D config.o
 LIB_OBJS +=3D connect.o
 LIB_OBJS +=3D connected.o
@@ -1726,11 +1725,6 @@ ifdef NO_DEFLATE_BOUND
 	BASIC_CFLAGS +=3D -DNO_DEFLATE_BOUND
 endif
=20
-ifdef NO_UNCOMPRESS2
-	BASIC_CFLAGS +=3D -DNO_UNCOMPRESS2
-	REFTABLE_OBJS +=3D compat/zlib-uncompress2.o
-endif
-
 ifdef NO_POSIX_GOODIES
 	BASIC_CFLAGS +=3D -DNO_POSIX_GOODIES
 endif
diff --git c/cache.h w/cache.h
index 281f00ab1b..3a0142aa56 100644
--- c/cache.h
+++ w/cache.h
@@ -18,7 +18,6 @@
 #include "repository.h"
 #include "mem-pool.h"
=20
-#include <zlib.h>
 typedef struct git_zstream {
 	z_stream z;
 	unsigned long avail_in;
diff --git c/ci/lib.sh w/ci/lib.sh
index 9d28ab50fb..cbc2f8f1ca 100755
--- c/ci/lib.sh
+++ w/ci/lib.sh
@@ -197,7 +197,6 @@ esac
 case "$jobname" in
 linux32)
 	CC=3Dgcc
-	MAKEFLAGS=3D"$MAKEFLAGS NO_UNCOMPRESS2=3D1"
 	;;
 linux-musl)
 	CC=3Dgcc
diff --git c/compat/zlib-uncompress2.c w/compat/zlib-uncompress2.c
index 722610b971..77a1b08048 100644
--- c/compat/zlib-uncompress2.c
+++ w/compat/zlib-uncompress2.c
@@ -1,3 +1,6 @@
+#include "git-compat-util.h"
+
+#if ZLIB_VERNUM < 0x1290
 /* taken from zlib's uncompr.c
=20
    commit cacf7f1d4e3d44d871b605da3b647f07d718623f
@@ -8,16 +11,11 @@
=20
 */
=20
-#include "../reftable/system.h"
-#define z_const
-
 /*
  * Copyright (C) 1995-2003, 2010, 2014, 2016 Jean-loup Gailly, Mark Adle=
r
  * For conditions of distribution and use, see copyright notice in zlib.=
h
  */
=20
-#include <zlib.h>
-
 /* clang-format off */
=20
 /* =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
@@ -93,3 +91,6 @@ int ZEXPORT uncompress2 (
 	   err =3D=3D Z_BUF_ERROR && left + stream.avail_out ? Z_DATA_ERROR :
 	   err;
 }
+#else
+static void *dummy_variable =3D &dummy_variable;
+#endif
diff --git c/config.mak.uname w/config.mak.uname
index c48db45106..92ea00c219 100644
--- c/config.mak.uname
+++ w/config.mak.uname
@@ -66,7 +66,6 @@ ifeq ($(uname_S),Linux)
 	# centos7/rhel7 provides gcc 4.8.5 and zlib 1.2.7.
 	ifneq ($(findstring .el7.,$(uname_R)),)
 		BASIC_CFLAGS +=3D -std=3Dc99
-		NO_UNCOMPRESS2 =3D YesPlease
 	endif
 endif
 ifeq ($(uname_S),GNU/kFreeBSD)
@@ -266,10 +265,6 @@ ifeq ($(uname_S),FreeBSD)
 	FILENO_IS_A_MACRO =3D UnfortunatelyYes
 endif
 ifeq ($(uname_S),OpenBSD)
-	# Versions < 7.0 need compatibility layer
-	ifeq ($(shell expr "$(uname_R)" : "[1-6]\."),2)
-		NO_UNCOMPRESS2 =3D UnfortunatelyYes
-	endif
 	NO_STRCASESTR =3D YesPlease
 	NO_MEMMEM =3D YesPlease
 	USE_ST_TIMESPEC =3D YesPlease
@@ -525,7 +520,6 @@ ifeq ($(uname_S),Interix)
 	endif
 endif
 ifeq ($(uname_S),Minix)
-	NO_UNCOMPRESS2 =3D YesPlease
 	NO_IPV6 =3D YesPlease
 	NO_ST_BLOCKS_IN_STRUCT_STAT =3D YesPlease
 	NO_NSEC =3D YesPlease
@@ -581,7 +575,6 @@ ifeq ($(uname_S),NONSTOP_KERNEL)
 	NO_SETENV =3D YesPlease
 	NO_UNSETENV =3D YesPlease
 	NO_MKDTEMP =3D YesPlease
-	NO_UNCOMPRESS2 =3D YesPlease
 	# Currently libiconv-1.9.1.
 	OLD_ICONV =3D UnfortunatelyYes
 	NO_REGEX =3D NeedsStartEnd
diff --git c/configure.ac w/configure.ac
index d60d494ee4..5ee25ec95c 100644
--- c/configure.ac
+++ w/configure.ac
@@ -664,22 +664,9 @@ AC_LINK_IFELSE([ZLIBTEST_SRC],
 	NO_DEFLATE_BOUND=3Dyes])
 LIBS=3D"$old_LIBS"
=20
-AC_DEFUN([ZLIBTEST_UNCOMPRESS2_SRC], [
-AC_LANG_PROGRAM([#include <zlib.h>],
- [uncompress2(NULL,NULL,NULL,NULL);])])
-AC_MSG_CHECKING([for uncompress2 in -lz])
-old_LIBS=3D"$LIBS"
-LIBS=3D"$LIBS -lz"
-AC_LINK_IFELSE([ZLIBTEST_UNCOMPRESS2_SRC],
-	[AC_MSG_RESULT([yes])],
-	[AC_MSG_RESULT([no])
-	NO_UNCOMPRESS2=3Dyes])
-LIBS=3D"$old_LIBS"
-
 GIT_UNSTASH_FLAGS($ZLIB_PATH)
=20
 GIT_CONF_SUBST([NO_DEFLATE_BOUND])
-GIT_CONF_SUBST([NO_UNCOMPRESS2])
=20
 #
 # Define NEEDS_SOCKET if linking with libc is not enough (SunOS,
diff --git c/git-compat-util.h w/git-compat-util.h
index 1229c8296b..ea111a7b48 100644
--- c/git-compat-util.h
+++ w/git-compat-util.h
@@ -1386,6 +1386,18 @@ void unleak_memory(const void *ptr, size_t len);
 #define UNLEAK(var) do {} while (0)
 #endif
=20
+#define z_const
+#include <zlib.h>
+
+#if ZLIB_VERNUM < 0x1290
+/*
+ * This is uncompress2, which is only available in zlib >=3D 1.2.9
+ * (released as of early 2017). See compat/zlib-uncompress2.c.
+ */
+int uncompress2(Bytef *dest, uLongf *destLen, const Bytef *source,
+		uLong *sourceLen);
+#endif
+
 /*
  * This include must come after system headers, since it introduces macr=
os that
  * replace system names.
diff --git c/reftable/system.h w/reftable/system.h
index 4907306c0c..18f9207dfe 100644
--- c/reftable/system.h
+++ w/reftable/system.h
@@ -16,17 +16,6 @@ license that can be found in the LICENSE file or at
 #include "hash.h" /* hash ID, sizes.*/
 #include "dir.h" /* remove_dir_recursively, for tests.*/
=20
-#include <zlib.h>
-
-#ifdef NO_UNCOMPRESS2
-/*
- * This is uncompress2, which is only available in zlib >=3D 1.2.9
- * (released as of early 2017)
- */
-int uncompress2(Bytef *dest, uLongf *destLen, const Bytef *source,
-		uLong *sourceLen);
-#endif
-
 int hash_size(uint32_t id);
=20
 #endif
