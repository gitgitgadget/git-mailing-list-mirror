From: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
Subject: [RFC PATCH 6/8] Remove special casing of http, https and ftp
Date: Tue,  1 Dec 2009 15:57:16 +0200
Message-ID: <1259675838-14692-7-git-send-email-ilari.liusvaara@elisanet.fi>
References: <1259675838-14692-1-git-send-email-ilari.liusvaara@elisanet.fi>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 01 15:08:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NFTPO-0000SF-R3
	for gcvg-git-2@lo.gmane.org; Tue, 01 Dec 2009 15:08:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752374AbZLAOIY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Dec 2009 09:08:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752311AbZLAOIY
	(ORCPT <rfc822;git-outgoing>); Tue, 1 Dec 2009 09:08:24 -0500
Received: from emh04.mail.saunalahti.fi ([62.142.5.110]:37485 "EHLO
	emh04.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750841AbZLAOIX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Dec 2009 09:08:23 -0500
Received: from saunalahti-vams (vs3-11.mail.saunalahti.fi [62.142.5.95])
	by emh04-2.mail.saunalahti.fi (Postfix) with SMTP id 5306913BECC
	for <git@vger.kernel.org>; Tue,  1 Dec 2009 15:57:52 +0200 (EET)
Received: from emh01.mail.saunalahti.fi ([62.142.5.107])
	by vs3-11.mail.saunalahti.fi ([62.142.5.95])
	with SMTP (gateway) id A046714F707; Tue, 01 Dec 2009 15:57:52 +0200
Received: from LK-Perkele-V (a88-113-39-59.elisa-laajakaista.fi [88.113.39.59])
	by emh01.mail.saunalahti.fi (Postfix) with ESMTP id 2E53A4062
	for <git@vger.kernel.org>; Tue,  1 Dec 2009 15:57:50 +0200 (EET)
X-Mailer: git-send-email 1.6.6.rc0.64.g5593e
In-Reply-To: <1259675838-14692-1-git-send-email-ilari.liusvaara@elisanet.fi>
X-Antivirus: VAMS
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134211>

HTTP, HTTPS and FTP are no longer special to transport code. Also
add support for FTPS (curl supports it so it is easy).

Signed-off-by: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
---
 .gitignore  |    5 ++++-
 Makefile    |   16 ++++++++++++++--
 transport.c |    8 --------
 3 files changed, 18 insertions(+), 11 deletions(-)

diff --git a/.gitignore b/.gitignore
index 7cc54b4..65508ea 100644
--- a/.gitignore
+++ b/.gitignore
@@ -106,7 +106,10 @@
 /git-reflog
 /git-relink
 /git-remote
-/git-remote-curl
+/git-remote-http
+/git-remote-https
+/git-remote-ftp
+/git-remote-ftps
 /git-repack
 /git-replace
 /git-repo-config
diff --git a/Makefile b/Makefile
index 42744a4..be0be87 100644
--- a/Makefile
+++ b/Makefile
@@ -1097,7 +1097,7 @@ else
 	else
 		CURL_LIBCURL = -lcurl
 	endif
-	PROGRAMS += git-remote-curl$X git-http-fetch$X
+	PROGRAMS += git-remote-http$X git-remote-https$X git-remote-ftp$X git-remote-ftps$X git-http-fetch$X
 	curl_check := $(shell (echo 070908; curl-config --vernum) | sort -r | sed -ne 2p)
 	ifeq "$(curl_check)" "070908"
 		ifndef NO_EXPAT
@@ -1676,7 +1676,19 @@ git-http-push$X: revision.o http.o http-push.o $(GITLIBS)
 	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^) \
 		$(LIBS) $(CURL_LIBCURL) $(EXPAT_LIBEXPAT)
 
-git-remote-curl$X: remote-curl.o http.o http-walker.o $(GITLIBS)
+git-remote-http$X: remote-curl.o http.o http-walker.o $(GITLIBS)
+	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^) \
+		$(LIBS) $(CURL_LIBCURL) $(EXPAT_LIBEXPAT)
+
+git-remote-https$X: remote-curl.o http.o http-walker.o $(GITLIBS)
+	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^) \
+		$(LIBS) $(CURL_LIBCURL) $(EXPAT_LIBEXPAT)
+
+git-remote-ftp$X: remote-curl.o http.o http-walker.o $(GITLIBS)
+	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^) \
+		$(LIBS) $(CURL_LIBCURL) $(EXPAT_LIBEXPAT)
+
+git-remote-ftps$X: remote-curl.o http.o http-walker.o $(GITLIBS)
 	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^) \
 		$(LIBS) $(CURL_LIBCURL) $(EXPAT_LIBEXPAT)
 
diff --git a/transport.c b/transport.c
index a32f405..872cc30 100644
--- a/transport.c
+++ b/transport.c
@@ -944,14 +944,6 @@ struct transport *transport_get(struct remote *remote, const char *url)
 
 		data->conn = NULL;
 		data->virtual_connected = 0;
-	} else if (!prefixcmp(url, "http://")
-		|| !prefixcmp(url, "https://")
-		|| !prefixcmp(url, "ftp://")) {
-		/* These three are just plain special. */
-		transport_helper_init(ret, "curl");
-#ifdef NO_CURL
-		error("git was compiled without libcurl support.");
-#else
 	} else {
 		/* Unknown protocol in URL. Pass to external handler. */
 		int len = external_specification_len(url);
-- 
1.6.6.rc0.64.g5593e
