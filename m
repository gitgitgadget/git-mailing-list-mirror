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
	by dcvr.yhbt.net (Postfix) with ESMTP id 2035120248
	for <e@80x24.org>; Fri, 22 Feb 2019 16:06:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727255AbfBVQFr (ORCPT <rfc822;e@80x24.org>);
        Fri, 22 Feb 2019 11:05:47 -0500
Received: from a7-20.smtp-out.eu-west-1.amazonses.com ([54.240.7.20]:41306
        "EHLO a7-20.smtp-out.eu-west-1.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727153AbfBVQFr (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 22 Feb 2019 11:05:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=uku4taia5b5tsbglxyj6zym32efj7xqv; d=amazonses.com; t=1550851545;
        h=From:To:Message-ID:In-Reply-To:References:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Date:Feedback-ID;
        bh=6Mz7l0mJFzYR4sM7BCe1lncpcwA+WsRh+NjzZThJTWc=;
        b=uz9TIxr5JCxrHY2plZUqk4uxKafzqxyV24hwEk6SnOy0Ld9K4m6TnAFhDgrRtTZk
        eYG3LjAFihODhF55EUevPeYoRMowQloMWgdmusHJM/O08g41f+yflxPx1mvmis3OksN
        Qpwoou7Q7PAAwVB2B1q0UNIkVORT6UYpFK7k+XJQ=
From:   Olga Telezhnaya <olyatelezhnaya@gmail.com>
To:     git@vger.kernel.org
Message-ID: <0102016915f49a4b-b346412b-752e-4068-8a25-62cac2a1f555-000000@eu-west-1.amazonses.com>
In-Reply-To: <0102016915f499b8-5813fc52-230b-469e-b939-a1244e83a2b9-000000@eu-west-1.amazonses.com>
References: <0102016915f499b8-5813fc52-230b-469e-b939-a1244e83a2b9-000000@eu-west-1.amazonses.com>
Subject: [PATCH RFC 05/20] cat-file: remove split_on_whitespace
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Date:   Fri, 22 Feb 2019 16:05:45 +0000
X-SES-Outgoing: 2019.02.22-54.240.7.20
Feedback-ID: 1.eu-west-1.YYPRFFOog89kHDDPKvTu4MK67j4wW0z7cAgZtFqQH58=:AmazonSES
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Get rid of split_on_whitespace field in struct expand_data.
expand_data may be global further as we use it in ref-filter also,
so we need to remove cat-file specific fields from it.

Signed-off-by: Olga Telezhnaia <olyatelezhnaya@gmail.com>
---
 builtin/cat-file.c | 16 +++-------------
 1 file changed, 3 insertions(+), 13 deletions(-)

diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index e5de596611800..60f3839b06f8c 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -203,13 +203,6 @@ struct expand_data {
 	 */
 	int mark_query;
 
-	/*
-	 * Whether to split the input on whitespace before feeding it to
-	 * get_sha1; this is decided during the mark_query phase based on
-	 * whether we have a %(rest) token in our format.
-	 */
-	int split_on_whitespace;
-
 	/*
 	 * After a mark_query run, this object_info is set up to be
 	 * passed to oid_object_info_extended. It will point to the data
@@ -255,9 +248,7 @@ static void expand_atom(struct strbuf *sb, const char *atom, int len,
 		else
 			strbuf_addf(sb, "%"PRIuMAX, (uintmax_t)data->disk_size);
 	} else if (is_atom("rest", atom, len)) {
-		if (data->mark_query)
-			data->split_on_whitespace = 1;
-		else if (data->rest)
+		if (data->rest)
 			strbuf_addstr(sb, data->rest);
 	} else if (is_atom("deltabase", atom, len)) {
 		if (data->mark_query)
@@ -491,6 +482,7 @@ static int batch_objects(struct batch_options *opt)
 	struct expand_data data;
 	int save_warning;
 	int retval = 0;
+	int is_rest = strstr(opt->format.format, "%(rest)") != NULL || opt->cmdmode;
 
 	/*
 	 * Expand once with our special mark_query flag, which will prime the
@@ -502,8 +494,6 @@ static int batch_objects(struct batch_options *opt)
 	strbuf_expand(&output, opt->format.format, expand_format, &data);
 	data.mark_query = 0;
 	strbuf_release(&output);
-	if (opt->cmdmode)
-		data.split_on_whitespace = 1;
 
 	if (opt->all_objects) {
 		struct object_info empty = OBJECT_INFO_INIT;
@@ -564,7 +554,7 @@ static int batch_objects(struct batch_options *opt)
 	warn_on_object_refname_ambiguity = 0;
 
 	while (strbuf_getline(&input, stdin) != EOF) {
-		if (data.split_on_whitespace) {
+		if (is_rest) {
 			/*
 			 * Split at first whitespace, tying off the beginning
 			 * of the string and saving the remainder (or NULL) in

--
https://github.com/git/git/pull/568
