From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: [PATCH 5/8] git-compat-util.h: tweak the way _XOPEN_SOURCE is set on Solaris
Date: Fri,  5 Jun 2009 18:36:13 -0500
Message-ID: <67hZHClrEWQHxCRdWosE26gwuGblUI8bcWLxyoPZhmfzJAibRVMtix-zkRUKYe5Y8R8-GRcIkUI@cipher.nrlssc.navy.mil>
References: <7vk53vlxhz.fsf@alter.siamese.dyndns.org> <67hZHClrEWQHxCRdWosE25_CVQVNIYpTaeW2DKuCCDfW4h-jHQ82zlGcCNn49KcxUKsj-TSJSVQ@cipher.nrlssc.navy.mil> <67hZHClrEWQHxCRdWosE24eNsO0do05033zPcGsXrwIRCoU8GtXor_XD8ayKlybu-V7PGeTC_PA@cipher.nrlssc.navy.mil> <67hZHClrEWQHxCRdWosE21Y219yACHqb_DoUmykc1kiOxwRuziSDMczTdmGkyEob9g6DVoIraR4@cipher.nrlssc.navy.mil> <67hZHClrEWQHxCRdWosE24FbCSWPktK230jx86LzLj0Aqa5g5XoJb3Iv805pzfx5wCPameuSp6M@cipher.nrlssc.navy.mil> <67hZHClrEWQHxCRdWosE28bOBU_EdMUdyv6uENKCaQfOLQjhGBq3kLwxe6mMrfW4HauaUwWt5eM@cipher.nrlssc.navy.mil>
Cc: gitster@pobox.com, peff@peff.net, Brandon Casey <drafnel@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 06 01:40:11 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MCj18-0003L7-RU
	for gcvg-git-2@gmane.org; Sat, 06 Jun 2009 01:40:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753257AbZFEXjo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Jun 2009 19:39:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753252AbZFEXjn
	(ORCPT <rfc822;git-outgoing>); Fri, 5 Jun 2009 19:39:43 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:42259 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752674AbZFEXjl (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Jun 2009 19:39:41 -0400
Received: by mail.nrlssc.navy.mil id n55NaS13019262; Fri, 5 Jun 2009 18:36:30 -0500
In-Reply-To: <67hZHClrEWQHxCRdWosE28bOBU_EdMUdyv6uENKCaQfOLQjhGBq3kLwxe6mMrfW4HauaUwWt5eM@cipher.nrlssc.navy.mil>
X-OriginalArrivalTime: 05 Jun 2009 23:36:28.0364 (UTC) FILETIME=[72B1B0C0:01C9E636]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120847>

From: Brandon Casey <drafnel@gmail.com>

On Solaris, when _XOPEN_EXTENDED is set, its header file forces the
programs to be XPG4v2, defeating any _XOPEN_SOURCE setting to say we are
XPG5 or XPG6.  Also on Solaris, XPG6 programs must be compiled with a c99
compiler, while non XPG6 programs must be compiled with a pre-c99 compiler.

So when compiling on Solaris, always refrain from setting _XOPEN_EXTENDED,
and then set _XOPEN_SOURCE to 600 or 500 based on whether a c99 compiler
is being used or not.

Signed-off-by: Brandon Casey <drafnel@gmail.com>
---
 git-compat-util.h |   17 ++++++++++++++---
 1 files changed, 14 insertions(+), 3 deletions(-)

diff --git a/git-compat-util.h b/git-compat-util.h
index f25f7f1..13e450d 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -39,12 +39,23 @@
 /* Approximation of the length of the decimal representation of this type. */
 #define decimal_length(x)	((int)(sizeof(x) * 2.56 + 0.5) + 1)
 
-#if !defined(__APPLE__) && !defined(__FreeBSD__)  && !defined(__USLC__) && !defined(_M_UNIX)
+#if defined(__sun__)
+ /*
+  * On Solaris, when _XOPEN_EXTENDED is set, its header file
+  * forces the programs to be XPG4v2, defeating any _XOPEN_SOURCE
+  * setting to say we are XPG5 or XPG6.  Also on Solaris,
+  * XPG6 programs must be compiled with a c99 compiler, while
+  * non XPG6 programs must be compiled with a pre-c99 compiler.
+  */
+# if __STDC_VERSION__ - 0 >= 199901L
+# define _XOPEN_SOURCE 600
+# else
+# define _XOPEN_SOURCE 500
+# endif
+#elif !defined(__APPLE__) && !defined(__FreeBSD__)  && !defined(__USLC__) && !defined(_M_UNIX)
 #define _XOPEN_SOURCE 600 /* glibc2 and AIX 5.3L need 500, OpenBSD needs 600 for S_ISLNK() */
-#ifndef __sun__
 #define _XOPEN_SOURCE_EXTENDED 1 /* AIX 5.3L needs this */
 #endif
-#endif
 #define _ALL_SOURCE 1
 #define _GNU_SOURCE 1
 #define _BSD_SOURCE 1
-- 
1.6.3.1.24.g152f4
