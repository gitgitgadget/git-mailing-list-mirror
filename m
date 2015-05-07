From: Lars Kellogg-Stedman <lars@redhat.com>
Subject: [PATCH] add support for specifying an SSL cipher list
Date: Thu,  7 May 2015 10:16:50 -0400
Message-ID: <1431008210-673-1-git-send-email-lars@redhat.com>
Cc: Lars Kellogg-Stedman <lars@redhat.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 07 16:17:17 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YqMc0-0002Ut-Ke
	for gcvg-git-2@plane.gmane.org; Thu, 07 May 2015 16:17:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752420AbbEGORN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 May 2015 10:17:13 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54425 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752411AbbEGORK (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 May 2015 10:17:10 -0400
Received: from int-mx11.intmail.prod.int.phx2.redhat.com (int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id t47EH9rc019800
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
	for <git@vger.kernel.org>; Thu, 7 May 2015 10:17:09 -0400
Received: from lkellogg-pk115wp.redhat.com (ovpn-112-66.phx2.redhat.com [10.3.112.66])
	by int-mx11.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id t47EH8FI020190;
	Thu, 7 May 2015 10:17:09 -0400
Received: by lkellogg-pk115wp.redhat.com (Postfix, from userid 1000)
	id C0AAAA0E2B; Thu,  7 May 2015 10:17:07 -0400 (EDT)
X-Scanned-By: MIMEDefang 2.68 on 10.5.11.24
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268532>

Teach git about a new option, "http.sslCipherList", which permits one to
specify a list of ciphers to use when negotiating SSL connections.  The
setting can be overwridden by the GIT_SSL_CIPHER_LIST environment
variable.

Signed-off-by: Lars Kellogg-Stedman <lars@redhat.com>
---

I was recently helping someone diagnose the following error when
trying to clone a remote repository:

  fatal: unable to access 'https://example.org/': Cannot communicate
  securely with peer: no common encryption algorithm(s).

This happens when the remote server and the default libcurl
configuration do not share any ciphers in common.  In this particular
case the solution was to add 'ecdhe_ecdsa_aes_128_gcm_sha_256' to the
list of ciphers via CURLOPT_SSL_CIPHER_LIST.  This patch permits one
to make such a configuration change in git.

 Documentation/config.txt |  7 +++++++
 http.c                   | 11 +++++++++++
 2 files changed, 18 insertions(+)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 2e5ceaf..b17985c 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1560,6 +1560,13 @@ http.saveCookies::
 	If set, store cookies received during requests to the file specified by
 	http.cookieFile. Has no effect if http.cookieFile is unset.
 
+http.sslCipherList::
+  A list of SSL ciphers to use when negotiating an SSL connection.
+  The available ciphers depend on whether libcurl was built against
+  NSS or OpenSSL and the particular configuration of the crypto
+  library in use.  Can be overwridden by the 'GIT_SSL_CIPHER_LIST'
+  environment variable.
+
 http.sslVerify::
 	Whether to verify the SSL certificate when fetching or pushing
 	over HTTPS. Can be overridden by the 'GIT_SSL_NO_VERIFY' environment
diff --git a/http.c b/http.c
index 4b179f6..8077f8d 100644
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
+	if (ssl_cipherlist != NULL)
+		curl_easy_setopt(result, CURLOPT_SSL_CIPHER_LIST,
+				ssl_cipherlist);
+
 	if (ssl_cert != NULL)
 		curl_easy_setopt(result, CURLOPT_SSLCERT, ssl_cert);
 	if (has_cert_password())
-- 
2.4.0
