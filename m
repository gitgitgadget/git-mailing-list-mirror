Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7D6F71F516
	for <e@80x24.org>; Thu, 28 Jun 2018 22:05:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966854AbeF1WF0 (ORCPT <rfc822;e@80x24.org>);
        Thu, 28 Jun 2018 18:05:26 -0400
Received: from cloud.peff.net ([104.130.231.41]:58946 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S966122AbeF1WF0 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Jun 2018 18:05:26 -0400
Received: (qmail 32012 invoked by uid 109); 28 Jun 2018 22:05:26 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 28 Jun 2018 22:05:26 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 26017 invoked by uid 111); 28 Jun 2018 22:05:46 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 28 Jun 2018 18:05:46 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 28 Jun 2018 18:05:24 -0400
Date:   Thu, 28 Jun 2018 18:05:24 -0400
From:   Jeff King <peff@peff.net>
To:     Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Jason@zx2c4.com,
        GIT Mailing-list <git@vger.kernel.org>
Subject: [PATCH 3/4] config: add options parameter to git_config_from_mem
Message-ID: <20180628220523.GC5524@sigill.intra.peff.net>
References: <20180628220332.GA5128@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180628220332.GA5128@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The underlying config parser knows how to handle a
config_options struct, but git_config_from_mem() always
passes NULL. Let's allow our callers to specify the options
struct.

We could add a "_with_options" variant, but since there are
only a handful of callers, let's just update them to pass
NULL.

Signed-off-by: Jeff King <peff@peff.net>
---
 config.c           | 11 +++++++----
 config.h           |  7 +++++--
 fsck.c             |  2 +-
 submodule-config.c |  2 +-
 4 files changed, 14 insertions(+), 8 deletions(-)

diff --git a/config.c b/config.c
index 0797e284f4..4548edb1e5 100644
--- a/config.c
+++ b/config.c
@@ -1569,8 +1569,10 @@ int git_config_from_file(config_fn_t fn, const char *filename, void *data)
 	return git_config_from_file_with_options(fn, filename, data, NULL);
 }
 
-int git_config_from_mem(config_fn_t fn, const enum config_origin_type origin_type,
-			const char *name, const char *buf, size_t len, void *data)
+int git_config_from_mem(config_fn_t fn,
+			const enum config_origin_type origin_type,
+			const char *name, const char *buf, size_t len,
+			void *data, const struct config_options *opts)
 {
 	struct config_source top;
 
@@ -1585,7 +1587,7 @@ int git_config_from_mem(config_fn_t fn, const enum config_origin_type origin_typ
 	top.do_ungetc = config_buf_ungetc;
 	top.do_ftell = config_buf_ftell;
 
-	return do_config_from(&top, fn, data, NULL);
+	return do_config_from(&top, fn, data, opts);
 }
 
 int git_config_from_blob_oid(config_fn_t fn,
@@ -1606,7 +1608,8 @@ int git_config_from_blob_oid(config_fn_t fn,
 		return error("reference '%s' does not point to a blob", name);
 	}
 
-	ret = git_config_from_mem(fn, CONFIG_ORIGIN_BLOB, name, buf, size, data);
+	ret = git_config_from_mem(fn, CONFIG_ORIGIN_BLOB, name, buf, size,
+				  data, NULL);
 	free(buf);
 
 	return ret;
diff --git a/config.h b/config.h
index c02809ffdc..f2063ceb86 100644
--- a/config.h
+++ b/config.h
@@ -68,8 +68,11 @@ extern int git_config_from_file(config_fn_t fn, const char *, void *);
 extern int git_config_from_file_with_options(config_fn_t fn, const char *,
 					     void *,
 					     const struct config_options *);
-extern int git_config_from_mem(config_fn_t fn, const enum config_origin_type,
-					const char *name, const char *buf, size_t len, void *data);
+extern int git_config_from_mem(config_fn_t fn,
+			       const enum config_origin_type,
+			       const char *name,
+			       const char *buf, size_t len,
+			       void *data, const struct config_options *opts);
 extern int git_config_from_blob_oid(config_fn_t fn, const char *name,
 				    const struct object_id *oid, void *data);
 extern void git_config_push_parameter(const char *text);
diff --git a/fsck.c b/fsck.c
index 0b8b20b6c4..aa7a52cc80 100644
--- a/fsck.c
+++ b/fsck.c
@@ -1012,7 +1012,7 @@ static int fsck_blob(struct blob *blob, const char *buf,
 	data.options = options;
 	data.ret = 0;
 	if (git_config_from_mem(fsck_gitmodules_fn, CONFIG_ORIGIN_BLOB,
-				".gitmodules", buf, size, &data))
+				".gitmodules", buf, size, &data, NULL))
 		data.ret |= report(options, &blob->object,
 				   FSCK_MSG_GITMODULES_PARSE,
 				   "could not parse gitmodules blob");
diff --git a/submodule-config.c b/submodule-config.c
index 388ef1f892..2ca3272dd1 100644
--- a/submodule-config.c
+++ b/submodule-config.c
@@ -561,7 +561,7 @@ static const struct submodule *config_from(struct submodule_cache *cache,
 	parameter.gitmodules_oid = &oid;
 	parameter.overwrite = 0;
 	git_config_from_mem(parse_config, CONFIG_ORIGIN_SUBMODULE_BLOB, rev.buf,
-			config, config_size, &parameter);
+			config, config_size, &parameter, NULL);
 	strbuf_release(&rev);
 	free(config);
 
-- 
2.18.0.604.g8c4f59c959

