Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2B5921FAFB
	for <e@80x24.org>; Fri, 31 Mar 2017 17:26:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933379AbdCaR0u (ORCPT <rfc822;e@80x24.org>);
        Fri, 31 Mar 2017 13:26:50 -0400
Received: from sub3.mail.dreamhost.com ([69.163.253.7]:56462 "EHLO
        homiemail-a11.g.dreamhost.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S933153AbdCaR0t (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 31 Mar 2017 13:26:49 -0400
Received: from homiemail-a11.g.dreamhost.com (localhost [127.0.0.1])
        by homiemail-a11.g.dreamhost.com (Postfix) with ESMTP id 41E34314C06D;
        Fri, 31 Mar 2017 10:26:48 -0700 (PDT)
Received: from localhost.localdomain (gzac12-mdf2-1.aoa.twosigma.com [208.77.215.155])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: novalis@novalis.org)
        by homiemail-a11.g.dreamhost.com (Postfix) with ESMTPSA id E6254314C069;
        Fri, 31 Mar 2017 10:26:47 -0700 (PDT)
From:   David Turner <dturner@twosigma.com>
To:     git@vger.kernel.org
Cc:     David Turner <dturner@twosigma.com>
Subject: [PATCH v3] http.postbuffer: allow full range of ssize_t values
Date:   Fri, 31 Mar 2017 13:26:31 -0400
Message-Id: <20170331172631.12024-1-dturner@twosigma.com>
X-Mailer: git-send-email 2.11.GIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Unfortunately, in order to push some large repos, the http postbuffer
must sometimes exceed two gigabytes.  On a 64-bit system, this is OK:
we just malloc a larger buffer.

Signed-off-by: David Turner <dturner@twosigma.com>
---

This version fixes the definition of git_parse_ssize_t to return int.

Sorry for the sloppiness.

 cache.h  |  1 +
 config.c | 17 +++++++++++++++++
 http.c   |  4 ++--
 http.h   |  2 +-
 4 files changed, 21 insertions(+), 3 deletions(-)

diff --git a/cache.h b/cache.h
index fbdf7a815a..5e6747dbb4 100644
--- a/cache.h
+++ b/cache.h
@@ -1900,6 +1900,7 @@ extern int git_parse_maybe_bool(const char *);
 extern int git_config_int(const char *, const char *);
 extern int64_t git_config_int64(const char *, const char *);
 extern unsigned long git_config_ulong(const char *, const char *);
+extern ssize_t git_config_ssize_t(const char *, const char *);
 extern int git_config_bool_or_int(const char *, const char *, int *);
 extern int git_config_bool(const char *, const char *);
 extern int git_config_maybe_bool(const char *, const char *);
diff --git a/config.c b/config.c
index 1a4d85537b..de5b155a4e 100644
--- a/config.c
+++ b/config.c
@@ -834,6 +834,15 @@ int git_parse_ulong(const char *value, unsigned long *ret)
 	return 1;
 }
 
+static int git_parse_ssize_t(const char *value, ssize_t *ret)
+{
+	ssize_t tmp;
+	if (!git_parse_signed(value, &tmp, maximum_signed_value_of_type(ssize_t)))
+		return 0;
+	*ret = tmp;
+	return 1;
+}
+
 NORETURN
 static void die_bad_number(const char *name, const char *value)
 {
@@ -892,6 +901,14 @@ unsigned long git_config_ulong(const char *name, const char *value)
 	return ret;
 }
 
+ssize_t git_config_ssize_t(const char *name, const char *value)
+{
+	ssize_t ret;
+	if (!git_parse_ssize_t(value, &ret))
+		die_bad_number(name, value);
+	return ret;
+}
+
 int git_parse_maybe_bool(const char *value)
 {
 	if (!value)
diff --git a/http.c b/http.c
index 96d84bbed3..22f8167ba2 100644
--- a/http.c
+++ b/http.c
@@ -19,7 +19,7 @@ long int git_curl_ipresolve;
 #endif
 int active_requests;
 int http_is_verbose;
-size_t http_post_buffer = 16 * LARGE_PACKET_MAX;
+ssize_t http_post_buffer = 16 * LARGE_PACKET_MAX;
 
 #if LIBCURL_VERSION_NUM >= 0x070a06
 #define LIBCURL_CAN_HANDLE_AUTH_ANY
@@ -331,7 +331,7 @@ static int http_options(const char *var, const char *value, void *cb)
 	}
 
 	if (!strcmp("http.postbuffer", var)) {
-		http_post_buffer = git_config_int(var, value);
+		http_post_buffer = git_config_ssize_t(var, value);
 		if (http_post_buffer < LARGE_PACKET_MAX)
 			http_post_buffer = LARGE_PACKET_MAX;
 		return 0;
diff --git a/http.h b/http.h
index 02bccb7b0c..f7bd3b26b0 100644
--- a/http.h
+++ b/http.h
@@ -111,7 +111,7 @@ extern struct curl_slist *http_copy_default_headers(void);
 extern long int git_curl_ipresolve;
 extern int active_requests;
 extern int http_is_verbose;
-extern size_t http_post_buffer;
+extern ssize_t http_post_buffer;
 extern struct credential http_auth;
 
 extern char curl_errorstr[CURL_ERROR_SIZE];
-- 
2.11.GIT

