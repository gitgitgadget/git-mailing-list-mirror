From: Boyd Lynn Gerber <gerberb@zenez.com>
Subject: [PATCH] version 0001 Port to 12 other Platforms.
Date: Sun, 8 Jun 2008 15:36:36 -0600
Message-ID: <Pine.LNX.4.64.0806081535080.18454@xenau.zenez.com>
References: <Pine.LNX.4.64.0806080926240.18454@xenau.zenez.com>
 <m3prqsvsiq.fsf@localhost.localdomain> <Pine.LNX.4.64.0806080959390.18454@xenau.zenez.com>
 <7vhcc3kbdw.fsf@gitster.siamese.dyndns.org> <Pine.LNX.4.64.0806081443130.18454@xenau.zenez.com>
 <7v8wxfiq01.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jakub Narebski <jnareb@gmail.com>, Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jun 08 23:37:33 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K5SZv-0008HQ-Ld
	for gcvg-git-2@gmane.org; Sun, 08 Jun 2008 23:37:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756089AbYFHVgi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Jun 2008 17:36:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756081AbYFHVgi
	(ORCPT <rfc822;git-outgoing>); Sun, 8 Jun 2008 17:36:38 -0400
Received: from zenez.com ([166.70.62.2]:13232 "EHLO xenau.zenez.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756018AbYFHVgh (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Jun 2008 17:36:37 -0400
Received: by xenau.zenez.com (Postfix, from userid 1000)
	id F0B12E60BA; Sun,  8 Jun 2008 15:36:36 -0600 (MDT)
Received: from localhost (localhost [127.0.0.1])
	by xenau.zenez.com (Postfix) with ESMTP id E3BC6E60B9;
	Sun,  8 Jun 2008 15:36:36 -0600 (MDT)
In-Reply-To: <7v8wxfiq01.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84327>


This patch adds support to compile and run git on 12 additional platforms.
The platforms are based on UNIX Systems Labs (USL)/Novell/SYS V code base.
The most common are Novell UnixWare 2.X.X, SCO UnixWare 7.X.X,
OpenServer 5.0.X, OpenServer 6.0.X, and SCO pre OSR 5 platforms.

This is from

The problem is that git source  has blocked some typedefs
by excluding certain <sys/types.h> content.

Looking at the the various platform header, I see around line 450

     && !defined(_POSIX_C_SOURCE) && !defined(_XOPEN_SOURCE)

which hides  u_short and other typedefs that other header files on these
platforms dependon.  With _XOPEN_SOURCE defined, sources that include
system header files that depend on the typedefs such as u_short cannot
be compiled on these platforms.

They all lead back to about line 66 in git-compat-util.h

I had to make the following changes

ned(_M_UNIX)
 #define _XOPEN_SOURCE 600 /* glibc2 and AIX 5.3L need 500, OpenBSD needs 600 fo
r S_ISLNK() */
 #define _XOPEN_SOURCE_EXTENDED 1 /* AIX 5.3L needs this */
 #endif

The _XOPEN_SOURCE hides many typedefs.
__USLC__ indicates UNIX System Labs Corperation (USLC), or a Novell-derived
compiler and/or some SysV based OS's.

__M_UNIX indicates XENIX/SCO UNIX/OpenServer 5.0.7 and prior releases
of the SCO OS's.  It is used just like Apple and BSD, both of these
shouldn't have _XOPEN_SOURCE defined.

This is with suggestions and modifications from

Daniel Barkalow <barkalow@iabervon.org>
Junio C Hamano <gitster@pobox.com>
Thomas Harning <harningt@gmail.com>
Jeremy Maitin-Shepard <jbms@cmu.edu>

Signed-off-by: Boyd Lynn Gerber <gerberb@zenez.com>

--
Boyd Gerber <gerberb@zenez.com>
ZENEZ	1042 East Fort Union #135, Midvale Utah  84047

---
        Developer's Certificate of Origin 1.1

        By making a contribution to this project, I certify that:

        (a) The contribution was created in whole or in part by me and I
            have the right to submit it under the open source license
            indicated in the file; or

        (b) The contribution is based upon previous work that, to the best
            of my knowledge, is covered under an appropriate open source
            license and I have the right under that license to submit that
            work with modifications, whether created in whole or in part
            by me, under the same open source license (unless I am
            permitted to submit under a different license), as indicated
            in the file; or

        (c) The contribution was provided directly to me by some other
            person who certified (a), (b) or (c) and I have not modified
            it.

        (d) I understand and agree that this project and the contribution
            are public and that a record of the contribution (including all
            personal information I submit with it, including my sign-off) is
            maintained indefinitely and may be redistributed consistent with
            this project or the open source license(s) involved.

---
git-compat-util.h

__USLC__ indicates UNIX System Labs Corperation (USLC), or a Novell-derived
compiler and/or some SysV based OS's.

__M_UNIX indicates XENIX/SCO UNIX/OpenServer 5.0.7 and prior releases
of the SCO OS's.  It is used just like Apple and BSD, both of these
shouldn't have _XOPEN_SOURCE defined.

diff --git a/Makefile b/Makefile
index cce5a6e..026de2f 100644
--- a/Makefile
+++ b/Makefile
@@ -564,6 +564,45 @@ endif
 ifeq ($(uname_S),GNU/kFreeBSD)
 	NO_STRLCPY = YesPlease
 endif
+ifeq ($(uname_S),UnixWare)
+	CC=cc
+	NEEDS_SOCKET = YesPlease
+	NEEDS_NSL = YesPlease
+	NEEDS_SSL_WITH_CRYPTO = YesPlease
+	NEEDS_LIBICONV = YesPlease
+	SHELL_PATH = /usr/local/bin/bash
+	NO_IPV6 = YesPlease
+	NO_HSTRERROR = YesPlease
+	BASIC_CFLAGS += -Kthread
+	BASIC_CFLAGS += -I/usr/local/include
+	BASIC_LDFLAGS += -L/usr/local/lib
+	INSTALL = ginstall
+	TAR = gtar
+	NO_STRCASESTR = YesPlease
+	NO_MEMMEM = YesPlease
+endif
+ifeq ($(uname_S),SCO_SV)
+	ifeq ($(uname_R),3.2)
+		CFLAGS = -O2
+	endif
+	ifeq ($(uname_R),5)
+		CC=cc
+		BASIC_CFLAGS += -Kthread
+	endif
+	NEEDS_SOCKET = YesPlease
+	NEEDS_NSL = YesPlease
+	NEEDS_SSL_WITH_CRYPTO = YesPlease
+	NEEDS_LIBICONV = YesPlease
+	SHELL_PATH = /usr/bin/bash
+	NO_IPV6 = YesPlease
+	NO_HSTRERROR = YesPlease
+	BASIC_CFLAGS += -I/usr/local/include
+	BASIC_LDFLAGS += -L/usr/local/lib
+	NO_STRCASESTR = YesPlease
+	NO_MEMMEM = YesPlease
+	INSTALL = ginstall
+	TAR = gtar
+endif
 ifeq ($(uname_S),Darwin)
 	NEEDS_SSL_WITH_CRYPTO = YesPlease
 	NEEDS_LIBICONV = YesPlease
diff --git a/git-compat-util.h b/git-compat-util.h
index 01c4045..c04e8ba 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -39,7 +39,7 @@
 /* Approximation of the length of the decimal representation of this type. */
 #define decimal_length(x)	((int)(sizeof(x) * 2.56 + 0.5) + 1)
 
-#if !defined(__APPLE__) && !defined(__FreeBSD__)
+#if !defined(__APPLE__) && !defined(__FreeBSD__)  && !defined(__USLC__) && !defined(_M_UNIX)
 #define _XOPEN_SOURCE 600 /* glibc2 and AIX 5.3L need 500, OpenBSD needs 600 for S_ISLNK() */
 #define _XOPEN_SOURCE_EXTENDED 1 /* AIX 5.3L needs this */
 #endif
-- 
1.5.2.4
