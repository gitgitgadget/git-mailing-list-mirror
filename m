From: Remi Pommarel <repk@triplefau.lt>
Subject: [PATCH v4 1/1] Makefile: link libcurl before zlib
Date: Wed, 21 Oct 2015 19:01:13 +0200
Message-ID: <1445446873-21294-1-git-send-email-repk@triplefau.lt>
Cc: Junio C Hamano <gitster@pobox.com>,
	Brandon Casey <drafnel@gmail.com>, Jeff King <peff@peff.net>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Remi Pommarel <repk@triplefau.lt>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 21 19:01:22 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZowlK-0003Gz-Qd
	for gcvg-git-2@plane.gmane.org; Wed, 21 Oct 2015 19:01:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750847AbbJURBO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Oct 2015 13:01:14 -0400
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:37003 "EHLO
	relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750732AbbJURBN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Oct 2015 13:01:13 -0400
Received: from mfilter23-d.gandi.net (mfilter23-d.gandi.net [217.70.178.151])
	by relay4-d.mail.gandi.net (Postfix) with ESMTP id F3D66172098;
	Wed, 21 Oct 2015 19:01:11 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at mfilter23-d.gandi.net
Received: from relay4-d.mail.gandi.net ([IPv6:::ffff:217.70.183.196])
	by mfilter23-d.gandi.net (mfilter23-d.gandi.net [::ffff:10.0.15.180]) (amavisd-new, port 10024)
	with ESMTP id rB9dTjWNG5Tn; Wed, 21 Oct 2015 19:01:10 +0200 (CEST)
X-Originating-IP: 81.57.43.44
Received: from localhost (mon75-1-81-57-43-44.fbx.proxad.net [81.57.43.44])
	(Authenticated sender: repk@triplefau.lt)
	by relay4-d.mail.gandi.net (Postfix) with ESMTPSA id B8D01172091;
	Wed, 21 Oct 2015 19:01:09 +0200 (CEST)
X-Mailer: git-send-email 2.0.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279991>

For static linking especially library order while linking is important. For
example, libcurl wants symbols from zlib when building http-push, http-fetch
and remote-curl. So for these programs libcurl has to be linked before zlib.

Signed-off-by: Remi Pommarel <repk@triplefau.lt>
---
Changes to v3:
	- Initialize IMAP_SEND_LDFLAGS so that no environment leak could occur
	- Rephrase the description to use zlib example instead of libcurl

 Makefile | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/Makefile b/Makefile
index 04c2231..8f1fa6c 100644
--- a/Makefile
+++ b/Makefile
@@ -1036,7 +1036,7 @@ ifdef HAVE_ALLOCA_H
 endif
 
 IMAP_SEND_BUILDDEPS =
-IMAP_SEND_LDFLAGS = $(OPENSSL_LINK) $(OPENSSL_LIBSSL) $(LIB_4_CRYPTO)
+IMAP_SEND_LDFLAGS =
 
 ifdef NO_CURL
 	BASIC_CFLAGS += -DNO_CURL
@@ -1093,6 +1093,7 @@ else
 		endif
 	endif
 endif
+IMAP_SEND_LDFLAGS += $(OPENSSL_LINK) $(OPENSSL_LIBSSL) $(LIB_4_CRYPTO)
 
 ifdef ZLIB_PATH
 	BASIC_CFLAGS += -I$(ZLIB_PATH)/include
@@ -1978,10 +1979,10 @@ git-imap-send$X: imap-send.o $(IMAP_SEND_BUILDDEPS) GIT-LDFLAGS $(GITLIBS)
 
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
@@ -1995,7 +1996,7 @@ $(REMOTE_CURL_ALIASES): $(REMOTE_CURL_PRIMARY)
 
 $(REMOTE_CURL_PRIMARY): remote-curl.o http.o http-walker.o GIT-LDFLAGS $(GITLIBS)
 	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^) \
-		$(LIBS) $(CURL_LIBCURL) $(EXPAT_LIBEXPAT)
+		$(CURL_LIBCURL) $(EXPAT_LIBEXPAT) $(LIBS)
 
 $(LIB_FILE): $(LIB_OBJS)
 	$(QUIET_AR)$(RM) $@ && $(AR) $(ARFLAGS) $@ $^
-- 
2.0.1
