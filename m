From: Sam Vilain <sam.vilain@catalyst.net.nz>
Subject: [PATCH] Allow HTTP proxy to be overridden in config
Date: Fri, 23 Nov 2007 13:07:00 +1300
Message-ID: <1195776420-22075-1-git-send-email-sam.vilain@catalyst.net.nz>
Cc: git@vger.kernel.org, francois@debian.org,
	Sam Vilain <sam.vilain@catalyst.net.nz>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Nov 23 01:10:47 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IvM85-000354-0a
	for gcvg-git-2@gmane.org; Fri, 23 Nov 2007 01:10:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751260AbXKWAHU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Nov 2007 19:07:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751241AbXKWAHT
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Nov 2007 19:07:19 -0500
Received: from godel.catalyst.net.nz ([202.78.240.40]:54020 "EHLO
	mail1.catalyst.net.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751002AbXKWAHS (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Nov 2007 19:07:18 -0500
Received: from leibniz.catalyst.net.nz ([202.78.240.7] helo=wilber.wgtn.cat-it.co.nz)
	by mail1.catalyst.net.nz with esmtp (Exim 4.63)
	(envelope-from <samv@wilber.wgtn.cat-it.co.nz>)
	id 1IvM4S-0008VW-E8; Fri, 23 Nov 2007 13:07:00 +1300
Received: by wilber.wgtn.cat-it.co.nz (Postfix, from userid 1000)
	id 632B420058; Fri, 23 Nov 2007 13:07:00 +1300 (NZDT)
X-Mailer: git-send-email 1.5.3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65858>

The http_proxy / HTTPS_PROXY variables used by curl to control
proxying may not be suitable for git.  Allow the user to override them
in the configuration file.
---
  In particular, privoxy will block directories called /ad/ ... d'oh!

 Documentation/config.txt |    4 ++++
 http.c                   |   11 +++++++++++
 2 files changed, 15 insertions(+), 0 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 7ee97df..859a7f3 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -515,6 +515,10 @@ specified as 'gitcvs.<access_method>.<varname>' (where 'access_method'
 is one of "ext" and "pserver") to make them apply only for the given
 access method.
 
+http.proxy::
+	Override the HTTP proxy, normally configured using the 'http_proxy'
+	environment variable (see gitlink:curl[1]).
+
 http.sslVerify::
 	Whether to verify the SSL certificate when fetching or pushing
 	over HTTPS. Can be overridden by the 'GIT_SSL_NO_VERIFY' environment
diff --git a/http.c b/http.c
index c6fb8ac..8f60d89 100644
--- a/http.c
+++ b/http.c
@@ -24,6 +24,7 @@ char *ssl_cainfo = NULL;
 long curl_low_speed_limit = -1;
 long curl_low_speed_time = -1;
 int curl_ftp_no_epsv = 0;
+char *curl_http_proxy = NULL;
 
 struct curl_slist *pragma_header;
 
@@ -160,6 +161,13 @@ static int http_options(const char *var, const char *value)
 		curl_ftp_no_epsv = git_config_bool(var, value);
 		return 0;
 	}
+	if (!strcmp("http.proxy", var)) {
+		if (curl_http_proxy == NULL) {
+			curl_http_proxy = xmalloc(strlen(value)+1);
+			strcpy(curl_http_proxy, value);
+		}
+		return 0;
+	}
 
 	/* Fall back on the default ones */
 	return git_default_config(var, value);
@@ -205,6 +213,9 @@ static CURL* get_curl_handle(void)
 	if (curl_ftp_no_epsv)
 		curl_easy_setopt(result, CURLOPT_FTP_USE_EPSV, 0);
 
+	if (curl_http_proxy)
+		curl_easy_setopt(result, CURLOPT_PROXY, curl_http_proxy);
+
 	return result;
 }
 
-- 
1.5.3.5
