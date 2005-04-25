From: Thomas Glanzmann <sithglan@stud.uni-erlangen.de>
Subject: git on solaris
Date: Mon, 25 Apr 2005 21:07:04 +0200
Message-ID: <20050425190704.GB14076@cip.informatik.uni-erlangen.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="pf9I7BMVVzbSWLtt"
X-From: git-owner@vger.kernel.org Mon Apr 25 21:05:43 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DQ8tl-0005uz-Bz
	for gcvg-git@gmane.org; Mon, 25 Apr 2005 21:05:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262762AbVDYTKH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 25 Apr 2005 15:10:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262756AbVDYTJm
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Apr 2005 15:09:42 -0400
Received: from faui03.informatik.uni-erlangen.de ([131.188.30.103]:54232 "EHLO
	faui03.informatik.uni-erlangen.de") by vger.kernel.org with ESMTP
	id S262739AbVDYTHG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Apr 2005 15:07:06 -0400
Received: from faui03.informatik.uni-erlangen.de (faui03.informatik.uni-erlangen.de [131.188.30.103])
	by faui03.informatik.uni-erlangen.de (8.12.9/8.12.9) with ESMTP id j3PJ75S8021766
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <git@vger.kernel.org>; Mon, 25 Apr 2005 19:07:05 GMT
Received: (from sithglan@localhost)
	by faui03.informatik.uni-erlangen.de (8.12.9/8.12.9) id j3PJ74nk021765
	for git@vger.kernel.org; Mon, 25 Apr 2005 21:07:04 +0200 (CEST)
To: GIT <git@vger.kernel.org>
Mail-Followup-To: GIT <git@vger.kernel.org>
Content-Disposition: inline
X-URL: http://wwwcip.informatik.uni-erlangen.de/~sithglan/
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


--pf9I7BMVVzbSWLtt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello,
this patch makes git compile on Solaris, but it isn't considered for
upstream at the moment.

	Thomas

--pf9I7BMVVzbSWLtt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="git.patch.solaris"

Index: Makefile
===================================================================
--- 648b1464afe31bf85116ca64734a8b8990f4e0da/Makefile  (mode:100644 sha1:022af9b8c0a8ded65892c84bd419e46af6d2ae92)
+++ uncommitted/Makefile  (mode:100644)
@@ -21,14 +21,14 @@
 all: $(PROG)
 
 install: $(PROG)
-	install $(PROG) $(HOME)/bin/
+	ginstall $(PROG) $(HOME)/bin/
 
 LIB_OBJS=read-cache.o sha1_file.o usage.o object.o commit.o tree.o blob.o
 LIB_FILE=libgit.a
 LIB_H=cache.h object.h
 
 LIBS = $(LIB_FILE)
-LIBS += -lz
+LIBS += -lz -L /opt/csw/lib -lsocket -lnsl
 
 ifdef MOZILLA_SHA1
   SHA1_HEADER="mozilla-sha1/sha1.h"
@@ -43,7 +43,7 @@
 endif
 endif
 
-CFLAGS += '-DSHA1_HEADER=$(SHA1_HEADER)'
+CFLAGS += '-DSHA1_HEADER=$(SHA1_HEADER)' -I/opt/csw/include -D_XOPEN_SOURCE_EXTENDED=1
 
 $(LIB_FILE): $(LIB_OBJS)
 	$(AR) rcs $@ $(LIB_OBJS)
Index: rsh.c
===================================================================
--- 648b1464afe31bf85116ca64734a8b8990f4e0da/rsh.c  (mode:100644 sha1:4d6a90bf6c1b290975fb2ac22f25979be56cb476)
+++ uncommitted/rsh.c  (mode:100644)
@@ -1,6 +1,7 @@
 #include "rsh.h"
 
 #include <string.h>
+#include <sys/types.h>
 #include <sys/socket.h>
 
 #include "cache.h"
@@ -47,7 +48,7 @@
 		}
 	}
 	strcpy(posn, " -");
-	if (socketpair(AF_LOCAL, SOCK_STREAM, 0, sv)) {
+	if (socketpair(AF_UNIX, SOCK_STREAM, 0, sv)) {
 		return error("Couldn't create socket");
 	}
 	if (!fork()) {
Index: show-files.c
===================================================================
--- 648b1464afe31bf85116ca64734a8b8990f4e0da/show-files.c  (mode:100644 sha1:b53ab1053e1acf7e2a1e9c97a4d87b76e8ee238e)
+++ uncommitted/show-files.c  (mode:100644)
@@ -51,6 +51,7 @@
 
 	if (dir) {
 		struct dirent *de;
+		struct stat st;
 		char fullname[MAXPATHLEN + 1];
 		memcpy(fullname, base, baselen);
 
@@ -62,8 +63,8 @@
 			len = strlen(de->d_name);
 			memcpy(fullname + baselen, de->d_name, len+1);
 
+#if __LINUX__
 			switch (de->d_type) {
-			struct stat st;
 			default:
 				continue;
 			case DT_UNKNOWN:
@@ -81,6 +82,17 @@
 			case DT_REG:
 				break;
 			}
+#else
+			if (lstat(fullname, &st))
+				continue;
+			if (S_ISDIR(st.st_mode)) {
+				memcpy(fullname + baselen + len, "/", 2);
+				read_directory(fullname, fullname, baselen + len + 1);
+				continue;
+			}
+			if (!S_ISREG(st.st_mode))
+				break;
+#endif
 			add_name(fullname, baselen + len);
 		}
 		closedir(dir);

--pf9I7BMVVzbSWLtt--
