Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BDBF220966
	for <e@80x24.org>; Thu, 30 Mar 2017 20:29:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754820AbdC3U3a (ORCPT <rfc822;e@80x24.org>);
        Thu, 30 Mar 2017 16:29:30 -0400
Received: from hapkido.dreamhost.com ([66.33.216.122]:52162 "EHLO
        hapkido.dreamhost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754435AbdC3U33 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Mar 2017 16:29:29 -0400
Received: from homiemail-a101.g.dreamhost.com (sub3.mail.dreamhost.com [69.163.253.7])
        by hapkido.dreamhost.com (Postfix) with ESMTP id 7EE6282336
        for <git@vger.kernel.org>; Thu, 30 Mar 2017 13:29:27 -0700 (PDT)
Received: from homiemail-a101.g.dreamhost.com (localhost [127.0.0.1])
        by homiemail-a101.g.dreamhost.com (Postfix) with ESMTP id DCAE5117E06A;
        Thu, 30 Mar 2017 13:29:26 -0700 (PDT)
Received: from localhost.localdomain (gzac12-mdf2-1.aoa.twosigma.com [208.77.215.155])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: novalis@novalis.org)
        by homiemail-a101.g.dreamhost.com (Postfix) with ESMTPSA id 7E59A117E06C;
        Thu, 30 Mar 2017 13:29:26 -0700 (PDT)
From:   David Turner <dturner@twosigma.com>
To:     git@vger.kernel.org
Cc:     David Turner <dturner@twosigma.com>
Subject: [PATCH] http.postbuffer: make a size_t
Date:   Thu, 30 Mar 2017 16:29:17 -0400
Message-Id: <20170330202917.24281-1-dturner@twosigma.com>
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
 cache.h  |  1 +
 config.c | 17 +++++++++++++++++
 http.c   |  2 +-
 3 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/cache.h b/cache.h
index fbdf7a815a..a8c1b65db0 100644
--- a/cache.h
+++ b/cache.h
@@ -1900,6 +1900,7 @@ extern int git_parse_maybe_bool(const char *);
 extern int git_config_int(const char *, const char *);
 extern int64_t git_config_int64(const char *, const char *);
 extern unsigned long git_config_ulong(const char *, const char *);
+extern size_t git_config_size_t(const char *, const char *);
 extern int git_config_bool_or_int(const char *, const char *, int *);
 extern int git_config_bool(const char *, const char *);
 extern int git_config_maybe_bool(const char *, const char *);
diff --git a/config.c b/config.c
index 1a4d85537b..7b706cf27a 100644
--- a/config.c
+++ b/config.c
@@ -834,6 +834,15 @@ int git_parse_ulong(const char *value, unsigned long *ret)
 	return 1;
 }
 
+static size_t git_parse_size_t(const char *value, unsigned long *ret)
+{
+	size_t tmp;
+	if (!git_parse_signed(value, &tmp, maximum_unsigned_value_of_type(size_t)))
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
 
+size_t git_config_size_t(const char *name, const char *value)
+{
+	unsigned long ret;
+	if (!git_parse_size_t(value, &ret))
+		die_bad_number(name, value);
+	return ret;
+}
+
 int git_parse_maybe_bool(const char *value)
 {
 	if (!value)
diff --git a/http.c b/http.c
index 96d84bbed3..ab6080835f 100644
--- a/http.c
+++ b/http.c
@@ -331,7 +331,7 @@ static int http_options(const char *var, const char *value, void *cb)
 	}
 
 	if (!strcmp("http.postbuffer", var)) {
-		http_post_buffer = git_config_int(var, value);
+		http_post_buffer = git_config_size_t(var, value);
 		if (http_post_buffer < LARGE_PACKET_MAX)
 			http_post_buffer = LARGE_PACKET_MAX;
 		return 0;
-- 
2.11.GIT

