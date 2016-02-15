From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH] http: add option to try authentication without username
Date: Mon, 15 Feb 2016 18:44:46 +0000
Message-ID: <1455561886-42028-1-git-send-email-sandals@crustytoothpaste.net>
References: <CAHdYDCq+MiAJoCPFd3Qn9VjAzoii8QgTOOV7HXEV8OdzW-dgPQ@mail.gmail.com>
Cc: Dmitry Vilkov <dmitry.a.vilkov@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 15 19:45:04 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aVO8t-0008Ey-8Y
	for gcvg-git-2@plane.gmane.org; Mon, 15 Feb 2016 19:45:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753884AbcBOSo5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Feb 2016 13:44:57 -0500
Received: from castro.crustytoothpaste.net ([173.11.243.49]:39982 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753806AbcBOSoz (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 15 Feb 2016 13:44:55 -0500
Received: from vauxhall.crustytoothpaste.net (unknown [50.244.99.171])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id AB560282CA;
	Mon, 15 Feb 2016 18:44:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=crustytoothpaste.net;
	s=default; t=1455561892;
	bh=MIE2E59Y8UtV4atvnhZNSeG3bpWXYfu2hGKF/UDErRQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=0+6ggz7mf5UJkWXBjF3wKgJqp8B8Auy9C+5n3cdD1VXt8mB8GG06nLAXSYNpDIF/b
	 /T7GUfwJZUrmuTnra4wSpujx1sJamVDi+tIig0LdOhabV3gtmM67AA9wrFo++OeYLk
	 Dv0hcNAHSAz7s2P0GovW/aekwPtfIRRNjBcUeBb33cH2RmoAOJcaqzstZuFpKdmSn9
	 yQUTIhsWDf6GHaKt3Ddez9tkHD2mH7Z8EG91TNmIQT1OQZTOUnvQX8K5ZihLxrmJPW
	 VG1bzcfg/HKuskejap06t/QOXybQQcZm71KoOR+J3enoxod+N1RhpFlE3KgKOtBulc
	 y9KIImPU6Lacgxb8Uo86QYFtOAkSuNYZ9QkKRW6LkqFtF8WLUKwCcwn681MXwL9DGe
	 fLLmOT2YiOU0NOxI3jaSJlAQRDUGtPPpt3YoQWX2w0KWBohsc7mRejVIpfjv1s+GI2
	 UiShAEByC9wMND+OVejb30LzTwoG/Rqa0LlyjcoQBe7ew73wfWM
X-Mailer: git-send-email 2.7.0.79.gdc08a19
In-Reply-To: <CAHdYDCq+MiAJoCPFd3Qn9VjAzoii8QgTOOV7HXEV8OdzW-dgPQ@mail.gmail.com>
X-Spam-Score: -0.262 BAYES_00,RDNS_NONE,T_DKIM_INVALID
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286229>

Performing GSS-Negotiate authentication using Kerberos does not require
specifying a username or password, since that information is already
included in the ticket itself.  However, libcurl refuses to perform
authentication if it has not been provided with a username and password.
Add an option, http.emptyAuth, that provides libcurl with an empty
username and password to make it attempt authentication anyway.
---
I'm not super excited about this name, but I couldn't think of a better
one.  Suggestions welcome.

 Documentation/config.txt |  6 ++++++
 http.c                   | 13 +++++++++++--
 2 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 27f02be3..f11de77e 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1648,6 +1648,12 @@ http.proxyAuthMethod::
 * `ntlm` - NTLM authentication (compare the --ntlm option of `curl(1)`)
 --
 
+http.emptyAuth::
+	Attempt authentication without seeking a username or password.  This
+	can be used to attempt GSS-Negotiate authentication without specifying
+	a username in the URL, as libcurl normally requires a username for
+	authentication.
+
 http.cookieFile::
 	File containing previously stored cookie lines which should be used
 	in the Git http session, if they match the server. The file format
diff --git a/http.c b/http.c
index dfc53c1e..a12a804b 100644
--- a/http.c
+++ b/http.c
@@ -87,6 +87,7 @@ static int curl_save_cookies;
 struct credential http_auth = CREDENTIAL_INIT;
 static int http_proactive_auth;
 static const char *user_agent;
+static int curl_empty_auth;
 
 #if LIBCURL_VERSION_NUM >= 0x071700
 /* Use CURLOPT_KEYPASSWD as is */
@@ -299,14 +300,22 @@ static int http_options(const char *var, const char *value, void *cb)
 	if (!strcmp("http.useragent", var))
 		return git_config_string(&user_agent, var, value);
 
+	if (!strcmp("http.emptyauth", var)) {
+		curl_empty_auth = git_config_bool(var, value);
+		return 0;
+	}
+
 	/* Fall back on the default ones */
 	return git_default_config(var, value, cb);
 }
 
 static void init_curl_http_auth(CURL *result)
 {
-	if (!http_auth.username)
+	if (!http_auth.username) {
+		if (curl_empty_auth)
+			curl_easy_setopt(result, CURLOPT_USERPWD, ":");
 		return;
+	}
 
 	credential_fill(&http_auth);
 
@@ -827,7 +836,7 @@ struct active_request_slot *get_active_slot(void)
 #ifdef LIBCURL_CAN_HANDLE_AUTH_ANY
 	curl_easy_setopt(slot->curl, CURLOPT_HTTPAUTH, http_auth_methods);
 #endif
-	if (http_auth.password)
+	if (http_auth.password || curl_empty_auth)
 		init_curl_http_auth(slot->curl);
 
 	return slot;
