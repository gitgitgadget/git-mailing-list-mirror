From: "Spencer E. Olson" <olsonse@umich.edu>
Subject: [PATCH v2] Allow HTTP user agent string to be modified.
Date: Fri,  6 Aug 2010 21:34:20 -0600
Message-ID: <1281152060-16736-1-git-send-email-olsonse@umich.edu>
Cc: Nick Hengeveld <nickh@reactrix.com>,
	Mark Lodato <lodatom@gmail.com>,
	Tay Ray Chuan <rctay89@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	"Spencer E. Olson" <olsonse@umich.edu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 07 05:35:22 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OhaBu-0003bt-2i
	for gcvg-git-2@lo.gmane.org; Sat, 07 Aug 2010 05:35:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751117Ab0HGDfR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Aug 2010 23:35:17 -0400
Received: from smtp.mail.umich.edu ([141.211.12.86]:58547 "EHLO
	tombraider.mr.itd.umich.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752202Ab0HGDfP (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 6 Aug 2010 23:35:15 -0400
Received: FROM localhost.localdomain (zektor.gpcc.itd.umich.edu [141.211.2.203])
	By tombraider.mr.itd.umich.edu ID 4C5CD470.AC410.30457 ;
	Authuser olsonse;
	 6 Aug 2010 23:35:13 EDT
X-Mailer: git-send-email 1.7.0.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152839>

Some firewalls restrict HTTP connections based on the clients user agent.  This
commit provides the user the ability to modify the user agent string via either
a new config option (http.useragent) or by an environment variable
(GIT_USER_AGENT).  Relevant documentation is added to Documentation/config.txt.

Signed-off-by: Spencer E. Olson <olsonse@umich.edu>
---

Hi all,

This is both a reminder and an update for a patch I sent earlier
(http://article.gmane.org/gmane.comp.version-control.git/151434).
This update includes the documentation for the new http.useragent configure
option and the new GIT_USER_AGENT environement variable.  I hadn't seen any
comments on the earlier version of this patch, so I assume it got lost among the
other list activity.  

 Documentation/config.txt |    9 +++++++++
 http.c                   |   11 ++++++++++-
 2 files changed, 19 insertions(+), 1 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index f81fb91..826e816 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1243,6 +1243,15 @@ http.noEPSV::
 	support EPSV mode. Can be overridden by the 'GIT_CURL_FTP_NO_EPSV'
 	environment variable. Default is false (curl will use EPSV).
 
+http.useragent::
+	The HTTP USER_AGENT string presented to an HTTP server.  The default
+	value represents the version of the client git such as git/1.7.1.
+	This option allows you to override this value to a more common value
+	such as Mozilla/4.0.  This may be necessary, for instance, if
+	connecting through a firewall that restricts HTTP connections to a set
+	of common USER_AGENT strings (but not including those like git/1.7.1).
+	Can be overridden by the 'GIT_USER_AGENT' environment variable.
+
 i18n.commitEncoding::
 	Character encoding the commit messages are stored in; git itself
 	does not care per se, but this information is necessary e.g. when
diff --git a/http.c b/http.c
index 1320c50..3a17193 100644
--- a/http.c
+++ b/http.c
@@ -41,6 +41,7 @@ static long curl_low_speed_time = -1;
 static int curl_ftp_no_epsv;
 static const char *curl_http_proxy;
 static char *user_name, *user_pass;
+static const char *user_agent = NULL;
 
 #if LIBCURL_VERSION_NUM >= 0x071700
 /* Use CURLOPT_KEYPASSWD as is */
@@ -196,6 +197,9 @@ static int http_options(const char *var, const char *value, void *cb)
 		return 0;
 	}
 
+	if (!strcmp("http.useragent", var))
+		return git_config_string(&user_agent, var, value);
+
 	/* Fall back on the default ones */
 	return git_default_config(var, value, cb);
 }
@@ -279,7 +283,10 @@ static CURL *get_curl_handle(void)
 	if (getenv("GIT_CURL_VERBOSE"))
 		curl_easy_setopt(result, CURLOPT_VERBOSE, 1);
 
-	curl_easy_setopt(result, CURLOPT_USERAGENT, GIT_USER_AGENT);
+	if (user_agent != NULL)
+		curl_easy_setopt(result, CURLOPT_USERAGENT, user_agent);
+	else
+		curl_easy_setopt(result, CURLOPT_USERAGENT, GIT_USER_AGENT);
 
 	if (curl_ftp_no_epsv)
 		curl_easy_setopt(result, CURLOPT_FTP_USE_EPSV, 0);
@@ -380,6 +387,8 @@ void http_init(struct remote *remote)
 #endif
 	set_from_env(&ssl_cainfo, "GIT_SSL_CAINFO");
 
+	set_from_env(&user_agent, "GIT_USER_AGENT");
+
 	low_speed_limit = getenv("GIT_HTTP_LOW_SPEED_LIMIT");
 	if (low_speed_limit != NULL)
 		curl_low_speed_limit = strtol(low_speed_limit, NULL, 10);
-- 
1.7.1.1
