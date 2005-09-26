From: Nick Hengeveld <nickh@reactrix.com>
Subject: [PATCH 1/3] Support for SSL client cert
Date: Mon, 26 Sep 2005 10:51:57 -0700
Message-ID: <20050926175156.GB9410@reactrix.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Mon Sep 26 19:54:28 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EJx93-0005p2-W9
	for gcvg-git@gmane.org; Mon, 26 Sep 2005 19:52:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932445AbVIZRv6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 26 Sep 2005 13:51:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932446AbVIZRv6
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Sep 2005 13:51:58 -0400
Received: from 195.37.26.69.virtela.com ([69.26.37.195]:4344 "EHLO
	teapot.corp.reactrix.com") by vger.kernel.org with ESMTP
	id S932445AbVIZRv5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Sep 2005 13:51:57 -0400
Received: from teapot.corp.reactrix.com (localhost.localdomain [127.0.0.1])
	by teapot.corp.reactrix.com (8.12.11/8.12.11) with ESMTP id j8QHpvG3009437
	for <git@vger.kernel.org>; Mon, 26 Sep 2005 10:51:57 -0700
Received: (from nickh@localhost)
	by teapot.corp.reactrix.com (8.12.11/8.12.11/Submit) id j8QHpvoW009435
	for git@vger.kernel.org; Mon, 26 Sep 2005 10:51:57 -0700
To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9313>


Added SSL client args and CURL settings

Signed-off-by: Nick Hengeveld <nickh@reactrix.com>


---

 http-fetch.c |   28 +++++++++++++++++++++++++++-
 1 files changed, 27 insertions(+), 1 deletions(-)

2d293c34fdfde8a394b5f8a5c5343d9caf363bcc
diff --git a/http-fetch.c b/http-fetch.c
--- a/http-fetch.c
+++ b/http-fetch.c
@@ -476,6 +476,10 @@ int main(int argc, char **argv)
 	char *commit_id;
 	char *url;
 	int arg = 1;
+	char *ssl_cert = NULL;
+	char *ssl_key = NULL;
+	char *ssl_capath = NULL;
+	char *ssl_cacert = NULL;
 
 	while (arg < argc && argv[arg][0] == '-') {
 		if (argv[arg][1] == 't') {
@@ -491,11 +495,19 @@ int main(int argc, char **argv)
 		} else if (argv[arg][1] == 'w') {
 			write_ref = argv[arg + 1];
 			arg++;
+		} else if (arg+1 < argc && !strcmp(argv[arg], "--cert")) {
+			ssl_cert = argv[++arg];
+		} else if (arg+1 < argc && !strcmp(argv[arg], "--key")) {
+			ssl_key = argv[++arg];
+		} else if (arg+1 < argc && !strcmp(argv[arg], "--capath")) {
+			ssl_capath = argv[++arg];
+		} else if (arg+1 < argc && !strcmp(argv[arg], "--cacert")) {
+			ssl_cacert = argv[++arg];
 		}
 		arg++;
 	}
 	if (argc < arg + 2) {
-		usage("git-http-fetch [-c] [-t] [-a] [-d] [-v] [--recover] [-w ref] commit-id url");
+		usage("git-http-fetch [-c] [-t] [-a] [-d] [-v] [--recover] [-w ref] [--cert ssl-cert-file] [--key ssl-key-file] [--capath CA-dir] [--cacert CA-cert-file] commit-id url");
 		return 1;
 	}
 	commit_id = argv[arg];
@@ -506,6 +518,20 @@ int main(int argc, char **argv)
 	curl = curl_easy_init();
 	no_pragma_header = curl_slist_append(no_pragma_header, "Pragma:");
 
+        /* Set SSL parameters if they were provided */
+	if (ssl_cert != NULL) {
+		curl_easy_setopt(curl, CURLOPT_SSLCERT, ssl_cert);
+	}
+	if (ssl_key != NULL) {
+		curl_easy_setopt(curl, CURLOPT_SSLKEY, ssl_key);
+	}
+	if (ssl_capath != NULL) {
+		curl_easy_setopt(curl, CURLOPT_CAPATH, ssl_capath);
+	}
+	if (ssl_cacert != NULL) {
+		curl_easy_setopt(curl, CURLOPT_CAINFO, ssl_cacert);
+	}
+
 	curl_ssl_verify = getenv("GIT_SSL_NO_VERIFY") ? 0 : 1;
 	curl_easy_setopt(curl, CURLOPT_SSL_VERIFYPEER, curl_ssl_verify);
 #if LIBCURL_VERSION_NUM >= 0x070907
