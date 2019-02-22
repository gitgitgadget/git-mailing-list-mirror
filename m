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
	by dcvr.yhbt.net (Postfix) with ESMTP id DE0AA20248
	for <e@80x24.org>; Fri, 22 Feb 2019 16:05:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727327AbfBVQF5 (ORCPT <rfc822;e@80x24.org>);
        Fri, 22 Feb 2019 11:05:57 -0500
Received: from a7-11.smtp-out.eu-west-1.amazonses.com ([54.240.7.11]:49302
        "EHLO a7-11.smtp-out.eu-west-1.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727240AbfBVQFr (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 22 Feb 2019 11:05:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=uku4taia5b5tsbglxyj6zym32efj7xqv; d=amazonses.com; t=1550851545;
        h=From:To:Message-ID:In-Reply-To:References:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Date:Feedback-ID;
        bh=EtweXjq7Vqyhyvt6aHhpjTCb0ei1HQDZT//IFtbAKeI=;
        b=HrLd1CpWVOp+541W2cL8WfY2uxMxJ20jARne7QSxXq1UUcmXpJZSG0kgqeFgS4PB
        s8lRJ8ntLZiAkvZWFKZ3doAq75I3WeH4QLayCSmt6RJ18eUyxcB/znUIVhVjwB1Njte
        hu7qDuyQc1I2JNqaQ5lPtsicF3tiwHzswYbT6Uw8=
From:   Olga Telezhnaya <olyatelezhnaya@gmail.com>
To:     git@vger.kernel.org
Message-ID: <0102016915f49a4f-f02a6509-a3ba-41b0-b768-3d8ba116f526-000000@eu-west-1.amazonses.com>
In-Reply-To: <0102016915f499b8-5813fc52-230b-469e-b939-a1244e83a2b9-000000@eu-west-1.amazonses.com>
References: <0102016915f499b8-5813fc52-230b-469e-b939-a1244e83a2b9-000000@eu-west-1.amazonses.com>
Subject: [PATCH RFC 06/20] cat-file: remove mark_query from expand_data
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Date:   Fri, 22 Feb 2019 16:05:45 +0000
X-SES-Outgoing: 2019.02.22-54.240.7.11
Feedback-ID: 1.eu-west-1.YYPRFFOog89kHDDPKvTu4MK67j4wW0z7cAgZtFqQH58=:AmazonSES
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Get rid of mark_query field in struct expand_data.
expand_data may be global further as we use it in ref-filter also,
so we need to remove cat-file specific fields from it.

All globals that I add through this patch will be deleted in the end,
so treat it just as the middle step.

Signed-off-by: Olga Telezhnaia <olyatelezhnaya@gmail.com>
---
 builtin/cat-file.c | 22 +++++++++-------------
 1 file changed, 9 insertions(+), 13 deletions(-)

diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index 60f3839b06f8c..9bcb02fad1f0d 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -29,6 +29,8 @@ struct batch_options {
 };
 
 static const char *force_path;
+/* Will be deleted at the end of this patch */
+static int mark_query;
 
 static int filter_object(const char *path, unsigned mode,
 			 const struct object_id *oid,
@@ -197,12 +199,6 @@ struct expand_data {
 	const char *rest;
 	struct object_id delta_base_oid;
 
-	/*
-	 * If mark_query is true, we do not expand anything, but rather
-	 * just mark the object_info with items we wish to query.
-	 */
-	int mark_query;
-
 	/*
 	 * After a mark_query run, this object_info is set up to be
 	 * passed to oid_object_info_extended. It will point to the data
@@ -230,20 +226,20 @@ static void expand_atom(struct strbuf *sb, const char *atom, int len,
 	struct expand_data *data = vdata;
 
 	if (is_atom("objectname", atom, len)) {
-		if (!data->mark_query)
+		if (!mark_query)
 			strbuf_addstr(sb, oid_to_hex(&data->oid));
 	} else if (is_atom("objecttype", atom, len)) {
-		if (data->mark_query)
+		if (mark_query)
 			data->info.typep = &data->type;
 		else
 			strbuf_addstr(sb, type_name(data->type));
 	} else if (is_atom("objectsize", atom, len)) {
-		if (data->mark_query)
+		if (mark_query)
 			data->info.sizep = &data->size;
 		else
 			strbuf_addf(sb, "%"PRIuMAX , (uintmax_t)data->size);
 	} else if (is_atom("objectsize:disk", atom, len)) {
-		if (data->mark_query)
+		if (mark_query)
 			data->info.disk_sizep = &data->disk_size;
 		else
 			strbuf_addf(sb, "%"PRIuMAX, (uintmax_t)data->disk_size);
@@ -251,7 +247,7 @@ static void expand_atom(struct strbuf *sb, const char *atom, int len,
 		if (data->rest)
 			strbuf_addstr(sb, data->rest);
 	} else if (is_atom("deltabase", atom, len)) {
-		if (data->mark_query)
+		if (mark_query)
 			data->info.delta_base_sha1 = data->delta_base_oid.hash;
 		else
 			strbuf_addstr(sb,
@@ -490,9 +486,9 @@ static int batch_objects(struct batch_options *opt)
 	 * object.
 	 */
 	memset(&data, 0, sizeof(data));
-	data.mark_query = 1;
+	mark_query = 1;
 	strbuf_expand(&output, opt->format.format, expand_format, &data);
-	data.mark_query = 0;
+	mark_query = 0;
 	strbuf_release(&output);
 
 	if (opt->all_objects) {

--
https://github.com/git/git/pull/568
