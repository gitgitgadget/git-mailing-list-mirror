From: Junio C Hamano <gitster@pobox.com>
Subject: [RFH Patch 2/2] http_init(): Fix config file parsing
Date: Mon, 09 Mar 2009 19:19:44 -0700
Message-ID: <7vfxhmce67.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 10 03:22:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LgrbC-0001LZ-Q2
	for gcvg-git-2@gmane.org; Tue, 10 Mar 2009 03:21:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753631AbZCJCTv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Mar 2009 22:19:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753567AbZCJCTv
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Mar 2009 22:19:51 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:51721 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753621AbZCJCTt (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Mar 2009 22:19:49 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 46971407E;
	Mon,  9 Mar 2009 22:19:48 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 79311407D; Mon, 
 9 Mar 2009 22:19:46 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: EDCEFAC4-0D19-11DE-A64C-CBE7E3B37BAC-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112774>

We honor the command line options, environment variables, variables in
repository configuration file, variables in user's global configuration
file, variables in the system configuration file, and then finally use
built-in default.  To implement this semantics, the code should:

 - start from built-in default values;

 - call git_config() with the configuration parser callback, which
   implements "later definition overrides earlier ones" logic
   (git_config() reads the system's, user's and then repository's
   configuration file in this order);

 - override the result from the above with environment variables if set;

 - override the result from the above with command line options.

The initialization code http_init() for http transfer got this wrong, and
implemented a "first one wins, ignoring the later ones" in http_options(),
to compensate this mistake, read environment variables before calling
git_config().  This is all wrong.

As a second class citizen, the http codepath hasn't been audited as
closely as other parts of the system, but we should try to bring sanity to
the existing codebase before inviting contributors to improve on it.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * This is what I need help from people who actually do use http transport
   and extra set of eyeballs to spot silly mistakes.

 http.c |   66 +++++++++++++++++++++++----------------------------------------
 1 files changed, 24 insertions(+), 42 deletions(-)

diff --git a/http.c b/http.c
index d1ead66..f4f0bf6 100644
--- a/http.c
+++ b/http.c
@@ -94,52 +94,33 @@ static void process_curl_messages(void)
 static int http_options(const char *var, const char *value, void *cb)
 {
 	if (!strcmp("http.sslverify", var)) {
-		if (curl_ssl_verify == -1)
-			curl_ssl_verify = git_config_bool(var, value);
-		return 0;
-	}
-
-	if (!strcmp("http.sslcert", var)) {
-		if (ssl_cert == NULL)
-			return git_config_string(&ssl_cert, var, value);
+		curl_ssl_verify = git_config_bool(var, value);
 		return 0;
 	}
+	if (!strcmp("http.sslcert", var))
+		return git_config_string(&ssl_cert, var, value);
 #if LIBCURL_VERSION_NUM >= 0x070902
-	if (!strcmp("http.sslkey", var)) {
-		if (ssl_key == NULL)
-			return git_config_string(&ssl_key, var, value);
-		return 0;
-	}
+	if (!strcmp("http.sslkey", var))
+		return git_config_string(&ssl_key, var, value);
 #endif
 #if LIBCURL_VERSION_NUM >= 0x070908
-	if (!strcmp("http.sslcapath", var)) {
-		if (ssl_capath == NULL)
-			return git_config_string(&ssl_capath, var, value);
-		return 0;
-	}
+	if (!strcmp("http.sslcapath", var))
+		return git_config_string(&ssl_capath, var, value);
 #endif
-	if (!strcmp("http.sslcainfo", var)) {
-		if (ssl_cainfo == NULL)
-			return git_config_string(&ssl_cainfo, var, value);
-		return 0;
-	}
-
+	if (!strcmp("http.sslcainfo", var))
+		return git_config_string(&ssl_cainfo, var, value);
 #ifdef USE_CURL_MULTI
 	if (!strcmp("http.maxrequests", var)) {
-		if (max_requests == -1)
-			max_requests = git_config_int(var, value);
+		max_requests = git_config_int(var, value);
 		return 0;
 	}
 #endif
-
 	if (!strcmp("http.lowspeedlimit", var)) {
-		if (curl_low_speed_limit == -1)
-			curl_low_speed_limit = (long)git_config_int(var, value);
+		curl_low_speed_limit = (long)git_config_int(var, value);
 		return 0;
 	}
 	if (!strcmp("http.lowspeedtime", var)) {
-		if (curl_low_speed_time == -1)
-			curl_low_speed_time = (long)git_config_int(var, value);
+		curl_low_speed_time = (long)git_config_int(var, value);
 		return 0;
 	}
 
@@ -147,11 +128,8 @@ static int http_options(const char *var, const char *value, void *cb)
 		curl_ftp_no_epsv = git_config_bool(var, value);
 		return 0;
 	}
-	if (!strcmp("http.proxy", var)) {
-		if (curl_http_proxy == NULL)
-			return git_config_string(&curl_http_proxy, var, value);
-		return 0;
-	}
+	if (!strcmp("http.proxy", var))
+		return git_config_string(&curl_http_proxy, var, value);
 
 	/* Fall back on the default ones */
 	return git_default_config(var, value, cb);
@@ -217,6 +195,8 @@ void http_init(struct remote *remote)
 	char *low_speed_limit;
 	char *low_speed_time;
 
+	git_config(http_options, NULL);
+
 	curl_global_init(CURL_GLOBAL_ALL);
 
 	if (remote && remote->http_proxy)
@@ -241,14 +221,18 @@ void http_init(struct remote *remote)
 	if (getenv("GIT_SSL_NO_VERIFY"))
 		curl_ssl_verify = 0;
 
-	ssl_cert = getenv("GIT_SSL_CERT");
+	if (getenv("GIT_SSL_CERT"))
+		ssl_cert = getenv("GIT_SSL_CERT");
 #if LIBCURL_VERSION_NUM >= 0x070902
-	ssl_key = getenv("GIT_SSL_KEY");
+	if (getenv("GIT_SSL_KEY"))
+		ssl_key = getenv("GIT_SSL_KEY");
 #endif
 #if LIBCURL_VERSION_NUM >= 0x070908
-	ssl_capath = getenv("GIT_SSL_CAPATH");
+	if (getenv("GIT_SSL_CAPATH"))
+		ssl_capath = getenv("GIT_SSL_CAPATH");
 #endif
-	ssl_cainfo = getenv("GIT_SSL_CAINFO");
+	if (getenv("GIT_SSL_CAINFO"))
+		ssl_cainfo = getenv("GIT_SSL_CAINFO");
 
 	low_speed_limit = getenv("GIT_HTTP_LOW_SPEED_LIMIT");
 	if (low_speed_limit != NULL)
@@ -257,8 +241,6 @@ void http_init(struct remote *remote)
 	if (low_speed_time != NULL)
 		curl_low_speed_time = strtol(low_speed_time, NULL, 10);
 
-	git_config(http_options, NULL);
-
 	if (curl_ssl_verify == -1)
 		curl_ssl_verify = 1;
 
-- 
1.6.2.206.g5bda76
