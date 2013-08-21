From: Steffen Prohaska <prohaska@zib.de>
Subject: [PATCH v5 2/2] Revert "compate/clipped-write.c: large write(2) fails on Mac OS X/XNU"
Date: Wed, 21 Aug 2013 15:46:22 +0200
Message-ID: <1377092782-11924-3-git-send-email-prohaska@zib.de>
References: <1376981035-23284-1-git-send-email-prohaska@zib.de>
 <1377092782-11924-1-git-send-email-prohaska@zib.de>
Cc: git@vger.kernel.org, Steffen Prohaska <prohaska@zib.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Aug 21 15:46:55 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VC8kQ-0005UJ-0c
	for gcvg-git-2@plane.gmane.org; Wed, 21 Aug 2013 15:46:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751811Ab3HUNqu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Aug 2013 09:46:50 -0400
Received: from mailer.zib.de ([130.73.108.11]:62678 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751511Ab3HUNqs (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Aug 2013 09:46:48 -0400
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id r7LDkcJI019200;
	Wed, 21 Aug 2013 15:46:43 +0200 (CEST)
Received: from vss6.zib.de (vss6.zib.de [130.73.69.7])
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id r7LDkXOo022380;
	Wed, 21 Aug 2013 15:46:38 +0200 (MEST)
X-Mailer: git-send-email 1.8.4.rc0.11.g35f5eaa
In-Reply-To: <1377092782-11924-1-git-send-email-prohaska@zib.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232705>

The previous commit introduced a size limit on IO chunks on all
platforms.  The compat clipped_write() is not needed anymore.

This reverts commit 6c642a878688adf46b226903858b53e2d31ac5c3.

Signed-off-by: Steffen Prohaska <prohaska@zib.de>
---
 Makefile               |  8 --------
 compat/clipped-write.c | 13 -------------
 config.mak.uname       |  1 -
 git-compat-util.h      |  5 -----
 4 files changed, 27 deletions(-)
 delete mode 100644 compat/clipped-write.c

diff --git a/Makefile b/Makefile
index 3588ca1..4026211 100644
--- a/Makefile
+++ b/Makefile
@@ -69,9 +69,6 @@ all::
 # Define NO_MSGFMT_EXTENDED_OPTIONS if your implementation of msgfmt
 # doesn't support GNU extensions like --check and --statistics
 #
-# Define NEEDS_CLIPPED_WRITE if your write(2) cannot write more than
-# INT_MAX bytes at once (e.g. MacOS X).
-#
 # Define HAVE_PATHS_H if you have paths.h and want to use the default PATH
 # it specifies.
 #
@@ -1493,11 +1490,6 @@ ifndef NO_MSGFMT_EXTENDED_OPTIONS
 	MSGFMT += --check --statistics
 endif
 
-ifdef NEEDS_CLIPPED_WRITE
-	BASIC_CFLAGS += -DNEEDS_CLIPPED_WRITE
-	COMPAT_OBJS += compat/clipped-write.o
-endif
-
 ifneq (,$(XDL_FAST_HASH))
 	BASIC_CFLAGS += -DXDL_FAST_HASH
 endif
diff --git a/compat/clipped-write.c b/compat/clipped-write.c
deleted file mode 100644
index b8f98ff..0000000
--- a/compat/clipped-write.c
+++ /dev/null
@@ -1,13 +0,0 @@
-#include "../git-compat-util.h"
-#undef write
-
-/*
- * Version of write that will write at most INT_MAX bytes.
- * Workaround a xnu bug on Mac OS X
- */
-ssize_t clipped_write(int fildes, const void *buf, size_t nbyte)
-{
-	if (nbyte > INT_MAX)
-		nbyte = INT_MAX;
-	return write(fildes, buf, nbyte);
-}
diff --git a/config.mak.uname b/config.mak.uname
index b27f51d..7d61531 100644
--- a/config.mak.uname
+++ b/config.mak.uname
@@ -95,7 +95,6 @@ ifeq ($(uname_S),Darwin)
 	NO_MEMMEM = YesPlease
 	USE_ST_TIMESPEC = YesPlease
 	HAVE_DEV_TTY = YesPlease
-	NEEDS_CLIPPED_WRITE = YesPlease
 	COMPAT_OBJS += compat/precompose_utf8.o
 	BASIC_CFLAGS += -DPRECOMPOSE_UNICODE
 endif
diff --git a/git-compat-util.h b/git-compat-util.h
index 115cb1d..96d8881 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -185,11 +185,6 @@ typedef unsigned long uintptr_t;
 #define probe_utf8_pathname_composition(a,b)
 #endif
 
-#ifdef NEEDS_CLIPPED_WRITE
-ssize_t clipped_write(int fildes, const void *buf, size_t nbyte);
-#define write(x,y,z) clipped_write((x),(y),(z))
-#endif
-
 #ifdef MKDIR_WO_TRAILING_SLASH
 #define mkdir(a,b) compat_mkdir_wo_trailing_slash((a),(b))
 extern int compat_mkdir_wo_trailing_slash(const char*, mode_t);
-- 
1.8.4.rc3.5.g4f480ff
