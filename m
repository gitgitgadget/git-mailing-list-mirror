From: =?iso-8859-1?Q?Martin_Storsj=F6?= <martin@martin.st>
Subject: [PATCH] Add an option for using any HTTP authentication scheme, not
 only basic
Date: Tue, 14 Apr 2009 23:52:11 +0300 (EEST)
Message-ID: <Pine.LNX.4.64.0904142350140.7479@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 14 22:54:03 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ltpdq-00038i-2w
	for gcvg-git-2@gmane.org; Tue, 14 Apr 2009 22:54:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753626AbZDNUwO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Apr 2009 16:52:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752777AbZDNUwO
	(ORCPT <rfc822;git-outgoing>); Tue, 14 Apr 2009 16:52:14 -0400
Received: from smtp2.abo.fi ([130.232.213.77]:44628 "EHLO smtp2.abo.fi"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753304AbZDNUwN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Apr 2009 16:52:13 -0400
Received: from albin.abo.fi (albin.abo.fi [130.232.81.192])
	by smtp2.abo.fi (8.14.3/8.12.9) with ESMTP id n3EKqBPe013485
	for <git@vger.kernel.org>; Tue, 14 Apr 2009 23:52:11 +0300
X-X-Sender: mstorsjo@localhost.localdomain
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (smtp2.abo.fi [130.232.213.77]); Tue, 14 Apr 2009 23:52:11 +0300 (EEST)
X-Virus-Scanned: by roxy.abo.fi (roxy.abo.fi: Tue Apr 14 23:52:11 2009)
X-Scanned-By: MIMEDefang 2.67 on 130.232.213.77
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116570>

This adds the configuration option http.authAny (overridable with
the environment variable GIT_HTTP_AUTH_ANY), for instructing curl
to allow any HTTP authentication scheme, not only basic (which
sends the password in plaintext).

When this is enabled, curl has to do double requests most of the time,
in order to discover which HTTP authentication method to use, which
lowers the performance slightly. Therefore this isn't enabled by default.

One example of another authentication scheme to use is digest, which
doesn't send the password in plaintext, but uses a challenge-response
mechanism instead. Using digest authentication in practice requires
at least curl 7.18.2, due to bugs in the digest handling in earlier
versions of curl.

Signed-off-by: Martin Storsjo <martin@martin.st>
---

This is a resend of a patch I sent a few weeks ago. Now this functionality
is configurable and disabled by default.

 Documentation/config.txt |    7 +++++++
 http.c                   |   18 ++++++++++++++++++
 2 files changed, 25 insertions(+), 0 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index f3ebd2f..1515d77 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1011,6 +1011,13 @@ http.noEPSV::
 	support EPSV mode. Can be overridden by the 'GIT_CURL_FTP_NO_EPSV'
 	environment variable. Default is false (curl will use EPSV).
 
+http.authAny::
+	Allow any HTTP authentication method, not only basic. Enabling
+	this lowers the performance slightly, by having to do requests
+	without any authentication to discover the authentication method
+	to use. Can be overridden by the 'GIT_HTTP_AUTH_ANY'
+	environment variable. Default is false.
+
 i18n.commitEncoding::
 	Character encoding the commit messages are stored in; git itself
 	does not care per se, but this information is necessary e.g. when
diff --git a/http.c b/http.c
index 2e3d649..0b18c64 100644
--- a/http.c
+++ b/http.c
@@ -26,6 +26,9 @@ static long curl_low_speed_time = -1;
 static int curl_ftp_no_epsv;
 static const char *curl_http_proxy;
 static char *user_name, *user_pass;
+#if LIBCURL_VERSION_NUM >= 0x070a06
+static int curl_http_auth_any = 0;
+#endif
 
 static struct curl_slist *pragma_header;
 
@@ -150,6 +153,12 @@ static int http_options(const char *var, const char *value, void *cb)
 	}
 	if (!strcmp("http.proxy", var))
 		return git_config_string(&curl_http_proxy, var, value);
+#if LIBCURL_VERSION_NUM >= 0x070a06
+	if (!strcmp("http.authany", var)) {
+		curl_http_auth_any = git_config_bool(var, value);
+		return 0;
+	}
+#endif
 
 	/* Fall back on the default ones */
 	return git_default_config(var, value, cb);
@@ -184,6 +193,10 @@ static CURL *get_curl_handle(void)
 #if LIBCURL_VERSION_NUM >= 0x070907
 	curl_easy_setopt(result, CURLOPT_NETRC, CURL_NETRC_OPTIONAL);
 #endif
+#if LIBCURL_VERSION_NUM >= 0x070a06
+	if (curl_http_auth_any)
+		curl_easy_setopt(result, CURLOPT_HTTPAUTH, CURLAUTH_ANY);
+#endif
 
 	init_curl_http_auth(result);
 
@@ -329,6 +342,11 @@ void http_init(struct remote *remote)
 	if (getenv("GIT_CURL_FTP_NO_EPSV"))
 		curl_ftp_no_epsv = 1;
 
+#if LIBCURL_VERSION_NUM >= 0x070a06
+	if (getenv("GIT_HTTP_AUTH_ANY"))
+		curl_http_auth_any = 1;
+#endif
+
 	if (remote && remote->url && remote->url[0])
 		http_auth_init(remote->url[0]);
 
-- 
1.6.0.2
