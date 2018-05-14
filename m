Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 15A681F42D
	for <e@80x24.org>; Mon, 14 May 2018 09:59:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752038AbeENJ7G (ORCPT <rfc822;e@80x24.org>);
        Mon, 14 May 2018 05:59:06 -0400
Received: from a7-11.smtp-out.eu-west-1.amazonses.com ([54.240.7.11]:54122
        "EHLO a7-11.smtp-out.eu-west-1.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751219AbeENJ7F (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 14 May 2018 05:59:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=uku4taia5b5tsbglxyj6zym32efj7xqv; d=amazonses.com; t=1526291944;
        h=From:To:Message-ID:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Date:Feedback-ID;
        bh=8BjJjqNkl/Fw+qxtKwIaEJbLmWGm6kbSk87J103XQgw=;
        b=akqI5xKvY2qYyIu0SWpx+kGQbvng/0x0pSkChvbuCH/VcVzPz0hhnAarNXKA8Brt
        MOZ537WI5EiIEWbHXK66EI/pmbSgwthHiLEbXEgQ/UBJG/Uhqfw6eawlGfJq4HOo9m9
        M2SNxA28rp1eMjFpaCw5BkVuDSbEbK+ylEBuxCmw=
From:   Olga Telezhnaya <olyatelezhnaya@gmail.com>
To:     git@vger.kernel.org
Message-ID: <010201635e16d282-89bdd0cd-df10-4509-bad7-fd49fd80ff2b-000000@eu-west-1.amazonses.com>
Subject: [PATCH RFC] ref-filter: start using oid_object_info
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Date:   Mon, 14 May 2018 09:59:04 +0000
X-SES-Outgoing: 2018.05.14-54.240.7.11
Feedback-ID: 1.eu-west-1.YYPRFFOog89kHDDPKvTu4MK67j4wW0z7cAgZtFqQH58=:AmazonSES
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Start using oid_object_info_extended(). So, if info from this function
is enough, we do not need to get and parse whole object (as it was before).
It's good for 3 reasons:
1. Some Git commands potentially will work faster.
2. It's much easier to add support for objectsize:disk and deltabase.
   (I have plans to add this support further)
3. It's easier to move formatting from cat-file command to this logic
   (It pretends to be unified formatting logic in the end)

Signed-off-by: Olga Telezhnaia <olyatelezhnaya@gmail.com>
---
 ref-filter.c | 34 +++++++++++++++++++++++++++++++---
 ref-filter.h | 21 +++++++++++++++++++++
 2 files changed, 52 insertions(+), 3 deletions(-)

diff --git a/ref-filter.c b/ref-filter.c
index 39e2744c949bb..7c4693ed084bb 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -100,6 +100,7 @@ static struct used_atom {
 	} u;
 } *used_atom;
 static int used_atom_cnt, need_tagged, need_symref;
+static struct expand_data format_data;
 
 /*
  * Expand string, append it to strbuf *sb, then return error code ret.
@@ -267,6 +268,22 @@ static int contents_atom_parser(const struct ref_format *format, struct used_ato
 	return 0;
 }
 
+static int objecttype_atom_parser(const struct ref_format *format, struct used_atom *atom,
+				  const char *arg, struct strbuf *unused_err)
+{
+	format_data.use_data = 1;
+	format_data.info.typep = &format_data.type;
+	return 0;
+}
+
+static int objectsize_atom_parser(const struct ref_format *format, struct used_atom *atom,
+				  const char *arg, struct strbuf *unused_err)
+{
+	format_data.use_data = 1;
+	format_data.info.sizep = &format_data.size;
+	return 0;
+}
+
 static int objectname_atom_parser(const struct ref_format *format, struct used_atom *atom,
 				  const char *arg, struct strbuf *err)
 {
@@ -383,9 +400,9 @@ static struct {
 	int (*parser)(const struct ref_format *format, struct used_atom *atom,
 		      const char *arg, struct strbuf *err);
 } valid_atom[] = {
-	{ "refname" , FIELD_STR, refname_atom_parser },
-	{ "objecttype" },
-	{ "objectsize", FIELD_ULONG },
+	{ "refname", FIELD_STR, refname_atom_parser },
+	{ "objecttype", FIELD_STR, objecttype_atom_parser },
+	{ "objectsize", FIELD_ULONG, objectsize_atom_parser },
 	{ "objectname", FIELD_STR, objectname_atom_parser },
 	{ "tree" },
 	{ "parent" },
@@ -1536,6 +1553,13 @@ static int populate_value(struct ref_array_item *ref, struct strbuf *err)
 			continue;
 		} else if (!deref && grab_objectname(name, &ref->objectname, v, atom)) {
 			continue;
+		} else if (!deref && !strcmp(name, "objecttype")) {
+			v->s = type_name(format_data.type);
+			continue;
+		} else if (!deref && !strcmp(name, "objectsize")) {
+			v->value = format_data.size;
+			v->s = xstrfmt("%lu", format_data.size);
+			continue;
 		} else if (!strcmp(name, "HEAD")) {
 			if (atom->u.head && !strcmp(ref->refname, atom->u.head))
 				v->s = "*";
@@ -2226,6 +2250,10 @@ int format_ref_array_item(struct ref_array_item *info,
 {
 	const char *cp, *sp, *ep;
 	struct ref_formatting_state state = REF_FORMATTING_STATE_INIT;
+	format_data.oid = info->objectname;
+	if (format_data.use_data && oid_object_info_extended(&format_data.oid, &format_data.info,
+							     OBJECT_INFO_LOOKUP_REPLACE) < 0)
+		return strbuf_addf_ret(error_buf, -1, "format: could not get object info");
 
 	state.quote_style = format->quote_style;
 	push_stack_element(&state.stack);
diff --git a/ref-filter.h b/ref-filter.h
index 85c8ebc3b904e..857e8c5318a8f 100644
--- a/ref-filter.h
+++ b/ref-filter.h
@@ -85,6 +85,27 @@ struct ref_format {
 	int need_color_reset_at_eol;
 };
 
+struct expand_data {
+	struct object_id oid;
+	enum object_type type;
+	unsigned long size;
+	off_t disk_size;
+	struct object_id delta_base_oid;
+
+	/*
+	 * This object_info is set up to be passed to oid_object_info_extended.
+	 * It will point to the data elements above, so you can retrieve
+	 * the response from there.
+	 */
+	struct object_info info;
+
+	/*
+	 * This flag will be true if the requested format and options
+	 * require us to call oid_object_info_extended.
+	 */
+	unsigned use_data : 1;
+};
+
 #define REF_FORMAT_INIT { NULL, 0, -1 }
 
 /*  Macros for checking --merged and --no-merged options */

--
https://github.com/git/git/pull/493
