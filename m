From: Remi Pommarel <repk@triplefau.lt>
Subject: [PATCH] Makefile: Change library order for static linking
Date: Thu, 17 Sep 2015 23:12:12 +0200
Message-ID: <1442524332-10180-1-git-send-email-repk@triplefau.lt>
Cc: Brandon Casey <drafnel@gmail.com>, Jeff King <peff@peff.net>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Remi Pommarel <repk@triplefau.lt>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 17 21:14:43 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zcedm-0004kF-KN
	for gcvg-git-2@plane.gmane.org; Thu, 17 Sep 2015 21:14:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751339AbbIQTOh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Sep 2015 15:14:37 -0400
Received: from slow1-d.mail.gandi.net ([217.70.178.86]:48785 "EHLO
	slow1-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751104AbbIQTOg (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Sep 2015 15:14:36 -0400
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	by slow1-d.mail.gandi.net (Postfix) with ESMTP id 68B9B4F618D
	for <git@vger.kernel.org>; Thu, 17 Sep 2015 21:13:23 +0200 (CEST)
Received: from mfilter18-d.gandi.net (mfilter18-d.gandi.net [217.70.178.146])
	by relay2-d.mail.gandi.net (Postfix) with ESMTP id 22745C5A44;
	Thu, 17 Sep 2015 21:13:21 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at mfilter18-d.gandi.net
Received: from relay2-d.mail.gandi.net ([IPv6:::ffff:217.70.183.194])
	by mfilter18-d.gandi.net (mfilter18-d.gandi.net [::ffff:10.0.15.180]) (amavisd-new, port 10024)
	with ESMTP id zTSQfPeWcQUk; Thu, 17 Sep 2015 21:13:19 +0200 (CEST)
X-Originating-IP: 81.57.43.44
Received: from localhost (mon75-1-81-57-43-44.fbx.proxad.net [81.57.43.44])
	(Authenticated sender: repk@triplefau.lt)
	by relay2-d.mail.gandi.net (Postfix) with ESMTPSA id 75BA3C5A42;
	Thu, 17 Sep 2015 21:13:18 +0200 (CEST)
X-Mailer: git-send-email 2.0.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278159>

For static linking especially library order while linking is important. For
example libssl contains symbol from libcrypto so the farmer should be linked
before the latter. The global link order should be libcurl then libssl then
libcrypto then libintl and finally zlib.

Signed-off-by: Remi Pommarel <repk@triplefau.lt>
---
 Makefile | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/Makefile b/Makefile
index 81ac5bb..26a483a 100644
--- a/Makefile
+++ b/Makefile
@@ -1030,7 +1030,6 @@ ifdef HAVE_ALLOCA_H
 endif
 
 IMAP_SEND_BUILDDEPS =
-IMAP_SEND_LDFLAGS = $(OPENSSL_LINK) $(OPENSSL_LIBSSL) $(LIB_4_CRYPTO)
 
 ifdef NO_CURL
 	BASIC_CFLAGS += -DNO_CURL
@@ -1087,6 +1086,7 @@ else
 		endif
 	endif
 endif
+IMAP_SEND_LDFLAGS += $(OPENSSL_LINK) $(OPENSSL_LIBSSL) $(LIB_4_CRYPTO)
 
 ifdef ZLIB_PATH
 	BASIC_CFLAGS += -I$(ZLIB_PATH)/include
@@ -1117,7 +1117,7 @@ ifdef NO_OPENSSL
 	LIB_4_CRYPTO =
 else
 ifdef NEEDS_SSL_WITH_CRYPTO
-	LIB_4_CRYPTO = $(OPENSSL_LINK) -lcrypto -lssl
+	LIB_4_CRYPTO = $(OPENSSL_LINK) -lssl -lcrypto
 else
 	LIB_4_CRYPTO = $(OPENSSL_LINK) -lcrypto
 endif
@@ -1972,10 +1972,10 @@ git-imap-send$X: imap-send.o $(IMAP_SEND_BUILDDEPS) GIT-LDFLAGS $(GITLIBS)
 
 git-http-fetch$X: http.o http-walker.o http-fetch.o GIT-LDFLAGS $(GITLIBS)
 	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^) \
-		$(LIBS) $(CURL_LIBCURL)
+		$(CURL_LIBCURL) $(LIBS)
 git-http-push$X: http.o http-push.o GIT-LDFLAGS $(GITLIBS)
 	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^) \
-		$(LIBS) $(CURL_LIBCURL) $(EXPAT_LIBEXPAT)
+		$(CURL_LIBCURL) $(EXPAT_LIBEXPAT) $(LIBS)
 
 git-remote-testsvn$X: remote-testsvn.o GIT-LDFLAGS $(GITLIBS) $(VCSSVN_LIB)
 	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^) $(LIBS) \
@@ -1989,7 +1989,7 @@ $(REMOTE_CURL_ALIASES): $(REMOTE_CURL_PRIMARY)
 
 $(REMOTE_CURL_PRIMARY): remote-curl.o http.o http-walker.o GIT-LDFLAGS $(GITLIBS)
 	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^) \
-		$(LIBS) $(CURL_LIBCURL) $(EXPAT_LIBEXPAT)
+		$(CURL_LIBCURL) $(EXPAT_LIBEXPAT) $(LIBS)
 
 $(LIB_FILE): $(LIB_OBJS)
 	$(QUIET_AR)$(RM) $@ && $(AR) rcs $@ $^
-- 
2.0.1
