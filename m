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
	by dcvr.yhbt.net (Postfix) with ESMTP id 488E01F42D
	for <e@80x24.org>; Fri, 18 May 2018 09:11:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753001AbeERITQ (ORCPT <rfc822;e@80x24.org>);
        Fri, 18 May 2018 04:19:16 -0400
Received: from a7-11.smtp-out.eu-west-1.amazonses.com ([54.240.7.11]:41240
        "EHLO a7-11.smtp-out.eu-west-1.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752974AbeERITL (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 18 May 2018 04:19:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=uku4taia5b5tsbglxyj6zym32efj7xqv; d=amazonses.com; t=1526631549;
        h=From:To:Message-ID:In-Reply-To:References:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Date:Feedback-ID;
        bh=GQ4ZBVidgEBhvbpMoehcnFfjtME11H9waszTnruOkn4=;
        b=vqEKEGOwTQpx7hjm/WkZJQEJQ6Ogb1OD6o4DdOtUNGvkiwL3B8gjQ2eDH4ExB1oo
        +mmE8yQP8nkrj7OfCQVNf2+9rJ4dMWelkje/Uc6NDEE2K7jDSyN7NDqiBgcc2XI1hAB
        iXnKdvqxPbUdRAp5fakeDUqUeXD1ls/+yFZwb074=
From:   Olga Telezhnaya <olyatelezhnaya@gmail.com>
To:     git@vger.kernel.org
Message-ID: <010201637254c969-a346030e-0b75-41ad-8ef3-2ac7e04ba4fb-000000@eu-west-1.amazonses.com>
In-Reply-To: <010201635e16d282-89bdd0cd-df10-4509-bad7-fd49fd80ff2b-000000@eu-west-1.amazonses.com>
References: <010201635e16d282-89bdd0cd-df10-4509-bad7-fd49fd80ff2b-000000@eu-west-1.amazonses.com>
Subject: [PATCH RFC v2 1/4] ref-filter: start using oid_object_info
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Date:   Fri, 18 May 2018 08:19:09 +0000
X-SES-Outgoing: 2018.05.18-54.240.7.11
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
 ref-filter.c | 47 +++++++++++++++++++++++++++++++++++++++++++----
 ref-filter.h | 21 +++++++++++++++++++++
 2 files changed, 64 insertions(+), 4 deletions(-)

diff --git a/ref-filter.c b/ref-filter.c
index 39e2744c949bb..4008351553391 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -100,6 +100,7 @@ static struct used_atom {
 	} u;
 } *used_atom;
 static int used_atom_cnt, need_tagged, need_symref;
+static struct expand_data oi_data;
 
 /*
  * Expand string, append it to strbuf *sb, then return error code ret.
@@ -267,6 +268,22 @@ static int contents_atom_parser(const struct ref_format *format, struct used_ato
 	return 0;
 }
 
+static int objecttype_atom_parser(const struct ref_format *format, struct used_atom *atom,
+				  const char *arg, struct strbuf *unused_err)
+{
+	oi_data.use_data = 1;
+	oi_data.info.typep = &oi_data.type;
+	return 0;
+}
+
+static int objectsize_atom_parser(const struct ref_format *format, struct used_atom *atom,
+				  const char *arg, struct strbuf *unused_err)
+{
+	oi_data.use_data = 1;
+	oi_data.info.sizep = &oi_data.size;
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
@@ -1207,7 +1224,8 @@ static void fill_missing_values(struct atom_value *val)
  */
 static void grab_values(struct atom_value *val, int deref, struct object *obj, void *buf, unsigned long sz)
 {
-	grab_common_values(val, deref, obj, buf, sz);
+	if (deref || !oi_data.use_data)
+		grab_common_values(val, deref, obj, buf, sz);
 	switch (obj->type) {
 	case OBJ_TAG:
 		grab_tag_values(val, deref, obj, buf, sz);
@@ -1536,6 +1554,13 @@ static int populate_value(struct ref_array_item *ref, struct strbuf *err)
 			continue;
 		} else if (!deref && grab_objectname(name, &ref->objectname, v, atom)) {
 			continue;
+		} else if (!deref && !strcmp(name, "objecttype") && oi_data.use_data) {
+			v->s = type_name(oi_data.type);
+			continue;
+		} else if (!deref && !strcmp(name, "objectsize") && oi_data.use_data) {
+			v->value = oi_data.size;
+			v->s = xstrfmt("%lu", oi_data.size);
+			continue;
 		} else if (!strcmp(name, "HEAD")) {
 			if (atom->u.head && !strcmp(ref->refname, atom->u.head))
 				v->s = "*";
@@ -2156,8 +2181,17 @@ static int cmp_ref_sorting(struct ref_sorting *s, struct ref_array_item *a, stru
 	int (*cmp_fn)(const char *, const char *);
 	struct strbuf err = STRBUF_INIT;
 
+	oi_data.oid = a->objectname;
+	if (oi_data.use_data &&
+	    oid_object_info_extended(&oi_data.oid, &oi_data.info, OBJECT_INFO_LOOKUP_REPLACE) < 0)
+		die(_("missing object %s for %s"), oid_to_hex(&a->objectname), a->refname);
 	if (get_ref_atom_value(a, s->atom, &va, &err))
 		die("%s", err.buf);
+
+	oi_data.oid = b->objectname;
+	if (oi_data.use_data &&
+	    oid_object_info_extended(&oi_data.oid, &oi_data.info, OBJECT_INFO_LOOKUP_REPLACE) < 0)
+		die(_("missing object %s for %s"), oid_to_hex(&b->objectname), b->refname);
 	if (get_ref_atom_value(b, s->atom, &vb, &err))
 		die("%s", err.buf);
 	strbuf_release(&err);
@@ -2226,6 +2260,11 @@ int format_ref_array_item(struct ref_array_item *info,
 {
 	const char *cp, *sp, *ep;
 	struct ref_formatting_state state = REF_FORMATTING_STATE_INIT;
+	oi_data.oid = info->objectname;
+	if (oi_data.use_data &&
+	    oid_object_info_extended(&oi_data.oid, &oi_data.info, OBJECT_INFO_LOOKUP_REPLACE) < 0)
+		return strbuf_addf_ret(error_buf, -1, _("missing object %s for %s"),
+				       oid_to_hex(&info->objectname), info->refname);
 
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
