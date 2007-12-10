From: Mike Hommey <mh@glandium.org>
Subject: [PATCH 5/5] Fix various memory leaks in http-push.c and http-walker.c
Date: Mon, 10 Dec 2007 22:36:11 +0100
Message-ID: <1197322571-25023-5-git-send-email-mh@glandium.org>
References: <1197322571-25023-1-git-send-email-mh@glandium.org>
 <1197322571-25023-2-git-send-email-mh@glandium.org>
 <1197322571-25023-3-git-send-email-mh@glandium.org>
 <1197322571-25023-4-git-send-email-mh@glandium.org>
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 10 22:36:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J1qIq-0003Jj-7B
	for gcvg-git-2@gmane.org; Mon, 10 Dec 2007 22:36:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753962AbXLJVgR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Dec 2007 16:36:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753954AbXLJVgQ
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Dec 2007 16:36:16 -0500
Received: from smtp27.orange.fr ([80.12.242.96]:55901 "EHLO smtp27.orange.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751485AbXLJVgO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Dec 2007 16:36:14 -0500
Received: from me-wanadoo.net (localhost [127.0.0.1])
	by mwinf2716.orange.fr (SMTP Server) with ESMTP id A6A7B1C000BE
	for <git@vger.kernel.org>; Mon, 10 Dec 2007 22:36:12 +0100 (CET)
Received: from namakemono.glandium.org (APuteaux-153-1-79-219.w81-249.abo.wanadoo.fr [81.249.109.219])
	by mwinf2716.orange.fr (SMTP Server) with ESMTP id 6931F1C00115;
	Mon, 10 Dec 2007 22:36:12 +0100 (CET)
X-ME-UUID: 20071210213612431.6931F1C00115@mwinf2716.orange.fr
Received: from mh by namakemono.glandium.org with local (Exim 4.68)
	(envelope-from <mh@glandium.org>)
	id 1J1qIO-0006W2-2P; Mon, 10 Dec 2007 22:36:12 +0100
X-Mailer: git-send-email 1.5.3.7.1159.gdd4a4-dirty
In-Reply-To: <1197322571-25023-4-git-send-email-mh@glandium.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67761>


Signed-off-by: Mike Hommey <mh@glandium.org>
---

 This one, too, sits on top of my strbuf patch for the http code. Note that
 I only went for the obvious ones I saw in the code I touched. There is more
 in these files.

 http-push.c   |   32 +++++++++++++++++++++-----------
 http-walker.c |   40 +++++++++++++++++++++++++---------------
 2 files changed, 46 insertions(+), 26 deletions(-)

diff --git a/http-push.c b/http-push.c
index ad8167e..610ed9c 100644
--- a/http-push.c
+++ b/http-push.c
@@ -924,6 +924,7 @@ static int fetch_index(unsigned char *sha1)
 				     hex);
 		}
 	} else {
+		free(url);
 		return error("Unable to start request");
 	}
 
@@ -1114,6 +1115,7 @@ int fetch_ref(char *ref, unsigned char *sha1)
 	char *base = remote->url;
 	struct active_request_slot *slot;
 	struct slot_results results;
+	int ret;
 
 	url = quote_ref_url(base, ref);
 	slot = get_active_slot();
@@ -1124,17 +1126,23 @@ int fetch_ref(char *ref, unsigned char *sha1)
 	curl_easy_setopt(slot->curl, CURLOPT_URL, url);
 	if (start_active_slot(slot)) {
 		run_active_slot(slot);
-		if (results.curl_result != CURLE_OK)
-			return error("Couldn't get %s for %s\n%s",
-				     url, ref, curl_errorstr);
+		if (results.curl_result == CURLE_OK) {
+			strbuf_rtrim(&buffer);
+			if (buffer.len == 40)
+				ret = get_sha1_hex(buffer.buf, sha1);
+			else
+				ret = 1;
+		} else {
+			ret = error("Couldn't get %s for %s\n%s",
+				    url, ref, curl_errorstr);
+		}
 	} else {
-		return error("Unable to start request");
+		ret = error("Unable to start request");
 	}
 
-	strbuf_rtrim(&buffer);
-	if (buffer.len != 40)
-		return 1;
-	return get_sha1_hex(buffer.buf, sha1);
+	strbuf_release(&buffer);
+	free(url);
+	return ret;
 }
 
 static void one_remote_object(const char *hex)
@@ -2033,6 +2041,7 @@ static int remote_exists(const char *path)
 	char *url = xmalloc(strlen(remote->url) + strlen(path) + 1);
 	struct active_request_slot *slot;
 	struct slot_results results;
+	int ret = -1;
 
 	sprintf(url, "%s%s", remote->url, path);
 
@@ -2044,16 +2053,17 @@ static int remote_exists(const char *path)
 	if (start_active_slot(slot)) {
 		run_active_slot(slot);
 		if (results.http_code == 404)
-			return 0;
+			ret = 0;
 		else if (results.curl_result == CURLE_OK)
-			return 1;
+			ret = 1;
 		else
 			fprintf(stderr, "HEAD HTTP error %ld\n", results.http_code);
 	} else {
 		fprintf(stderr, "Unable to start HEAD request\n");
 	}
 
-	return -1;
+	free(url);
+	return ret;
 }
 
 static void fetch_symref(const char *path, char **symref, unsigned char *sha1)
diff --git a/http-walker.c b/http-walker.c
index 8dbf9cc..4e878b3 100644
--- a/http-walker.c
+++ b/http-walker.c
@@ -644,6 +644,7 @@ static int fetch_indices(struct walker *walker, struct alt_base *repo)
 	struct strbuf buffer = STRBUF_INIT;
 	char *data;
 	int i = 0;
+	int ret = 0;
 
 	struct active_request_slot *slot;
 	struct slot_results results;
@@ -666,19 +667,19 @@ static int fetch_indices(struct walker *walker, struct alt_base *repo)
 	if (start_active_slot(slot)) {
 		run_active_slot(slot);
 		if (results.curl_result != CURLE_OK) {
-			strbuf_release(&buffer);
 			if (missing_target(&results)) {
 				repo->got_indices = 1;
-				return 0;
+				goto cleanup;
 			} else {
 				repo->got_indices = 0;
-				return error("%s", curl_errorstr);
+				ret = error("%s", curl_errorstr);
+				goto cleanup;
 			}
 		}
 	} else {
 		repo->got_indices = 0;
-		strbuf_release(&buffer);
-		return error("Unable to start request");
+		ret = error("Unable to start request");
+		goto cleanup;
 	}
 
 	data = buffer.buf;
@@ -701,9 +702,11 @@ static int fetch_indices(struct walker *walker, struct alt_base *repo)
 		i++;
 	}
 
-	strbuf_release(&buffer);
 	repo->got_indices = 1;
-	return 0;
+cleanup:
+	strbuf_release(&buffer);
+	free(url);
+	return ret;
 }
 
 static int fetch_pack(struct walker *walker, struct alt_base *repo, unsigned char *sha1)
@@ -939,6 +942,7 @@ static int fetch_ref(struct walker *walker, char *ref, unsigned char *sha1)
 	const char *base = data->alt->base;
 	struct active_request_slot *slot;
 	struct slot_results results;
+	int ret;
 
 	url = quote_ref_url(base, ref);
 	slot = get_active_slot();
@@ -949,17 +953,23 @@ static int fetch_ref(struct walker *walker, char *ref, unsigned char *sha1)
 	curl_easy_setopt(slot->curl, CURLOPT_URL, url);
 	if (start_active_slot(slot)) {
 		run_active_slot(slot);
-		if (results.curl_result != CURLE_OK)
-			return error("Couldn't get %s for %s\n%s",
-				     url, ref, curl_errorstr);
+		if (results.curl_result == CURLE_OK) {
+			strbuf_rtrim(&buffer);
+			if (buffer.len == 40)
+				ret = get_sha1_hex(buffer.buf, sha1);
+			else
+				ret = 1;
+		} else {
+			ret = error("Couldn't get %s for %s\n%s",
+				    url, ref, curl_errorstr);
+		}
 	} else {
-		return error("Unable to start request");
+		ret = error("Unable to start request");
 	}
 
-	strbuf_rtrim(&buffer);
-	if (buffer.len != 40)
-		return 1;
-	return get_sha1_hex(buffer.buf, sha1);
+	strbuf_release(&buffer);
+	free(url);
+	return ret;
 }
 
 static void cleanup(struct walker *walker)
-- 
1.5.3.7.1159.gdd4a4
