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
	by dcvr.yhbt.net (Postfix) with ESMTP id 869F11F576
	for <e@80x24.org>; Mon, 12 Feb 2018 08:09:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933025AbeBLIJN (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Feb 2018 03:09:13 -0500
Received: from a7-18.smtp-out.eu-west-1.amazonses.com ([54.240.7.18]:46182
        "EHLO a7-18.smtp-out.eu-west-1.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932996AbeBLII4 (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 12 Feb 2018 03:08:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=shh3fegwg5fppqsuzphvschd53n6ihuv; d=amazonses.com; t=1518422934;
        h=From:To:Message-ID:In-Reply-To:References:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Date:Feedback-ID;
        bh=lt8d9hFohFO6njdd8UJ67xDSNy9ux50MR2wapR0zOJU=;
        b=M8NDtYgeAh9QNUmnItqyF71wcnKIwBxmJPe0OBAktNfaMVUJlBz2xIlOXycoNbov
        Hg8U+EkPnG5n/Z3t7f41NwlZyyvV23w0SWd1TY0IjeHyjytT0qyJPtuQ3BCdfmc1TWa
        clOOszeJ0uVJv0FIAaJV+FBjmxLGVlHoPXDJtYRc=
From:   Olga Telezhnaya <olyatelezhnaya@gmail.com>
To:     git@vger.kernel.org
Message-ID: <01020161890f4348-10a54126-e31d-448d-93a3-55fd89c248c4-000000@eu-west-1.amazonses.com>
In-Reply-To: <01020161890f4236-47989eb4-c19f-4282-9084-9d4f90c2ebeb-000000@eu-west-1.amazonses.com>
References: <01020161890f4236-47989eb4-c19f-4282-9084-9d4f90c2ebeb-000000@eu-west-1.amazonses.com>
Subject: [PATCH v3 07/23] cat-file: start migrating formatting to ref-filter
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Date:   Mon, 12 Feb 2018 08:08:54 +0000
X-SES-Outgoing: 2018.02.12-54.240.7.18
Feedback-ID: 1.eu-west-1.YYPRFFOog89kHDDPKvTu4MK67j4wW0z7cAgZtFqQH58=:AmazonSES
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Move mark_atom_in_object_info() from cat-file to ref-filter and
start using it in verify_ref_format().
It also means that we start reusing verify_ref_format() in cat-file.

Start from simple moving of mark_atom_in_object_info(),
it would be removed later by integrating all needed processes into
ref-filter logic.

Signed-off-by: Olga Telezhnaia <olyatelezhnaya@gmail.com>
Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored by: Jeff King <peff@peff.net>
---
 builtin/cat-file.c | 35 +++++------------------------------
 ref-filter.c       | 41 ++++++++++++++++++++++++++++++++++++-----
 ref-filter.h       | 12 ++++++------
 3 files changed, 47 insertions(+), 41 deletions(-)

diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index edb04a96d9bd3..67e7790d2f319 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -182,25 +182,6 @@ static int is_atom(const char *atom, const char *s, int slen)
 	return alen == slen && !memcmp(atom, s, alen);
 }
 
-static void mark_atom_in_object_info(const char *atom, int len,
-				     struct expand_data *data)
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
@@ -230,11 +211,7 @@ static size_t expand_format(struct strbuf *sb, const char *start, void *vdata)
 	if (!end)
 		die("format element '%s' does not end in ')'", start);
 
-	if (data->mark_query)
-		mark_atom_in_object_info(start + 1, end - start - 1, data);
-	else
-		expand_atom(sb, start + 1, end - start - 1, data);
-
+	expand_atom(sb, start + 1, end - start - 1, data);
 	return end - start + 1;
 }
 
@@ -413,14 +390,12 @@ static int batch_objects(struct batch_options *opt)
 		opt->format.format = "%(objectname) %(objecttype) %(objectsize)";
 
 	/*
-	 * Expand once with our special mark_query flag, which will prime the
-	 * object_info to be handed to sha1_object_info_extended for each
-	 * object.
+	 * Call verify_ref_format to prepare object_info to be handed to
+	 * sha1_object_info_extended for each object.
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
index 5e7ed0f338490..ff87e632f463c 100644
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
+static void mark_atom_in_object_info(const char *atom, int len,
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
+			mark_atom_in_object_info(sp + 2, ep - sp - 2,
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
index 17f2ac24d2739..52e07dbe6864a 100644
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
