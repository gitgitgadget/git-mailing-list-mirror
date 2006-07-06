From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] Fix compilation
Date: Fri, 7 Jul 2006 01:21:57 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0607070120590.29667@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Fri Jul 07 01:22:05 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FydAY-0001Mt-VY
	for gcvg-git@gmane.org; Fri, 07 Jul 2006 01:22:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751019AbWGFXWA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 6 Jul 2006 19:22:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751031AbWGFXWA
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Jul 2006 19:22:00 -0400
Received: from mail.gmx.net ([213.165.64.21]:60392 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751019AbWGFXWA (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 6 Jul 2006 19:22:00 -0400
Received: (qmail invoked by alias); 06 Jul 2006 23:21:58 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp015) with SMTP; 07 Jul 2006 01:21:58 +0200
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: git@vger.kernel.org, junkio@cox.net
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23408>


Without this, make 3.79.1 (Darwin) says

rm -f git-archimport git-archimport+
INSTLIBDIR=`make -C perl -s --no-print-directory instlibdir` && \
sed -e '1s|#!.*perl|#!/usr/bin/perl|1' \
    -e '2i\
        use lib (split(/:/, $ENV{GITPERLLIB} || '\'"$INSTLIBDIR"\''));' \
    -e 's|@@INSTLIBDIR@@|'"$INSTLIBDIR"'|g' \
    -e 's/@@GIT_VERSION@@/1.4.1.gb564-dirty/g' \
    git-archimport.perl >git-archimport+
sed: 1: "2i use lib (split(/:/,  ...": command i expects \ followed by text

Signed-off-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>

---

	Note that this just fixes compilation, not the tests. All of
	a sudden, I have to install Scalar::Util, where things were
	fine before Git.pm.

	Note also, that this patch relies on the perl scripts not
	caring if an additional command is shifted into the 2nd line.
	I checked all of them, and they don't.

 Makefile |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/Makefile b/Makefile
--- a/Makefile
+++ b/Makefile
@@ -563,8 +563,7 @@ common-cmds.h: Documentation/git-*.txt
 	rm -f $@ $@+
 	INSTLIBDIR=`$(MAKE) -C perl -s --no-print-directory instlibdir` && \
 	sed -e '1s|#!.*perl|#!$(PERL_PATH_SQ)|1' \
-	    -e '2i\
-	        use lib (split(/:/, $$ENV{GITPERLLIB} || '\'"$$INSTLIBDIR"\''));' \
+	    -e "2s=^=use lib (split(/:/, \$$ENV{GITPERLLIB} || \'$$INSTLIBDIR\')); =g" \
 	    -e 's|@@INSTLIBDIR@@|'"$$INSTLIBDIR"'|g' \
 	    -e 's/@@GIT_VERSION@@/$(GIT_VERSION)/g' \
 	    $@.perl >$@+
