Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.5 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD,UNWANTED_LANGUAGE_BODY shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AEC161F404
	for <e@80x24.org>; Fri, 26 Jan 2018 19:44:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751938AbeAZTod (ORCPT <rfc822;e@80x24.org>);
        Fri, 26 Jan 2018 14:44:33 -0500
Received: from a7-12.smtp-out.eu-west-1.amazonses.com ([54.240.7.12]:43856
        "EHLO a7-12.smtp-out.eu-west-1.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751476AbeAZTnl (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 26 Jan 2018 14:43:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=shh3fegwg5fppqsuzphvschd53n6ihuv; d=amazonses.com; t=1516995820;
        h=From:To:Message-ID:In-Reply-To:References:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Date:Feedback-ID;
        bh=f9Tsn4/MFWUi21dTWBkwCwUdFBo7X4ktxBd8LILWFGI=;
        b=LGDaRor9B33m17XIZF5aXpGUnUQ9XkTMueorvUFR5xycYJLLkAEcuzLxmJv8YL62
        XhaDw7y8ZLC6vfFEiyn6lN9pIgmHlPOxTbPWb6LTVPeKX8zqEfQ7/xtBLM9eQMLjd47
        88GE/wMU3SpdTrwCjPXBcfqR+F2Y9hPzPWyyuk0c=
From:   Olga Telezhnaya <olyatelezhnaya@gmail.com>
To:     git@vger.kernel.org
Message-ID: <0102016133ff3b0a-d7e5bf0c-4d99-41e4-882b-47a875c528fb-000000@eu-west-1.amazonses.com>
In-Reply-To: <0102016133ff3a86-44d354ec-13c6-4c38-bc75-1ba4422db5a7-000000@eu-west-1.amazonses.com>
References: <0102016133ff3a86-44d354ec-13c6-4c38-bc75-1ba4422db5a7-000000@eu-west-1.amazonses.com>
Subject: [PATCH RFC 07/24] cat-file: start migrating to ref-filter
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Date:   Fri, 26 Jan 2018 19:43:40 +0000
X-SES-Outgoing: 2018.01.26-54.240.7.12
Feedback-ID: 1.eu-west-1.YYPRFFOog89kHDDPKvTu4MK67j4wW0z7cAgZtFqQH58=:AmazonSES
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Start moving formatting stuff related to data preparation
from cat-file to ref-filter.
Start from simple moving, it would be integrated into
all ref-filter processes further.

Signed-off-by: Olga Telezhnaia <olyatelezhnaya@gmail.com>
Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored by: Jeff King <peff@peff.net>
---
 builtin/cat-file.c | 32 +++-----------------------------
 ref-filter.c       | 41 ++++++++++++++++++++++++++++++++++++-----
 ref-filter.h       | 12 ++++++------
 3 files changed, 45 insertions(+), 40 deletions(-)

diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index 490d9f8a8a922..909412747cbd2 100644
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
@@ -217,8 +198,6 @@ static void expand_atom(struct strbuf *sb, const char *atom, int len,
 			strbuf_addstr(sb, data->rest);
 	} else if (is_atom("deltabase", atom, len))
 		strbuf_addstr(sb, oid_to_hex(&data->delta_base_oid));
-	else
-		die("unknown format element: %.*s", len, atom);
 }
 
 static size_t expand_format(struct strbuf *sb, const char *start, void *vdata)
@@ -232,11 +211,7 @@ static size_t expand_format(struct strbuf *sb, const char *start, void *vdata)
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
 
@@ -420,9 +395,8 @@ static int batch_objects(struct batch_options *opt)
 	 * object.
 	 */
 	memset(&data, 0, sizeof(data));
-	data.mark_query = 1;
-	strbuf_expand(&buf, opt->format.format, expand_format, &data);
-	data.mark_query = 0;
+	opt->format.cat_file_data = &data;
+	verify_ref_format(&opt->format);
 	if (opt->cmdmode)
 		data.split_on_whitespace = 1;
 
diff --git a/ref-filter.c b/ref-filter.c
index ee2aa7d6d072b..8e384b2818b22 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -392,6 +392,31 @@ struct atom_value {
 	struct used_atom *atom;
 };
 
+static int is_atom(const char *atom, const char *s, int slen)
+{
+	int alen = strlen(atom);
+	return alen == slen && !memcmp(atom, s, alen);
+}
+
+static void expand_atom_into_fields(const char *atom, int len,
+				    struct expand_data *data)
+{
+	if (is_atom("objectname", atom, len))
+		; /* do nothing */
+	else if (is_atom("objecttype", atom, len))
+		data->info.typep = &data->type;
+	else if (is_atom("objectsize", atom, len))
+		data->info.sizep = &data->size;
+	else if (is_atom("objectsize:disk", atom, len))
+		data->info.disk_sizep = &data->disk_size;
+	else if (is_atom("rest", atom, len))
+		data->split_on_whitespace = 1;
+	else if (is_atom("deltabase", atom, len))
+		data->info.delta_base_sha1 = data->delta_base_oid.hash;
+	else
+		die("unknown format element: %.*s", len, atom);
+}
+
 /*
  * Used to parse format string and sort specifiers
  */
@@ -709,12 +734,18 @@ int verify_ref_format(struct ref_format *format)
 		if (!ep)
 			return error(_("malformed format string %s"), sp);
 		/* sp points at "%(" and ep points at the closing ")" */
-		at = parse_ref_filter_atom(format, valid_atom,
-					   ARRAY_SIZE(valid_atom), sp + 2, ep);
-		cp = ep + 1;
 
-		if (skip_prefix(used_atom[at].name, "color:", &color))
-			format->need_color_reset_at_eol = !!strcmp(color, "reset");
+		if (format->cat_file_data)
+			expand_atom_into_fields(sp + 2, ep - sp - 2,
+						format->cat_file_data);
+		else {
+			at = parse_ref_filter_atom(format, valid_atom,
+						   ARRAY_SIZE(valid_atom), sp + 2, ep);
+			if (skip_prefix(used_atom[at].name, "color:", &color))
+				format->need_color_reset_at_eol = !!strcmp(color, "reset");
+		}
+
+		cp = ep + 1;
 	}
 	if (format->need_color_reset_at_eol && !want_color(format->use_color))
 		format->need_color_reset_at_eol = 0;
diff --git a/ref-filter.h b/ref-filter.h
index 56093a85d52b8..b50c8e6aaf2c4 100644
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
@@ -119,6 +113,12 @@ struct ref_format {
 
 	/* Internal state to ref-filter */
 	int need_color_reset_at_eol;
+
+	/*
+	 * Helps to move all formatting logic from cat-file to ref-filter,
+	 * hopefully would be reduced later.
+	 */
+	struct expand_data *cat_file_data;
 };
 
 #define REF_FORMAT_INIT { NULL, 0, -1 }

--
https://github.com/git/git/pull/452
