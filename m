From: dborowitz@google.com
Subject: [PATCH] http: Add http.savecookies option to write out HTTP cookies
Date: Tue, 23 Jul 2013 14:07:56 -0700
Message-ID: <1374613676-20889-1-git-send-email-dborowitz@google.com>
Cc: Dave Borowitz <dborowitz@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 23 23:09:03 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V1jpK-000417-Vm
	for gcvg-git-2@plane.gmane.org; Tue, 23 Jul 2013 23:08:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757685Ab3GWVIy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Jul 2013 17:08:54 -0400
Received: from mail-pa0-f41.google.com ([209.85.220.41]:57201 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751386Ab3GWVIw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Jul 2013 17:08:52 -0400
Received: by mail-pa0-f41.google.com with SMTP id bj3so8946276pad.28
        for <git@vger.kernel.org>; Tue, 23 Jul 2013 14:08:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=zOjBn8CQx72CpKIwH1lYJpVBuNOHo+ogdt8ZUIbAIhQ=;
        b=P73crk6hkdMElUCnsuhWrh+KUb/AaJMvG69Eea/Tpz1r6hWlS3lr04McjCFlsdHieL
         O5z1dfwJrSLHemddeWM1LvJlGl1FL/pO4qE4IvovhvheVdufsJiBmDRPG9CfiWdbcaf5
         212i7PKNFbTFxL8PejI5kSfC9ivIZnHledGPptggaJGOmnvXl1j0uapwQmkxQs4G+YQy
         H6nZUdNMZJo17c178rm/63d6jo+kZs7YlzrLfZ65/LCbq3RyIaMsjD94bvlHjTzRu/0G
         TwEky/IRtwK0XKlTYu2y2wf4XUYxOtYzfSuytS1o9onp8FgcQjmiDELFhQMsLCccUl8y
         A0Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:x-gm-message-state;
        bh=zOjBn8CQx72CpKIwH1lYJpVBuNOHo+ogdt8ZUIbAIhQ=;
        b=F3wyT9yO4rwEuX6g9lMxrVUd1m+ldLfc86Pg/TS8/OOwz7oKtiTzBe6shhbwVDHcHU
         KgeoSKsRxDleIzV9drIwuOR1QJyAl+RpCksilgdwk2RwxfbQ6nUan6CqYMxd8z3cwhry
         r2YwtGlJcok0ULHwPJhzEh4xpIpnjElX90s8VUnKiLqfwhCBhy4ceSPUQ8QHB2OT7aVr
         NSQgvkBeUMGvF7kQhZt4h1dGR6dVZ8U2Ch9/ndQdOr0gAZQ49UQ3ABgq+Fz+WCuiNF83
         1JLSqdh82yYXYAT7GRsrwOSmxk6FfaC6VC/CQkoK5UoAtD7bth/vq9d+PnIYP84mPrbs
         S/Wg==
X-Received: by 10.68.234.33 with SMTP id ub1mr38261388pbc.98.1374613731996;
        Tue, 23 Jul 2013 14:08:51 -0700 (PDT)
Received: from serval.mtv.corp.google.com (serval.mtv.corp.google.com [172.27.69.27])
        by mx.google.com with ESMTPSA id ai6sm47190132pad.15.2013.07.23.14.08.49
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 23 Jul 2013 14:08:50 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.2
X-Gm-Message-State: ALoCoQlPWMmDJynj1g+j8F1j4spZx6PR3+RQFKF4mT9csxsOClHCU13ghPXuwiSuoR7BSgsNYBe1mvxuVIPmcBca7jORD2xUMYRxUALVvu5dFlvVYsAEgCGojmocg02aFZViXoLQY6Syzi3MOCY/wzRKp8vupMRBexrZXPwnmKwk6ltyrqZrnncaigeTGawOdrPlK9Iy451+ysRKdRrrWK737YzLYaxueuU0jxLvjC9NtNtuiaq8Pmc=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231061>

From: Dave Borowitz <dborowitz@google.com>

HTTP servers may send Set-Cookie headers in a response and expect them
to be set on subsequent requests. By default, libcurl behavior is to
store such cookies in memory and reuse them across requests within a
single session. However, it may also make sense, depending on the
server and the cookies, to store them across sessions. Provide users
an option to enable this behavior, writing cookies out to the same
file specified in http.cookiefile.
---
 Documentation/config.txt |  6 +++++-
 http.c                   |  7 +++++++
 t/lib-httpd/apache.conf  |  8 ++++++++
 t/t5551-http-fetch.sh    | 18 ++++++++++++++++++
 4 files changed, 38 insertions(+), 1 deletion(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index e0b923f..e935447 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1456,7 +1456,11 @@ http.cookiefile::
 	of the file to read cookies from should be plain HTTP headers or
 	the Netscape/Mozilla cookie file format (see linkgit:curl[1]).
 	NOTE that the file specified with http.cookiefile is only used as
-	input. No cookies will be stored in the file.
+	input unless http.saveCookies is set.
+
+http.savecookies::
+	If set, store cookies received during requests to the file specified by
+	http.cookiefile. Has no effect if http.cookiefile is unset.
 
 http.sslVerify::
 	Whether to verify the SSL certificate when fetching or pushing
diff --git a/http.c b/http.c
index 2d086ae..2fbf986 100644
--- a/http.c
+++ b/http.c
@@ -45,6 +45,7 @@ static long curl_low_speed_time = -1;
 static int curl_ftp_no_epsv;
 static const char *curl_http_proxy;
 static const char *curl_cookie_file;
+static int curl_save_cookies;
 static struct credential http_auth = CREDENTIAL_INIT;
 static int http_proactive_auth;
 static const char *user_agent;
@@ -200,6 +201,10 @@ static int http_options(const char *var, const char *value, void *cb)
 
 	if (!strcmp("http.cookiefile", var))
 		return git_config_string(&curl_cookie_file, var, value);
+	if (!strcmp("http.savecookies", var)) {
+		curl_save_cookies = git_config_bool(var, value);
+		return 0;
+	}
 
 	if (!strcmp("http.postbuffer", var)) {
 		http_post_buffer = git_config_int(var, value);
@@ -513,6 +518,8 @@ struct active_request_slot *get_active_slot(void)
 	slot->callback_data = NULL;
 	slot->callback_func = NULL;
 	curl_easy_setopt(slot->curl, CURLOPT_COOKIEFILE, curl_cookie_file);
+	if (curl_save_cookies)
+		curl_easy_setopt(slot->curl, CURLOPT_COOKIEJAR, curl_cookie_file);
 	curl_easy_setopt(slot->curl, CURLOPT_HTTPHEADER, pragma_header);
 	curl_easy_setopt(slot->curl, CURLOPT_ERRORBUFFER, curl_errorstr);
 	curl_easy_setopt(slot->curl, CURLOPT_CUSTOMREQUEST, NULL);
diff --git a/t/lib-httpd/apache.conf b/t/lib-httpd/apache.conf
index dd17e3a..397c480 100644
--- a/t/lib-httpd/apache.conf
+++ b/t/lib-httpd/apache.conf
@@ -22,6 +22,9 @@ ErrorLog error.log
 <IfModule !mod_version.c>
 	LoadModule version_module modules/mod_version.so
 </IfModule>
+<IfModule !mod_headers.c>
+	LoadModule headers_module modules/mod_headers.so
+</IfModule>
 
 <IfVersion < 2.4>
 LockFile accept.lock
@@ -87,6 +90,11 @@ Alias /auth/dumb/ www/auth/dumb/
 	SetEnv GIT_HTTP_EXPORT_ALL
 	SetEnv GIT_NAMESPACE ns
 </LocationMatch>
+<LocationMatch /smart_cookies/>
+	SetEnv GIT_EXEC_PATH ${GIT_EXEC_PATH}
+	SetEnv GIT_HTTP_EXPORT_ALL
+	Header set Set-Cookie name=value
+</LocationMatch>
 ScriptAliasMatch /smart_*[^/]*/(.*) ${GIT_EXEC_PATH}/git-http-backend/$1
 ScriptAlias /broken_smart/ broken-smart-http.sh/
 <Directory ${GIT_EXEC_PATH}>
diff --git a/t/t5551-http-fetch.sh b/t/t5551-http-fetch.sh
index 55a866a..287d22b 100755
--- a/t/t5551-http-fetch.sh
+++ b/t/t5551-http-fetch.sh
@@ -187,6 +187,24 @@ test_expect_success 'dumb clone via http-backend respects namespace' '
 	test_cmp expect actual
 '
 
+cat >cookies.txt <<EOF
+127.0.0.1	FALSE	/smart_cookies/	FALSE	0	othername	othervalue
+EOF
+cat >expect_cookies.txt <<EOF
+# Netscape HTTP Cookie File
+# http://curl.haxx.se/docs/http-cookies.html
+# This file was generated by libcurl! Edit at your own risk.
+
+127.0.0.1	FALSE	/smart_cookies/	FALSE	0	othername	othervalue
+127.0.0.1	FALSE	/smart_cookies/repo.git/info/	FALSE	0	name	value
+EOF
+test_expect_success 'cookies stored in http.cookiefile when http.savecookies set' '
+	git config http.cookiefile cookies.txt &&
+	git config http.savecookies true &&
+	git ls-remote $HTTPD_URL/smart_cookies/repo.git master &&
+	test_cmp expect_cookies.txt cookies.txt
+'
+
 test -n "$GIT_TEST_LONG" && test_set_prereq EXPENSIVE
 
 test_expect_success EXPENSIVE 'create 50,000 tags in the repo' '
-- 
1.8.3.2
