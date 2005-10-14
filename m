From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] Some curl versions lack curl_easy_duphandle()
Date: Sat, 15 Oct 2005 00:39:17 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0510150038550.2807@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Sat Oct 15 00:40:54 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EQYDC-0001nE-8M
	for gcvg-git@gmane.org; Sat, 15 Oct 2005 00:39:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750969AbVJNWjW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 14 Oct 2005 18:39:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750991AbVJNWjW
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Oct 2005 18:39:22 -0400
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:37841 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S1750969AbVJNWjV (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Oct 2005 18:39:21 -0400
Received: from wrzx30.rz.uni-wuerzburg.de (wrzx30.rz.uni-wuerzburg.de [132.187.1.30])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 7A91413ECC1; Sat, 15 Oct 2005 00:39:17 +0200 (CEST)
Received: from virusscan (localhost [127.0.0.1])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 61D579ED76; Sat, 15 Oct 2005 00:39:17 +0200 (CEST)
Received: from wrzx28.rz.uni-wuerzburg.de (wrzx28.rz.uni-wuerzburg.de [132.187.3.28])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 45AEF9BD04; Sat, 15 Oct 2005 00:39:17 +0200 (CEST)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 207EF13ECC1; Sat, 15 Oct 2005 00:39:17 +0200 (CEST)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: git@vger.kernel.org, junkio@cox.net
X-Virus-Scanned: by amavisd-new (Rechenzentrum Universitaet Wuerzburg)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10124>

This patch looks bigger than it really is: The code to get the default handle
was refactored into a function, and is called instead of curl_easy_duphandle()
if that does not exist.

Tested once.

Signed-off-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>

---

 http-fetch.c |   73 +++++++++++++++++++++++++++++++++++++++-------------------
 1 files changed, 49 insertions(+), 24 deletions(-)

applies-to: 63f8082177fa17ae2aadd5ab417758f3d53456d8
1d9c990c46e306b6310fda8ff94bca2feccfbd99
diff --git a/http-fetch.c b/http-fetch.c
index 0aba891..5f1f7f9 100644
--- a/http-fetch.c
+++ b/http-fetch.c
@@ -18,6 +18,10 @@
 #define curl_global_init(a) do { /* nothing */ } while(0)
 #endif
 
+#if LIBCURL_VERSION_NUM < 0x070c04
+#define NO_CURL_EASY_DUPHANDLE
+#endif
+
 #define PREV_BUF_SIZE 4096
 #define RANGE_HEADER_SIZE 30
 
@@ -28,7 +32,9 @@ static int data_received;
 static int max_requests = DEFAULT_MAX_REQUESTS;
 static CURLM *curlm;
 #endif
+#ifndef NO_CURL_EASY_DUPHANDLE
 static CURL *curl_default;
+#endif
 static struct curl_slist *pragma_header;
 static struct curl_slist *no_pragma_header;
 static struct curl_slist *no_range_header;
@@ -87,8 +93,12 @@ static struct active_request_slot *activ
 
 static int curl_ssl_verify;
 static char *ssl_cert;
+#if LIBCURL_VERSION_NUM >= 0x070902
 static char *ssl_key;
+#endif
+#if LIBCURL_VERSION_NUM >= 0x070908
 static char *ssl_capath;
+#endif
 static char *ssl_cainfo;
 
 struct buffer
@@ -143,6 +153,37 @@ void process_curl_messages();
 void process_request_queue();
 #endif
 
+CURL* get_curl_handle()
+{
+	CURL* result = curl_easy_init();
+
+	curl_ssl_verify = getenv("GIT_SSL_NO_VERIFY") ? 0 : 1;
+	curl_easy_setopt(result, CURLOPT_SSL_VERIFYPEER, curl_ssl_verify);
+#if LIBCURL_VERSION_NUM >= 0x070907
+	curl_easy_setopt(result, CURLOPT_NETRC, CURL_NETRC_OPTIONAL);
+#endif
+
+	if ((ssl_cert = getenv("GIT_SSL_CERT")) != NULL) {
+		curl_easy_setopt(result, CURLOPT_SSLCERT, ssl_cert);
+	}
+#if LIBCURL_VERSION_NUM >= 0x070902
+	if ((ssl_key = getenv("GIT_SSL_KEY")) != NULL) {
+		curl_easy_setopt(result, CURLOPT_SSLKEY, ssl_key);
+	}
+#endif
+#if LIBCURL_VERSION_NUM >= 0x070908
+	if ((ssl_capath = getenv("GIT_SSL_CAPATH")) != NULL) {
+		curl_easy_setopt(result, CURLOPT_CAPATH, ssl_capath);
+	}
+#endif
+	if ((ssl_cainfo = getenv("GIT_SSL_CAINFO")) != NULL) {
+		curl_easy_setopt(result, CURLOPT_CAINFO, ssl_cainfo);
+	}
+	curl_easy_setopt(result, CURLOPT_FAILONERROR, 1);
+
+	return result;
+}
+
 struct active_request_slot *get_active_slot()
 {
 	struct active_request_slot *slot = active_queue_head;
@@ -165,7 +206,11 @@ struct active_request_slot *get_active_s
 	}
 	if (slot == NULL) {
 		newslot = xmalloc(sizeof(*newslot));
+#ifdef NO_CURL_EASY_DUPHANDLE
+		newslot->curl = get_curl_handle();
+#else
 		newslot->curl = curl_easy_duphandle(curl_default);
+#endif
 		newslot->in_use = 0;
 		newslot->next = NULL;
 
@@ -1098,32 +1143,10 @@ int main(int argc, char **argv)
 	no_pragma_header = curl_slist_append(no_pragma_header, "Pragma:");
 	no_range_header = curl_slist_append(no_range_header, "Range:");
 
-	curl_default = curl_easy_init();
-
-	curl_ssl_verify = getenv("GIT_SSL_NO_VERIFY") ? 0 : 1;
-	curl_easy_setopt(curl_default, CURLOPT_SSL_VERIFYPEER, curl_ssl_verify);
-#if LIBCURL_VERSION_NUM >= 0x070907
-	curl_easy_setopt(curl_default, CURLOPT_NETRC, CURL_NETRC_OPTIONAL);
+#ifndef NO_CURL_EASY_DUPHANDLE
+	curl_default = get_curl_handle();
 #endif
 
-	if ((ssl_cert = getenv("GIT_SSL_CERT")) != NULL) {
-		curl_easy_setopt(curl_default, CURLOPT_SSLCERT, ssl_cert);
-	}
-#if LIBCURL_VERSION_NUM >= 0x070902
-	if ((ssl_key = getenv("GIT_SSL_KEY")) != NULL) {
-		curl_easy_setopt(curl_default, CURLOPT_SSLKEY, ssl_key);
-	}
-#endif
-#if LIBCURL_VERSION_NUM >= 0x070908
-	if ((ssl_capath = getenv("GIT_SSL_CAPATH")) != NULL) {
-		curl_easy_setopt(curl_default, CURLOPT_CAPATH, ssl_capath);
-	}
-#endif
-	if ((ssl_cainfo = getenv("GIT_SSL_CAINFO")) != NULL) {
-		curl_easy_setopt(curl_default, CURLOPT_CAINFO, ssl_cainfo);
-	}
-	curl_easy_setopt(curl_default, CURLOPT_FAILONERROR, 1);
-
 	alt = xmalloc(sizeof(*alt));
 	alt->base = url;
 	alt->got_indices = 0;
@@ -1137,7 +1160,9 @@ int main(int argc, char **argv)
 	curl_slist_free_all(pragma_header);
 	curl_slist_free_all(no_pragma_header);
 	curl_slist_free_all(no_range_header);
+#ifndef NO_CURL_EASY_DUPHANDLE
 	curl_easy_cleanup(curl_default);
+#endif
 	slot = active_queue_head;
 	while (slot != NULL) {
 		curl_easy_cleanup(slot->curl);
---
0.99.8.GIT
