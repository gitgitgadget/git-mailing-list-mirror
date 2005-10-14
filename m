From: Nick Hengeveld <nickh@reactrix.com>
Subject: [PATCH] Use config file settings for http
Date: Fri, 14 Oct 2005 11:51:18 -0700
Message-ID: <20051014185118.GA5509@reactrix.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Fri Oct 14 20:54:30 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EQUeM-0001C1-Le
	for gcvg-git@gmane.org; Fri, 14 Oct 2005 20:51:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750879AbVJNSvX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 14 Oct 2005 14:51:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750878AbVJNSvX
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Oct 2005 14:51:23 -0400
Received: from 194.37.26.69.virtela.com ([69.26.37.194]:20138 "EHLO
	teapot.corp.reactrix.com") by vger.kernel.org with ESMTP
	id S1750860AbVJNSvX (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Oct 2005 14:51:23 -0400
Received: from teapot.corp.reactrix.com (localhost.localdomain [127.0.0.1])
	by teapot.corp.reactrix.com (8.12.11/8.12.11) with ESMTP id j9EIpIeb010855
	for <git@vger.kernel.org>; Fri, 14 Oct 2005 11:51:18 -0700
Received: (from nickh@localhost)
	by teapot.corp.reactrix.com (8.12.11/8.12.11/Submit) id j9EIpIR8010853
	for git@vger.kernel.org; Fri, 14 Oct 2005 11:51:18 -0700
To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10121>

Use "http." config file settings if they exist.  Environment variables
still work, and they will override config file settings.

Signed-off-by: Nick Hengeveld <nickh@reactrix.com>


---

 http-fetch.c |  109 +++++++++++++++++++++++++++++++++++++++++++++++-----------
 1 files changed, 88 insertions(+), 21 deletions(-)

e1564121cae5272fbac9710a61ac182ddb9d421c
diff --git a/http-fetch.c b/http-fetch.c
--- a/http-fetch.c
+++ b/http-fetch.c
@@ -25,7 +25,7 @@ static int active_requests = 0;
 static int data_received;
 
 #ifdef USE_CURL_MULTI
-static int max_requests = DEFAULT_MAX_REQUESTS;
+static int max_requests = -1;
 static CURLM *curlm;
 #endif
 static CURL *curl_default;
@@ -85,11 +85,11 @@ struct active_request_slot
 static struct transfer_request *request_queue_head = NULL;
 static struct active_request_slot *active_queue_head = NULL;
 
-static int curl_ssl_verify;
-static char *ssl_cert;
-static char *ssl_key;
-static char *ssl_capath;
-static char *ssl_cainfo;
+static int curl_ssl_verify = -1;
+static char *ssl_cert = NULL;
+static char *ssl_key = NULL;
+static char *ssl_capath = NULL;
+static char *ssl_cainfo = NULL;
 
 struct buffer
 {
@@ -98,6 +98,60 @@ struct buffer
         void *buffer;
 };
 
+static int http_options(const char *var, const char *value)
+{
+	if (!strcmp("http.sslverify", var)) {
+		if (curl_ssl_verify == -1) {
+			curl_ssl_verify = git_config_bool(var, value);
+		}
+		return 0;
+	}
+
+	if (!strcmp("http.sslcert", var)) {
+		if (ssl_cert == NULL) {
+			ssl_cert = xmalloc(strlen(value)+1);
+			strcpy(ssl_cert, value);
+		}
+		return 0;
+	}
+#if LIBCURL_VERSION_NUM >= 0x070902
+	if (!strcmp("http.sslkey", var)) {
+		if (ssl_key == NULL) {
+			ssl_key = xmalloc(strlen(value)+1);
+			strcpy(ssl_key, value);
+		}
+		return 0;
+	}
+#endif
+#if LIBCURL_VERSION_NUM >= 0x070908
+	if (!strcmp("http.sslcapath", var)) {
+		if (ssl_capath == NULL) {
+			ssl_capath = xmalloc(strlen(value)+1);
+			strcpy(ssl_capath, value);
+		}
+		return 0;
+	}
+#endif
+	if (!strcmp("http.sslcainfo", var)) {
+		if (ssl_cainfo == NULL) {
+			ssl_cainfo = xmalloc(strlen(value)+1);
+			strcpy(ssl_cainfo, value);
+		}
+		return 0;
+	}
+
+#ifdef USE_CURL_MULTI	
+	if (!strcmp("http.maxrequests", var)) {
+		if (max_requests == -1)
+			max_requests = git_config_int(var, value);
+		return 0;
+	}
+#endif
+
+	/* Fall back on the default ones */
+	return git_default_config(var, value);
+}
+
 static size_t fwrite_buffer(void *ptr, size_t eltsize, size_t nmemb,
                             struct buffer *buffer)
 {
@@ -1114,8 +1168,6 @@ int main(int argc, char **argv)
 	char *http_max_requests = getenv("GIT_HTTP_MAX_REQUESTS");
 	if (http_max_requests != NULL)
 		max_requests = atoi(http_max_requests);
-	if (max_requests < 1)
-		max_requests = DEFAULT_MAX_REQUESTS;
 
 	curlm = curl_multi_init();
 	if (curlm == NULL) {
@@ -1123,34 +1175,49 @@ int main(int argc, char **argv)
 		return 1;
 	}
 #endif
+
+	if (getenv("GIT_SSL_NO_VERIFY"))
+		curl_ssl_verify = 0;
+
+	ssl_cert = getenv("GIT_SSL_CERT");
+#if LIBCURL_VERSION_NUM >= 0x070902
+	ssl_key = getenv("GIT_SSL_KEY");
+#endif
+#if LIBCURL_VERSION_NUM >= 0x070908
+	ssl_capath = getenv("GIT_SSL_CAPATH");
+#endif
+	ssl_cainfo = getenv("GIT_SSL_CAINFO");
+
+	git_config(http_options);
+
+	if (curl_ssl_verify == -1)
+		curl_ssl_verify = 1;
+
+#ifdef USE_CURL_MULTI
+	if (max_requests < 1)
+		max_requests = DEFAULT_MAX_REQUESTS;
+#endif
+
 	pragma_header = curl_slist_append(pragma_header, "Pragma: no-cache");
 	no_pragma_header = curl_slist_append(no_pragma_header, "Pragma:");
 	no_range_header = curl_slist_append(no_range_header, "Range:");
 
 	curl_default = curl_easy_init();
 
-	curl_ssl_verify = getenv("GIT_SSL_NO_VERIFY") ? 0 : 1;
 	curl_easy_setopt(curl_default, CURLOPT_SSL_VERIFYPEER, curl_ssl_verify);
 #if LIBCURL_VERSION_NUM >= 0x070907
 	curl_easy_setopt(curl_default, CURLOPT_NETRC, CURL_NETRC_OPTIONAL);
 #endif
 
-	if ((ssl_cert = getenv("GIT_SSL_CERT")) != NULL) {
+	if (ssl_cert != NULL)
 		curl_easy_setopt(curl_default, CURLOPT_SSLCERT, ssl_cert);
-	}
-#if LIBCURL_VERSION_NUM >= 0x070902
-	if ((ssl_key = getenv("GIT_SSL_KEY")) != NULL) {
+	if (ssl_key != NULL)
 		curl_easy_setopt(curl_default, CURLOPT_SSLKEY, ssl_key);
-	}
-#endif
-#if LIBCURL_VERSION_NUM >= 0x070908
-	if ((ssl_capath = getenv("GIT_SSL_CAPATH")) != NULL) {
+	if (ssl_capath != NULL)
 		curl_easy_setopt(curl_default, CURLOPT_CAPATH, ssl_capath);
-	}
-#endif
-	if ((ssl_cainfo = getenv("GIT_SSL_CAINFO")) != NULL) {
+	if (ssl_cainfo != NULL)
 		curl_easy_setopt(curl_default, CURLOPT_CAINFO, ssl_cainfo);
-	}
+
 	curl_easy_setopt(curl_default, CURLOPT_FAILONERROR, 1);
 
 	alt = xmalloc(sizeof(*alt));
