From: Mark Lodato <lodatom@gmail.com>
Subject: [PATCH 1/2] http.c: prompt for SSL client certificate password
Date: Wed, 27 May 2009 23:16:02 -0400
Message-ID: <1243480563-5954-1-git-send-email-lodatom@gmail.com>
Cc: Mark Lodato <lodatom@gmail.com>
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 28 05:16:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M9W6o-0005jG-Sj
	for gcvg-git-2@gmane.org; Thu, 28 May 2009 05:16:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755441AbZE1DQj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 May 2009 23:16:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754858AbZE1DQj
	(ORCPT <rfc822;git-outgoing>); Wed, 27 May 2009 23:16:39 -0400
Received: from mail-qy0-f190.google.com ([209.85.221.190]:48947 "EHLO
	mail-qy0-f190.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754377AbZE1DQi (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 May 2009 23:16:38 -0400
Received: by qyk28 with SMTP id 28so5128155qyk.33
        for <git@vger.kernel.org>; Wed, 27 May 2009 20:16:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=2+ay2opALLrAf4wW9faPBLRkEC2/+oMffA0SCIvGXds=;
        b=xPMGz3FmiMI80TCyc41agSdcbkvLdWNGsT3swOBnXJ3q3lrIqEtR0I0IcH2VuE4vmZ
         Ee2BiHfDvY8sCte8NMj6meumgkwDL4E64yDa3kFQBXol8qHWO6dwissSnXJTwRw+FEnY
         /9gKzJ2z2g+SoHXENkQfLyykZ978e81mdgcmU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=TJscl+S+zCQIHPsIrXi1oDMHh1/oqwFnVMoAZMkDxPdEGzBJTvEJtb773yH29+1V3q
         xUWI/ZwTC95aMxqbiYyBG/7lry5qHHWCcCPuBCs2txH4m+tUlvQwcuk1x3T9Ld7qCJmK
         u13mSPvgWTptsl4CCG7KIr3mewIMvUImf2yYY=
Received: by 10.224.37.138 with SMTP id x10mr946317qad.147.1243480597653;
        Wed, 27 May 2009 20:16:37 -0700 (PDT)
Received: from localhost.localdomain (c-68-33-182-150.hsd1.dc.comcast.net [68.33.182.150])
        by mx.google.com with ESMTPS id 5sm680953qwg.29.2009.05.27.20.16.36
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 27 May 2009 20:16:37 -0700 (PDT)
X-Mailer: git-send-email 1.6.3.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120140>

If an SSL client certificate is enabled (via http.sslcert or
GIT_SSL_CERT), prompt for the certificate password rather than
defaulting to OpenSSL's password prompt.  This causes the prompt to only
appear once each run.  Previously, OpenSSL prompted the user *many*
times, causing git to be unusable over HTTPS with client-side
certificates.

Note that the password is stored in memory in the clear while the
program is running.  This may be a security problem if git crashes and
core dumps.

The user is always prompted, even if the certificate is not encrypted.
This should be fine; unencrypted certificates are rare and a security
risk anyway.

Signed-off-by: Mark Lodato <lodatom@gmail.com>
---

See http://osdir.com/ml/git/2009-02/msg03402.html for a discussion of
this topic and an example showing how horrible the current password
prompts are.

The next patch adds an option to disable this feature.  I split it into
two commits in case the configuration option is not wanted.

I did not create any tests because the existing http.sslcert option has
no tests to begin with.

I would really like to use git over HTTPS with client certs, but the
current situation is just unusable.  So, I'm hoping this gets included
in git.git at some point.  I would be happy to hear any comments people
have about this patch series.  Thanks!


 http.c |   40 +++++++++++++++++++++++++++++++++++++++-
 1 files changed, 39 insertions(+), 1 deletions(-)

diff --git a/http.c b/http.c
index 2e3d649..1fc3444 100644
--- a/http.c
+++ b/http.c
@@ -26,6 +26,8 @@ static long curl_low_speed_time = -1;
 static int curl_ftp_no_epsv;
 static const char *curl_http_proxy;
 static char *user_name, *user_pass;
+static char *ssl_cert_password;
+static int ssl_cert_password_required;
 
 static struct curl_slist *pragma_header;
 
@@ -167,6 +169,22 @@ static void init_curl_http_auth(CURL *result)
 	}
 }
 
+static int has_cert_password(void)
+{
+	if (ssl_cert_password != NULL)
+		return 1;
+	if (ssl_cert == NULL || ssl_cert_password_required != 1)
+		return 0;
+	/* Only prompt the user once. */
+	ssl_cert_password_required = -1;
+	ssl_cert_password = getpass("Certificate Password: ");
+	if (ssl_cert_password != NULL) {
+		ssl_cert_password = xstrdup(ssl_cert_password);
+		return 1;
+	} else
+		return 0;
+}
+
 static CURL *get_curl_handle(void)
 {
 	CURL *result = curl_easy_init();
@@ -189,6 +207,16 @@ static CURL *get_curl_handle(void)
 
 	if (ssl_cert != NULL)
 		curl_easy_setopt(result, CURLOPT_SSLCERT, ssl_cert);
+	if (has_cert_password())
+		curl_easy_setopt(result,
+#if LIBCURL_VERSION_NUM >= 0x071700
+				 CURLOPT_KEYPASSWD,
+#elif LIBCURL_VERSION_NUM >= 0x070903
+				 CURLOPT_SSLKEYPASSWD,
+#else
+				 CURLOPT_SSLCERTPASSWD,
+#endif
+				 ssl_cert_password);
 #if LIBCURL_VERSION_NUM >= 0x070902
 	if (ssl_key != NULL)
 		curl_easy_setopt(result, CURLOPT_SSLKEY, ssl_key);
@@ -329,8 +357,11 @@ void http_init(struct remote *remote)
 	if (getenv("GIT_CURL_FTP_NO_EPSV"))
 		curl_ftp_no_epsv = 1;
 
-	if (remote && remote->url && remote->url[0])
+	if (remote && remote->url && remote->url[0]) {
 		http_auth_init(remote->url[0]);
+		if (!prefixcmp(remote->url[0], "https://"))
+			ssl_cert_password_required = 1;
+	}
 
 #ifndef NO_CURL_EASY_DUPHANDLE
 	curl_default = get_curl_handle();
@@ -370,6 +401,13 @@ void http_cleanup(void)
 		free((void *)curl_http_proxy);
 		curl_http_proxy = NULL;
 	}
+
+	if (ssl_cert_password != NULL) {
+		memset(ssl_cert_password, 0, strlen(ssl_cert_password));
+		free(ssl_cert_password);
+		ssl_cert_password = NULL;
+	}
+	ssl_cert_password_required = 0;
 }
 
 struct active_request_slot *get_active_slot(void)
-- 
1.6.3.1
