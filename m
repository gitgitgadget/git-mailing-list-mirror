Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 541E91F516
	for <e@80x24.org>; Thu, 28 Jun 2018 22:05:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967282AbeF1WFD (ORCPT <rfc822;e@80x24.org>);
        Thu, 28 Jun 2018 18:05:03 -0400
Received: from cloud.peff.net ([104.130.231.41]:58924 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S966122AbeF1WFC (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Jun 2018 18:05:02 -0400
Received: (qmail 31983 invoked by uid 109); 28 Jun 2018 22:05:03 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 28 Jun 2018 22:05:03 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 25979 invoked by uid 111); 28 Jun 2018 22:05:23 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 28 Jun 2018 18:05:23 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 28 Jun 2018 18:05:00 -0400
Date:   Thu, 28 Jun 2018 18:05:00 -0400
From:   Jeff King <peff@peff.net>
To:     Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Jason@zx2c4.com,
        GIT Mailing-list <git@vger.kernel.org>
Subject: [PATCH 1/4] config: turn die_on_error into caller-facing enum
Message-ID: <20180628220500.GA5524@sigill.intra.peff.net>
References: <20180628220332.GA5128@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180628220332.GA5128@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The config code has a die_on_error flag, which lets us emit
an error() instead of dying when we see a bogus config file.
But there's no way for a caller of the config code to set
this: it's auto-set based on whether we're reading a file or
a blob.

Instead, let's add it to the config_options struct. When
it's not set (or we have no options) we'll continue to fall
back to the existing file/blob behavior.

Signed-off-by: Jeff King <peff@peff.net>
---
 config.c | 18 +++++++++++++-----
 config.h |  5 +++++
 2 files changed, 18 insertions(+), 5 deletions(-)

diff --git a/config.c b/config.c
index a0a6ae1980..b5c23369d0 100644
--- a/config.c
+++ b/config.c
@@ -31,7 +31,7 @@ struct config_source {
 	enum config_origin_type origin_type;
 	const char *name;
 	const char *path;
-	int die_on_error;
+	enum config_error_action default_error_action;
 	int linenr;
 	int eof;
 	struct strbuf value;
@@ -809,10 +809,18 @@ static int git_parse_source(config_fn_t fn, void *data,
 				      cf->linenr, cf->name);
 	}
 
-	if (cf->die_on_error)
+	switch (opts && opts->error_action ?
+		opts->error_action :
+		cf->default_error_action) {
+	case CONFIG_ERROR_DIE:
 		die("%s", error_msg);
-	else
+		break;
+	case CONFIG_ERROR_ERROR:
 		error_return = error("%s", error_msg);
+		break;
+	case CONFIG_ERROR_UNSET:
+		BUG("config error action unset");
+	}
 
 	free(error_msg);
 	return error_return;
@@ -1520,7 +1528,7 @@ static int do_config_from_file(config_fn_t fn,
 	top.origin_type = origin_type;
 	top.name = name;
 	top.path = path;
-	top.die_on_error = 1;
+	top.default_error_action = CONFIG_ERROR_DIE;
 	top.do_fgetc = config_file_fgetc;
 	top.do_ungetc = config_file_ungetc;
 	top.do_ftell = config_file_ftell;
@@ -1569,7 +1577,7 @@ int git_config_from_mem(config_fn_t fn, const enum config_origin_type origin_typ
 	top.origin_type = origin_type;
 	top.name = name;
 	top.path = NULL;
-	top.die_on_error = 0;
+	top.default_error_action = CONFIG_ERROR_ERROR;
 	top.do_fgetc = config_buf_fgetc;
 	top.do_ungetc = config_buf_ungetc;
 	top.do_ftell = config_buf_ftell;
diff --git a/config.h b/config.h
index 626d4654bd..ce75bf1e5c 100644
--- a/config.h
+++ b/config.h
@@ -54,6 +54,11 @@ struct config_options {
 	const char *git_dir;
 	config_parser_event_fn_t event_fn;
 	void *event_fn_data;
+	enum config_error_action {
+		CONFIG_ERROR_UNSET = 0, /* use source-specific default */
+		CONFIG_ERROR_DIE, /* die() on error */
+		CONFIG_ERROR_ERROR, /* error() on error, return -1 */
+	} error_action;
 };
 
 typedef int (*config_fn_t)(const char *, const char *, void *);
-- 
2.18.0.604.g8c4f59c959

