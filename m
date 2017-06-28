Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D75351FCCA
	for <e@80x24.org>; Wed, 28 Jun 2017 16:30:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751626AbdF1QaE (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Jun 2017 12:30:04 -0400
Received: from mout.web.de ([212.227.17.12]:63118 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751518AbdF1QaD (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Jun 2017 12:30:03 -0400
Received: from tor.lan ([195.198.252.176]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MRlIL-1dJKvB0pEv-00SyYz; Wed, 28
 Jun 2017 18:30:00 +0200
From:   tboegi@web.de
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>
Subject: [PATCH/RFC v1 1/1] cygwin: Allow pushing to UNC paths
Date:   Wed, 28 Jun 2017 18:29:58 +0200
Message-Id: <20170628162958.519-1-tboegi@web.de>
X-Mailer: git-send-email 2.10.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:5LohYo627JFCRmBcFj/tFn84rhlZ/m3+IIW6p/lHVe0JpEbC3a4
 b6hMbly6LKo6UU54V5V0I9eYO/JofduDnxYwkPD0ICw9LDHFYbDKBqINMWlhYbTxFbXH/K1
 cfLVHe267/KOSkXEFLcsVS521j0czEtU8FZCgvk3AQxHCpAIyclKH7urRQEfw2JsjFPxbHr
 2cCNYnUbPPxD4to6MEP6Q==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Wtm1gNKS+u4=:rue1mzJZKowgXCHMzvmuvx
 sqLxcYGsyl58L5kvqZKDh6v1IyOPzBMcPM2GuPuajqzVI0SxdqPs2Y97rn+Ka4rX6fpgKwEhm
 ry4Jh+5KNUctT7G6MPL28mIm+wrVMlnVoVt8B8Y4z5kk72beNxHBFQOgfEEVkUtML7ykQWkEi
 chN6fRVPCc277CfoXo9Ot3Gok/H35+aOnidINn0VCnlz94OhSf59JWGKPDA0SCnirEH0OKKws
 JJ8HtC2XTOKyD6i6jSCLcjFzQMTn7XsJ3fHvX2gTxSmErBNrBeGxl7VeCvv1eHmnHLyakxKXS
 HRvs8I5/HjqSveGu8xHF68NBDNPbROvshS147LkJZE4kARILflcuOiFSGqhQ9Uq72iH0sk3TU
 4EjLAhjjum+JLYsCoY29WrJNAYLB/n9UBNAOn/loOos3ldmp3S9NQzXXXmgVP5+jP8fcOrVuk
 GPxg/t674nfwA5r6p0Jti7os7DqUme2NdoXbofEvwwVwPiX1mjFor4vHKP86XL9HoqfmHHOnS
 7k2mtEtlHyXpuOs7zhj+KconA+Lxt6uCVDi9opElj/UrtfkRTsBGkn7DzXaLq413mNcLk64I+
 kqN5JIWcGl+h/28bEI/1VtgRloFGD9YHlW6HYB9SAsf9aRM1v6Wg5z9e3u+auTE5aSUG3mw79
 3RGkYeJ3J/Rg0kTvJh87H1riAk4e9MgP6iOV6zjp8K6mY4UkgP6pMYg0dPmBZBD+SLRMTenyp
 Q+tr167vT982eFRuQBIRtYm16pO8zw2S1mS79ZYwyzwvnyrRrKEJkc5PD56tEzK4s/sPQsSw0
 zx5kzgH
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Torsten Bögershausen <tboegi@web.de>

cygwin can use an UNC path like //server/share/repo
$ cd //server/share/dir
$ mkdir test
$ cd test
$ git init --bare

However, when we try to push from a local Git repository to this repo,
there are 2 problems:
- Git converts the leading "//" into a single "/".
- The remote repo is not accepted because setup.c calls
  access(getenv(DB_ENVIRONMENT), X_OK)
  and this call fails. In other words, checking the executable bit
  of a directory mounted on a SAMBA share is not reliable (and not needed).

As cygwin handles an UNC path so well, Git can support them better.
- Introduce cygwin_offset_1st_component() which keeps the leading "//",
  similar to what Git for Windows does.
- Move CYGWIN out of the POSIX in the tests for path normalization in t0060.
- Use cygwin_access() with a relaxed test for the executable bit on
  a directory pointed out by an UNC path.

Signed-off-by: Torsten Bögershausen <tboegi@web.de>
---
 compat/cygwin.c       | 29 +++++++++++++++++++++++++++++
 compat/cygwin.h       |  7 +++++++
 config.mak.uname      |  1 +
 git-compat-util.h     |  3 +++
 t/t0060-path-utils.sh |  2 ++
 5 files changed, 42 insertions(+)
 create mode 100644 compat/cygwin.c
 create mode 100644 compat/cygwin.h

diff --git a/compat/cygwin.c b/compat/cygwin.c
new file mode 100644
index 0000000..d98e877
--- /dev/null
+++ b/compat/cygwin.c
@@ -0,0 +1,29 @@
+#include "../git-compat-util.h"
+#include "../cache.h"
+
+int cygwin_offset_1st_component(const char *path)
+{
+	const char *pos = path;
+	/* unc paths */
+	if (is_dir_sep(pos[0]) && is_dir_sep(pos[1])) {
+		/* skip server name */
+		pos = strchr(pos + 2, '/');
+		if (!pos)
+			return 0; /* Error: malformed unc path */
+
+		do {
+			pos++;
+		} while (*pos && pos[0] != '/');
+	}
+	return pos + is_dir_sep(*pos) - path;
+}
+
+#undef access
+int cygwin_access(const char *filename, int mode)
+{
+	/* the execute bit does not work on SAMBA drives */
+	if (filename[0] == '/' && filename[1] == '/' )
+		return access(filename, mode & ~X_OK);
+	else
+		return access(filename, mode);
+}
diff --git a/compat/cygwin.h b/compat/cygwin.h
new file mode 100644
index 0000000..efa12ad
--- /dev/null
+++ b/compat/cygwin.h
@@ -0,0 +1,7 @@
+int cygwin_access(const char *filename, int mode);
+#undef access
+#define access cygwin_access
+
+
+int cygwin_offset_1st_component(const char *path);
+#define offset_1st_component cygwin_offset_1st_component
diff --git a/config.mak.uname b/config.mak.uname
index adfb90b..551e465 100644
--- a/config.mak.uname
+++ b/config.mak.uname
@@ -184,6 +184,7 @@ ifeq ($(uname_O),Cygwin)
 	UNRELIABLE_FSTAT = UnfortunatelyYes
 	SPARSE_FLAGS = -isystem /usr/include/w32api -Wno-one-bit-signed-bitfield
 	OBJECT_CREATION_USES_RENAMES = UnfortunatelyNeedsTo
+	COMPAT_OBJS += compat/cygwin.o
 endif
 ifeq ($(uname_S),FreeBSD)
 	NEEDS_LIBICONV = YesPlease
diff --git a/git-compat-util.h b/git-compat-util.h
index 047172d..db9c22d 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -189,6 +189,9 @@
 #include <sys/sysctl.h>
 #endif
 
+#if defined(__CYGWIN__)
+#include "compat/cygwin.h"
+#endif
 #if defined(__MINGW32__)
 /* pull in Windows compatibility stuff */
 #include "compat/mingw.h"
diff --git a/t/t0060-path-utils.sh b/t/t0060-path-utils.sh
index 444b5a4..7ea2bb5 100755
--- a/t/t0060-path-utils.sh
+++ b/t/t0060-path-utils.sh
@@ -70,6 +70,8 @@ ancestor() {
 case $(uname -s) in
 *MINGW*)
 	;;
+*CYGWIN*)
+	;;
 *)
 	test_set_prereq POSIX
 	;;
-- 
2.10.0

