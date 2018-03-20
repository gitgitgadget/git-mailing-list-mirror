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
	by dcvr.yhbt.net (Postfix) with ESMTP id C70001F404
	for <e@80x24.org>; Tue, 20 Mar 2018 16:05:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751701AbeCTQFF (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Mar 2018 12:05:05 -0400
Received: from a7-20.smtp-out.eu-west-1.amazonses.com ([54.240.7.20]:47320
        "EHLO a7-20.smtp-out.eu-west-1.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751475AbeCTQFC (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 20 Mar 2018 12:05:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=uku4taia5b5tsbglxyj6zym32efj7xqv; d=amazonses.com; t=1521561901;
        h=From:To:Message-ID:In-Reply-To:References:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Date:Feedback-ID;
        bh=Zem1jF+d0ol+Z3hPeXL39jjkV3eEf9cyx4tj82WfQMA=;
        b=flJ4rhjoclsrkl5r2FK0h6Nz5Vox96C3B6afDEjpW1NPiHiFY6TT67NJ1cDHYXQs
        hyfbjFg34vTYDXKThlsbz9izIHqe95vDfy9ETF/WePfKKJKgefz1ypFIcO2v09vPXl6
        QmgyS7R2veUF3gC+01cJvTUxRaId7/WGFW8leVV0=
From:   Olga Telezhnaya <olyatelezhnaya@gmail.com>
To:     git@vger.kernel.org
Message-ID: <010201624428199f-b4b3d8ce-222f-4966-9171-7fcf932ca220-000000@eu-west-1.amazonses.com>
In-Reply-To: <01020162442818b4-c153f9ce-3813-41a6-aebd-f5cb2b98b1fa-000000@eu-west-1.amazonses.com>
References: <01020162442818b4-c153f9ce-3813-41a6-aebd-f5cb2b98b1fa-000000@eu-west-1.amazonses.com>
Subject: [PATCH v4 5/5] ref-filter: get_ref_atom_value() error handling
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Date:   Tue, 20 Mar 2018 16:05:01 +0000
X-SES-Outgoing: 2018.03.20-54.240.7.20
Feedback-ID: 1.eu-west-1.YYPRFFOog89kHDDPKvTu4MK67j4wW0z7cAgZtFqQH58=:AmazonSES
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Finish removing die() calls from ref-filter formatting logic,
so that it could be used by other commands.

Change the signature of get_ref_atom_value() and underlying functions
by adding return value and strbuf parameter for error message.
Return value equals 0 upon success and -1 upon failure (there
could be more error codes further if necessary).
Upon failure, error message is appended to the strbuf.

Signed-off-by: Olga Telezhnaia <olyatelezhnaya@gmail.com>
---
 ref-filter.c | 55 ++++++++++++++++++++++++++++++++++++-------------------
 1 file changed, 36 insertions(+), 19 deletions(-)

diff --git a/ref-filter.c b/ref-filter.c
index b90cec1056954..85f971663a4aa 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -1445,28 +1445,36 @@ static const char *get_refname(struct used_atom *atom, struct ref_array_item *re
 	return show_ref(&atom->u.refname, ref->refname);
 }
 
-static void get_object(struct ref_array_item *ref, const struct object_id *oid,
-		       int deref, struct object **obj)
+static int get_object(struct ref_array_item *ref, const struct object_id *oid,
+		       int deref, struct object **obj, struct strbuf *err)
 {
 	int eaten;
 	unsigned long size;
 	void *buf = get_obj(oid, obj, &size, &eaten);
-	if (!buf)
-		die(_("missing object %s for %s"),
-		    oid_to_hex(oid), ref->refname);
-	if (!*obj)
-		die(_("parse_object_buffer failed on %s for %s"),
-		    oid_to_hex(oid), ref->refname);
-
+	if (!buf) {
+		strbuf_addf(err, _("missing object %s for %s"), oid_to_hex(oid),
+			    ref->refname);
+		if (!eaten)
+			free(buf);
+		return -1;
+	}
+	if (!*obj) {
+		strbuf_addf(err, _("parse_object_buffer failed on %s for %s"),
+			    oid_to_hex(oid), ref->refname);
+		if (!eaten)
+			free(buf);
+		return -1;
+	}
 	grab_values(ref->value, deref, *obj, buf, size);
 	if (!eaten)
 		free(buf);
+	return 0;
 }
 
 /*
  * Parse the object referred by ref, and grab needed value.
  */
-static void populate_value(struct ref_array_item *ref)
+static int populate_value(struct ref_array_item *ref, struct strbuf *err)
 {
 	struct object *obj;
 	int i;
@@ -1588,16 +1596,17 @@ static void populate_value(struct ref_array_item *ref)
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
@@ -1611,20 +1620,23 @@ static void populate_value(struct ref_array_item *ref)
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
@@ -2148,9 +2160,13 @@ static int cmp_ref_sorting(struct ref_sorting *s, struct ref_array_item *a, stru
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
@@ -2230,7 +2246,8 @@ int format_ref_array_item(struct ref_array_item *info,
 		pos = parse_ref_filter_atom(format, sp + 2, ep, error_buf);
 		if (pos < 0)
 			return -1;
-		get_ref_atom_value(info, pos, &atomv);
+		if (get_ref_atom_value(info, pos, &atomv, error_buf))
+			return -1;
 		if (atomv->handler(atomv, &state, error_buf))
 			return -1;
 	}

--
https://github.com/git/git/pull/466
