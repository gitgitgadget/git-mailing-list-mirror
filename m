From: Lars Kellogg-Stedman <lars@redhat.com>
Subject: [PATCH v5] http: add support for specifying an SSL cipher list
Date: Fri,  8 May 2015 09:22:15 -0400
Message-ID: <1431091335-16455-1-git-send-email-lars@redhat.com>
References: <1431008210-673-1-git-send-email-lars@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: gitster@pobox.com, Lars Kellogg-Stedman <lars@redhat.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 08 15:22:56 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YqiEx-0005dE-D3
	for gcvg-git-2@plane.gmane.org; Fri, 08 May 2015 15:22:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753235AbbEHNWx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 8 May 2015 09:22:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55524 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753224AbbEHNWv (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 May 2015 09:22:51 -0400
Received: from int-mx11.intmail.prod.int.phx2.redhat.com (int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id t48DMmEU026035
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 8 May 2015 09:22:48 -0400
Received: from lkellogg-pk115wp.redhat.com (ovpn-112-66.phx2.redhat.com [10.3.112.66])
	by int-mx11.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id t48DMlnm016478;
	Fri, 8 May 2015 09:22:48 -0400
Received: by lkellogg-pk115wp.redhat.com (Postfix, from userid 1000)
	id CD8F7A1928; Fri,  8 May 2015 09:22:46 -0400 (EDT)
In-Reply-To: <1431008210-673-1-git-send-email-lars@redhat.com>
X-Scanned-By: MIMEDefang 2.68 on 10.5.11.24
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268618>

Teach git about a new option, "http.sslCipherList", which permits one t=
o
specify a list of ciphers to use when negotiating SSL connections.  The
setting can be overwridden by the GIT_SSL_CIPHER_LIST environment
variable.

Signed-off-by: Lars Kellogg-Stedman <lars@redhat.com>
---

Addressing comments from G=C3=A1bor and Eric.

 Documentation/config.txt               | 13 +++++++++++++
 contrib/completion/git-completion.bash |  1 +
 http.c                                 | 10 ++++++++++
 3 files changed, 24 insertions(+)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 2e5ceaf..e3f95a2 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1560,6 +1560,19 @@ http.saveCookies::
 	If set, store cookies received during requests to the file specified =
by
 	http.cookieFile. Has no effect if http.cookieFile is unset.
=20
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
diff --git a/contrib/completion/git-completion.bash b/contrib/completio=
n/git-completion.bash
index 5944c82..43bfc0c 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -2123,6 +2123,7 @@ _git_config ()
 		http.noEPSV
 		http.postBuffer
 		http.proxy
+		http.sslCipherList
 		http.sslCAInfo
 		http.sslCAPath
 		http.sslCert
diff --git a/http.c b/http.c
index 4b179f6..f0c5bbc 100644
--- a/http.c
+++ b/http.c
@@ -36,6 +36,7 @@ char curl_errorstr[CURL_ERROR_SIZE];
 static int curl_ssl_verify =3D -1;
 static int curl_ssl_try;
 static const char *ssl_cert;
+static const char *ssl_cipherlist;
 #if LIBCURL_VERSION_NUM >=3D 0x070903
 static const char *ssl_key;
 #endif
@@ -187,6 +188,8 @@ static int http_options(const char *var, const char=
 *value, void *cb)
 		curl_ssl_verify =3D git_config_bool(var, value);
 		return 0;
 	}
+	if (!strcmp("http.sslcipherlist", var))
+		return git_config_string(&ssl_cipherlist, var, value);
 	if (!strcmp("http.sslcert", var))
 		return git_config_string(&ssl_cert, var, value);
 #if LIBCURL_VERSION_NUM >=3D 0x070903
@@ -361,6 +364,13 @@ static CURL *get_curl_handle(void)
 	if (http_proactive_auth)
 		init_curl_http_auth(result);
=20
+	if (getenv("GIT_SSL_CIPHER_LIST"))
+		ssl_cipherlist =3D getenv("GIT_SSL_CIPHER_LIST");
+
+	if (ssl_cipherlist !=3D NULL && *ssl_cipherlist)
+		curl_easy_setopt(result, CURLOPT_SSL_CIPHER_LIST,
+				ssl_cipherlist);
+
 	if (ssl_cert !=3D NULL)
 		curl_easy_setopt(result, CURLOPT_SSLCERT, ssl_cert);
 	if (has_cert_password())
--=20
2.4.0
