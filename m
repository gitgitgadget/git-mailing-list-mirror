Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 691381F667
	for <e@80x24.org>; Wed, 16 Aug 2017 20:16:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752609AbdHPUQz (ORCPT <rfc822;e@80x24.org>);
        Wed, 16 Aug 2017 16:16:55 -0400
Received: from vie01a-dmta-pe06-1.mx.upcmail.net ([84.116.36.14]:48034 "EHLO
        vie01a-dmta-pe05-1.mx.upcmail.net" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752570AbdHPUQv (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 16 Aug 2017 16:16:51 -0400
Received: from [172.31.216.44] (helo=vie01a-pemc-psmtp-pe02)
        by vie01a-dmta-pe06.mx.upcmail.net with esmtp (Exim 4.88)
        (envelope-from <martin.koegler@chello.at>)
        id 1di4kE-0004LY-3Y
        for git@vger.kernel.org; Wed, 16 Aug 2017 22:16:50 +0200
Received: from master.zuhause ([80.108.242.240])
        by vie01a-pemc-psmtp-pe02 with SMTP @ mailcloud.upcmail.net
        id xwGk1v0095BuuEg01wGlM8; Wed, 16 Aug 2017 22:16:45 +0200
X-SourceIP: 80.108.242.240
Received: by master.zuhause (Postfix, from userid 1006)
        id DB14F45D4512; Wed, 16 Aug 2017 22:16:43 +0200 (CEST)
From:   Martin Koegler <martin.koegler@chello.at>
To:     git@vger.kernel.org, gitster@pobox.com, Johannes.Schindelin@gmx.de
Cc:     Martin Koegler <martin.koegler@chello.at>
Subject: [Patch size_t V3 11/19] Use size_t for config parsing
Date:   Wed, 16 Aug 2017 22:16:23 +0200
Message-Id: <1502914591-26215-12-git-send-email-martin@mail.zuhause>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1502914591-26215-1-git-send-email-martin@mail.zuhause>
References: <1502914591-26215-1-git-send-email-martin@mail.zuhause>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Martin Koegler <martin.koegler@chello.at>

Signed-off-by: Martin Koegler <martin.koegler@chello.at>
---
 builtin/pack-objects.c |  6 +++---
 config.c               | 27 ++++++++++++++++++++++-----
 config.h               |  2 ++
 3 files changed, 27 insertions(+), 8 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 9067803..fbb07a8 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -2450,7 +2450,7 @@ static int git_pack_config(const char *k, const char *v, void *cb)
 		return 0;
 	}
 	if (!strcmp(k, "pack.windowmemory")) {
-		window_memory_limit = git_config_ulong(k, v);
+		window_memory_limit = git_config_size_t(k, v);
 		return 0;
 	}
 	if (!strcmp(k, "pack.depth")) {
@@ -2458,11 +2458,11 @@ static int git_pack_config(const char *k, const char *v, void *cb)
 		return 0;
 	}
 	if (!strcmp(k, "pack.deltacachesize")) {
-		max_delta_cache_size = git_config_int(k, v);
+		max_delta_cache_size = git_config_size_t(k, v);
 		return 0;
 	}
 	if (!strcmp(k, "pack.deltacachelimit")) {
-		cache_max_small_delta_size = git_config_int(k, v);
+		cache_max_small_delta_size = git_config_size_t(k, v);
 		return 0;
 	}
 	if (!strcmp(k, "pack.writebitmaphashcache")) {
diff --git a/config.c b/config.c
index bf4e2e4..50f0077 100644
--- a/config.c
+++ b/config.c
@@ -863,6 +863,15 @@ static int git_parse_ssize_t(const char *value, ssize_t *ret)
 	return 1;
 }
 
+int git_parse_size_t(const char *value, size_t *ret)
+{
+	uintmax_t tmp;
+	if (!git_parse_unsigned(value, &tmp, maximum_signed_value_of_type(size_t)))
+		return 0;
+	*ret = tmp;
+	return 1;
+}
+
 NORETURN
 static void die_bad_number(const char *name, const char *value)
 {
@@ -929,6 +938,14 @@ ssize_t git_config_ssize_t(const char *name, const char *value)
 	return ret;
 }
 
+size_t git_config_size_t(const char *name, const char *value)
+{
+	size_t ret;
+	if (!git_parse_size_t(value, &ret))
+		die_bad_number(name, value);
+	return ret;
+}
+
 int git_parse_maybe_bool(const char *value)
 {
 	if (!value)
@@ -1105,7 +1122,7 @@ static int git_default_core_config(const char *var, const char *value)
 
 	if (!strcmp(var, "core.packedgitwindowsize")) {
 		int pgsz_x2 = getpagesize() * 2;
-		packed_git_window_size = git_config_ulong(var, value);
+		packed_git_window_size = git_config_size_t(var, value);
 
 		/* This value must be multiple of (pagesize * 2) */
 		packed_git_window_size /= pgsz_x2;
@@ -1116,17 +1133,17 @@ static int git_default_core_config(const char *var, const char *value)
 	}
 
 	if (!strcmp(var, "core.bigfilethreshold")) {
-		big_file_threshold = git_config_ulong(var, value);
+		big_file_threshold = git_config_size_t(var, value);
 		return 0;
 	}
 
 	if (!strcmp(var, "core.packedgitlimit")) {
-		packed_git_limit = git_config_ulong(var, value);
+		packed_git_limit = git_config_size_t(var, value);
 		return 0;
 	}
 
 	if (!strcmp(var, "core.deltabasecachelimit")) {
-		delta_base_cache_limit = git_config_ulong(var, value);
+		delta_base_cache_limit = git_config_size_t(var, value);
 		return 0;
 	}
 
@@ -1360,7 +1377,7 @@ int git_default_config(const char *var, const char *value, void *dummy)
 	}
 
 	if (!strcmp(var, "pack.packsizelimit")) {
-		pack_size_limit_cfg = git_config_ulong(var, value);
+		pack_size_limit_cfg = git_config_size_t(var, value);
 		return 0;
 	}
 
diff --git a/config.h b/config.h
index 18b6f3f..cbaa3e3 100644
--- a/config.h
+++ b/config.h
@@ -49,11 +49,13 @@ extern int config_with_options(config_fn_t fn, void *,
 			       struct git_config_source *config_source,
 			       const struct config_options *opts);
 extern int git_parse_ulong(const char *, unsigned long *);
+extern int git_parse_size_t(const char *, size_t *);
 extern int git_parse_maybe_bool(const char *);
 extern int git_config_int(const char *, const char *);
 extern int64_t git_config_int64(const char *, const char *);
 extern unsigned long git_config_ulong(const char *, const char *);
 extern ssize_t git_config_ssize_t(const char *, const char *);
+extern size_t git_config_size_t(const char *, const char *);
 extern int git_config_bool_or_int(const char *, const char *, int *);
 extern int git_config_bool(const char *, const char *);
 extern int git_config_maybe_bool(const char *, const char *);
-- 
2.1.4

