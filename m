From: Nick Hengeveld <nickh@reactrix.com>
Subject: [PATCH] Support for HTTP transfer timeouts based on transfer speed
Date: Wed, 19 Oct 2005 11:59:59 -0700
Message-ID: <20051019185959.GA6160@reactrix.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Wed Oct 19 21:00:11 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ESJAT-0007Gt-Tq
	for gcvg-git@gmane.org; Wed, 19 Oct 2005 21:00:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751221AbVJSTAA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 19 Oct 2005 15:00:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751222AbVJSTAA
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Oct 2005 15:00:00 -0400
Received: from 195.37.26.69.virtela.com ([69.26.37.195]:33729 "EHLO
	teapot.corp.reactrix.com") by vger.kernel.org with ESMTP
	id S1751221AbVJSS77 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Oct 2005 14:59:59 -0400
Received: from teapot.corp.reactrix.com (localhost.localdomain [127.0.0.1])
	by teapot.corp.reactrix.com (8.12.11/8.12.11) with ESMTP id j9JIxxV7011993
	for <git@vger.kernel.org>; Wed, 19 Oct 2005 11:59:59 -0700
Received: (from nickh@localhost)
	by teapot.corp.reactrix.com (8.12.11/8.12.11/Submit) id j9JIxxFl011991
	for git@vger.kernel.org; Wed, 19 Oct 2005 11:59:59 -0700
To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10298>

Add configuration settings to abort HTTP requests if the transfer rate
drops below a threshold for a specified length of time.  Environment
variables override config file settings.

Signed-off-by: Nick Hengeveld <nickh@reactrix.com>


---

It looks as though these curl options have been there since 1999 (before
version 6.5), so we shouldn't need to conditionally compile them 
based on LIBCURL_VERSION_NUM.


 http-fetch.c |   29 +++++++++++++++++++++++++++++
 1 files changed, 29 insertions(+), 0 deletions(-)

e624aa205da9861a7d70bffbd22df471c92f1561
diff --git a/http-fetch.c b/http-fetch.c
--- a/http-fetch.c
+++ b/http-fetch.c
@@ -100,6 +100,8 @@ static char *ssl_key = NULL;
 static char *ssl_capath = NULL;
 #endif
 static char *ssl_cainfo = NULL;
+static long curl_low_speed_limit = -1;
+static long curl_low_speed_time = -1;
 
 struct buffer
 {
@@ -158,6 +160,17 @@ static int http_options(const char *var,
 	}
 #endif
 
+	if (!strcmp("http.lowspeedlimit", var)) {
+		if (curl_low_speed_limit == -1)
+			curl_low_speed_limit = (long)git_config_int(var, value);
+		return 0;
+	}
+	if (!strcmp("http.lowspeedtime", var)) {
+		if (curl_low_speed_time == -1)
+			curl_low_speed_time = (long)git_config_int(var, value);
+		return 0;
+	}
+
 	/* Fall back on the default ones */
 	return git_default_config(var, value);
 }
@@ -246,6 +259,13 @@ static CURL* get_curl_handle(void)
 		curl_easy_setopt(result, CURLOPT_CAINFO, ssl_cainfo);
 	curl_easy_setopt(result, CURLOPT_FAILONERROR, 1);
 
+	if (curl_low_speed_limit > 0 && curl_low_speed_time > 0) {
+		curl_easy_setopt(result, CURLOPT_LOW_SPEED_LIMIT,
+				 curl_low_speed_limit);
+		curl_easy_setopt(result, CURLOPT_LOW_SPEED_TIME,
+				 curl_low_speed_time);
+	}
+
 	return result;
 }
 
@@ -1177,6 +1197,8 @@ int main(int argc, char **argv)
 	char *url;
 	int arg = 1;
 	struct active_request_slot *slot;
+	char *low_speed_limit;
+	char *low_speed_time;
 
 	while (arg < argc && argv[arg][0] == '-') {
 		if (argv[arg][1] == 't') {
@@ -1232,6 +1254,13 @@ int main(int argc, char **argv)
 #endif
 	ssl_cainfo = getenv("GIT_SSL_CAINFO");
 
+	low_speed_limit = getenv("GIT_HTTP_LOW_SPEED_LIMIT");
+	if (low_speed_limit != NULL)
+		curl_low_speed_limit = strtol(low_speed_limit, NULL, 10);
+	low_speed_time = getenv("GIT_HTTP_LOW_SPEED_TIME");
+	if (low_speed_time != NULL)
+		curl_low_speed_time = strtol(low_speed_time, NULL, 10);
+
 	git_config(http_options);
 
 	if (curl_ssl_verify == -1)
