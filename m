From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH] Work around missing strtoumax on Solaris.
Date: Mon, 19 Feb 2007 02:36:13 -0500
Message-ID: <20070219073613.GA30144@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Mon Feb 19 08:36:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HJ34N-0003f3-UE
	for gcvg-git@gmane.org; Mon, 19 Feb 2007 08:36:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750704AbXBSHgR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 19 Feb 2007 02:36:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750719AbXBSHgR
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Feb 2007 02:36:17 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:52791 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750704AbXBSHgQ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Feb 2007 02:36:16 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HJ34I-0001IJ-Df; Mon, 19 Feb 2007 02:36:14 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 443A120FBAE; Mon, 19 Feb 2007 02:36:13 -0500 (EST)
Content-Disposition: inline
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40100>

Solaris 9 apparently lacks the strtoumax function in its C library.
But it does have strtoull and uintmax_t appears to be defined to
be unsigned long long.

We now set NO_STRTOUMAX in the Makefile for SunOS systems, and
if this is set define strtoumax to be strtoull.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---

 Too bad I missed 1.5.0.1!  Time for 1.5.0.2 ?  ;-)

 Makefile          |    6 ++++++
 git-compat-util.h |    4 ++++
 2 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/Makefile b/Makefile
index ebecbbd..e8a827d 100644
--- a/Makefile
+++ b/Makefile
@@ -28,6 +28,8 @@ all::
 #
 # Define NO_STRLCPY if you don't have strlcpy.
 #
+# Define NO_STRTOUMAX if you don't have strtoumax.
+#
 # Define NO_SETENV if you don't have setenv in the C library.
 #
 # Define NO_SYMLINK_HEAD if you never want .git/HEAD to be a symbolic link.
@@ -348,6 +350,7 @@ ifeq ($(uname_S),SunOS)
 	NEEDS_NSL = YesPlease
 	SHELL_PATH = /bin/bash
 	NO_STRCASESTR = YesPlease
+	NO_STRTOUMAX = YesPlease
 	ifeq ($(uname_R),5.8)
 		NEEDS_LIBICONV = YesPlease
 		NO_UNSETENV = YesPlease
@@ -517,6 +520,9 @@ ifdef NO_STRLCPY
 	COMPAT_CFLAGS += -DNO_STRLCPY
 	COMPAT_OBJS += compat/strlcpy.o
 endif
+ifdef NO_STRTOUMAX
+	COMPAT_CFLAGS += -DNO_STRTOUMAX
+endif
 ifdef NO_SETENV
 	COMPAT_CFLAGS += -DNO_SETENV
 	COMPAT_OBJS += compat/setenv.o
diff --git a/git-compat-util.h b/git-compat-util.h
index 105ac28..f812f8e 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -139,6 +139,10 @@ extern char *gitstrcasestr(const char *haystack, const char *needle);
 extern size_t gitstrlcpy(char *, const char *, size_t);
 #endif
 
+#ifdef NO_STRTOUMAX
+#define strtoumax strtoull
+#endif
+
 extern void release_pack_memory(size_t);
 
 static inline char* xstrdup(const char *str)
-- 
1.5.0.552.ge1b1c
