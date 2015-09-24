From: Remi Pommarel <repk@triplefau.lt>
Subject: [PATCH v2 1/1] Makefile: link libcurl before openssl and crypto
Date: Thu, 24 Sep 2015 19:43:10 +0200
Message-ID: <1443116590-6222-1-git-send-email-repk@triplefau.lt>
Cc: Junio C Hamano <gitster@pobox.com>,
	Brandon Casey <drafnel@gmail.com>, Jeff King <peff@peff.net>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Remi Pommarel <repk@triplefau.lt>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 24 19:43:34 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZfAYO-0006hD-1o
	for gcvg-git-2@plane.gmane.org; Thu, 24 Sep 2015 19:43:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755531AbbIXRn2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Sep 2015 13:43:28 -0400
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:58196 "EHLO
	relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754904AbbIXRn0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Sep 2015 13:43:26 -0400
Received: from mfilter25-d.gandi.net (mfilter25-d.gandi.net [217.70.178.153])
	by relay4-d.mail.gandi.net (Postfix) with ESMTP id 0D29F172095;
	Thu, 24 Sep 2015 19:43:25 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at mfilter25-d.gandi.net
Received: from relay4-d.mail.gandi.net ([IPv6:::ffff:217.70.183.196])
	by mfilter25-d.gandi.net (mfilter25-d.gandi.net [::ffff:10.0.15.180]) (amavisd-new, port 10024)
	with ESMTP id kIE08G13Ea91; Thu, 24 Sep 2015 19:43:23 +0200 (CEST)
X-Originating-IP: 81.57.43.44
Received: from localhost (mon75-1-81-57-43-44.fbx.proxad.net [81.57.43.44])
	(Authenticated sender: repk@triplefau.lt)
	by relay4-d.mail.gandi.net (Postfix) with ESMTPSA id E1AA217208C;
	Thu, 24 Sep 2015 19:43:22 +0200 (CEST)
X-Mailer: git-send-email 2.0.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278548>

For static linking especially library order while linking is important. For
example libssl contains symbol from libcrypto so the former should be linked
before the latter.

The global link order should be libcurl then libssl then libcrypto then
libintl and finally zlib.

Signed-off-by: Remi Pommarel <repk@triplefau.lt>
---
 Makefile | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/Makefile b/Makefile
index ce0cfe2..59a0747 100644
--- a/Makefile
+++ b/Makefile
@@ -1029,7 +1029,6 @@ ifdef HAVE_ALLOCA_H
 endif
 
 IMAP_SEND_BUILDDEPS =
-IMAP_SEND_LDFLAGS = $(OPENSSL_LINK) $(OPENSSL_LIBSSL) $(LIB_4_CRYPTO)
 
 ifdef NO_CURL
 	BASIC_CFLAGS += -DNO_CURL
@@ -1086,6 +1085,7 @@ else
 		endif
 	endif
 endif
+IMAP_SEND_LDFLAGS += $(OPENSSL_LINK) $(OPENSSL_LIBSSL) $(LIB_4_CRYPTO)
 
 ifdef ZLIB_PATH
 	BASIC_CFLAGS += -I$(ZLIB_PATH)/include
@@ -1971,10 +1971,10 @@ git-imap-send$X: imap-send.o $(IMAP_SEND_BUILDDEPS) GIT-LDFLAGS $(GITLIBS)
 
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
@@ -1988,7 +1988,7 @@ $(REMOTE_CURL_ALIASES): $(REMOTE_CURL_PRIMARY)
 
 $(REMOTE_CURL_PRIMARY): remote-curl.o http.o http-walker.o GIT-LDFLAGS $(GITLIBS)
 	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^) \
-		$(LIBS) $(CURL_LIBCURL) $(EXPAT_LIBEXPAT)
+		$(CURL_LIBCURL) $(EXPAT_LIBEXPAT) $(LIBS)
 
 $(LIB_FILE): $(LIB_OBJS)
 	$(QUIET_AR)$(RM) $@ && $(AR) rcs $@ $^
-- 
2.0.1
