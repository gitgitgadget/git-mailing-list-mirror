From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [RFD] socklen_t needs to be defined and libssl to be linked on old
 Mac OS X
Date: Thu, 28 Jul 2005 16:51:41 +0200 (CEST)
Message-ID: <Pine.LNX.4.58.0507281649230.25783@wgmdd8.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Thu Jul 28 17:00:51 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dy9rC-0001lN-6x
	for gcvg-git@gmane.org; Thu, 28 Jul 2005 16:59:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261548AbVG1O7C (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 28 Jul 2005 10:59:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261528AbVG1OyA
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Jul 2005 10:54:00 -0400
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:57521 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S261515AbVG1Ovm (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Jul 2005 10:51:42 -0400
Received: from wrzx34.rz.uni-wuerzburg.de (wrzx34.rz.uni-wuerzburg.de [132.187.3.34])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP id 6B533E243F
	for <git@vger.kernel.org>; Thu, 28 Jul 2005 16:51:41 +0200 (CEST)
Received: from virusscan (localhost [127.0.0.1])
	by wrzx34.rz.uni-wuerzburg.de (Postfix) with ESMTP id 48066A86AF
	for <git@vger.kernel.org>; Thu, 28 Jul 2005 16:51:41 +0200 (CEST)
Received: from wrzx28.rz.uni-wuerzburg.de (wrzx28.rz.uni-wuerzburg.de [132.187.3.28])
	by wrzx34.rz.uni-wuerzburg.de (Postfix) with ESMTP id 2B9F7A8677
	for <git@vger.kernel.org>; Thu, 28 Jul 2005 16:51:41 +0200 (CEST)
Received: from wgmdd8.biozentrum.uni-wuerzburg.de (wrzx68.rz.uni-wuerzburg.de [132.187.3.68])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP id 1495CE243F
	for <git@vger.kernel.org>; Thu, 28 Jul 2005 16:51:41 +0200 (CEST)
X-X-Sender: gene099@wgmdd8.biozentrum.uni-wuerzburg.de
To: git@vger.kernel.org
X-Virus-Scanned: by amavisd-new (Rechenzentrum Universitaet Wuerzburg)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


On older Mac OS X (10.2.8), no socklen_t is defined, and therefore
daemon.c does not compile. However, Mac OS X 10.4 seems to define
socklen_t differently.

Also, linking fails due to some symbols defined in libssl (not just
libcrypto).

Signed-off-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>

---

 Makefile |    4 ++++
 daemon.c |    3 +++
 2 files changed, 7 insertions

diff --git a/Makefile b/Makefile
--- a/Makefile
+++ b/Makefile
@@ -95,7 +95,11 @@ ifdef PPC_SHA1
   LIB_OBJS += ppc/sha1.o ppc/sha1ppc.o
 else
   SHA1_HEADER=<openssl/sha.h>
+ifeq ($(shell uname -s),Darwin)
+  LIBS += -lcrypto -lssl
+else
   LIBS += -lcrypto
+endif
 endif
 endif

diff --git a/daemon.c b/daemon.c
--- a/daemon.c
+++ b/daemon.c
@@ -5,6 +5,9 @@
 #include <sys/socket.h>
 #include <netinet/in.h>
 #include <arpa/inet.h>
+#ifdef __APPLE__
+typedef int socklen_t;
+#endif

 static const char daemon_usage[] = "git-daemon [--inetd | --port=n]";
