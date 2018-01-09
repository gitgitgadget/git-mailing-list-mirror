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
	by dcvr.yhbt.net (Postfix) with ESMTP id EB5471F406
	for <e@80x24.org>; Tue,  9 Jan 2018 13:06:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757232AbeAINGh (ORCPT <rfc822;e@80x24.org>);
        Tue, 9 Jan 2018 08:06:37 -0500
Received: from a7-12.smtp-out.eu-west-1.amazonses.com ([54.240.7.12]:49094
        "EHLO a7-12.smtp-out.eu-west-1.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1756976AbeAINFY (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 9 Jan 2018 08:05:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=shh3fegwg5fppqsuzphvschd53n6ihuv; d=amazonses.com; t=1515503123;
        h=From:To:Message-ID:In-Reply-To:References:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Date:Feedback-ID;
        bh=XTKDFh00CyV8FOpgtoPwuSU+mGnUTJMhqKt629tMyQg=;
        b=XUiCsvht3n/Td/qj/mJAvgbOaXwExm8abrlfLbGUv6i+SDdAqN7Jj8A3E4YbuBMC
        mwI58d94ueOAiXYUjvBQ20J/mZ2eiyAlB65dZRNwY3LmExIe51xrKcxpWQkAUksVI/v
        YlxQh/TaHtsViVw8MkTZQlaKzx8C0Gc7Sj3wudCI=
From:   Olga Telezhnaya <olyatelezhnaya@gmail.com>
To:     git@vger.kernel.org
Message-ID: <01020160db067add-6a32c398-0438-4bd1-8622-d3870adf9167-000000@eu-west-1.amazonses.com>
In-Reply-To: <01020160db0679c9-799a0bc4-b6d1-43e2-ad3b-80be4e4c55e9-000000@eu-west-1.amazonses.com>
References: <01020160db0679c9-799a0bc4-b6d1-43e2-ad3b-80be4e4c55e9-000000@eu-west-1.amazonses.com>
Subject: [PATCH 08/20] cat-file: remove unused code
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Date:   Tue, 9 Jan 2018 13:05:23 +0000
X-SES-Outgoing: 2018.01.09-54.240.7.12
Feedback-ID: 1.eu-west-1.YYPRFFOog89kHDDPKvTu4MK67j4wW0z7cAgZtFqQH58=:AmazonSES
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

No further need in mark_query parameter.
All logic related to expand_atom_into_fields is not needed here also,
we are doing that in ref-filter.

Signed-off-by: Olga Telezhnaia <olyatelezhnaya@gmail.com>
Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored by: Jeff King <peff@peff.net>
---
 builtin/cat-file.c | 25 +------------------------
 ref-filter.h       |  6 ------
 2 files changed, 1 insertion(+), 30 deletions(-)

diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index 0a3f4a47bf1ae..9055fa3a8b0ae 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -182,25 +182,6 @@ static int is_atom(const char *atom, const char *s, int slen)
 	return alen == slen && !memcmp(atom, s, alen);
 }
 
-static void expand_atom_into_fields(struct strbuf *sb, const char *atom, int len,
-			struct expand_data *data)
-{
-	if (is_atom("objectname", atom, len))
-		; /* do nothing */
-	else if (is_atom("objecttype", atom, len))
-		data->info.typep = &data->type;
-	else if (is_atom("objectsize", atom, len))
-		data->info.sizep = &data->size;
-	else if (is_atom("objectsize:disk", atom, len))
-		data->info.disk_sizep = &data->disk_size;
-	else if (is_atom("rest", atom, len))
-		data->split_on_whitespace = 1;
-	else if (is_atom("deltabase", atom, len))
-		data->info.delta_base_sha1 = data->delta_base_oid.hash;
-	else
-		die("unknown format element: %.*s", len, atom);
-}
-
 static void expand_atom(struct strbuf *sb, const char *atom, int len,
 			 struct expand_data *data)
 {
@@ -232,11 +213,7 @@ static size_t expand_format(struct strbuf *sb, const char *start, void *vdata)
 	if (!end)
 		die("format element '%s' does not end in ')'", start);
 
-	if (data->mark_query)
-		expand_atom_into_fields(sb, start + 1, end - start - 1, data);
-	else
-		expand_atom(sb, start + 1, end - start - 1, data);
-
+	expand_atom(sb, start + 1, end - start - 1, data);
 	return end - start + 1;
 }
 
diff --git a/ref-filter.h b/ref-filter.h
index 97169548939cd..590a60ffe034d 100644
--- a/ref-filter.h
+++ b/ref-filter.h
@@ -80,12 +80,6 @@ struct expand_data {
 	const char *rest;
 	struct object_id delta_base_oid;
 
-	/*
-	 * If mark_query is true, we do not expand anything, but rather
-	 * just mark the object_info with items we wish to query.
-	 */
-	int mark_query;
-
 	/*
 	 * Whether to split the input on whitespace before feeding it to
 	 * get_sha1; this is decided during the mark_query phase based on

--
https://github.com/git/git/pull/450
