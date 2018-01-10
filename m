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
	by dcvr.yhbt.net (Postfix) with ESMTP id BAC391FADF
	for <e@80x24.org>; Wed, 10 Jan 2018 09:38:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965401AbeAJJhy (ORCPT <rfc822;e@80x24.org>);
        Wed, 10 Jan 2018 04:37:54 -0500
Received: from a7-12.smtp-out.eu-west-1.amazonses.com ([54.240.7.12]:44090
        "EHLO a7-12.smtp-out.eu-west-1.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1755737AbeAJJgm (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 10 Jan 2018 04:36:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=shh3fegwg5fppqsuzphvschd53n6ihuv; d=amazonses.com; t=1515577001;
        h=From:To:Message-ID:In-Reply-To:References:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Date:Feedback-ID;
        bh=7Cj8U3cWN0ZTxk05CG68T0I9N9NYngpKQZwuLNYTDjs=;
        b=KIUeuHDzHWYbgvCtJsay+lWJJKjAgCXjyGGCnWvamCpl/6YKtZ5aLZz2zDwjQ/N4
        wUTD+YdR2qaVfgkJn8vFafXCpqCnrrR8goK6ZRo3PF1GjLoIQGRVDUe4et6HajyFAsP
        uzxMgggv/g6jMUSyEIwP2w2hyjrq2JpO+Nvh58/8=
From:   Olga Telezhnaya <olyatelezhnaya@gmail.com>
To:     git@vger.kernel.org
Message-ID: <01020160df6dc583-8c4e2489-bbba-43d5-b2b8-48794531acea-000000@eu-west-1.amazonses.com>
In-Reply-To: <01020160df6dc499-0e6d11ec-1dcd-4a71-997b-ea231f33fae4-000000@eu-west-1.amazonses.com>
References: <01020160df6dc499-0e6d11ec-1dcd-4a71-997b-ea231f33fae4-000000@eu-west-1.amazonses.com>
Subject: [PATCH v2 11/18] cat-file: start use ref_array_item struct
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Date:   Wed, 10 Jan 2018 09:36:41 +0000
X-SES-Outgoing: 2018.01.10-54.240.7.12
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
 builtin/cat-file.c | 30 +++++++++++++++++++-----------
 ref-filter.h       |  5 +++++
 2 files changed, 24 insertions(+), 11 deletions(-)

diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index 1f331559e55c7..1c92194faaede 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -183,26 +183,26 @@ static int is_atom(const char *atom, const char *s, int slen)
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
 	else if (is_atom("rest", atom, len))
-		strbuf_addstr(sb, data->rest);
+		strbuf_addstr(sb, item->rest);
 	else if (is_atom("deltabase", atom, len))
-		strbuf_addstr(sb, oid_to_hex(&data->delta_base_oid));
+		strbuf_addstr(sb, oid_to_hex(&item->delta_base_oid));
 }
 
-static size_t expand_format(struct strbuf *sb, const char *start, void *vdata)
+static size_t expand_format(struct strbuf *sb, const char *start, void *data)
 {
 	const char *end;
-	struct expand_data *data = vdata;
+	struct ref_array_item *item = data;
 
 	if (*start != '(')
 		return 0;
@@ -210,7 +210,7 @@ static size_t expand_format(struct strbuf *sb, const char *start, void *vdata)
 	if (!end)
 		die("format element '%s' does not end in ')'", start);
 
-	expand_atom(sb, start + 1, end - start - 1, data);
+	expand_atom(sb, start + 1, end - start - 1, item);
 	return end - start + 1;
 }
 
@@ -282,6 +282,7 @@ static void batch_object_write(const char *obj_name, struct batch_options *opt,
 			       struct expand_data *data)
 {
 	struct strbuf buf = STRBUF_INIT;
+	struct ref_array_item item;
 
 	if (!data->skip_object_info &&
 	    sha1_object_info_extended(data->oid.hash, &data->info,
@@ -292,7 +293,14 @@ static void batch_object_write(const char *obj_name, struct batch_options *opt,
 		return;
 	}
 
-	strbuf_expand(&buf, opt->format->format, expand_format, data);
+	item.objectname = data->oid;
+	item.type = data->type;
+	item.size = data->size;
+	item.disk_size = data->disk_size;
+	item.rest = data->rest;
+	item.delta_base_oid = data->delta_base_oid;
+
+	strbuf_expand(&buf, opt->format->format, expand_format, &item);
 	strbuf_addch(&buf, '\n');
 	batch_write(opt, buf.buf, buf.len);
 	strbuf_release(&buf);
diff --git a/ref-filter.h b/ref-filter.h
index 590a60ffe034d..9bd36243481b4 100644
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
+	struct object_id delta_base_oid;
 	char refname[FLEX_ARRAY];
 };
 

--
https://github.com/git/git/pull/450
