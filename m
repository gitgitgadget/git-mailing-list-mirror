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
	by dcvr.yhbt.net (Postfix) with ESMTP id 15F541F404
	for <e@80x24.org>; Thu, 29 Mar 2018 12:50:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752604AbeC2Mty (ORCPT <rfc822;e@80x24.org>);
        Thu, 29 Mar 2018 08:49:54 -0400
Received: from a7-12.smtp-out.eu-west-1.amazonses.com ([54.240.7.12]:34270
        "EHLO a7-12.smtp-out.eu-west-1.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752496AbeC2Mtr (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 29 Mar 2018 08:49:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=uku4taia5b5tsbglxyj6zym32efj7xqv; d=amazonses.com; t=1522327786;
        h=From:To:Message-ID:In-Reply-To:References:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Date:Feedback-ID;
        bh=JAk1lDMScigoVSt+zohLJol7juJNfJ3TCylxpOQh/Tw=;
        b=MU3MlbUJ+DXJftS816qVnpXdxwZDTYO52PoZg4PbokrCZETHCjpVBdFE0K38Q5YH
        Tg8i/WNKsIL33QbZXZqCJ4t/J42hbyUI6dY3q9PThGVfm7aNEIjVQ9SpU1m3LwKQJCI
        2W/y96UvOUSeH5Yxsfx8qL+34M2m6OZwDzWUilr0=
From:   Olga Telezhnaya <olyatelezhnaya@gmail.com>
To:     git@vger.kernel.org
Message-ID: <0102016271ce91a8-81115fbe-a57e-40ba-be4b-a5af72dd2763-000000@eu-west-1.amazonses.com>
In-Reply-To: <0102016271ce90fc-1bd75012-add6-49ee-bb32-66eeeb1cc3df-000000@eu-west-1.amazonses.com>
References: <0102016271ce90fc-1bd75012-add6-49ee-bb32-66eeeb1cc3df-000000@eu-west-1.amazonses.com>
Subject: [PATCH v6 6/6] ref-filter: libify get_ref_atom_value()
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Date:   Thu, 29 Mar 2018 12:49:45 +0000
X-SES-Outgoing: 2018.03.29-54.240.7.12
Feedback-ID: 1.eu-west-1.YYPRFFOog89kHDDPKvTu4MK67j4wW0z7cAgZtFqQH58=:AmazonSES
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Finish removing die() calls from ref-filter formatting logic,
so that it could be used by other commands.

Change the signature of get_ref_atom_value() and underlying functions
by adding return value and strbuf parameter for error message.
Return value equals 0 upon success and -1 upon failure.
Upon failure, error message is appended to the strbuf.

Signed-off-by: Olga Telezhnaia <olyatelezhnaya@gmail.com>
---
 ref-filter.c | 54 ++++++++++++++++++++++++++++++------------------------
 1 file changed, 30 insertions(+), 24 deletions(-)

diff --git a/ref-filter.c b/ref-filter.c
index 3f85ef64267d9..3bc65e49358ee 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -1427,28 +1427,30 @@ static const char *get_refname(struct used_atom *atom, struct ref_array_item *re
 	return show_ref(&atom->u.refname, ref->refname);
 }
 
-static void get_object(struct ref_array_item *ref, const struct object_id *oid,
-		       int deref, struct object **obj)
+static int get_object(struct ref_array_item *ref, const struct object_id *oid,
+		       int deref, struct object **obj, struct strbuf *err)
 {
 	int eaten;
+	int ret = 0;
 	unsigned long size;
 	void *buf = get_obj(oid, obj, &size, &eaten);
 	if (!buf)
-		die(_("missing object %s for %s"),
-		    oid_to_hex(oid), ref->refname);
-	if (!*obj)
-		die(_("parse_object_buffer failed on %s for %s"),
-		    oid_to_hex(oid), ref->refname);
-
-	grab_values(ref->value, deref, *obj, buf, size);
+		ret = strbuf_addf_ret(err, -1, _("missing object %s for %s"),
+				      oid_to_hex(oid), ref->refname);
+	else if (!*obj)
+		ret = strbuf_addf_ret(err, -1, _("parse_object_buffer failed on %s for %s"),
+				      oid_to_hex(oid), ref->refname);
+	else
+		grab_values(ref->value, deref, *obj, buf, size);
 	if (!eaten)
 		free(buf);
+	return ret;
 }
 
 /*
  * Parse the object referred by ref, and grab needed value.
  */
-static void populate_value(struct ref_array_item *ref)
+static int populate_value(struct ref_array_item *ref, struct strbuf *err)
 {
 	struct object *obj;
 	int i;
@@ -1570,16 +1572,17 @@ static void populate_value(struct ref_array_item *ref)
 			break;
 	}
 	if (used_atom_cnt <= i)
-		return;
+		return 0;
 
-	get_object(ref, &ref->objectname, 0, &obj);
+	if (get_object(ref, &ref->objectname, 0, &obj, err))
+		return -1;
 
 	/*
 	 * If there is no atom that wants to know about tagged
 	 * object, we are done.
 	 */
 	if (!need_tagged || (obj->type != OBJ_TAG))
-		return;
+		return 0;
 
 	/*
 	 * If it is a tag object, see if we use a value that derefs
@@ -1593,20 +1596,23 @@ static void populate_value(struct ref_array_item *ref)
 	 * is not consistent with what deref_tag() does
 	 * which peels the onion to the core.
 	 */
-	get_object(ref, tagged, 1, &obj);
+	return get_object(ref, tagged, 1, &obj, err);
 }
 
 /*
  * Given a ref, return the value for the atom.  This lazily gets value
  * out of the object by calling populate value.
  */
-static void get_ref_atom_value(struct ref_array_item *ref, int atom, struct atom_value **v)
+static int get_ref_atom_value(struct ref_array_item *ref, int atom,
+			      struct atom_value **v, struct strbuf *err)
 {
 	if (!ref->value) {
-		populate_value(ref);
+		if (populate_value(ref, err))
+			return -1;
 		fill_missing_values(ref->value);
 	}
 	*v = &ref->value[atom];
+	return 0;
 }
 
 /*
@@ -2130,9 +2136,13 @@ static int cmp_ref_sorting(struct ref_sorting *s, struct ref_array_item *a, stru
 	int cmp;
 	cmp_type cmp_type = used_atom[s->atom].type;
 	int (*cmp_fn)(const char *, const char *);
+	struct strbuf err = STRBUF_INIT;
 
-	get_ref_atom_value(a, s->atom, &va);
-	get_ref_atom_value(b, s->atom, &vb);
+	if (get_ref_atom_value(a, s->atom, &va, &err))
+		die("%s", err.buf);
+	if (get_ref_atom_value(b, s->atom, &vb, &err))
+		die("%s", err.buf);
+	strbuf_release(&err);
 	cmp_fn = s->ignore_case ? strcasecmp : strcmp;
 	if (s->version)
 		cmp = versioncmp(va->s, vb->s);
@@ -2210,12 +2220,8 @@ int format_ref_array_item(struct ref_array_item *info,
 		if (cp < sp)
 			append_literal(cp, sp, &state);
 		pos = parse_ref_filter_atom(format, sp + 2, ep, error_buf);
-		if (pos < 0) {
-			pop_stack_element(&state.stack);
-			return -1;
-		}
-		get_ref_atom_value(info, pos, &atomv);
-		if (atomv->handler(atomv, &state, error_buf)) {
+		if (pos < 0 || get_ref_atom_value(info, pos, &atomv, error_buf) ||
+		    atomv->handler(atomv, &state, error_buf)) {
 			pop_stack_element(&state.stack);
 			return -1;
 		}

--
https://github.com/git/git/pull/466
