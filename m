From: Emil Medve <Emilian.Medve@Freescale.com>
Subject: [PATCH] Fix a strchrnul() related build error
Date: Mon, 12 Nov 2007 15:01:22 -0600
Message-ID: <1194901282-2468-1-git-send-email-Emilian.Medve@Freescale.com>
Cc: Emil Medve <Emilian.Medve@Freescale.com>
To: gitster@pobox.com, ae@op5.se, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 12 22:03:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IrgQx-0003RY-2a
	for gcvg-git-2@gmane.org; Mon, 12 Nov 2007 22:03:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760174AbXKLVCB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Nov 2007 16:02:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759724AbXKLVCA
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Nov 2007 16:02:00 -0500
Received: from az33egw02.freescale.net ([192.88.158.103]:59070 "EHLO
	az33egw02.freescale.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760162AbXKLVB7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Nov 2007 16:01:59 -0500
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw02.freescale.net (8.12.11/az33egw02) with ESMTP id lACL1OuG022786;
	Mon, 12 Nov 2007 14:01:25 -0700 (MST)
Received: from localhost.localdomain ([10.82.125.87])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id lACL1NxF007928;
	Mon, 12 Nov 2007 15:01:24 -0600 (CST)
X-Mailer: git-send-email 1.5.3.5.1466.gfa36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64709>

Systems/environments without glibc (such as CygWin), and as a consequence whithout the
__GLIBC_PREREQ() macro, fail to build with the following error message:

    CC git.o
In file included from builtin.h:4,
                 from git.c:1:
git-compat-util.h:187:48: missing binary operator before token "("

Signed-off-by: Emil Medve <Emilian.Medve@Freescale.com>
---

Here is a relevant comment from my Linux box features.h:

/* Convenience macros to test the versions of glibc and gcc.
   Use them like this:
   #if __GNUC_PREREQ (2,8)
   ... code requiring gcc 2.8 or later ...
   #endif
   Note - they won't work for gcc1 or glibc1, since the _MINOR macros
   were not defined then.  */

My CygWin gcc version is:

$ gcc -dumpversion
3.4.4

This applies to next

 git-compat-util.h |    8 +++++++-
 1 files changed, 7 insertions(+), 1 deletions(-)

diff --git a/git-compat-util.h b/git-compat-util.h
index 3d147b6..c4ed308 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -184,7 +184,13 @@ void *gitmemmem(const void *haystack, size_t haystacklen,
                 const void *needle, size_t needlelen);
 #endif
 
-#if !defined(__GLIBC_PREREQ) && !__GLIBC_PREREQ(2, 1)
+#ifndef __GLIBC_PREREQ
+#define NO_STRCHRNUL
+#elif !__GLIBC_PREREQ(2, 1)
+#define NO_STRCHRNUL
+#endif
+
+#ifdef NO_STRCHRNUL
 #define strchrnul gitstrchrnul
 static inline char *gitstrchrnul(const char *s, int c)
 {
-- 
1.5.3.5.1466.gfa36
