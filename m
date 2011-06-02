From: dabrown@physics.syr.edu (Duncan Brown)
Subject: [PATCH/RFC] http: pass http.cookiefile using CURLOPT_COOKIEFILE
Date: Thu,  2 Jun 2011 16:31:25 -0400 (EDT)
Message-ID: <20110602203125.0E04C734F12@antares.phy.syr.edu>
Cc: dabrown@physics.syr.edu, gitster@pobox.com,
	skoranda@gravity.phys.uwm.edu
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 03 00:26:16 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QSGLH-0006zq-D0
	for gcvg-git-2@lo.gmane.org; Fri, 03 Jun 2011 00:26:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751471Ab1FBW0K (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Jun 2011 18:26:10 -0400
Received: from smtp1.syr.edu ([128.230.18.82]:58483 "EHLO smtp1.syr.edu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751077Ab1FBW0I (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Jun 2011 18:26:08 -0400
X-Greylist: delayed 6876 seconds by postgrey-1.27 at vger.kernel.org; Thu, 02 Jun 2011 18:26:08 EDT
Received: from antares.phy.syr.edu (antares.phy.syr.edu [128.230.52.80])
	by smtp1.syr.edu (8.14.3/8.14.3) with ESMTP id p52KVPsL023873;
	Thu, 2 Jun 2011 16:31:25 -0400
Received: by antares.phy.syr.edu (Postfix, from userid 501)
	id 0E04C734F12; Thu,  2 Jun 2011 16:31:25 -0400 (EDT)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:5.4.6813,1.0.148,0.0.0000
 definitions=2011-06-02_07:2011-06-02,2011-06-02,1970-01-01 signatures=0
X-Proofpoint-Spam-Reason: safe
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174981>

If the config option http.cookiefile is set, pass this file to libCURL using
the CURLOPT_COOKIEFILE option. This is similar to calling curl with the -b
option.  This allows git http authorization with authentication mechanisms
that use cookies, such as SAML Enhanced Client or Proxy (ECP) used by
Shibboleth.

To use SAML/ECP, the user needs to request a session cookie with their own ECP
code. See for example:

<https://wiki.shibboleth.net/confluence/display/SHIB2/ECP>

Once the cookie file has been created, it can be passed to git with, e.g.

git config --global http.cookiefile "/home/dbrown/.curlcookies"

libCURL will then pass the appropriate session cookies to the git http server.

Signed-off-by: Duncan Brown <duncan.brown@ligo.org>
---
 Documentation/config.txt |    8 ++++++++
 http.c                   |    5 +++++
 2 files changed, 13 insertions(+), 0 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 6b93777..c631d1c 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1196,6 +1196,14 @@ http.proxy::
 	environment variable (see linkgit:curl[1]).  This can be overridden
 	on a per-remote basis; see remote.<name>.proxy
 
+http.cookiefile::
+	File containing previously stored cookie lines which should be used
+	in the git http session, if they match the server. The file format
+	of the file to read cookies from should be plain HTTP headers or
+	the Netscape/Mozilla cookie file format (see linkgit:curl[1]).
+	NOTE that the file specified with http.cookiefile is only used as
+	input. No cookies will be stored in the file.
+
 http.sslVerify::
 	Whether to verify the SSL certificate when fetching or pushing
 	over HTTPS. Can be overridden by the 'GIT_SSL_NO_VERIFY' environment
diff --git a/http.c b/http.c
index b2ae8de..a1ea3db 100644
--- a/http.c
+++ b/http.c
@@ -41,6 +41,7 @@ static long curl_low_speed_limit = -1;
 static long curl_low_speed_time = -1;
 static int curl_ftp_no_epsv;
 static const char *curl_http_proxy;
+static const char *curl_cookie_file;
 static char *user_name, *user_pass;
 static const char *user_agent;
 
@@ -191,6 +192,9 @@ static int http_options(const char *var, const char *value, void *cb)
 	if (!strcmp("http.proxy", var))
 		return git_config_string(&curl_http_proxy, var, value);
 
+	if (!strcmp("http.cookiefile", var))
+		return git_config_string(&curl_cookie_file, var, value);
+
 	if (!strcmp("http.postbuffer", var)) {
 		http_post_buffer = git_config_int(var, value);
 		if (http_post_buffer < LARGE_PACKET_MAX)
@@ -531,6 +535,7 @@ struct active_request_slot *get_active_slot(void)
 	slot->finished = NULL;
 	slot->callback_data = NULL;
 	slot->callback_func = NULL;
+	curl_easy_setopt(slot->curl, CURLOPT_COOKIEFILE, curl_cookie_file);
 	curl_easy_setopt(slot->curl, CURLOPT_HTTPHEADER, pragma_header);
 	curl_easy_setopt(slot->curl, CURLOPT_ERRORBUFFER, curl_errorstr);
 	curl_easy_setopt(slot->curl, CURLOPT_CUSTOMREQUEST, NULL);
-- 
1.7.3.4
