From: Brian Gernhardt <benji@silverinsanity.com>
Subject: [PATCH] Create USE_ST_TIMESPEC and turn it on for Darwin
Date: Sun,  8 Mar 2009 16:04:28 -0400
Message-ID: <1236542668-83333-1-git-send-email-benji@silverinsanity.com>
Cc: Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Mar 08 21:06:37 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LgPGO-0004oK-VF
	for gcvg-git-2@gmane.org; Sun, 08 Mar 2009 21:06:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753703AbZCHUEg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Mar 2009 16:04:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753654AbZCHUEg
	(ORCPT <rfc822;git-outgoing>); Sun, 8 Mar 2009 16:04:36 -0400
Received: from vs072.rosehosting.com ([216.114.78.72]:37561 "EHLO
	silverinsanity.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753289AbZCHUEf (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Mar 2009 16:04:35 -0400
Received: by silverinsanity.com (Postfix, from userid 5001)
	id 729F51FFC3FB; Sun,  8 Mar 2009 20:04:27 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.5 (2008-06-10) on silverinsanity.com
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=4.0 tests=ALL_TRUSTED,AWL,BAYES_00
	autolearn=ham version=3.2.5
Received: from localhost.localdomain (cpe-74-74-137-205.rochester.res.rr.com [74.74.137.205])
	by silverinsanity.com (Postfix) with ESMTPA id 3C20A1FFC043;
	Sun,  8 Mar 2009 20:04:23 +0000 (UTC)
X-Mailer: git-send-email 1.6.2.222.g01cbd
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112635>

Not all OSes use st_ctim and st_mtim in their struct stat.  In
particular, it appears that OS X uses st_*timespec instead.  So add a
Makefile variable and #define called USE_ST_TIMESPEC to switch the
USE_NSEC defines to use st_*timespec.

This also turns it on by default for OS X (Darwin) machines.  Likely
this is a sane default for other BSD kernels as well, but I don't have
any to test that assumption on.

Signed-off-by: Brian Gernhardt <benji@silverinsanity.com>
---

 This is on top of "next".

 Now time to go debug a Bus Error in git-grep that made this hard to find.

 Makefile          |    7 +++++++
 git-compat-util.h |    5 +++++
 2 files changed, 12 insertions(+), 0 deletions(-)

diff --git a/Makefile b/Makefile
index 9a23aa5..4bdaad7 100644
--- a/Makefile
+++ b/Makefile
@@ -126,6 +126,9 @@ all::
 # randomly break unless your underlying filesystem supports those sub-second
 # times (my ext3 doesn't).
 #
+# Define USE_ST_TIMESPEC if your "struct stat" uses "st_ctimespec" instead of
+# "st_ctim"
+#
 # Define NO_NSEC if your "struct stat" does not have "st_ctim.tv_nsec"
 # available.  This automatically turns USE_NSEC off.
 #
@@ -660,6 +663,7 @@ ifeq ($(uname_S),Darwin)
 	endif
 	NO_MEMMEM = YesPlease
 	THREADED_DELTA_SEARCH = YesPlease
+	USE_ST_TIMESPEC = YesPlease
 endif
 ifeq ($(uname_S),SunOS)
 	NEEDS_SOCKET = YesPlease
@@ -925,6 +929,9 @@ endif
 ifdef NO_ST_BLOCKS_IN_STRUCT_STAT
 	BASIC_CFLAGS += -DNO_ST_BLOCKS_IN_STRUCT_STAT
 endif
+ifdef USE_ST_TIMESPEC
+	BASIC_CFLAGS += -DUSE_ST_TIMESPEC
+endif
 ifdef NO_NSEC
 	BASIC_CFLAGS += -DNO_NSEC
 endif
diff --git a/git-compat-util.h b/git-compat-util.h
index 83d8389..1906253 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -393,8 +393,13 @@ void git_qsort(void *base, size_t nmemb, size_t size,
 #define ST_CTIME_NSEC(st) 0
 #define ST_MTIME_NSEC(st) 0
 #else
+#ifdef USE_ST_TIMESPEC
+#define ST_CTIME_NSEC(st) ((unsigned int)((st).st_ctimespec.tv_nsec))
+#define ST_MTIME_NSEC(st) ((unsigned int)((st).st_mtimespec.tv_nsec))
+#else
 #define ST_CTIME_NSEC(st) ((unsigned int)((st).st_ctim.tv_nsec))
 #define ST_MTIME_NSEC(st) ((unsigned int)((st).st_mtim.tv_nsec))
 #endif
+#endif
 
 #endif
-- 
1.6.2.221.g2411c.dirty
