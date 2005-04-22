From: "lode leroy" <lode_leroy@hotmail.com>
Subject: (nearly trivial) patch to compile git on cygwin
Date: Fri, 22 Apr 2005 10:09:08 +0200
Message-ID: <BAY22-F35C035C6AE6B9A45CDEF61FF2D0@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
X-From: git-owner@vger.kernel.org Fri Apr 22 10:04:59 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DOt9j-0002IY-4q
	for gcvg-git@gmane.org; Fri, 22 Apr 2005 10:04:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261860AbVDVIJW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 22 Apr 2005 04:09:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261708AbVDVIJW
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Apr 2005 04:09:22 -0400
Received: from bay22-f35.bay22.hotmail.com ([64.4.16.85]:44814 "EHLO
	hotmail.com") by vger.kernel.org with ESMTP id S261860AbVDVIJJ
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Apr 2005 04:09:09 -0400
Received: from mail pickup service by hotmail.com with Microsoft SMTPSVC;
	 Fri, 22 Apr 2005 01:09:08 -0700
Received: from 194.7.240.10 by by22fd.bay22.hotmail.msn.com with HTTP;
	Fri, 22 Apr 2005 08:09:08 GMT
X-Originating-IP: [194.7.240.10]
X-Originating-Email: [lode_leroy@hotmail.com]
X-Sender: lode_leroy@hotmail.com
To: git@vger.kernel.org
X-OriginalArrivalTime: 22 Apr 2005 08:09:08.0329 (UTC) FILETIME=[8EF45D90:01C54712]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

I wonder if anyone is interested in using git on windows / cygwin.
It almost compiles out of the box... just this one little thinggy
that's glibc-specific (struct dirent . d_type)

~/pkg $ diff -bruw git-0.6 git-0.6-cyg | grep -v ^Only
diff -bruw git-0.6/Makefile git-0.6-cyg/Makefile
--- git-0.6/Makefile    2005-04-21 19:58:47.000000000 +0200
+++ git-0.6-cyg/Makefile        2005-04-22 09:28:54.259531200 +0200
@@ -30,7 +30,7 @@
$(LIB_FILE): $(LIB_OBJS)
        $(AR) rcs $@ $(LIB_OBJS)

-LIBS= $(LIB_FILE) -lssl -lz
+LIBS= $(LIB_FILE) -lssl -lz -lcrypto

init-db: init-db.o

diff -bruw git-0.6/show-files.c git-0.6-cyg/show-files.c
--- git-0.6/show-files.c        2005-04-21 19:58:47.000000000 +0200
+++ git-0.6-cyg/show-files.c    2005-04-22 10:03:04.227240000 +0200
@@ -61,26 +61,33 @@
                                continue;
                        len = strlen(de->d_name);
                        memcpy(fullname + baselen, de->d_name, len+1);

+#ifdef DT_DIR
                        switch (de->d_type) {
+#endif
                        struct stat st;
+#ifdef DT_DIR
                        default:
                                continue;
                        case DT_UNKNOWN:
+#endif
                                if (lstat(fullname, &st))
                                        continue;
                                if (S_ISREG(st.st_mode))
                                        break;
                                if (!S_ISDIR(st.st_mode))
                                        continue;
+#ifdef DT_DIR
                                /* fallthrough */
                        case DT_DIR:
+#endif
                                memcpy(fullname + baselen + len, "/", 2);
                                read_directory(fullname, fullname, baselen + 
len + 1);
                                continue;
+#ifdef DT_DIR
                        case DT_REG:
                                break;
                        }
+#endif
                        add_name(fullname, baselen + len);
                }
                closedir(dir);
~/pkg $

_________________________________________________________________


