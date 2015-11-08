From: "Rainer M. Canavan" <git@canavan.de>
Subject: [PATCH] configure.ac: try -lpthread in $LIBS instead of $CFLAGS
Date: Sun, 8 Nov 2015 16:28:42 +0100 (CET)
Message-ID: <201511081528.tA8FSgdc003895@tezro.nonet>
References: <vpqbnb7edqn.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Matthieu.Moy@grenoble-inp.fr
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 08 16:31:10 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZvRvx-0001jR-AT
	for gcvg-git-2@plane.gmane.org; Sun, 08 Nov 2015 16:31:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752701AbbKHPbA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Nov 2015 10:31:00 -0500
Received: from [213.196.234.34] ([213.196.234.34]:55691 "EHLO turms.7val.com"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1752619AbbKHPaR (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Nov 2015 10:30:17 -0500
Received: from localhost (amavis.7val.com [172.22.0.32])
	by localhost (Postfix) with ESMTP id 1AB0339538A6;
	Sun,  8 Nov 2015 16:29:20 +0100 (CET)
Received: from turms.7val.com ([172.22.0.34])
	by localhost (amavis.7val.com [172.22.0.32]) (amavisd-new, port 10024)
	with ESMTP id nu0FmU76nUhO; Sun,  8 Nov 2015 16:29:17 +0100 (CET)
Received: from qube.nonet (xdsl-87-78-120-226.netcologne.de [87.78.120.226])
	by turms.7val.com (Postfix) with ESMTP;
	Sun,  8 Nov 2015 16:29:17 +0100 (CET)
Received: from tezro.nonet (tezro.nonet [10.0.0.1])
	by qube.nonet (Postfix) with ESMTP id A55342DA90;
	Sun,  8 Nov 2015 16:29:14 +0100 (CET)
Received: from tezro.nonet (localhost [127.0.0.1])
	by tezro.nonet (SGI-8.12.11.20060308/8.12.11) with ESMTP id tA8FShnq003897;
	Sun, 8 Nov 2015 16:28:43 +0100 (CET)
Received: (from canavan@localhost)
	by tezro.nonet (SGI-8.12.11.20060308/8.12.11/Submit) id tA8FSgdc003895;
	Sun, 8 Nov 2015 16:28:42 +0100 (CET)
In-Reply-To: <vpqbnb7edqn.fsf@anie.imag.fr>
X-Mailer: Ishmail 2.1.0-20150803-mips-sgi-irix6.5 <http://ishmail.sourceforge.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281038>

Some linkers, namely the one on IRIX are rather strict concerning the order or
arguments for symbol resolution, i.e. no libraries listed before objects or
other libraries on the command line are considered for symbol resolution. That
means that -lpthread can't work if it's put in CFLAGS, because it will not be
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
