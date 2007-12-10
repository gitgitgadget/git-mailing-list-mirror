From: Mike Hommey <mh@glandium.org>
Subject: [PATCH 3/5] Avoid redundant declaration of missing_target()
Date: Mon, 10 Dec 2007 22:36:09 +0100
Message-ID: <1197322571-25023-3-git-send-email-mh@glandium.org>
References: <1197322571-25023-1-git-send-email-mh@glandium.org>
 <1197322571-25023-2-git-send-email-mh@glandium.org>
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 10 22:36:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J1qIs-0003Jj-6F
	for gcvg-git-2@gmane.org; Mon, 10 Dec 2007 22:36:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754343AbXLJVgW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Dec 2007 16:36:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754327AbXLJVgW
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Dec 2007 16:36:22 -0500
Received: from smtp20.orange.fr ([80.12.242.26]:40505 "EHLO smtp20.orange.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754171AbXLJVgS (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Dec 2007 16:36:18 -0500
Received: from me-wanadoo.net (localhost [127.0.0.1])
	by mwinf2027.orange.fr (SMTP Server) with ESMTP id 09A821C000CF
	for <git@vger.kernel.org>; Mon, 10 Dec 2007 22:36:16 +0100 (CET)
Received: from namakemono.glandium.org (APuteaux-153-1-79-219.w81-249.abo.wanadoo.fr [81.249.109.219])
	by mwinf2027.orange.fr (SMTP Server) with ESMTP id DE0A31C000BC;
	Mon, 10 Dec 2007 22:36:15 +0100 (CET)
X-ME-UUID: 20071210213615909.DE0A31C000BC@mwinf2027.orange.fr
Received: from mh by namakemono.glandium.org with local (Exim 4.68)
	(envelope-from <mh@glandium.org>)
	id 1J1qIO-0006Vy-0z; Mon, 10 Dec 2007 22:36:12 +0100
X-Mailer: git-send-email 1.5.3.7.1159.gdd4a4-dirty
In-Reply-To: <1197322571-25023-2-git-send-email-mh@glandium.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67759>

Signed-off-by: Mike Hommey <mh@glandium.org>
---

I though it's also small enough to grant inlining.

 http-walker.c |   13 -------------
 http.h        |   13 +++++++++++++
 transport.c   |   13 -------------
 3 files changed, 13 insertions(+), 26 deletions(-)

diff --git a/http-walker.c b/http-walker.c
index d9a5f1e..8dbf9cc 100644
--- a/http-walker.c
+++ b/http-walker.c
@@ -90,19 +90,6 @@ static size_t fwrite_sha1_file(void *ptr, size_t eltsize, size_t nmemb,
 	return size;
 }
 
-static int missing__target(int code, int result)
-{
-	return	/* file:// URL -- do we ever use one??? */
-		(result == CURLE_FILE_COULDNT_READ_FILE) ||
-		/* http:// and https:// URL */
-		(code == 404 && result == CURLE_HTTP_RETURNED_ERROR) ||
-		/* ftp:// URL */
-		(code == 550 && result == CURLE_FTP_COULDNT_RETR_FILE)
-		;
-}
-
-#define missing_target(a) missing__target((a)->http_code, (a)->curl_result)
-
 static void fetch_alternates(struct walker *walker, const char *base);
 
 static void process_object_response(void *callback_data);
diff --git a/http.h b/http.h
index a0fb4cf..87d638b 100644
--- a/http.h
+++ b/http.h
@@ -83,4 +83,17 @@ extern int active_requests;
 
 extern char curl_errorstr[CURL_ERROR_SIZE];
 
+static inline int missing__target(int code, int result)
+{
+	return	/* file:// URL -- do we ever use one??? */
+		(result == CURLE_FILE_COULDNT_READ_FILE) ||
+		/* http:// and https:// URL */
+		(code == 404 && result == CURLE_HTTP_RETURNED_ERROR) ||
+		/* ftp:// URL */
+		(code == 550 && result == CURLE_FTP_COULDNT_RETR_FILE)
+		;
+}
+
+#define missing_target(a) missing__target((a)->http_code, (a)->curl_result)
+
 #endif /* HTTP_H */
diff --git a/transport.c b/transport.c
index 22234e8..4e151a9 100644
--- a/transport.c
+++ b/transport.c
@@ -426,19 +426,6 @@ static int curl_transport_push(struct transport *transport, int refspec_nr, cons
 	return !!err;
 }
 
-static int missing__target(int code, int result)
-{
-	return	/* file:// URL -- do we ever use one??? */
-		(result == CURLE_FILE_COULDNT_READ_FILE) ||
-		/* http:// and https:// URL */
-		(code == 404 && result == CURLE_HTTP_RETURNED_ERROR) ||
-		/* ftp:// URL */
-		(code == 550 && result == CURLE_FTP_COULDNT_RETR_FILE)
-		;
-}
-
-#define missing_target(a) missing__target((a)->http_code, (a)->curl_result)
-
 static struct ref *get_refs_via_curl(struct transport *transport)
 {
 	struct strbuf buffer = STRBUF_INIT;
-- 
1.5.3.7.1159.gdd4a4
