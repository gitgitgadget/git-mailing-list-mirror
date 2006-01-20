From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] DT_UNKNOWN: do not fully trust existence of DT_UNKNOWN
Date: Thu, 19 Jan 2006 17:13:57 -0800
Message-ID: <7voe277lbe.fsf@assigned-by-dhcp.cox.net>
References: <81b0412b0601180547q4a812c8xb632de6ab13a5e62@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Christopher Faylor <me@cgf.cx>
X-From: git-owner@vger.kernel.org Fri Jan 20 02:14:13 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ezkqs-0001WO-4D
	for gcvg-git@gmane.org; Fri, 20 Jan 2006 02:14:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030438AbWATBOB (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 19 Jan 2006 20:14:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030445AbWATBOB
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Jan 2006 20:14:01 -0500
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:6794 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S1030438AbWATBOA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Jan 2006 20:14:00 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060120011246.PYMS6244.fed1rmmtao11.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 19 Jan 2006 20:12:46 -0500
To: Alex Riesen <raa.lkml@gmail.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14949>

The recent Cygwin defines DT_UNKNOWN although it does not have d_type
in struct dirent.  Give an option to tell us not to use d_type on such
platforms.  Hopefully this problem will be transient.

Signed-off-by: Junio C Hamano <junkio@cox.net>

---

 * By sending this out, I am not claiming this is better than
   your version or anything like that.  This is just for
   completeness and convenience, because my other two patches
   touch overlapping areas in the same Makefile.  This patch
   comes after the other two.

 Makefile |    7 +++++++
 cache.h  |    2 +-
 2 files changed, 8 insertions(+), 1 deletions(-)

80a4322a9bfbf0389ba8cb50f674682349f40a3a
diff --git a/Makefile b/Makefile
index 31898f7..84f5d24 100644
--- a/Makefile
+++ b/Makefile
@@ -21,6 +21,9 @@ all:
 #
 # Define NO_D_INO_IN_DIRENT if you don't have d_ino in your struct dirent.
 #
+# Define NO_D_TYPE_IN_DIRENT if your platform defines DT_UNKNOWN but lacks
+# d_type in struct dirent (latest Cygwin -- will be fixed soonish).
+#
 # Define NO_STRCASESTR if you don't have strcasestr.
 #
 # Define NO_SETENV if you don't have setenv in the C library.
@@ -233,6 +236,7 @@ ifeq ($(uname_S),SunOS)
 	ALL_CFLAGS += -D__EXTENSIONS__
 endif
 ifeq ($(uname_O),Cygwin)
+	NO_D_TYPE_IN_DIRENT = YesPlease
 	NO_D_INO_IN_DIRENT = YesPlease
 	NO_STRCASESTR = YesPlease
 	NEEDS_LIBICONV = YesPlease
@@ -335,6 +339,9 @@ ifdef NEEDS_NSL
 	LIBS += -lnsl
 	SIMPLE_LIB += -lnsl
 endif
+ifdef NO_D_TYPE_IN_DIRENT
+	ALL_CFLAGS += -DNO_D_TYPE_IN_DIRENT
+endif
 ifdef NO_D_INO_IN_DIRENT
 	ALL_CFLAGS += -DNO_D_INO_IN_DIRENT
 endif
diff --git a/cache.h b/cache.h
index 29c9e81..3d79c55 100644
--- a/cache.h
+++ b/cache.h
@@ -10,7 +10,7 @@
 #define deflateBound(c,s)  ((s) + (((s) + 7) >> 3) + (((s) + 63) >> 6) + 11)
 #endif
 
-#ifdef DT_UNKNOWN
+#if defined(DT_UNKNOWN) && !NO_D_TYPE_IN_DIRENT
 #define DTYPE(de)	((de)->d_type)
 #else
 #define DT_UNKNOWN	0
-- 
1.1.3-gacdd
