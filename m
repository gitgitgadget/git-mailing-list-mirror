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
	by dcvr.yhbt.net (Postfix) with ESMTP id 09E911F576
	for <e@80x24.org>; Mon,  5 Feb 2018 11:28:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752944AbeBEL2G (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Feb 2018 06:28:06 -0500
Received: from a7-17.smtp-out.eu-west-1.amazonses.com ([54.240.7.17]:42248
        "EHLO a7-17.smtp-out.eu-west-1.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752840AbeBEL1k (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 5 Feb 2018 06:27:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=shh3fegwg5fppqsuzphvschd53n6ihuv; d=amazonses.com; t=1517830059;
        h=From:To:Message-ID:In-Reply-To:References:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Date:Feedback-ID;
        bh=JxaorqxvP61g7dNeFDDENo1m1QvLP+cXDqhX+18RohU=;
        b=Zup4lml9ge5d7pDFoLfhvFYJo2I5pCb9WmnnDvueXLwndC7JSo+QQMBFloBH1uEo
        NKUo6PN3qNKxC1VSNTE8Yfs6DIWDMdNMXgL8LKYzLTqvFYShCCzygEWcSrFszYkQTLg
        2fg/eKUpIQDQuk1jeawzFcM2LaRNKhAYtpGWwi/U=
From:   Olga Telezhnaya <olyatelezhnaya@gmail.com>
To:     git@vger.kernel.org
Message-ID: <0102016165b8b444-99fcbf50-ab35-4781-821a-a0dc90ed813b-000000@eu-west-1.amazonses.com>
In-Reply-To: <0102016165b8b3c4-54efe4c4-6d19-435d-b5b9-6c727771353b-000000@eu-west-1.amazonses.com>
References: <0102016165b8b3c4-54efe4c4-6d19-435d-b5b9-6c727771353b-000000@eu-west-1.amazonses.com>
Subject: [PATCH RFC v2 03/25] cat-file: reuse struct ref_format
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Date:   Mon, 5 Feb 2018 11:27:39 +0000
X-SES-Outgoing: 2018.02.05-54.240.7.17
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
 builtin/cat-file.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index f5fa4fd75af26..98fc5ec069a49 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -13,15 +13,16 @@
 #include "tree-walk.h"
 #include "sha1-array.h"
 #include "packfile.h"
+#include "ref-filter.h"
 
 struct batch_options {
+	struct ref_format format;
 	int enabled;
 	int follow_symlinks;
 	int print_contents;
 	int buffer_output;
 	int all_objects;
 	int cmdmode; /* may be 'w' or 'c' for --filters or --textconv */
-	const char *format;
 };
 
 static const char *force_path;
@@ -348,7 +349,7 @@ static void batch_object_write(const char *obj_name, struct batch_options *opt,
 		return;
 	}
 
-	strbuf_expand(&buf, opt->format, expand_format, data);
+	strbuf_expand(&buf, opt->format.format, expand_format, data);
 	strbuf_addch(&buf, '\n');
 	batch_write(opt, buf.buf, buf.len);
 	strbuf_release(&buf);
@@ -441,8 +442,8 @@ static int batch_objects(struct batch_options *opt)
 	int save_warning;
 	int retval = 0;
 
-	if (!opt->format)
-		opt->format = "%(objectname) %(objecttype) %(objectsize)";
+	if (!opt->format.format)
+		opt->format.format = "%(objectname) %(objecttype) %(objectsize)";
 
 	/*
 	 * Expand once with our special mark_query flag, which will prime the
@@ -451,7 +452,7 @@ static int batch_objects(struct batch_options *opt)
 	 */
 	memset(&data, 0, sizeof(data));
 	data.mark_query = 1;
-	strbuf_expand(&buf, opt->format, expand_format, &data);
+	strbuf_expand(&buf, opt->format.format, expand_format, &data);
 	data.mark_query = 0;
 	if (opt->cmdmode)
 		data.split_on_whitespace = 1;
@@ -543,7 +544,7 @@ static int batch_option_callback(const struct option *opt,
 
 	bo->enabled = 1;
 	bo->print_contents = !strcmp(opt->long_name, "batch");
-	bo->format = arg;
+	bo->format.format = arg;
 
 	return 0;
 }
@@ -552,7 +553,7 @@ int cmd_cat_file(int argc, const char **argv, const char *prefix)
 {
 	int opt = 0;
 	const char *exp_type = NULL, *obj_name = NULL;
-	struct batch_options batch = {0};
+	struct batch_options batch = { REF_FORMAT_INIT };
 	int unknown_type = 0;
 
 	const struct option options[] = {

--
https://github.com/git/git/pull/452
