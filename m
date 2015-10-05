From: Remi Pommarel <repk@triplefau.lt>
Subject: [PATCH v3 1/1] Makefile: link libcurl before libssl
Date: Mon,  5 Oct 2015 21:24:03 +0200
Message-ID: <1444073043-24618-1-git-send-email-repk@triplefau.lt>
Cc: Junio C Hamano <gitster@pobox.com>,
	Brandon Casey <drafnel@gmail.com>, Jeff King <peff@peff.net>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Remi Pommarel <repk@triplefau.lt>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 05 21:24:26 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZjBN4-0003GJ-89
	for gcvg-git-2@plane.gmane.org; Mon, 05 Oct 2015 21:24:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751191AbbJETYT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Oct 2015 15:24:19 -0400
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:33793 "EHLO
	relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751052AbbJETYS (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Oct 2015 15:24:18 -0400
Received: from mfilter27-d.gandi.net (mfilter27-d.gandi.net [217.70.178.155])
	by relay4-d.mail.gandi.net (Postfix) with ESMTP id 809D1172097;
	Mon,  5 Oct 2015 21:24:16 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at mfilter27-d.gandi.net
Received: from relay4-d.mail.gandi.net ([IPv6:::ffff:217.70.183.196])
	by mfilter27-d.gandi.net (mfilter27-d.gandi.net [::ffff:10.0.15.180]) (amavisd-new, port 10024)
	with ESMTP id 1jt-buxwi_Sf; Mon,  5 Oct 2015 21:24:15 +0200 (CEST)
X-Originating-IP: 81.57.43.44
Received: from localhost (unknown [81.57.43.44])
	(Authenticated sender: repk@triplefau.lt)
	by relay4-d.mail.gandi.net (Postfix) with ESMTPSA id 81833172080;
	Mon,  5 Oct 2015 21:24:13 +0200 (CEST)
X-Mailer: git-send-email 2.0.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279069>

For static linking especially library order while linking is important. For
example, libcurl wants symbols for libssl when building http-push, http-fetch
and remote-curl. So for these programs libcurl has to be linked before libssl.

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
