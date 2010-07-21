From: "Spencer E. Olson" <olsonse@umich.edu>
Subject: [PATCH] Allow the CURL user agent to be specified either by config option http.useragent or by the environment variable GIT_USER_AGENT.
Date: Wed, 21 Jul 2010 17:40:17 -0600
Message-ID: <201007211740.42319.olsonse@umich.edu>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: "Spencer E. Olson" <olsonse@umich.edu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 22 01:56:53 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Obj9e-0007by-S6
	for gcvg-git-2@lo.gmane.org; Thu, 22 Jul 2010 01:56:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759116Ab0GUX4p (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Jul 2010 19:56:45 -0400
Received: from 28dayslater.mr.itd.umich.edu ([141.211.12.118]:48392 "EHLO
	28dayslater.mr.itd.umich.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1759076Ab0GUX4o (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 21 Jul 2010 19:56:44 -0400
X-Greylist: delayed 300 seconds by postgrey-1.27 at vger.kernel.org; Wed, 21 Jul 2010 19:56:44 EDT
Received: FROM hellskitchen.mr.itd.umich.edu (smtp.mail.umich.edu [141.211.14.82])
	By 28dayslater.mr.itd.umich.edu ID 4C47857D.55CA4.30335 ;
	21 Jul 2010 19:40:45 EDT
Received: FROM localhost (cadash.gpcc.itd.umich.edu [141.211.2.218])
	By hellskitchen.mr.itd.umich.edu ID 4C47857B.681D3.13746 ;
	Authuser olsonse;
	21 Jul 2010 19:40:43 EDT
User-Agent: KMail/1.9.4
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151434>

Necessary to get through some firewalls that do not allow but the most common 
User-Agent strings.

---
 http.c |   10 +++++++++-
 1 files changed, 9 insertions(+), 1 deletions(-)

diff --git a/http.c b/http.c
index 1320c50..abee89e 100644
--- a/http.c
+++ b/http.c
@@ -41,6 +41,7 @@ static long curl_low_speed_time = -1;
 static int curl_ftp_no_epsv;
 static const char *curl_http_proxy;
 static char *user_name, *user_pass;
+static const char *user_agent = NULL;

 #if LIBCURL_VERSION_NUM >= 0x071700
 /* Use CURLOPT_KEYPASSWD as is */
@@ -196,6 +197,9 @@ static int http_options(const char *var, const char 
*value, void *cb)
        return 0;
    }

+   if (!strcmp("http.useragent", var))
+       return git_config_string(&user_agent, var, value);
+
    /* Fall back on the default ones */
    return git_default_config(var, value, cb);
 }
@@ -279,7 +283,10 @@ static CURL *get_curl_handle(void)
    if (getenv("GIT_CURL_VERBOSE"))
        curl_easy_setopt(result, CURLOPT_VERBOSE, 1);

-   curl_easy_setopt(result, CURLOPT_USERAGENT, GIT_USER_AGENT);
+  if (user_agent != NULL)
+     curl_easy_setopt(result, CURLOPT_USERAGENT, user_agent);
+  else
+     curl_easy_setopt(result, CURLOPT_USERAGENT, GIT_USER_AGENT);

    if (curl_ftp_no_epsv)
        curl_easy_setopt(result, CURLOPT_FTP_USE_EPSV, 0);
@@ -379,6 +386,7 @@ void http_init(struct remote *remote)
    set_from_env(&ssl_capath, "GIT_SSL_CAPATH");
 #endif
    set_from_env(&ssl_cainfo, "GIT_SSL_CAINFO");
+   set_from_env(&user_agent, "GIT_USER_AGENT");

    low_speed_limit = getenv("GIT_HTTP_LOW_SPEED_LIMIT");
    if (low_speed_limit != NULL)
-- 
1.7.1.1
