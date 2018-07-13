Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2CEFE1F85E
	for <e@80x24.org>; Fri, 13 Jul 2018 12:44:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729699AbeGMM63 (ORCPT <rfc822;e@80x24.org>);
        Fri, 13 Jul 2018 08:58:29 -0400
Received: from a7-20.smtp-out.eu-west-1.amazonses.com ([54.240.7.20]:34164
        "EHLO a7-20.smtp-out.eu-west-1.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729632AbeGMM63 (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 13 Jul 2018 08:58:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=uku4taia5b5tsbglxyj6zym32efj7xqv; d=amazonses.com; t=1531485836;
        h=From:To:Message-ID:In-Reply-To:References:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Date:Feedback-ID;
        bh=mLlfQ6zIXwtgghjidZIbnsN+4Rfqj9OZJaRF+U1vg7Y=;
        b=X/VX5Itv16VMELjd4u6DkmTYL9CGHJ1yfS2eh3+JQ5os8wpP5u0ZOSfOkBZ4L1LA
        JXFaQtwEXjUHaaoccQhpxh9GdZVO3TaYrby1ligqEuWfNrRQpBI9TW7AB370FqQQx05
        STw76+r6ZiUKyDTKfMHQ98r1z9QYFQJ/6hQ4x7zc=
From:   Olga Telezhnaya <olyatelezhnaya@gmail.com>
To:     git@vger.kernel.org
Message-ID: <0102016493ab542d-ea2a3e8c-d6a0-44ca-8fc6-f940fe7e84cd-000000@eu-west-1.amazonses.com>
In-Reply-To: <0102016493ab5347-c0429041-6e66-4550-894c-2d500cb2ed8e-000000@eu-west-1.amazonses.com>
References: <0102016493ab5347-c0429041-6e66-4550-894c-2d500cb2ed8e-000000@eu-west-1.amazonses.com>
Subject: [PATCH v2 4/4] ref-filter: use oid_object_info() to get object
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Date:   Fri, 13 Jul 2018 12:43:56 +0000
X-SES-Outgoing: 2018.07.13-54.240.7.20
Feedback-ID: 1.eu-west-1.YYPRFFOog89kHDDPKvTu4MK67j4wW0z7cAgZtFqQH58=:AmazonSES
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Use oid_object_info_extended() to get object info instead of
read_object_file().
It will help to handle some requests faster (e.g., we do not need to
parse whole object if we need to know %(objectsize)).
It could also help us to add new atoms such as %(objectsize:disk)
and %(deltabase).

Signed-off-by: Olga Telezhnaia <olyatelezhnaya@gmail.com>
---
 ref-filter.c | 123 ++++++++++++++++++++++++++++++++++++++++++-----------------
 1 file changed, 89 insertions(+), 34 deletions(-)

diff --git a/ref-filter.c b/ref-filter.c
index f04169f0ea0e3..112955f006648 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -61,6 +61,17 @@ struct refname_atom {
 	int lstrip, rstrip;
 };
 
+static struct expand_data {
+	struct object_id oid;
+	enum object_type type;
+	unsigned long size;
+	off_t disk_size;
+	struct object_id delta_base_oid;
+	void *content;
+
+	struct object_info info;
+} oi, oi_deref;
+
 /*
  * An atom is a valid field atom listed below, possibly prefixed with
  * a "*" to denote deref_tag().
@@ -202,6 +213,30 @@ static int remote_ref_atom_parser(const struct ref_format *format, struct used_a
 	return 0;
 }
 
+static int objecttype_atom_parser(const struct ref_format *format, struct used_atom *atom,
+				  const char *arg, struct strbuf *err)
+{
+	if (arg)
+		return strbuf_addf_ret(err, -1, _("%%(objecttype) does not take arguments"));
+	if (*atom->name == '*')
+		oi_deref.info.typep = &oi_deref.type;
+	else
+		oi.info.typep = &oi.type;
+	return 0;
+}
+
+static int objectsize_atom_parser(const struct ref_format *format, struct used_atom *atom,
+				  const char *arg, struct strbuf *err)
+{
+	if (arg)
+		return strbuf_addf_ret(err, -1, _("%%(objectsize) does not take arguments"));
+	if (*atom->name == '*')
+		oi_deref.info.sizep = &oi_deref.size;
+	else
+		oi.info.sizep = &oi.size;
+	return 0;
+}
+
 static int body_atom_parser(const struct ref_format *format, struct used_atom *atom,
 			    const char *arg, struct strbuf *err)
 {
@@ -388,8 +423,8 @@ static struct {
 		      const char *arg, struct strbuf *err);
 } valid_atom[] = {
 	{ "refname", SOURCE_NONE, FIELD_STR, refname_atom_parser },
-	{ "objecttype", SOURCE_OTHER },
-	{ "objectsize", SOURCE_OTHER, FIELD_ULONG },
+	{ "objecttype", SOURCE_OTHER, FIELD_STR, objecttype_atom_parser },
+	{ "objectsize", SOURCE_OTHER, FIELD_ULONG, objectsize_atom_parser },
 	{ "objectname", SOURCE_OTHER, FIELD_STR, objectname_atom_parser },
 	{ "tree", SOURCE_OBJ },
 	{ "parent", SOURCE_OBJ },
@@ -502,6 +537,12 @@ static int parse_ref_filter_atom(const struct ref_format *format,
 	used_atom[at].name = xmemdupz(atom, ep - atom);
 	used_atom[at].type = valid_atom[i].cmp_type;
 	used_atom[at].source = valid_atom[i].source;
+	if (used_atom[at].source == SOURCE_OBJ) {
+		if (*atom == '*')
+			oi_deref.info.contentp = &oi_deref.content;
+		else
+			oi.info.contentp = &oi.content;
+	}
 	if (arg) {
 		arg = used_atom[at].name + (arg - atom) + 1;
 		if (!*arg) {
@@ -817,7 +858,7 @@ static int grab_objectname(const char *name, const struct object_id *oid,
 }
 
 /* See grab_values */
-static void grab_common_values(struct atom_value *val, int deref, struct object *obj, void *buf, unsigned long sz)
+static void grab_common_values(struct atom_value *val, int deref, struct expand_data *oi)
 {
 	int i;
 
@@ -829,13 +870,13 @@ static void grab_common_values(struct atom_value *val, int deref, struct object
 		if (deref)
 			name++;
 		if (!strcmp(name, "objecttype"))
-			v->s = type_name(obj->type);
+			v->s = type_name(oi->type);
 		else if (!strcmp(name, "objectsize")) {
-			v->value = sz;
-			v->s = xstrfmt("%lu", sz);
+			v->value = oi->size;
+			v->s = xstrfmt("%lu", oi->size);
 		}
 		else if (deref)
-			grab_objectname(name, &obj->oid, v, &used_atom[i]);
+			grab_objectname(name, &oi->oid, v, &used_atom[i]);
 	}
 }
 
@@ -1194,7 +1235,6 @@ static void fill_missing_values(struct atom_value *val)
  */
 static void grab_values(struct atom_value *val, int deref, struct object *obj, void *buf, unsigned long sz)
 {
-	grab_common_values(val, deref, obj, buf, sz);
 	switch (obj->type) {
 	case OBJ_TAG:
 		grab_tag_values(val, deref, obj, buf, sz);
@@ -1418,28 +1458,36 @@ static const char *get_refname(struct used_atom *atom, struct ref_array_item *re
 	return show_ref(&atom->u.refname, ref->refname);
 }
 
-static int get_object(struct ref_array_item *ref, const struct object_id *oid,
-		      int deref, struct object **obj, struct strbuf *err)
+static int get_object(struct ref_array_item *ref, int deref, struct object **obj,
+		      struct expand_data *oi, struct strbuf *err)
 {
-	int eaten;
-	int ret = 0;
-	unsigned long size;
-	enum object_type type;
-	void *buf = read_object_file(oid, &type, &size);
-	if (!buf)
-		ret = strbuf_addf_ret(err, -1, _("missing object %s for %s"),
-				      oid_to_hex(oid), ref->refname);
-	else {
-		*obj = parse_object_buffer(oid, type, size, buf, &eaten);
-		if (!*obj)
-			ret = strbuf_addf_ret(err, -1, _("parse_object_buffer failed on %s for %s"),
-					      oid_to_hex(oid), ref->refname);
-		else
-			grab_values(ref->value, deref, *obj, buf, size);
+	/* parse_object_buffer() will set eaten to 0 if free() will be needed */
+	int eaten = 1;
+	if (oi->info.contentp) {
+		/* We need to know that to use parse_object_buffer properly */
+		oi->info.sizep = &oi->size;
+		oi->info.typep = &oi->type;
 	}
+	if (oid_object_info_extended(the_repository, &oi->oid, &oi->info,
+				     OBJECT_INFO_LOOKUP_REPLACE))
+		return strbuf_addf_ret(err, -1, _("missing object %s for %s"),
+				       oid_to_hex(&oi->oid), ref->refname);
+
+	if (oi->info.contentp) {
+		*obj = parse_object_buffer(&oi->oid, oi->type, oi->size, oi->content, &eaten);
+		if (!obj) {
+			if (!eaten)
+				free(oi->content);
+			return strbuf_addf_ret(err, -1, _("parse_object_buffer failed on %s for %s"),
+					       oid_to_hex(&oi->oid), ref->refname);
+		}
+		grab_values(ref->value, deref, *obj, oi->content, oi->size);
+	}
+
+	grab_common_values(ref->value, deref, oi);
 	if (!eaten)
-		free(buf);
-	return ret;
+		free(oi->content);
+	return 0;
 }
 
 /*
@@ -1449,7 +1497,7 @@ static int populate_value(struct ref_array_item *ref, struct strbuf *err)
 {
 	struct object *obj;
 	int i;
-	const struct object_id *tagged;
+	struct object_info empty = OBJECT_INFO_INIT;
 
 	ref->value = xcalloc(used_atom_cnt, sizeof(struct atom_value));
 
@@ -1569,13 +1617,20 @@ static int populate_value(struct ref_array_item *ref, struct strbuf *err)
 
 	for (i = 0; i < used_atom_cnt; i++) {
 		struct atom_value *v = &ref->value[i];
-		if (v->s == NULL)
-			break;
+		if (v->s == NULL && used_atom[i].source == SOURCE_NONE)
+			return strbuf_addf_ret(err, -1, _("missing object %s for %s"),
+					       oid_to_hex(&ref->objectname), ref->refname);
 	}
-	if (used_atom_cnt <= i)
+
+	if (need_tagged)
+		oi.info.contentp = &oi.content;
+	if (!memcmp(&oi.info, &empty, sizeof(empty)) &&
+	    !memcmp(&oi_deref.info, &empty, sizeof(empty)))
 		return 0;
 
-	if (get_object(ref, &ref->objectname, 0, &obj, err))
+
+	oi.oid = ref->objectname;
+	if (get_object(ref, 0, &obj, &oi, err))
 		return -1;
 
 	/*
@@ -1589,7 +1644,7 @@ static int populate_value(struct ref_array_item *ref, struct strbuf *err)
 	 * If it is a tag object, see if we use a value that derefs
 	 * the object, and if we do grab the object it refers to.
 	 */
-	tagged = &((struct tag *)obj)->tagged->oid;
+	oi_deref.oid = ((struct tag *)obj)->tagged->oid;
 
 	/*
 	 * NEEDSWORK: This derefs tag only once, which
@@ -1597,7 +1652,7 @@ static int populate_value(struct ref_array_item *ref, struct strbuf *err)
 	 * is not consistent with what deref_tag() does
 	 * which peels the onion to the core.
 	 */
-	return get_object(ref, tagged, 1, &obj, err);
+	return get_object(ref, 1, &obj, &oi_deref, err);
 }
 
 /*

--
https://github.com/git/git/pull/520
