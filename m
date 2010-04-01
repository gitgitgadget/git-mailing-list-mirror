From: Eric Blake <eblake@redhat.com>
Subject: [PATCH] Makefile: update defaults for modern Cygwin
Date: Thu,  1 Apr 2010 16:43:54 -0600
Message-ID: <1270161834-9597-1-git-send-email-eblake@redhat.com>
Cc: jon.seymour@gmail.com, jrnieder@gmail.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 02 00:45:20 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NxT8Z-0006qb-5C
	for gcvg-git-2@lo.gmane.org; Fri, 02 Apr 2010 00:45:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757317Ab0DAWpN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Apr 2010 18:45:13 -0400
Received: from qmta03.emeryville.ca.mail.comcast.net ([76.96.30.32]:55979 "EHLO
	qmta03.emeryville.ca.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757253Ab0DAWpK (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 1 Apr 2010 18:45:10 -0400
Received: from omta22.emeryville.ca.mail.comcast.net ([76.96.30.89])
	by qmta03.emeryville.ca.mail.comcast.net with comcast
	id 0GxR1e0091vN32cA3NlBZz; Thu, 01 Apr 2010 22:45:11 +0000
Received: from localhost.localdomain ([24.10.248.129])
	by omta22.emeryville.ca.mail.comcast.net with comcast
	id 0NpW1e00N2oEyzc8iNpZkA; Thu, 01 Apr 2010 22:49:34 +0000
X-Mailer: git-send-email 1.6.6.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143758>

Now that Cygwin 1.7.x has enabled lots of new features, and Cygwin 1.5
is no longer actively supported by the Cygwin mailing lists, we might
as well update the defaults to cater to those new features.

NO_TRUSTABLE_FILEMODE is only necessary on FAT drives; the Cygwin
community recommends NTFS drives, but there is still too much use
for FAT to switch the default.  Likewise, UNRELIABLE_FSTAT is probably
file-system specific, but worth keeping unchanged.

This commit does not change the default for NO_MMAP, although definitive
proof of whether this option is necessary is lacking.

Signed-off-by: Eric Blake <eblake@redhat.com>
---
 Makefile |   22 ++++++++++++----------
 1 files changed, 12 insertions(+), 10 deletions(-)

diff --git a/Makefile b/Makefile
index 3e816e1..442ce0b 100644
--- a/Makefile
+++ b/Makefile
@@ -34,7 +34,7 @@ all::
 # Define NO_D_INO_IN_DIRENT if you don't have d_ino in your struct dirent.
 #
 # Define NO_D_TYPE_IN_DIRENT if your platform defines DT_UNKNOWN but lacks
-# d_type in struct dirent (latest Cygwin -- will be fixed soonish).
+# d_type in struct dirent (Cygwin 1.5, fixed in Cygwin 1.7).
 #
 # Define NO_C99_FORMAT if your formatted IO functions (printf/scanf et.al.)
 # do not support the 'size specifiers' introduced by C99, namely ll, hh,
@@ -109,7 +109,7 @@ all::
 # Define NO_PTHREADS if you do not have or do not want to use Pthreads.
 #
 # Define NO_PREAD if you have a problem with pread() system call (e.g.
-# cygwin.dll before v1.5.22).
+# cygwin1.dll before v1.5.22).
 #
 # Define NO_FAST_WORKING_DIRECTORY if accessing objects in pack files is
 # generally faster on your platform than accessing the working directory.
@@ -831,22 +831,24 @@ ifeq ($(uname_S),SunOS)
 	BASIC_CFLAGS += -D__EXTENSIONS__ -D__sun__ -DHAVE_ALLOCA_H
 endif
 ifeq ($(uname_O),Cygwin)
-	NO_D_TYPE_IN_DIRENT = YesPlease
-	NO_D_INO_IN_DIRENT = YesPlease
-	NO_STRCASESTR = YesPlease
-	NO_MEMMEM = YesPlease
-	NO_MKSTEMPS = YesPlease
-	NO_SYMLINK_HEAD = YesPlease
+	ifneq ($(wordlist 1, 2, $(subst ., ,$(uname_R))),1 7)
+		NO_D_TYPE_IN_DIRENT = YesPlease
+		NO_D_INO_IN_DIRENT = YesPlease
+		NO_STRCASESTR = YesPlease
+		NO_MEMMEM = YesPlease
+		NO_MKSTEMPS = YesPlease
+		NO_SYMLINK_HEAD = YesPlease
+		NO_IPV6 = YesPlease
+		OLD_ICONV = UnfortunatelyYes
+	endif
 	NEEDS_LIBICONV = YesPlease
 	NO_FAST_WORKING_DIRECTORY = UnfortunatelyYes
 	NO_TRUSTABLE_FILEMODE = UnfortunatelyYes
-	OLD_ICONV = UnfortunatelyYes
 	NO_ST_BLOCKS_IN_STRUCT_STAT = YesPlease
 	# There are conflicting reports about this.
 	# On some boxes NO_MMAP is needed, and not so elsewhere.
 	# Try commenting this out if you suspect MMAP is more efficient
 	NO_MMAP = YesPlease
-	NO_IPV6 = YesPlease
 	X = .exe
 	COMPAT_OBJS += compat/cygwin.o
 	UNRELIABLE_FSTAT = UnfortunatelyYes
-- 
1.6.6.1
