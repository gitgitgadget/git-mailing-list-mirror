Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,FORGED_GMAIL_RCVD,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0A14B20248
	for <e@80x24.org>; Fri, 22 Feb 2019 16:06:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727251AbfBVQGM (ORCPT <rfc822;e@80x24.org>);
        Fri, 22 Feb 2019 11:06:12 -0500
Received: from a7-10.smtp-out.eu-west-1.amazonses.com ([54.240.7.10]:33620
        "EHLO a7-10.smtp-out.eu-west-1.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727212AbfBVQFr (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 22 Feb 2019 11:05:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=uku4taia5b5tsbglxyj6zym32efj7xqv; d=amazonses.com; t=1550851545;
        h=From:To:Message-ID:In-Reply-To:References:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Date:Feedback-ID;
        bh=xoV5L6cupe0t4D+I0/sIpdLnYI17oFDktSbYjdAI3pY=;
        b=lLlJROcid12C+xr2lNhlir6UVoV2hNMNkBxGYSyV2sF+YkZdHmAtUj0Jc6uHLFs+
        FY5mjEEbN80jmM4XZjoJg6/NPloYzFrJPZECEuTNH+AQCVBdLZrOQF2YXWxAAcz/R+I
        F+TDtUcgoQmuAaAt1iZ84cKeG7p5M28x3A/rBrVk=
From:   Olga Telezhnaya <olyatelezhnaya@gmail.com>
To:     git@vger.kernel.org
Message-ID: <0102016915f499b8-5813fc52-230b-469e-b939-a1244e83a2b9-000000@eu-west-1.amazonses.com>
In-Reply-To: <CAL21BmnVkKtYWa1cRL1EJAwtchGcVUzhu0136AuV8uXAi5Kuew@mail.gmail.com>
References: <CAL21BmnVkKtYWa1cRL1EJAwtchGcVUzhu0136AuV8uXAi5Kuew@mail.gmail.com>
Subject: [PATCH RFC 01/20] cat-file: reuse struct ref_format
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Date:   Fri, 22 Feb 2019 16:05:45 +0000
X-SES-Outgoing: 2019.02.22-54.240.7.10
Feedback-ID: 1.eu-west-1.YYPRFFOog89kHDDPKvTu4MK67j4wW0z7cAgZtFqQH58=:AmazonSES
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Start using ref_format struct instead of simple char*.
Need that for further reusing of formatting logic from ref-filter.

Signed-off-by: Olga Telezhnaia <olyatelezhnaya@gmail.com>
---
 builtin/cat-file.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index 0f092382e175c..e5de596611800 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -15,8 +15,10 @@
 #include "sha1-array.h"
 #include "packfile.h"
 #include "object-store.h"
+#include "ref-filter.h"
 
 struct batch_options {
+	struct ref_format format;
 	int enabled;
 	int follow_symlinks;
 	int print_contents;
@@ -24,7 +26,6 @@ struct batch_options {
 	int all_objects;
 	int unordered;
 	int cmdmode; /* may be 'w' or 'c' for --filters or --textconv */
-	const char *format;
 };
 
 static const char *force_path;
@@ -365,7 +366,7 @@ static void batch_object_write(const char *obj_name,
 	}
 
 	strbuf_reset(scratch);
-	strbuf_expand(scratch, opt->format, expand_format, data);
+	strbuf_expand(scratch, opt->format.format, expand_format, data);
 	strbuf_addch(scratch, '\n');
 	batch_write(opt, scratch->buf, scratch->len);
 
@@ -491,9 +492,6 @@ static int batch_objects(struct batch_options *opt)
 	int save_warning;
 	int retval = 0;
 
-	if (!opt->format)
-		opt->format = "%(objectname) %(objecttype) %(objectsize)";
-
 	/*
 	 * Expand once with our special mark_query flag, which will prime the
 	 * object_info to be handed to oid_object_info_extended for each
@@ -501,7 +499,7 @@ static int batch_objects(struct batch_options *opt)
 	 */
 	memset(&data, 0, sizeof(data));
 	data.mark_query = 1;
-	strbuf_expand(&output, opt->format, expand_format, &data);
+	strbuf_expand(&output, opt->format.format, expand_format, &data);
 	data.mark_query = 0;
 	strbuf_release(&output);
 	if (opt->cmdmode)
@@ -617,7 +615,7 @@ static int batch_option_callback(const struct option *opt,
 
 	bo->enabled = 1;
 	bo->print_contents = !strcmp(opt->long_name, "batch");
-	bo->format = arg;
+	bo->format.format = arg;
 
 	return 0;
 }
@@ -626,7 +624,7 @@ int cmd_cat_file(int argc, const char **argv, const char *prefix)
 {
 	int opt = 0;
 	const char *exp_type = NULL, *obj_name = NULL;
-	struct batch_options batch = {0};
+	struct batch_options batch = { REF_FORMAT_INIT };
 	int unknown_type = 0;
 
 	const struct option options[] = {
@@ -707,6 +705,9 @@ int cmd_cat_file(int argc, const char **argv, const char *prefix)
 	if (batch.buffer_output < 0)
 		batch.buffer_output = batch.all_objects;
 
+	if (!batch.format.format)
+		batch.format.format = "%(objectname) %(objecttype) %(objectsize)";
+
 	if (batch.enabled)
 		return batch_objects(&batch);
 

--
https://github.com/git/git/pull/568
