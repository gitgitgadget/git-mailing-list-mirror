Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D5A6F1F404
	for <e@80x24.org>; Fri, 26 Jan 2018 19:43:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752475AbeAZTny (ORCPT <rfc822;e@80x24.org>);
        Fri, 26 Jan 2018 14:43:54 -0500
Received: from a7-17.smtp-out.eu-west-1.amazonses.com ([54.240.7.17]:34828
        "EHLO a7-17.smtp-out.eu-west-1.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752209AbeAZTnl (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 26 Jan 2018 14:43:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=shh3fegwg5fppqsuzphvschd53n6ihuv; d=amazonses.com; t=1516995820;
        h=From:To:Message-ID:In-Reply-To:References:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Date:Feedback-ID;
        bh=vQnn+YOYRl2FZ6NNrBkF7VBZAP4+2FjFkO/4gAozu1Q=;
        b=drJ9t0YjnY5jPEfFLKxgGYlZEwkk4zhTUlxR/5CIA5jUV79vsatE9larAKUQ2G5Y
        dZtBV9xFC7pNSMJrhIR3u7+q9DHCVmKkAZxgjhEtPEkpGd57pNfYNsjlWyqFn5rgZA+
        C0RtoKPpkd/6uAukdhamtMCQ3+O4wg/k6os/TNn4=
From:   Olga Telezhnaya <olyatelezhnaya@gmail.com>
To:     git@vger.kernel.org
Message-ID: <0102016133ff3b28-9969f573-5976-45d9-a51a-4edba26d95c2-000000@eu-west-1.amazonses.com>
In-Reply-To: <0102016133ff3a86-44d354ec-13c6-4c38-bc75-1ba4422db5a7-000000@eu-west-1.amazonses.com>
References: <0102016133ff3a86-44d354ec-13c6-4c38-bc75-1ba4422db5a7-000000@eu-west-1.amazonses.com>
Subject: [PATCH RFC 09/24] cat-file: start use ref_array_item struct
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Date:   Fri, 26 Jan 2018 19:43:40 +0000
X-SES-Outgoing: 2018.01.26-54.240.7.17
Feedback-ID: 1.eu-west-1.YYPRFFOog89kHDDPKvTu4MK67j4wW0z7cAgZtFqQH58=:AmazonSES
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Moving from using expand_data to ref_array_item structure.
That helps us to reuse functions from ref-filter easier.

Signed-off-by: Olga Telezhnaia <olyatelezhnaya@gmail.com>
Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored by: Jeff King <peff@peff.net>
---
 builtin/cat-file.c | 32 ++++++++++++++++++++------------
 ref-filter.h       |  5 +++++
 2 files changed, 25 insertions(+), 12 deletions(-)

diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index 909412747cbd2..61b7acc79155d 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -183,27 +183,27 @@ static int is_atom(const char *atom, const char *s, int slen)
 }
 
 static void expand_atom(struct strbuf *sb, const char *atom, int len,
-			 struct expand_data *data)
+			 struct ref_array_item *item)
 {
 	if (is_atom("objectname", atom, len))
-		strbuf_addstr(sb, oid_to_hex(&data->oid));
+		strbuf_addstr(sb, oid_to_hex(&item->objectname));
 	else if (is_atom("objecttype", atom, len))
-		strbuf_addstr(sb, typename(data->type));
+		strbuf_addstr(sb, typename(item->type));
 	else if (is_atom("objectsize", atom, len))
-		strbuf_addf(sb, "%lu", data->size);
+		strbuf_addf(sb, "%lu", item->size);
 	else if (is_atom("objectsize:disk", atom, len))
-		strbuf_addf(sb, "%"PRIuMAX, (uintmax_t)data->disk_size);
+		strbuf_addf(sb, "%"PRIuMAX, (uintmax_t)item->disk_size);
 	else if (is_atom("rest", atom, len)) {
-		if (data->rest)
-			strbuf_addstr(sb, data->rest);
+		if (item->rest)
+			strbuf_addstr(sb, item->rest);
 	} else if (is_atom("deltabase", atom, len))
-		strbuf_addstr(sb, oid_to_hex(&data->delta_base_oid));
+		strbuf_addstr(sb, oid_to_hex(item->delta_base_oid));
 }
 
-static size_t expand_format(struct strbuf *sb, const char *start, void *vdata)
+static size_t expand_format(struct strbuf *sb, const char *start, void *data)
 {
 	const char *end;
-	struct expand_data *data = vdata;
+	struct ref_array_item *item = data;
 
 	if (*start != '(')
 		return 0;
@@ -211,7 +211,7 @@ static size_t expand_format(struct strbuf *sb, const char *start, void *vdata)
 	if (!end)
 		die("format element '%s' does not end in ')'", start);
 
-	expand_atom(sb, start + 1, end - start - 1, data);
+	expand_atom(sb, start + 1, end - start - 1, item);
 	return end - start + 1;
 }
 
@@ -283,6 +283,7 @@ static void batch_object_write(const char *obj_name, struct batch_options *opt,
 			       struct expand_data *data)
 {
 	struct strbuf buf = STRBUF_INIT;
+	struct ref_array_item item = {0};
 
 	if (!data->skip_object_info &&
 	    sha1_object_info_extended(data->oid.hash, &data->info,
@@ -293,7 +294,14 @@ static void batch_object_write(const char *obj_name, struct batch_options *opt,
 		return;
 	}
 
-	strbuf_expand(&buf, opt->format.format, expand_format, data);
+	item.objectname = data->oid;
+	item.type = data->type;
+	item.size = data->size;
+	item.disk_size = data->disk_size;
+	item.rest = data->rest;
+	item.delta_base_oid = &data->delta_base_oid;
+
+	strbuf_expand(&buf, opt->format.format, expand_format, &item);
 	strbuf_addch(&buf, '\n');
 	batch_write(opt, buf.buf, buf.len);
 	strbuf_release(&buf);
diff --git a/ref-filter.h b/ref-filter.h
index b50c8e6aaf2c4..7aaf82799ec2d 100644
--- a/ref-filter.h
+++ b/ref-filter.h
@@ -40,6 +40,11 @@ struct ref_array_item {
 	const char *symref;
 	struct commit *commit;
 	struct atom_value *value;
+	enum object_type type;
+	unsigned long size;
+	off_t disk_size;
+	const char *rest;
+	struct object_id *delta_base_oid;
 	char refname[FLEX_ARRAY];
 };
 

--
https://github.com/git/git/pull/452
