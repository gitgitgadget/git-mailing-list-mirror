From: "Rainer M. Canavan" <git@canavan.de>
Subject: configure: -lpthread doesn't belong in CFLAGS
Date: Sun, 1 Nov 2015 23:30:16 +0100 (CET)
Message-ID: <201511012230.tA1MUGa5016836@tezro.nonet>
Mime-Version: 1.0
Content-Type: text/plain
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 01 23:56:36 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zt1YA-0001cI-4T
	for gcvg-git-2@plane.gmane.org; Sun, 01 Nov 2015 23:56:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753255AbbKAW43 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 1 Nov 2015 17:56:29 -0500
Received: from [213.196.234.34] ([213.196.234.34]:62346 "EHLO turms.7val.com"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1753176AbbKAW4X (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 Nov 2015 17:56:23 -0500
X-Greylist: delayed 1490 seconds by postgrey-1.27 at vger.kernel.org; Sun, 01 Nov 2015 17:56:22 EST
Received: from localhost (amavis.7val.com [172.22.0.32])
	by localhost (Postfix) with ESMTP id E98E939538B4
	for <git@vger.kernel.org>; Sun,  1 Nov 2015 23:30:34 +0100 (CET)
Received: from turms.7val.com ([172.22.0.34])
	by localhost (amavis.7val.com [172.22.0.32]) (amavisd-new, port 10024)
	with ESMTP id ymiH3xKmWxch; Sun,  1 Nov 2015 23:30:31 +0100 (CET)
Received: from qube.nonet (xdsl-78-35-201-247.netcologne.de [78.35.201.247])
	by turms.7val.com (Postfix) with ESMTP;
	Sun,  1 Nov 2015 23:30:31 +0100 (CET)
Received: from tezro.nonet (tezro.nonet [10.0.0.1])
	by qube.nonet (Postfix) with ESMTP id 9120B2DB65;
	Sun,  1 Nov 2015 23:30:29 +0100 (CET)
Received: from tezro.nonet (localhost [127.0.0.1])
	by tezro.nonet (SGI-8.12.11.20060308/8.12.11) with ESMTP id tA1MUGbW016838;
	Sun, 1 Nov 2015 23:30:16 +0100 (CET)
Received: (from canavan@localhost)
	by tezro.nonet (SGI-8.12.11.20060308/8.12.11/Submit) id tA1MUGa5016836;
	Sun, 1 Nov 2015 23:30:16 +0100 (CET)
X-Mailer: Ishmail 2.1.0-20150803-mips-sgi-irix6.5 <http://ishmail.sourceforge.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280675>

Hi,

some linkers, namely the one on IRIX are rather strict concerning the 
order or arguments for symbol resolution, i.e. no libraries listed
before objects or other libraries on the command line are considered
for symbol resolution. That means that -lpthread can't work if it's 
put in CFLAGS, because it will not be considered for resolving 
pthread_key_create in conftest.o. Apparently only $LIBS goes
after conftest.o when the linker is called.

Without the patch below, the POSIX Threads with '-lpthread' fails, 
with the patch it succeeds. I haven't checked if that is relevant
at all, since that check is immediately followed by 
checking for pthread_create in -lpthread... yes


regards,


rainer


--- ../src/git-2.6.2/configure.ac	Fri Oct 16 23:58:26 CEST 2015
+++ configure.ac	Sun Nov 01 23:19:41 CET 2015
@@ -1126,7 +1126,13 @@
   # would then trigger compiler warnings on every single file we compile.
   for opt in "" -mt -pthread -lpthread; do
      old_CFLAGS="$CFLAGS"
-     CFLAGS="$opt $CFLAGS"
+     old_LIBS="$LIBS"
+     if test "$(echo $opt | cut -b 1-2)" = -l ; then
+        LIBS="$opt $LIBS"
+     else
+        CFLAGS="$opt $CFLAGS"
+     fi
+
      AC_MSG_CHECKING([for POSIX Threads with '$opt'])
      AC_LINK_IFELSE([PTHREADTEST_SRC],
 	[AC_MSG_RESULT([yes])
@@ -1138,6 +1144,7 @@
 	],
 	[AC_MSG_RESULT([no])])
       CFLAGS="$old_CFLAGS"
+      LIBS="$old_LIBS"
   done
   if test $threads_found != yes; then
     AC_CHECK_LIB([pthread], [pthread_create],
