From: Lars Kellogg-Stedman <lars@redhat.com>
Subject: [PATCH v4] http: add support for specifying an SSL cipher list
Date: Thu,  7 May 2015 23:44:45 -0400
Message-ID: <1431056685-12337-1-git-send-email-lars@redhat.com>
References: <1431008210-673-1-git-send-email-lars@redhat.com>
Cc: gitster@pobox.com, Lars Kellogg-Stedman <lars@redhat.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 08 05:45:02 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YqZDg-0002fr-MH
	for gcvg-git-2@plane.gmane.org; Fri, 08 May 2015 05:45:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751778AbbEHDo4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 May 2015 23:44:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39623 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750995AbbEHDoz (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 May 2015 23:44:55 -0400
Received: from int-mx14.intmail.prod.int.phx2.redhat.com (int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id t483ist0016969
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 7 May 2015 23:44:54 -0400
Received: from lkellogg-pk115wp.redhat.com (ovpn-112-66.phx2.redhat.com [10.3.112.66])
	by int-mx14.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id t483irvp023586;
	Thu, 7 May 2015 23:44:54 -0400
Received: by lkellogg-pk115wp.redhat.com (Postfix, from userid 1000)
	id 99F8EA1928; Thu,  7 May 2015 23:44:52 -0400 (EDT)
In-Reply-To: <1431008210-673-1-git-send-email-lars@redhat.com>
X-Scanned-By: MIMEDefang 2.68 on 10.5.11.27
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268600>

Teach git about a new option, "http.sslCipherList", which permits one to
specify a list of ciphers to use when negotiating SSL connections.  The
setting can be overwridden by the GIT_SSL_CIPHER_LIST environment
variable.

Signed-off-by: Lars Kellogg-Stedman <lars@redhat.com>
---
 Documentation/config.txt | 13 +++++++++++++
 http.c                   | 11 +++++++++++
 2 files changed, 24 insertions(+)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 2e5ceaf..e3f95a2 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1560,6 +1560,19 @@ http.saveCookies::
 	If set, store cookies received during requests to the file specified by
 	http.cookieFile. Has no effect if http.cookieFile is unset.
 
+http.sslCipherList::
+  A list of SSL ciphers to use when negotiating an SSL connection.
+  The available ciphers depend on whether libcurl was built against
+  NSS or OpenSSL and the particular configuration of the crypto
+  library in use.  Internally this sets the 'CURLOPT_SSL_CIPHER_LIST'
+  option; see the libcurl documentation for more details on the format
+  of this list.
++
+Can be overridden by the 'GIT_SSL_CIPHER_LIST' environment variable.
+To force git to use libcurl's default cipher list and ignore any
+explicit http.sslCipherList option, set 'GIT_SSL_CIPHER_LIST' to the
+empty string.
+
 http.sslVerify::
 	Whether to verify the SSL certificate when fetching or pushing
 	over HTTPS. Can be overridden by the 'GIT_SSL_NO_VERIFY' environment
diff --git a/http.c b/http.c
index 4b179f6..3a39d07 100644
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
+	if (ssl_cipherlist != NULL && *ssl_cipherlist)
+		curl_easy_setopt(result, CURLOPT_SSL_CIPHER_LIST,
+				ssl_cipherlist);
+
 	if (ssl_cert != NULL)
 		curl_easy_setopt(result, CURLOPT_SSLCERT, ssl_cert);
 	if (has_cert_password())
-- 
2.4.0
