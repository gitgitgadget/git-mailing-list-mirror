Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0B8F81F406
	for <e@80x24.org>; Tue,  9 Jan 2018 13:06:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757228AbeAINGL (ORCPT <rfc822;e@80x24.org>);
        Tue, 9 Jan 2018 08:06:11 -0500
Received: from a7-11.smtp-out.eu-west-1.amazonses.com ([54.240.7.11]:56474
        "EHLO a7-11.smtp-out.eu-west-1.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1756985AbeAINFY (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 9 Jan 2018 08:05:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=shh3fegwg5fppqsuzphvschd53n6ihuv; d=amazonses.com; t=1515503123;
        h=From:To:Message-ID:In-Reply-To:References:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Date:Feedback-ID;
        bh=4i1BWTRJikYZR1bt85ynu1OFvgDzplX/DR0IXMRcisA=;
        b=ENp8SF8z4i6QtnyOpHhE9Y5oGPFGcpDboqPfhvnjOpVEdexiy6YJJKm/JAght11f
        rsknovs42/bQUWJ89G6NLVUeQrKVEQZ5Vo1oX3pPUqeU7TKuEMiqKLF02RIbk9CRY1i
        9oPvqW35Xhh4xEYJ1FM48jNP8nX7fufXN3W2XqtU=
From:   Olga Telezhnaya <olyatelezhnaya@gmail.com>
To:     git@vger.kernel.org
Message-ID: <01020160db067a62-874402f0-c7c0-4fb4-91c3-ac644fcf9a1f-000000@eu-west-1.amazonses.com>
In-Reply-To: <01020160db0679c9-799a0bc4-b6d1-43e2-ad3b-80be4e4c55e9-000000@eu-west-1.amazonses.com>
References: <01020160db0679c9-799a0bc4-b6d1-43e2-ad3b-80be4e4c55e9-000000@eu-west-1.amazonses.com>
Subject: [PATCH 02/20] cat-file: reuse struct ref_format
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Date:   Tue, 9 Jan 2018 13:05:23 +0000
X-SES-Outgoing: 2018.01.09-54.240.7.11
Feedback-ID: 1.eu-west-1.YYPRFFOog89kHDDPKvTu4MK67j4wW0z7cAgZtFqQH58=:AmazonSES
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Start using ref_format struct instead of simple char*.
Need that for further reusing of formatting logic from ref-filter.

Signed-off-by: Olga Telezhnaia <olyatelezhnaya@gmail.com>
Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored by: Jeff King <peff@peff.net>
---
 builtin/cat-file.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index f783b39b9bd5c..7655a9a726773 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -13,15 +13,16 @@
 #include "tree-walk.h"
 #include "sha1-array.h"
 #include "packfile.h"
+#include "ref-filter.h"
 
 struct batch_options {
+	struct ref_format *format;
 	int enabled;
 	int follow_symlinks;
 	int print_contents;
 	int buffer_output;
 	int all_objects;
 	int cmdmode; /* may be 'w' or 'c' for --filters or --textconv */
-	const char *format;
 };
 
 static const char *force_path;
@@ -353,7 +354,7 @@ static void batch_object_write(const char *obj_name, struct batch_options *opt,
 		return;
 	}
 
-	strbuf_expand(&buf, opt->format, expand_format, data);
+	strbuf_expand(&buf, opt->format->format, expand_format, data);
 	strbuf_addch(&buf, '\n');
 	batch_write(opt, buf.buf, buf.len);
 	strbuf_release(&buf);
@@ -446,8 +447,8 @@ static int batch_objects(struct batch_options *opt)
 	int save_warning;
 	int retval = 0;
 
-	if (!opt->format)
-		opt->format = "%(objectname) %(objecttype) %(objectsize)";
+	if (!opt->format->format)
+		opt->format->format = "%(objectname) %(objecttype) %(objectsize)";
 
 	/*
 	 * Expand once with our special mark_query flag, which will prime the
@@ -456,7 +457,7 @@ static int batch_objects(struct batch_options *opt)
 	 */
 	memset(&data, 0, sizeof(data));
 	data.mark_query = 1;
-	strbuf_expand(&buf, opt->format, expand_format, &data);
+	strbuf_expand(&buf, opt->format->format, expand_format, &data);
 	data.mark_query = 0;
 	if (opt->cmdmode)
 		data.split_on_whitespace = 1;
@@ -548,7 +549,7 @@ static int batch_option_callback(const struct option *opt,
 
 	bo->enabled = 1;
 	bo->print_contents = !strcmp(opt->long_name, "batch");
-	bo->format = arg;
+	bo->format->format = arg;
 
 	return 0;
 }
@@ -557,7 +558,8 @@ int cmd_cat_file(int argc, const char **argv, const char *prefix)
 {
 	int opt = 0;
 	const char *exp_type = NULL, *obj_name = NULL;
-	struct batch_options batch = {0};
+	struct ref_format format = REF_FORMAT_INIT;
+	struct batch_options batch = {&format};
 	int unknown_type = 0;
 
 	const struct option options[] = {

--
https://github.com/git/git/pull/450
