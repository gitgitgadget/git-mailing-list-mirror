Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4264EC433F5
	for <git@archiver.kernel.org>; Mon, 24 Jan 2022 18:28:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245260AbiAXS2E (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 Jan 2022 13:28:04 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:60312 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245257AbiAXS2D (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Jan 2022 13:28:03 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 5E5CA1791A9;
        Mon, 24 Jan 2022 13:28:03 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type
        :content-transfer-encoding; s=sasl; bh=HaX133RBapUcnoI3PgKSUmX9A
        z89eyKQgQ8KU29prxc=; b=XcERdWY8DM+r/Pn7t46IjuiX8VCb3pnAR42KA9pqP
        I7UT4tpL0hWeIZ46lGix2gt4VYFhUzzfhh1dfaBRmvykT9kOSc/KVtnYAtVUgIiH
        tYsoLLTTzPt/Neq7wGNN1qJmAeBC5F94FLKWNo8y8SxOh9HYT1iVxCFgYPJz+LE+
        jQ=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 573231791A8;
        Mon, 24 Jan 2022 13:28:03 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id BB9281791A5;
        Mon, 24 Jan 2022 13:28:00 -0500 (EST)
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
Subject: [PATCH v5] compat: auto-detect if zlib has uncompress2()
References: <patch-v2-1.1-444eacf30be-20220119T094428Z-avarab@gmail.com>
        <patch-v3-1.1-e9cb8763fd4-20220120T011414Z-avarab@gmail.com>
        <xmqqr190ekrh.fsf@gitster.g>
        <74d35354-20a6-9cc1-3452-573460c694bd@drbeat.li>
        <xmqqtudu9s7k.fsf@gitster.g> <xmqqh79t7sj4.fsf_-_@gitster.g>
Date:   Mon, 24 Jan 2022 10:27:59 -0800
Message-ID: <xmqqr18x3s5s.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 5C61CDAC-7D43-11EC-9D88-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
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

Attempt to instead ask the system header <zlib.h> to decide if we
need the compatibility implementation.  This is a deviation from the
way we have been handling the "compatiblity" features so far, and if
it can be done cleanly enough, it could work as a model for features
that need compatibility definition we discover in the future.  With
that goal in mind, avoid expedient but ugly hacks, like shoving the
code that is conditionally compiled into an unrelated .c file, which
may not work in future cases---instead, take an approach that uses a
file that is independently compiled and stands on its own.

Compile and link compat/zlib-uncompress2.c file unconditionally, but
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

 - Until objects in libgit.a that is already used gains a reference
   to the function, the reftable code will be the only one that
   wants it, so libgit.a on the linker command line needs to appear
   once more at the end to satisify the mutual dependency.

 - Beat found a trick used by OpenSSL to avoid making the
   conditionally-compiled object truly empty (apparently because
   they had to deal with compilers that do not want to see an
   effectively empty input file).  Our compat/zlib-uncompress2.c
   file borrows the same trick for portabilty.

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
Helped-by: Beat Bolli <dev+git@drbeat.li>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * With a single-liner update to the Makefile with an updated log
   message that explains the change.  I am not sure if this version
   can become the model of future "compat" support, or we should
   just discard the new approach and use the Makefile macro approach
   that has worked well for all of our existing compat support
   already.

Range-diff against v4:
1:  d26c9073bf ! 1:  63c5753c6f compat: auto-detect if zlib has uncompres=
s2()
    @@ Commit message
         need to tweak on platforms that are not common enough to have th=
e
         default set in the config.mak.uname file.
    =20
    -    =C3=86var came up with an idea to instead ask the system header =
<zlib.h>
    -    to decide if we need the compatibility implementation.  We can
    -    compile and link compat/zlib-uncompress2.c file unconditionally,=
 but
    +    Attempt to instead ask the system header <zlib.h> to decide if w=
e
    +    need the compatibility implementation.  This is a deviation from=
 the
    +    way we have been handling the "compatiblity" features so far, an=
d if
    +    it can be done cleanly enough, it could work as a model for feat=
ures
    +    that need compatibility definition we discover in the future.  W=
ith
    +    that goal in mind, avoid expedient but ugly hacks, like shoving =
the
    +    code that is conditionally compiled into an unrelated .c file, w=
hich
    +    may not work in future cases---instead, take an approach that us=
es a
    +    file that is independently compiled and stands on its own.
    +
    +    Compile and link compat/zlib-uncompress2.c file unconditionally,=
 but
         conditionally hide the implementation behind #if/#endif when zli=
b
         version is 1.2.9 or newer, and unconditionally archive the resul=
ting
         object file in the libgit.a to be picked up by the linker.
    @@ Commit message
            first thing it does, so from the *.c codes, there is no pract=
ical
            change.
    =20
    +     - Until objects in libgit.a that is already used gains a refere=
nce
    +       to the function, the reftable code will be the only one that
    +       wants it, so libgit.a on the linker command line needs to app=
ear
    +       once more at the end to satisify the mutual dependency.
    +
          - Beat found a trick used by OpenSSL to avoid making the
            conditionally-compiled object truly empty (apparently because
            they had to deal with compilers that do not want to see an
    @@ Makefile: THIRD_PARTY_SOURCES +=3D compat/regex/%
      THIRD_PARTY_SOURCES +=3D sha1dc/%
     =20
     -GITLIBS =3D common-main.o $(LIB_FILE) $(XDIFF_LIB) $(REFTABLE_LIB)
    ++# xdiff and reftable libs may in turn depend on what is in libgit.a
     +GITLIBS =3D common-main.o $(LIB_FILE) $(XDIFF_LIB) $(REFTABLE_LIB) =
$(LIB_FILE)
      EXTLIBS =3D
     =20

 Makefile                  | 11 +++--------
 cache.h                   |  1 -
 ci/lib.sh                 |  1 -
 compat/zlib-uncompress2.c | 11 ++++++-----
 config.mak.uname          |  7 -------
 configure.ac              | 13 -------------
 git-compat-util.h         | 12 ++++++++++++
 reftable/system.h         | 11 -----------
 8 files changed, 21 insertions(+), 46 deletions(-)

diff --git a/Makefile b/Makefile
index 5580859afd..f194b2afc6 100644
--- a/Makefile
+++ b/Makefile
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
@@ -1194,7 +1193,8 @@ THIRD_PARTY_SOURCES +=3D compat/regex/%
 THIRD_PARTY_SOURCES +=3D sha1collisiondetection/%
 THIRD_PARTY_SOURCES +=3D sha1dc/%
=20
-GITLIBS =3D common-main.o $(LIB_FILE) $(XDIFF_LIB) $(REFTABLE_LIB)
+# xdiff and reftable libs may in turn depend on what is in libgit.a
+GITLIBS =3D common-main.o $(LIB_FILE) $(XDIFF_LIB) $(REFTABLE_LIB) $(LIB=
_FILE)
 EXTLIBS =3D
=20
 GIT_USER_AGENT =3D git/$(GIT_VERSION)
@@ -1726,11 +1726,6 @@ ifdef NO_DEFLATE_BOUND
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
diff --git a/cache.h b/cache.h
index 281f00ab1b..3a0142aa56 100644
--- a/cache.h
+++ b/cache.h
@@ -18,7 +18,6 @@
 #include "repository.h"
 #include "mem-pool.h"
=20
-#include <zlib.h>
 typedef struct git_zstream {
 	z_stream z;
 	unsigned long avail_in;
diff --git a/ci/lib.sh b/ci/lib.sh
index 9d28ab50fb..cbc2f8f1ca 100755
--- a/ci/lib.sh
+++ b/ci/lib.sh
@@ -197,7 +197,6 @@ esac
 case "$jobname" in
 linux32)
 	CC=3Dgcc
-	MAKEFLAGS=3D"$MAKEFLAGS NO_UNCOMPRESS2=3D1"
 	;;
 linux-musl)
 	CC=3Dgcc
diff --git a/compat/zlib-uncompress2.c b/compat/zlib-uncompress2.c
index 722610b971..77a1b08048 100644
--- a/compat/zlib-uncompress2.c
+++ b/compat/zlib-uncompress2.c
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
diff --git a/config.mak.uname b/config.mak.uname
index c48db45106..92ea00c219 100644
--- a/config.mak.uname
+++ b/config.mak.uname
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
diff --git a/configure.ac b/configure.ac
index d60d494ee4..5ee25ec95c 100644
--- a/configure.ac
+++ b/configure.ac
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
diff --git a/git-compat-util.h b/git-compat-util.h
index 1229c8296b..ea111a7b48 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
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
diff --git a/reftable/system.h b/reftable/system.h
index 4907306c0c..18f9207dfe 100644
--- a/reftable/system.h
+++ b/reftable/system.h
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
--=20
2.35.0-155-g0eb5153edc

