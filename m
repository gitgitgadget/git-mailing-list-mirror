From: Sergey Vlasov <vsu@altlinux.ru>
Subject: [PATCH] git-http-fetch: Allow caching of retrieved objects by proxy servers
Date: Tue, 13 Sep 2005 19:38:58 +0400
Message-ID: <20050913153858.GB24405@master.mivlgu.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Tue Sep 13 17:39:13 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EFCsH-0002Wu-AQ
	for gcvg-git@gmane.org; Tue, 13 Sep 2005 17:39:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964774AbVIMPjG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 13 Sep 2005 11:39:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964804AbVIMPjG
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Sep 2005 11:39:06 -0400
Received: from mivlgu.ru ([81.18.140.87]:15036 "EHLO master.mivlgu.local")
	by vger.kernel.org with ESMTP id S964774AbVIMPjF (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 13 Sep 2005 11:39:05 -0400
Received: by master.mivlgu.local (Postfix, from userid 1000)
	id 999CC180119; Tue, 13 Sep 2005 19:38:58 +0400 (MSD)
To: git@vger.kernel.org
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8466>

By default the curl library adds "Pragma: no-cache" header to all
requests, which disables caching by proxy servers.  However, most
files in a GIT repository are immutable, and caching them is safe and
could be useful.

This patch removes the "Pragma: no-cache" header from requests for all
files except the pack list (objects/info/packs) and references
(refs/*), which are really mutable and should not be cached.

Signed-off-by: Sergey Vlasov <vsu@altlinux.ru>


---

 http-fetch.c |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

fd3f39120636d1ef8834845aa80475c1664a3a3e
diff --git a/http-fetch.c b/http-fetch.c
--- a/http-fetch.c
+++ b/http-fetch.c
@@ -14,6 +14,7 @@
 #endif
 
 static CURL *curl;
+static struct curl_slist *no_pragma_header;
 
 static char *base;
 
@@ -102,6 +103,7 @@ static int fetch_index(unsigned char *sh
 	curl_easy_setopt(curl, CURLOPT_FILE, indexfile);
 	curl_easy_setopt(curl, CURLOPT_WRITEFUNCTION, fwrite);
 	curl_easy_setopt(curl, CURLOPT_URL, url);
+	curl_easy_setopt(curl, CURLOPT_HTTPHEADER, no_pragma_header);
 	
 	if (curl_easy_perform(curl)) {
 		fclose(indexfile);
@@ -152,6 +154,7 @@ static int fetch_indices(void)
 	curl_easy_setopt(curl, CURLOPT_FILE, &buffer);
 	curl_easy_setopt(curl, CURLOPT_WRITEFUNCTION, fwrite_buffer);
 	curl_easy_setopt(curl, CURLOPT_URL, url);
+	curl_easy_setopt(curl, CURLOPT_HTTPHEADER, NULL);
 	
 	if (curl_easy_perform(curl)) {
 		return error("Unable to get pack index %s", url);
@@ -215,6 +218,7 @@ static int fetch_pack(unsigned char *sha
 	curl_easy_setopt(curl, CURLOPT_FILE, packfile);
 	curl_easy_setopt(curl, CURLOPT_WRITEFUNCTION, fwrite);
 	curl_easy_setopt(curl, CURLOPT_URL, url);
+	curl_easy_setopt(curl, CURLOPT_HTTPHEADER, no_pragma_header);
 	
 	if (curl_easy_perform(curl)) {
 		fclose(packfile);
@@ -255,6 +259,7 @@ int fetch(unsigned char *sha1)
 	curl_easy_setopt(curl, CURLOPT_FAILONERROR, 1);
 	curl_easy_setopt(curl, CURLOPT_FILE, NULL);
 	curl_easy_setopt(curl, CURLOPT_WRITEFUNCTION, fwrite_sha1_file);
+	curl_easy_setopt(curl, CURLOPT_HTTPHEADER, no_pragma_header);
 
 	url = xmalloc(strlen(base) + 50);
 	strcpy(url, base);
@@ -303,6 +308,7 @@ int fetch_ref(char *ref, unsigned char *
         
         curl_easy_setopt(curl, CURLOPT_FILE, &buffer);
         curl_easy_setopt(curl, CURLOPT_WRITEFUNCTION, fwrite_buffer);
+	curl_easy_setopt(curl, CURLOPT_HTTPHEADER, NULL);
 
         url = xmalloc(strlen(base) + 6 + strlen(ref));
         strcpy(url, base);
@@ -354,6 +360,7 @@ int main(int argc, char **argv)
 	curl_global_init(CURL_GLOBAL_ALL);
 
 	curl = curl_easy_init();
+	no_pragma_header = curl_slist_append(no_pragma_header, "Pragma:");
 
 	curl_ssl_verify = getenv("GIT_SSL_NO_VERIFY") ? 0 : 1;
 	curl_easy_setopt(curl, CURLOPT_SSL_VERIFYPEER, curl_ssl_verify);
@@ -366,6 +373,7 @@ int main(int argc, char **argv)
 	if (pull(commit_id))
 		return 1;
 
+	curl_slist_free_all(no_pragma_header);
 	curl_global_cleanup();
 	return 0;
 }
