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
	by dcvr.yhbt.net (Postfix) with ESMTP id CF8421F576
	for <e@80x24.org>; Mon,  5 Feb 2018 11:28:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753013AbeBEL2c (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Feb 2018 06:28:32 -0500
Received: from a7-18.smtp-out.eu-west-1.amazonses.com ([54.240.7.18]:41058
        "EHLO a7-18.smtp-out.eu-west-1.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752787AbeBEL1k (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 5 Feb 2018 06:27:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=shh3fegwg5fppqsuzphvschd53n6ihuv; d=amazonses.com; t=1517830059;
        h=From:To:Message-ID:In-Reply-To:References:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Date:Feedback-ID;
        bh=co4ovW8rShdVKG/tB72HWAfc6/zM86b3TQXjCB+CTA8=;
        b=eQTFtHvoI2rYWd1EAG3lqj0J+v1tKZeGDnGmBRUrWXYxYXWsRWIKssHp6guBsrgm
        0PZ3DliSXc3K5tRZ/AeiuUssdjhfMKeRa4IbJriO+F1w2hHzhItelcCqnoWYnLjHfMN
        CL1WufMj8E3A6nvRBSzpE0LqynRFjHt0735fat1M=
From:   Olga Telezhnaya <olyatelezhnaya@gmail.com>
To:     git@vger.kernel.org
Message-ID: <0102016165b8b44c-a6d5c188-a9f2-4c5a-8cfb-6094af8f0163-000000@eu-west-1.amazonses.com>
In-Reply-To: <0102016165b8b3c4-54efe4c4-6d19-435d-b5b9-6c727771353b-000000@eu-west-1.amazonses.com>
References: <0102016165b8b3c4-54efe4c4-6d19-435d-b5b9-6c727771353b-000000@eu-west-1.amazonses.com>
Subject: [PATCH RFC v2 14/25] ref-filter: add is_cat flag
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Date:   Mon, 5 Feb 2018 11:27:39 +0000
X-SES-Outgoing: 2018.02.05-54.240.7.18
Feedback-ID: 1.eu-west-1.YYPRFFOog89kHDDPKvTu4MK67j4wW0z7cAgZtFqQH58=:AmazonSES
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add is_cat flag, further it helps to get rid of cat_file_data field
in ref_format.

Signed-off-by: Olga Telezhnaia <olyatelezhnaya@gmail.com>
Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored by: Jeff King <peff@peff.net>
---
 builtin/cat-file.c | 1 +
 ref-filter.c       | 8 +++++---
 ref-filter.h       | 1 +
 3 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index 179c955b86bd5..e8e788f41b890 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -395,6 +395,7 @@ static int batch_objects(struct batch_options *opt)
 	 */
 	memset(&data, 0, sizeof(data));
 	opt->format.cat_file_data = &data;
+	opt->format.is_cat = 1;
 	verify_ref_format(&opt->format);
 	if (opt->cmdmode)
 		data.split_on_whitespace = 1;
diff --git a/ref-filter.c b/ref-filter.c
index 34a54db168265..91290b62450b3 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -101,6 +101,7 @@ static struct used_atom {
 } *used_atom;
 static int used_atom_cnt, need_tagged, need_symref;
 struct expand_data *cat_file_info;
+static int is_cat = 0;
 
 static void color_atom_parser(const struct ref_format *format, struct used_atom *atom, const char *color_value)
 {
@@ -493,7 +494,7 @@ static int parse_ref_filter_atom(const struct ref_format *format,
 		need_tagged = 1;
 	if (!strcmp(valid_atom[i].name, "symref"))
 		need_symref = 1;
-	if (cat_file_info && !strcmp(valid_atom[i].name, "rest"))
+	if (is_cat && !strcmp(valid_atom[i].name, "rest"))
 		cat_file_info->split_on_whitespace = 1;
 	return at;
 }
@@ -739,6 +740,7 @@ int verify_ref_format(struct ref_format *format)
 	const char *cp, *sp;
 
 	cat_file_info = format->cat_file_data;
+	is_cat = format->is_cat;
 	format->need_color_reset_at_eol = 0;
 	for (cp = format->format; *cp && (sp = find_next(cp)); ) {
 		const char *color, *ep = strchr(sp, ')');
@@ -748,7 +750,7 @@ int verify_ref_format(struct ref_format *format)
 			return error(_("malformed format string %s"), sp);
 		/* sp points at "%(" and ep points at the closing ")" */
 
-		if (format->cat_file_data)
+		if (is_cat)
 			at = parse_ref_filter_atom(format, valid_cat_file_atom,
 						   ARRAY_SIZE(valid_cat_file_atom), sp + 2, ep);
 		else {
@@ -1438,7 +1440,7 @@ int populate_value(struct ref_array_item *ref)
 			ref->symref = "";
 	}
 
-	if (cat_file_info && check_and_fill_for_cat(ref))
+	if (is_cat && check_and_fill_for_cat(ref))
 		return -1;
 
 	/* Fill in specials first */
diff --git a/ref-filter.h b/ref-filter.h
index 5c6e019998716..69271e8c39f40 100644
--- a/ref-filter.h
+++ b/ref-filter.h
@@ -125,6 +125,7 @@ struct ref_format {
 	 * hopefully would be reduced later.
 	 */
 	struct expand_data *cat_file_data;
+	int is_cat;
 };
 
 #define REF_FORMAT_INIT { NULL, 0, -1 }

--
https://github.com/git/git/pull/452
