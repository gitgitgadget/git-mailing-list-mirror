From: Lars Kellogg-Stedman <lars@redhat.com>
Subject: [PATCH v2] http: add support for specifying an SSL cipher list
Date: Thu,  7 May 2015 12:08:52 -0400
Message-ID: <1431014932-19236-1-git-send-email-lars@redhat.com>
References: <xmqq8ud0s7sv.fsf@gitster.dls.corp.google.com>
Cc: Lars Kellogg-Stedman <lars@redhat.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 07 18:09:04 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YqOM9-0004Yy-IJ
	for gcvg-git-2@plane.gmane.org; Thu, 07 May 2015 18:09:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751733AbbEGQI5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 May 2015 12:08:57 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46323 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751169AbbEGQI4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 May 2015 12:08:56 -0400
Received: from int-mx10.intmail.prod.int.phx2.redhat.com (int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	by mx1.redhat.com (Postfix) with ESMTPS id A35E58E78A
	for <git@vger.kernel.org>; Thu,  7 May 2015 16:08:56 +0000 (UTC)
Received: from lkellogg-pk115wp.redhat.com (ovpn-112-66.phx2.redhat.com [10.3.112.66])
	by int-mx10.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id t47G8tqk024825;
	Thu, 7 May 2015 12:08:56 -0400
Received: by lkellogg-pk115wp.redhat.com (Postfix, from userid 1000)
	id AE000A0E2B; Thu,  7 May 2015 12:08:54 -0400 (EDT)
In-Reply-To: <xmqq8ud0s7sv.fsf@gitster.dls.corp.google.com>
X-Scanned-By: MIMEDefang 2.68 on 10.5.11.23
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268539>

Teach git about a new option, "http.sslCipherList", which permits one to
specify a list of ciphers to use when negotiating SSL connections.  The
setting can be overwridden by the GIT_SSL_CIPHER_LIST environment
variable.

Signed-off-by: Lars Kellogg-Stedman <lars@redhat.com>
---
 Documentation/config.txt |  8 ++++++++
 http.c                   | 11 +++++++++++
 2 files changed, 19 insertions(+)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 2e5ceaf..b0af723 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1560,6 +1560,14 @@ http.saveCookies::
 	If set, store cookies received during requests to the file specified by
 	http.cookieFile. Has no effect if http.cookieFile is unset.
 
+http.sslCipherList::
+  A list of SSL ciphers to use when negotiating an SSL connection.
+  The available ciphers depend on whether libcurl was built against
+  NSS or OpenSSL and the particular configuration of the crypto
+  library in use.  Can be overwridden by the 'GIT_SSL_CIPHER_LIST'
+  environment variable.  To force git to use libcurl's default cipher
+  list, set GIT_SSL_CIPHER_LIST to the empty string.
+
 http.sslVerify::
 	Whether to verify the SSL certificate when fetching or pushing
 	over HTTPS. Can be overridden by the 'GIT_SSL_NO_VERIFY' environment
diff --git a/http.c b/http.c
index 4b179f6..55adff1 100644
--- a/http.c
+++ b/http.c
@@ -36,6 +36,7 @@ char curl_errorstr[CURL_ERROR_SIZE];
 static int curl_ssl_verify = -1;
 static int curl_ssl_try;
 static const char *ssl_cert;
+static const char *ssl_cipherlist;
 #if LIBCURL_VERSION_NUM >= 0x070903
 static const char *ssl_key;
 #endif
@@ -187,6 +188,9 @@ static int http_options(const char *var, const char *value, void *cb)
 		curl_ssl_verify = git_config_bool(var, value);
 		return 0;
 	}
+	if (!strcmp("http.sslcipherlist", var)) {
+		return git_config_string(&ssl_cipherlist, var, value);
+	}
 	if (!strcmp("http.sslcert", var))
 		return git_config_string(&ssl_cert, var, value);
 #if LIBCURL_VERSION_NUM >= 0x070903
@@ -361,6 +365,13 @@ static CURL *get_curl_handle(void)
 	if (http_proactive_auth)
 		init_curl_http_auth(result);
 
+	if (getenv("GIT_SSL_CIPHER_LIST"))
+		ssl_cipherlist = getenv("GIT_SSL_CIPHER_LIST");
+
+	if (ssl_cipherlist != NULL && ssl_cipherlist[0] != '\0')
+		curl_easy_setopt(result, CURLOPT_SSL_CIPHER_LIST,
+				ssl_cipherlist);
+
 	if (ssl_cert != NULL)
 		curl_easy_setopt(result, CURLOPT_SSLCERT, ssl_cert);
 	if (has_cert_password())
-- 
2.4.0
