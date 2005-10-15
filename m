From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Some curl versions lack curl_easy_duphandle()
Date: Sat, 15 Oct 2005 13:50:16 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0510151348080.12307@wbgn013.biozentrum.uni-wuerzburg.de>
References: <Pine.LNX.4.63.0510150038550.2807@wbgn013.biozentrum.uni-wuerzburg.de>
 <7vmzlbpbwu.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Nick Hengeveld <nickh@reactrix.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 15 13:51:04 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EQkYq-0001hE-5N
	for gcvg-git@gmane.org; Sat, 15 Oct 2005 13:50:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751082AbVJOLuU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 15 Oct 2005 07:50:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751133AbVJOLuT
	(ORCPT <rfc822;git-outgoing>); Sat, 15 Oct 2005 07:50:19 -0400
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:47497 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S1751082AbVJOLuS (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Oct 2005 07:50:18 -0400
Received: from wrzx34.rz.uni-wuerzburg.de (wrzx34.rz.uni-wuerzburg.de [132.187.3.34])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 46D3013EE46; Sat, 15 Oct 2005 13:50:17 +0200 (CEST)
Received: from virusscan (localhost [127.0.0.1])
	by wrzx34.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 149BBB4D44; Sat, 15 Oct 2005 13:50:17 +0200 (CEST)
Received: from wrzx28.rz.uni-wuerzburg.de (wrzx28.rz.uni-wuerzburg.de [132.187.3.28])
	by wrzx34.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id DC2F4B08A3; Sat, 15 Oct 2005 13:50:16 +0200 (CEST)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 58E9013EE46; Sat, 15 Oct 2005 13:50:16 +0200 (CEST)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vmzlbpbwu.fsf@assigned-by-dhcp.cox.net>
X-Virus-Scanned: by amavisd-new (Rechenzentrum Universitaet Wuerzburg)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10131>

Hi,

On Fri, 14 Oct 2005, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > This patch looks bigger than it really is: The code to get the
> > default handle was refactored into a function, and is called
> > instead of curl_easy_duphandle() if that does not exist.
> 
> I'd like to take Nick's config file patch first, which
> unfortunately interferes with your patch.  I'd hate to ask you
> this, but could you rebase it on top of Nick's patch, [...]

No need to hate it. Here comes the rebased patch, and this time, I 
actually tested it a bit.

---

diff --git a/http-fetch.c b/http-fetch.c
index 784aedf..40bd0b4 100644
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
 static int max_requests = -1;
 static CURLM *curlm;
 #endif
+#ifndef NO_CURL_EASY_DUPHANDLE
 static CURL *curl_default;
+#endif
 static struct curl_slist *pragma_header;
 static struct curl_slist *no_pragma_header;
 static struct curl_slist *no_range_header;
@@ -87,8 +93,12 @@ static struct active_request_slot *activ
 
 static int curl_ssl_verify = -1;
 static char *ssl_cert = NULL;
+#if LIBCURL_VERSION_NUM >= 0x070902
 static char *ssl_key = NULL;
+#endif
+#if LIBCURL_VERSION_NUM >= 0x070908
 static char *ssl_capath = NULL;
+#endif
 static char *ssl_cainfo = NULL;
 
 struct buffer
@@ -213,6 +223,32 @@ void process_curl_messages();
 void process_request_queue();
 #endif
 
+static CURL* get_curl_handle()
+{
+	CURL* result = curl_easy_init();
+
+	curl_easy_setopt(result, CURLOPT_SSL_VERIFYPEER, curl_ssl_verify);
+#if LIBCURL_VERSION_NUM >= 0x070907
+	curl_easy_setopt(result, CURLOPT_NETRC, CURL_NETRC_OPTIONAL);
+#endif
+
+	if (ssl_cert != NULL)
+		curl_easy_setopt(result, CURLOPT_SSLCERT, ssl_cert);
+#if LIBCURL_VERSION_NUM >= 0x070902
+	if (ssl_key != NULL)
+		curl_easy_setopt(result, CURLOPT_SSLKEY, ssl_key);
+#endif
+#if LIBCURL_VERSION_NUM >= 0x070908
+	if (ssl_capath != NULL)
+		curl_easy_setopt(result, CURLOPT_CAPATH, ssl_capath);
+#endif
+	if (ssl_cainfo != NULL)
+		curl_easy_setopt(result, CURLOPT_CAINFO, ssl_cainfo);
+	curl_easy_setopt(result, CURLOPT_FAILONERROR, 1);
+
+	return result;
+}
+
 struct active_request_slot *get_active_slot()
 {
 	struct active_request_slot *slot = active_queue_head;
@@ -235,7 +271,11 @@ struct active_request_slot *get_active_s
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
 
@@ -1202,24 +1242,10 @@ int main(int argc, char **argv)
 	no_pragma_header = curl_slist_append(no_pragma_header, "Pragma:");
 	no_range_header = curl_slist_append(no_range_header, "Range:");
 
-	curl_default = curl_easy_init();
-
-	curl_easy_setopt(curl_default, CURLOPT_SSL_VERIFYPEER, curl_ssl_verify);
-#if LIBCURL_VERSION_NUM >= 0x070907
-	curl_easy_setopt(curl_default, CURLOPT_NETRC, CURL_NETRC_OPTIONAL);
+#ifndef NO_CURL_EASY_DUPHANDLE
+	curl_default = get_curl_handle();
 #endif
 
-	if (ssl_cert != NULL)
-		curl_easy_setopt(curl_default, CURLOPT_SSLCERT, ssl_cert);
-	if (ssl_key != NULL)
-		curl_easy_setopt(curl_default, CURLOPT_SSLKEY, ssl_key);
-	if (ssl_capath != NULL)
-		curl_easy_setopt(curl_default, CURLOPT_CAPATH, ssl_capath);
-	if (ssl_cainfo != NULL)
-		curl_easy_setopt(curl_default, CURLOPT_CAINFO, ssl_cainfo);
-
-	curl_easy_setopt(curl_default, CURLOPT_FAILONERROR, 1);
-
 	alt = xmalloc(sizeof(*alt));
 	alt->base = url;
 	alt->got_indices = 0;
@@ -1233,7 +1259,9 @@ int main(int argc, char **argv)
 	curl_slist_free_all(pragma_header);
 	curl_slist_free_all(no_pragma_header);
 	curl_slist_free_all(no_range_header);
+#ifndef NO_CURL_EASY_DUPHANDLE
 	curl_easy_cleanup(curl_default);
+#endif
 	slot = active_queue_head;
 	while (slot != NULL) {
 		curl_easy_cleanup(slot->curl);
