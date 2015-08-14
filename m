From: Elia Pinto <gitter.spiros@gmail.com>
Subject: [PATCHv4] http: add support for specifying the SSL version
Date: Fri, 14 Aug 2015 18:35:35 +0200
Message-ID: <1439570135-17324-1-git-send-email-gitter.spiros@gmail.com>
Cc: remi.galan-alfonso@ensimag.grenoble-inp.fr,
	sunshine@sunshineco.com, Elia Pinto <gitter.spiros@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 14 18:35:52 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZQHxJ-0005s6-Bz
	for gcvg-git-2@plane.gmane.org; Fri, 14 Aug 2015 18:35:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755225AbbHNQfl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Aug 2015 12:35:41 -0400
Received: from mail-pa0-f50.google.com ([209.85.220.50]:36591 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755104AbbHNQfk (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Aug 2015 12:35:40 -0400
Received: by pacrr5 with SMTP id rr5so63581975pac.3
        for <git@vger.kernel.org>; Fri, 14 Aug 2015 09:35:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=SbyGuL7UNAfs4YqiPKr9CZH6O+vmxuA9kpLDVvaeQOk=;
        b=WjkFyr1cVt4yYTXJ5CUtsC9ak0/966eAk9VCDXdB8jFx/R9j3V7Q1jhuem1dqqDq+2
         iT9n9BfanVX3qMEVfZZo3u0Ei7m6SUZ6hUW+txIsSROTuG1ef1+Ik5UdANoOhWoeAsFl
         fyz+4WXXGEmPxd9td0i3lo+T8Qs++xssx12kk4mpfGR+LU5ctQo1ZGcEIap1UZOIGWzN
         onMZT/6VtTpIj9QBU+x0mYS9/s9TDyFamFZowhMmWIoAHxvpVqSYu1mweP/bbmY5Vr2f
         oKs3e7hKuWma/RImosqHoY5K3zTIuDEkGBcJDwumrxFebehzYchEtq0yBMvj8/8mluTx
         Ocuw==
X-Received: by 10.66.136.102 with SMTP id pz6mr90006337pab.52.1439570139602;
        Fri, 14 Aug 2015 09:35:39 -0700 (PDT)
Received: from ubuntu14.nephoscale.com (static-67.207.195.141.nephosdns.com. [67.207.195.141])
        by smtp.gmail.com with ESMTPSA id f10sm6558913pdk.20.2015.08.14.09.35.38
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 14 Aug 2015 09:35:38 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.235.gb9bd8dc
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275909>

Teach git about a new option, "http.sslVersion", which permits one to
specify the SSL version  to use when negotiating SSL connections.  The
setting can be overridden by the GIT_SSL_VERSION environment
variable.

Signed-off-by: Elia Pinto <gitter.spiros@gmail.com>
---
This is the fourth revision of the patch. Changes from previous

- Used only ARRAY_SIZE for walking sslversions (Eric, Junio)
- Fixed some problems of style: spurious blanks in if stm, wrapped warning 


 Documentation/config.txt               | 22 ++++++++++++++++++++++
 contrib/completion/git-completion.bash |  1 +
 http.c                                 | 31 ++++++++++++++++++++++++++++++-
 3 files changed, 53 insertions(+), 1 deletion(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 315f271..b23b01a 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1595,6 +1595,28 @@ http.saveCookies::
 	If set, store cookies received during requests to the file specified by
 	http.cookieFile. Has no effect if http.cookieFile is unset.
 
+http.sslVersion::
+	The SSL version to use when negotiating an SSL connection, if you
+	want to force the default.  The available and default version depend on
+	whether libcurl was built against NSS or OpenSSL and the particular configuration
+	of the crypto library in use. Internally this sets the 'CURLOPT_SSL_VERSION'
+	option; see the libcurl documentation for more details on the format
+	of this option and for the ssl version supported. Actually the possible values
+	of this option are:
+
+	- sslv2
+	- sslv3
+	- tlsv1
+	- tlsv1.0
+	- tlsv1.1
+	- tlsv1.2
+
++
+Can be overridden by the 'GIT_SSL_VERSION' environment variable.
+To force git to use libcurl's default ssl version and ignore any
+explicit http.sslversion option, set 'GIT_SSL_VERSION' to the
+empty string.
+
 http.sslCipherList::
   A list of SSL ciphers to use when negotiating an SSL connection.
   The available ciphers depend on whether libcurl was built against
diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index c97c648..6e9359c 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -2118,6 +2118,7 @@ _git_config ()
 		http.postBuffer
 		http.proxy
 		http.sslCipherList
+		http.sslVersion
 		http.sslCAInfo
 		http.sslCAPath
 		http.sslCert
diff --git a/http.c b/http.c
index e9c6fdd..83118b5 100644
--- a/http.c
+++ b/http.c
@@ -37,6 +37,20 @@ static int curl_ssl_verify = -1;
 static int curl_ssl_try;
 static const char *ssl_cert;
 static const char *ssl_cipherlist;
+static const char *ssl_version;
+static struct {
+	const char *name;
+	long ssl_version;
+	} sslversions[] = {
+		{ "sslv2", CURL_SSLVERSION_SSLv2 },
+		{ "sslv3", CURL_SSLVERSION_TLSv1 },
+		{ "tlsv1", CURL_SSLVERSION_TLSv1 },
+#if LIBCURL_VERSION_NUM >= 0x072200
+		{ "tlsv1.0", CURL_SSLVERSION_TLSv1_0 },
+		{ "tlsv1.1", CURL_SSLVERSION_TLSv1_1 },
+		{ "tlsv1.2", CURL_SSLVERSION_TLSv1_2 }
+#endif
+};
 #if LIBCURL_VERSION_NUM >= 0x070903
 static const char *ssl_key;
 #endif
@@ -190,6 +204,8 @@ static int http_options(const char *var, const char *value, void *cb)
 	}
 	if (!strcmp("http.sslcipherlist", var))
 		return git_config_string(&ssl_cipherlist, var, value);
+	if (!strcmp("http.sslversion", var))
+		return git_config_string(&ssl_version, var, value);
 	if (!strcmp("http.sslcert", var))
 		return git_config_string(&ssl_cert, var, value);
 #if LIBCURL_VERSION_NUM >= 0x070903
@@ -364,9 +380,22 @@ static CURL *get_curl_handle(void)
 	if (http_proactive_auth)
 		init_curl_http_auth(result);
 
+	if (getenv("GIT_SSL_VERSION"))
+		ssl_version = getenv("GIT_SSL_VERSION");
+	if (ssl_version != NULL && *ssl_version) {
+		int i;
+		for ( i = 0; i < ARRAY_SIZE(sslversions); i++ ) {
+			if (!strcmp(ssl_version,sslversions[i].name)) {
+				curl_easy_setopt(result, CURLOPT_SSLVERSION,
+					sslversions[i].ssl_version);
+				break;
+			}
+		}
+		if (i == ARRAY_SIZE(sslversions)) warning("unsupported ssl version %s: using default",ssl_version);
+	}
+
 	if (getenv("GIT_SSL_CIPHER_LIST"))
 		ssl_cipherlist = getenv("GIT_SSL_CIPHER_LIST");
-
 	if (ssl_cipherlist != NULL && *ssl_cipherlist)
 		curl_easy_setopt(result, CURLOPT_SSL_CIPHER_LIST,
 				ssl_cipherlist);
-- 
2.5.0.235.gb9bd8dc
