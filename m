From: Nick Hengeveld <nickh@reactrix.com>
Subject: [PATCH] Support for more CURL SSL settings via environment variables
Date: Tue, 27 Sep 2005 10:45:27 -0700
Message-ID: <20050927174526.GD1377@reactrix.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Tue Sep 27 19:49:01 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EKJWE-0006AA-Rp
	for gcvg-git@gmane.org; Tue, 27 Sep 2005 19:45:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965031AbVI0Rp2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 27 Sep 2005 13:45:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965030AbVI0Rp2
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Sep 2005 13:45:28 -0400
Received: from 195.37.26.69.virtela.com ([69.26.37.195]:62716 "EHLO
	teapot.corp.reactrix.com") by vger.kernel.org with ESMTP
	id S965031AbVI0Rp1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Sep 2005 13:45:27 -0400
Received: from teapot.corp.reactrix.com (localhost.localdomain [127.0.0.1])
	by teapot.corp.reactrix.com (8.12.11/8.12.11) with ESMTP id j8RHjRBs005776
	for <git@vger.kernel.org>; Tue, 27 Sep 2005 10:45:27 -0700
Received: (from nickh@localhost)
	by teapot.corp.reactrix.com (8.12.11/8.12.11/Submit) id j8RHjRL6005774
	for git@vger.kernel.org; Tue, 27 Sep 2005 10:45:27 -0700
To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9410>

Added support for additional CURL SSL settings via environment variables.
Client certificate/key files can be specified as well as alternate CA
information.

Signed-off-by: Nick Hengeveld <nickh@reactrix.com>


---

 http-fetch.c |   19 +++++++++++++++++++
 1 files changed, 19 insertions(+), 0 deletions(-)

8ce3710b0b838d6f4c9813ad3631afced80ce346
diff --git a/http-fetch.c b/http-fetch.c
--- a/http-fetch.c
+++ b/http-fetch.c
@@ -35,6 +35,10 @@ static int local;
 static int zret;
 
 static int curl_ssl_verify;
+static char *ssl_cert;
+static char *ssl_key;
+static char *ssl_capath;
+static char *ssl_cainfo;
 
 struct buffer
 {
@@ -512,6 +516,21 @@ int main(int argc, char **argv)
 	curl_easy_setopt(curl, CURLOPT_NETRC, CURL_NETRC_OPTIONAL);
 #endif
 
+	if ((ssl_cert = getenv("GIT_SSL_CERT")) != NULL) {
+		curl_easy_setopt(curl, CURLOPT_SSLCERT, ssl_cert);
+	}
+	if ((ssl_key = getenv("GIT_SSL_KEY")) != NULL) {
+		curl_easy_setopt(curl, CURLOPT_SSLKEY, ssl_key);
+	}
+#if LIBCURL_VERSION_NUM >= 0x070908
+	if ((ssl_capath = getenv("GIT_SSL_CAPATH")) != NULL) {
+		curl_easy_setopt(curl, CURLOPT_CAPATH, ssl_capath);
+	}
+#endif
+	if ((ssl_cainfo = getenv("GIT_SSL_CAINFO")) != NULL) {
+		curl_easy_setopt(curl, CURLOPT_CAINFO, ssl_cainfo);
+	}
+
 	alt = xmalloc(sizeof(*alt));
 	alt->base = url;
 	alt->got_indices = 0;
