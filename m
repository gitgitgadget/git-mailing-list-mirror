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
	by dcvr.yhbt.net (Postfix) with ESMTP id 0A08720248
	for <e@80x24.org>; Fri, 22 Feb 2019 16:05:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727313AbfBVQFu (ORCPT <rfc822;e@80x24.org>);
        Fri, 22 Feb 2019 11:05:50 -0500
Received: from a7-18.smtp-out.eu-west-1.amazonses.com ([54.240.7.18]:44896
        "EHLO a7-18.smtp-out.eu-west-1.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727196AbfBVQFs (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 22 Feb 2019 11:05:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=uku4taia5b5tsbglxyj6zym32efj7xqv; d=amazonses.com; t=1550851545;
        h=From:To:Message-ID:In-Reply-To:References:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Date:Feedback-ID;
        bh=3fYIMeYyY85cRkCc9W47QCD7qpgLl13vZMOdPBD3upE=;
        b=dC+x5S+Av3gCHEKQNqcjv+S33hfXB50+kIcFLufNRj8pdZsyjUhbxb633jcBglVK
        jR2xyk01h0lZ2u+2uQb/VwNE0DYselLf8o7b1FCtZO5UVg3LOHo7Itjd4Xa0oFfemX9
        1BGLIAahHEXJX5dBYexWEznOIeVNaubVJsGOrVS4=
From:   Olga Telezhnaya <olyatelezhnaya@gmail.com>
To:     git@vger.kernel.org
Message-ID: <0102016915f49a54-e28b7a40-d51c-4dd4-85a3-0eea83d4f0cb-000000@eu-west-1.amazonses.com>
In-Reply-To: <0102016915f499b8-5813fc52-230b-469e-b939-a1244e83a2b9-000000@eu-west-1.amazonses.com>
References: <0102016915f499b8-5813fc52-230b-469e-b939-a1244e83a2b9-000000@eu-west-1.amazonses.com>
Subject: [PATCH RFC 08/20] cat-file: remove rest from expand_data
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Date:   Fri, 22 Feb 2019 16:05:45 +0000
X-SES-Outgoing: 2019.02.22-54.240.7.18
Feedback-ID: 1.eu-west-1.YYPRFFOog89kHDDPKvTu4MK67j4wW0z7cAgZtFqQH58=:AmazonSES
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Get rid of rest field in struct expand_data.
expand_data may be global further as we use it in ref-filter also,
so we need to remove cat-file specific fields from it.

All globals that I add through this patch will be deleted in the end,
so treat it just as the middle step.

Signed-off-by: Olga Telezhnaia <olyatelezhnaya@gmail.com>
---
 builtin/cat-file.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index f6470380f55b3..e52646c0e6b5b 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -29,9 +29,10 @@ struct batch_options {
 };
 
 static const char *force_path;
-/* Next 2 vars will be deleted at the end of this patch */
+/* Next 3 vars will be deleted at the end of this patch */
 static int mark_query;
 static int skip_object_info;
+static const char *rest;
 
 static int filter_object(const char *path, unsigned mode,
 			 const struct object_id *oid,
@@ -197,7 +198,6 @@ struct expand_data {
 	enum object_type type;
 	unsigned long size;
 	off_t disk_size;
-	const char *rest;
 	struct object_id delta_base_oid;
 
 	/*
@@ -238,8 +238,8 @@ static void expand_atom(struct strbuf *sb, const char *atom, int len,
 		else
 			strbuf_addf(sb, "%"PRIuMAX, (uintmax_t)data->disk_size);
 	} else if (is_atom("rest", atom, len)) {
-		if (data->rest)
-			strbuf_addstr(sb, data->rest);
+		if (rest)
+			strbuf_addstr(sb, rest);
 	} else if (is_atom("deltabase", atom, len)) {
 		if (mark_query)
 			data->info.delta_base_sha1 = data->delta_base_oid.hash;
@@ -287,25 +287,25 @@ static void print_object_or_die(struct batch_options *opt, struct expand_data *d
 			char *contents;
 			unsigned long size;
 
-			if (!data->rest)
+			if (!rest)
 				die("missing path for '%s'", oid_to_hex(oid));
 
 			if (opt->cmdmode == 'w') {
-				if (filter_object(data->rest, 0100644, oid,
+				if (filter_object(rest, 0100644, oid,
 						  &contents, &size))
 					die("could not convert '%s' %s",
-					    oid_to_hex(oid), data->rest);
+					    oid_to_hex(oid), rest);
 			} else if (opt->cmdmode == 'c') {
 				enum object_type type;
 				if (!textconv_object(the_repository,
-						     data->rest, 0100644, oid,
+						     rest, 0100644, oid,
 						     1, &contents, &size))
 					contents = read_object_file(oid,
 								    &type,
 								    &size);
 				if (!contents)
 					die("could not convert '%s' %s",
-					    oid_to_hex(oid), data->rest);
+					    oid_to_hex(oid), rest);
 			} else
 				BUG("invalid cmdmode: %c", opt->cmdmode);
 			batch_write(opt, contents, size);
@@ -555,7 +555,7 @@ static int batch_objects(struct batch_options *opt)
 				while (*p && strchr(" \t", *p))
 					*p++ = '\0';
 			}
-			data.rest = p;
+			rest = p;
 		}
 
 		batch_one_object(input.buf, &output, opt, &data);

--
https://github.com/git/git/pull/568
