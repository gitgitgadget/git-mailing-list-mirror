From: "Spencer E. Olson" <olsonse@umich.edu>
Subject: [PATCH v4] Allow HTTP user agent string to be modified.
Date: Wed, 11 Aug 2010 14:32:05 -0600
Message-ID: <1281558725-29938-1-git-send-email-olsonse@umich.edu>
References: <7v62zgyks6.fsf@alter.siamese.dyndns.org>
Cc: Junio C Hamano <gitster@pobox.com>,
	Tay Ray Chuan <rctay89@gmail.com>,
	Nick Hengeveld <nickh@reactrix.com>,
	Mark Lodato <lodatom@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	"Spencer E. Olson" <olsonse@umich.edu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 11 22:32:42 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OjHyb-0007wT-Sw
	for gcvg-git-2@lo.gmane.org; Wed, 11 Aug 2010 22:32:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757143Ab0HKUcg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Aug 2010 16:32:36 -0400
Received: from smtp.mail.umich.edu ([141.211.12.86]:52008 "EHLO
	tombraider.mr.itd.umich.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754294Ab0HKUcf (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 11 Aug 2010 16:32:35 -0400
Received: FROM localhost.localdomain (174-28-223-52.albq.qwest.net [174.28.223.52])
	By tombraider.mr.itd.umich.edu ID 4C6308E1.734E1.18154 ;
	Authuser olsonse;
	11 Aug 2010 16:32:34 EDT
X-Mailer: git-send-email 1.7.0.4
In-Reply-To: <7v62zgyks6.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153301>

Some firewalls restrict HTTP connections based on the clients user agent.  This
commit provides the user the ability to modify the user agent string via either
a new config option (http.useragent) or by an environment variable
(GIT_USER_AGENT).  Relevant documentation is added to Documentation/config.txt.

Signed-off-by: Spencer E. Olson <olsonse@umich.edu>
---

All,

This includes the changes suggested by Ray Chuan and by Junio Hamano, with one
minor additional change:  This changes the internal -DGIT_USER_AGENT to
-DGIT_HTTP_USER_AGENT.

Since GIT_HTTP_* seems to follow what several of the other HTTP related
environement variables, I agree that using GIT_HTTP_USER_AGENT is better for the
user interface (via env variables) than GIT_USER_AGENT.  I would like to
additionally change the internal token also to GIT_HTTP_USER_AGENT just because
it is clearer for other developers.


 Documentation/config.txt |    9 +++++++++
 Makefile                 |    2 +-
 http.c                   |    9 ++++++++-
 3 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index f81fb91..7253b71 100644
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
+	Can be overridden by the 'GIT_HTTP_USER_AGENT' environment variable.
+
 i18n.commitEncoding::
 	Character encoding the commit messages are stored in; git itself
 	does not care per se, but this information is necessary e.g. when
diff --git a/Makefile b/Makefile
index e151516..f84f4a1 100644
--- a/Makefile
+++ b/Makefile
@@ -1873,7 +1873,7 @@ builtin/init-db.s builtin/init-db.o: EXTRA_CPPFLAGS = \
 
 config.s config.o: EXTRA_CPPFLAGS = -DETC_GITCONFIG='"$(ETC_GITCONFIG_SQ)"'
 
-http.s http.o: EXTRA_CPPFLAGS = -DGIT_USER_AGENT='"git/$(GIT_VERSION)"'
+http.s http.o: EXTRA_CPPFLAGS = -DGIT_HTTP_USER_AGENT='"git/$(GIT_VERSION)"'
 
 ifdef NO_EXPAT
 http-walker.s http-walker.o: EXTRA_CPPFLAGS = -DNO_EXPAT
diff --git a/http.c b/http.c
index 1320c50..0a5011f 100644
--- a/http.c
+++ b/http.c
@@ -41,6 +41,7 @@ static long curl_low_speed_time = -1;
 static int curl_ftp_no_epsv;
 static const char *curl_http_proxy;
 static char *user_name, *user_pass;
+static const char *user_agent;
 
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
@@ -279,7 +283,8 @@ static CURL *get_curl_handle(void)
 	if (getenv("GIT_CURL_VERBOSE"))
 		curl_easy_setopt(result, CURLOPT_VERBOSE, 1);
 
-	curl_easy_setopt(result, CURLOPT_USERAGENT, GIT_USER_AGENT);
+	curl_easy_setopt(result, CURLOPT_USERAGENT,
+		user_agent ? user_agent : GIT_HTTP_USER_AGENT);
 
 	if (curl_ftp_no_epsv)
 		curl_easy_setopt(result, CURLOPT_FTP_USE_EPSV, 0);
@@ -380,6 +385,8 @@ void http_init(struct remote *remote)
 #endif
 	set_from_env(&ssl_cainfo, "GIT_SSL_CAINFO");
 
+	set_from_env(&user_agent, "GIT_HTTP_USER_AGENT");
+
 	low_speed_limit = getenv("GIT_HTTP_LOW_SPEED_LIMIT");
 	if (low_speed_limit != NULL)
 		curl_low_speed_limit = strtol(low_speed_limit, NULL, 10);
-- 
1.7.0.4
