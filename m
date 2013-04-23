From: Jerry Qassar <jqassar@gmail.com>
Subject: [PATCH] http.c: Add config options/parsing for SSL engine vars
Date: Tue, 23 Apr 2013 16:03:27 -0700
Message-ID: <1366758207-7724-1-git-send-email-jqassar@gmail.com>
Cc: Jerry Qassar <jqassar@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 24 01:03:46 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UUmFR-0005l4-LP
	for gcvg-git-2@plane.gmane.org; Wed, 24 Apr 2013 01:03:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753987Ab3DWXDh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Apr 2013 19:03:37 -0400
Received: from mail-pa0-f47.google.com ([209.85.220.47]:60978 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751705Ab3DWXDg (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Apr 2013 19:03:36 -0400
Received: by mail-pa0-f47.google.com with SMTP id bj1so785662pad.20
        for <git@vger.kernel.org>; Tue, 23 Apr 2013 16:03:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer;
        bh=C2mnytaLzHOTY705OzMs+QbjnWVOV64xcX2Fa4flyg4=;
        b=BzI4kfHsid2MBqbS3sFQQe83vfyW1Tb2NbQF6qoiQt6aOcLh+Ud74RICdElWfgWvhu
         oexqK1dWEu2+MFQU8OhWOy187v3y935ec76D0OaWZB3SJ/0jrp7FcbIE/mK4WfmmD7uf
         m0SNzAezHOF5Jngd6qHJw+eTmOkH/NIqOqgNlZNkRQXqNosj033ntOCd13g52+FGBuqg
         z7QuJT9BgUW23EVE+Y0FtdkbHycK7G8ZgUNt1DYnlUedKecNx7WXwW0ss/0LD/w9W+Or
         EHLt2SXDIQUXbRlEAx8ER3DaiWO8GP5jvri6bLQODxmB47HZiF3V3P+jgZo9pm9V2qzy
         wGpw==
X-Received: by 10.69.11.133 with SMTP id ei5mr44625532pbd.137.1366758216427;
        Tue, 23 Apr 2013 16:03:36 -0700 (PDT)
Received: from localhost.localdomain (cmagent04.sd.spawar.navy.mil. [128.49.67.13])
        by mx.google.com with ESMTPSA id b7sm303241pba.39.2013.04.23.16.03.33
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 23 Apr 2013 16:03:34 -0700 (PDT)
X-Mailer: git-send-email 1.8.2.1.342.gfa7285d.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222217>


curl provides many options for configuring the way it negotiates an SSL
connection (with its default OpenSSL support), including ways to define
the SSL engine used, and parameters to set the format of the key and
certificate used.  Unfortunately, git does not parse some of the
critical ones needed by curl to support PKCS#11.

Add the following git config variables (and direct env-set variables):

* http.sslengine
  A string variable that sets CURLOPT_SSLENGINE on the back end.
  Can be set from environment using GIT_SSL_ENGINE.
* http.sslkeytype
  A string variable, either PEM/DER/ENG, that sets CURLOPT_SSLKEYTYPE.
  Can be set from environment using GIT_SSL_KEYTYPE.
* http.sslcerttype
  A string variable, either PEM/DER/ENG, that sets CURLOPT_SSLCERTTYPE.
  Can be set from environment using GIT_SSL_CERTTYPE.

Parsing these new variables combined with related patches to curl
will allow git to support native authentication with smart cards.

Note: It's difficult to test this without the related curl patches,
which I will be submitting soon.  At the very least, leaving these new
options unset doesn't break anything, and setting them has little
effect without the back-end curl changes needed to 'turn on' PKCS#11.
Any suggestions would be greatly appreciated.

Signed-off-by: Jerry Qassar <jqassar@gmail.com>
---
 Documentation/config.txt | 13 +++++++++++++
 http.c                   | 36 ++++++++++++++++++++++++++++++++++++
 2 files changed, 49 insertions(+)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index c67038b..d155620 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1440,16 +1440,29 @@ http.sslVerify::
 	over HTTPS. Can be overridden by the 'GIT_SSL_NO_VERIFY' environment
 	variable.
 
+http.sslEngine::
+	String specifying the SSL engine to be used by curl.  This can be used to
+	specify non-default or dynamically loaded engines.  Can be overridden by
+	the 'GIT_SSL_ENGINE' environment variable.
+
 http.sslCert::
 	File containing the SSL certificate when fetching or pushing
 	over HTTPS. Can be overridden by the 'GIT_SSL_CERT' environment
 	variable.
 
+http.sslCertType::
+	Specifies the format of the certificate to curl as one of (PEM|DER|ENG).
+	Can be overridden by the 'GIT_SSL_CERTTYPE' environment variable.
+
 http.sslKey::
 	File containing the SSL private key when fetching or pushing
 	over HTTPS. Can be overridden by the 'GIT_SSL_KEY' environment
 	variable.
 
+http.sslKeyType::
+	Specifies the format of the private key to curl as one of (PEM|DER|ENG).
+	Can be overridden by the 'GIT_SSL_KEYTYPE' environment variable.
+
 http.sslCertPasswordProtected::
 	Enable Git's password prompt for the SSL certificate.  Otherwise
 	OpenSSL will prompt the user, possibly many times, if the
diff --git a/http.c b/http.c
index 92aba59..06cb22e 100644
--- a/http.c
+++ b/http.c
@@ -49,6 +49,10 @@ static struct credential http_auth = CREDENTIAL_INIT;
 static int http_proactive_auth;
 static const char *user_agent;
 
+static const char *ssl_keytype;
+static const char *ssl_certtype;
+static const char *ssl_engine;
+
 #if LIBCURL_VERSION_NUM >= 0x071700
 /* Use CURLOPT_KEYPASSWD as is */
 #elif LIBCURL_VERSION_NUM >= 0x070903
@@ -211,6 +215,17 @@ static int http_options(const char *var, const char *value, void *cb)
 	if (!strcmp("http.useragent", var))
 		return git_config_string(&user_agent, var, value);
 
+	/* Adding parsing for curl options relating to engines and */
+	/* key/cert types.  This is necessary if attempting to     */
+	/* specify an external engine (e.g. for smartcards.)       */
+
+	if (!strcmp("http.sslkeytype", var))
+		return git_config_string(&ssl_keytype, var, value);
+	if (!strcmp("http.sslcerttype", var))
+		return git_config_string(&ssl_certtype, var, value);
+	if (!strcmp("http.sslengine", var))
+		return git_config_string(&ssl_engine, var, value);
+
 	/* Fall back on the default ones */
 	return git_default_config(var, value, cb);
 }
@@ -321,6 +336,22 @@ static CURL *get_curl_handle(void)
 		curl_easy_setopt(result, CURLOPT_PROXYAUTH, CURLAUTH_ANY);
 	}
 
+	/* Adding setting of engine-related curl SSL options. */
+	if (ssl_engine != NULL) {
+		curl_easy_setopt(result, CURLOPT_SSLENGINE, ssl_engine);
+
+		/* Within the lifetime of a single git execution, setting
+		 * the default does nothing interesting.  When curl properly
+		 * duplicates handles, the engine choice will propagate.
+		 */
+		/* curl_easy_setopt(result, CURLOPT_SSLENGINE_DEFAULT, 1L); */
+	}
+
+	if (ssl_keytype != NULL)
+		curl_easy_setopt(result, CURLOPT_SSLKEYTYPE, ssl_keytype);
+	if (ssl_certtype != NULL)
+		curl_easy_setopt(result, CURLOPT_SSLCERTTYPE, ssl_certtype);
+
 	return result;
 }
 
@@ -405,6 +436,11 @@ void http_init(struct remote *remote, const char *url, int proactive_auth)
 			ssl_cert_password_required = 1;
 	}
 
+	/* Added environment variables for expanded engine-related options. */
+	set_from_env(&ssl_keytype, "GIT_SSL_KEYTYPE");
+	set_from_env(&ssl_certtype, "GIT_SSL_CERTTYPE");
+	set_from_env(&ssl_engine, "GIT_SSL_ENGINE");
+
 #ifndef NO_CURL_EASY_DUPHANDLE
 	curl_default = get_curl_handle();
 #endif
-- 
1.8.2.1.342.gfa7285d.dirty
