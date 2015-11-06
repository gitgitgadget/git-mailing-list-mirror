From: "Rainer M. Canavan" <git@canavan.de>
Subject: [PATCH] In configure.ac, try -lpthread in $LIBS instead of $CFLAGS to make picky linkers happy
Date: Fri, 6 Nov 2015 02:11:37 +0100 (CET)
Message-ID: <201511060111.tA61BbFX084361@tezro.nonet>
References: <vpqa8qwst4y.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Matthieu.Moy@grenoble-inp.fr
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 06 02:13:14 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZuVab-0005KC-KR
	for gcvg-git-2@plane.gmane.org; Fri, 06 Nov 2015 02:13:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030660AbbKFBNJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Nov 2015 20:13:09 -0500
Received: from [213.196.234.34] ([213.196.234.34]:50720 "EHLO turms.7val.com"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1030447AbbKFBNH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Nov 2015 20:13:07 -0500
Received: from localhost (amavis.7val.com [172.22.0.32])
	by localhost (Postfix) with ESMTP id 505D43956EBE;
	Fri,  6 Nov 2015 02:12:10 +0100 (CET)
Received: from turms.7val.com ([172.22.0.34])
	by localhost (amavis.7val.com [172.22.0.32]) (amavisd-new, port 10024)
	with ESMTP id tzbNNk+5YHPP; Fri,  6 Nov 2015 02:12:07 +0100 (CET)
Received: from qube.nonet (xdsl-78-35-202-116.netcologne.de [78.35.202.116])
	by turms.7val.com (Postfix) with ESMTP;
	Fri,  6 Nov 2015 02:12:07 +0100 (CET)
Received: from tezro.nonet (tezro.nonet [10.0.0.1])
	by qube.nonet (Postfix) with ESMTP id 0C44E2DB21;
	Fri,  6 Nov 2015 02:12:04 +0100 (CET)
Received: from tezro.nonet (localhost [127.0.0.1])
	by tezro.nonet (SGI-8.12.11.20060308/8.12.11) with ESMTP id tA61Bc73084362;
	Fri, 6 Nov 2015 02:11:38 +0100 (CET)
Received: (from canavan@localhost)
	by tezro.nonet (SGI-8.12.11.20060308/8.12.11/Submit) id tA61BbFX084361;
	Fri, 6 Nov 2015 02:11:37 +0100 (CET)
In-Reply-To: <vpqa8qwst4y.fsf@anie.imag.fr>
X-Mailer: Ishmail 2.1.0-20150803-mips-sgi-irix6.5 <http://ishmail.sourceforge.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280951>

Some linkers, namely the one on IRIX are rather strict concerning the order or
arguments for symbol resolution, i.e. no libraries listed before objects or
other libraries on the command line are considered for symbol resolution. 
Therefore, -lpthread can't work if it's put in CFLAGS, because it will not be
considered for resolving pthread_key_create in conftest.o. Use $LIBS instead.

Signed-off-by: Rainer Canavan <git@canavan.de>
---
 configure.ac | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/configure.ac b/configure.ac
index fd22d41..1f55009 100644
--- a/configure.ac
+++ b/configure.ac
@@ -1149,7 +1149,12 @@ elif test -z "$PTHREAD_CFLAGS"; then
   # would then trigger compiler warnings on every single file we compile.
   for opt in "" -mt -pthread -lpthread; do
      old_CFLAGS="$CFLAGS"
-     CFLAGS="$opt $CFLAGS"
+     old_LIBS="$LIBS"
+     case "$opt" in
+        -l*)  LIBS="$opt $LIBS" ;;
+        *)    CFLAGS="$opt $CFLAGS" ;;
+     esac
+
      AC_MSG_CHECKING([for POSIX Threads with '$opt'])
      AC_LINK_IFELSE([PTHREADTEST_SRC],
 	[AC_MSG_RESULT([yes])
@@ -1161,6 +1166,7 @@ elif test -z "$PTHREAD_CFLAGS"; then
 	],
 	[AC_MSG_RESULT([no])])
       CFLAGS="$old_CFLAGS"
+      LIBS="$old_LIBS"
   done
   if test $threads_found != yes; then
     AC_CHECK_LIB([pthread], [pthread_create],
-- 
2.6.2
