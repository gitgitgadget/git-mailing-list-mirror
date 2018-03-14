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
	by dcvr.yhbt.net (Postfix) with ESMTP id 14BFF1F404
	for <e@80x24.org>; Wed, 14 Mar 2018 19:04:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751824AbeCNTEZ (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Mar 2018 15:04:25 -0400
Received: from a7-11.smtp-out.eu-west-1.amazonses.com ([54.240.7.11]:58612
        "EHLO a7-11.smtp-out.eu-west-1.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751440AbeCNTEV (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 14 Mar 2018 15:04:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=uku4taia5b5tsbglxyj6zym32efj7xqv; d=amazonses.com; t=1521054260;
        h=From:To:Message-ID:In-Reply-To:References:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Date:Feedback-ID;
        bh=fFq2vTzCwTYm42Jcsh2e081tDNdrMEnMDeTc9CznC0Y=;
        b=tdV4Vrg+Be00Y9c1aiCJlcnk1pE8ySUklgqWLyhABlJdt6kVqUJy2NlWfmxn3Ama
        X+KzX5OzhtH/Bj6HbR+gsTeuJKOZ+JSyiKTakfEVO2u8JHTGEjTJl8UQAwh1oHfjh92
        LLO7XvI35PRu15CVqQLLg4nLqO0aUhfEIkyrraPM=
From:   Olga Telezhnaya <olyatelezhnaya@gmail.com>
To:     git@vger.kernel.org
Message-ID: <0102016225e61cc2-0d0c05ef-b999-4bf2-88ac-db9840dd2a87-000000@eu-west-1.amazonses.com>
In-Reply-To: <0102016225e61c34-50ab78f0-6fb6-4ece-acfe-da253bdce616-000000@eu-west-1.amazonses.com>
References: <0102016225e61c34-50ab78f0-6fb6-4ece-acfe-da253bdce616-000000@eu-west-1.amazonses.com>
Subject: [PATCH v2 5/5] ref-filter: get_ref_atom_value() error handling
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Date:   Wed, 14 Mar 2018 19:04:20 +0000
X-SES-Outgoing: 2018.03.14-54.240.7.11
Feedback-ID: 1.eu-west-1.YYPRFFOog89kHDDPKvTu4MK67j4wW0z7cAgZtFqQH58=:AmazonSES
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Finish removing any printing from ref-filter formatting logic,
so that it could be more general.

Change the signature of get_ref_atom_value() and underlying functions
by adding return value and strbuf parameter for error message.

It's important to mention that grab_objectname() returned 1 if
it gets objectname atom and 0 otherwise. Now this logic changed:
we return 0 if we have no error, -1 otherwise. If someone needs to
know whether it's objectname atom or not, he/she could use
starts_with() function. It duplicates this checking but it does not
sound like a really big overhead.

Signed-off-by: Olga Telezhnaia <olyatelezhnaya@gmail.com>
---
 ref-filter.c | 109 +++++++++++++++++++++++++++++++++++++----------------------
 1 file changed, 69 insertions(+), 40 deletions(-)

diff --git a/ref-filter.c b/ref-filter.c
index 62ea4adcd0ff1..3f0c3924273d5 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -831,26 +831,27 @@ static void *get_obj(const struct object_id *oid, struct object **obj, unsigned
 }
 
 static int grab_objectname(const char *name, const unsigned char *sha1,
-			   struct atom_value *v, struct used_atom *atom)
+			   struct atom_value *v, struct used_atom *atom,
+			   struct strbuf *err)
 {
 	if (starts_with(name, "objectname")) {
 		if (atom->u.objectname.option == O_SHORT) {
 			v->s = xstrdup(find_unique_abbrev(sha1, DEFAULT_ABBREV));
-			return 1;
 		} else if (atom->u.objectname.option == O_FULL) {
 			v->s = xstrdup(sha1_to_hex(sha1));
-			return 1;
 		} else if (atom->u.objectname.option == O_LENGTH) {
 			v->s = xstrdup(find_unique_abbrev(sha1, atom->u.objectname.length));
-			return 1;
-		} else
-			die("BUG: unknown %%(objectname) option");
+		} else {
+			strbuf_addstr(err, "BUG: unknown %(objectname) option");
+			return -1;
+		}
 	}
 	return 0;
 }
 
 /* See grab_values */
-static void grab_common_values(struct atom_value *val, int deref, struct object *obj, void *buf, unsigned long sz)
+static int grab_common_values(struct atom_value *val, int deref, struct object *obj,
+			      void *buf, unsigned long sz, struct strbuf *err)
 {
 	int i;
 
@@ -868,8 +869,10 @@ static void grab_common_values(struct atom_value *val, int deref, struct object
 			v->s = xstrfmt("%lu", sz);
 		}
 		else if (deref)
-			grab_objectname(name, obj->oid.hash, v, &used_atom[i]);
+			if (grab_objectname(name, obj->oid.hash, v, &used_atom[i], err))
+				return -1;
 	}
+	return 0;
 }
 
 /* See grab_values */
@@ -1225,9 +1228,11 @@ static void fill_missing_values(struct atom_value *val)
  * pointed at by the ref itself; otherwise it is the object the
  * ref (which is a tag) refers to.
  */
-static void grab_values(struct atom_value *val, int deref, struct object *obj, void *buf, unsigned long sz)
+static int grab_values(struct atom_value *val, int deref, struct object *obj,
+		       void *buf, unsigned long sz, struct strbuf *err)
 {
-	grab_common_values(val, deref, obj, buf, sz);
+	if (grab_common_values(val, deref, obj, buf, sz, err))
+		return -1;
 	switch (obj->type) {
 	case OBJ_TAG:
 		grab_tag_values(val, deref, obj, buf, sz);
@@ -1247,8 +1252,10 @@ static void grab_values(struct atom_value *val, int deref, struct object *obj, v
 		/* grab_blob_values(val, deref, obj, buf, sz); */
 		break;
 	default:
-		die("Eh?  Object of type %d?", obj->type);
+		strbuf_addf(err, "Eh?  Object of type %d?", obj->type);
+		return -1;
 	}
+	return 0;
 }
 
 static inline char *copy_advance(char *dst, const char *src)
@@ -1335,8 +1342,9 @@ static const char *show_ref(struct refname_atom *atom, const char *refname)
 		return refname;
 }
 
-static void fill_remote_ref_details(struct used_atom *atom, const char *refname,
-				    struct branch *branch, const char **s)
+static int fill_remote_ref_details(struct used_atom *atom, const char *refname,
+				   struct branch *branch, const char **s,
+				   struct strbuf *err)
 {
 	int num_ours, num_theirs;
 	if (atom->u.remote_ref.option == RR_REF)
@@ -1362,7 +1370,7 @@ static void fill_remote_ref_details(struct used_atom *atom, const char *refname,
 	} else if (atom->u.remote_ref.option == RR_TRACKSHORT) {
 		if (stat_tracking_info(branch, &num_ours, &num_theirs,
 				       NULL, AHEAD_BEHIND_FULL) < 0)
-			return;
+			return 0;
 
 		if (!num_ours && !num_theirs)
 			*s = "=";
@@ -1391,8 +1399,11 @@ static void fill_remote_ref_details(struct used_atom *atom, const char *refname,
 			*s = xstrdup(merge);
 		else
 			*s = "";
-	} else
-		die("BUG: unhandled RR_* enum");
+	} else {
+		strbuf_addstr(err, "BUG: unhandled RR_* enum");
+		return -1;
+	}
+	return 0;
 }
 
 char *get_head_description(void)
@@ -1447,28 +1458,33 @@ static const char *get_refname(struct used_atom *atom, struct ref_array_item *re
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
-	grab_values(ref->value, deref, *obj, buf, size);
+	if (!buf) {
+		strbuf_addf(err, _("missing object %s for %s"), oid_to_hex(oid),
+			    ref->refname);
+		return -1;
+	}
+	if (!*obj) {
+		strbuf_addf(err, _("parse_object_buffer failed on %s for %s"),
+			    oid_to_hex(oid), ref->refname);
+		return -1;
+	}
+	if (grab_values(ref->value, deref, *obj, buf, size, err))
+		return -1;
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
@@ -1513,8 +1529,9 @@ static void populate_value(struct ref_array_item *ref)
 			branch = branch_get(branch_name);
 
 			refname = branch_get_upstream(branch, NULL);
-			if (refname)
-				fill_remote_ref_details(atom, refname, branch, &v->s);
+			if (refname &&
+			    fill_remote_ref_details(atom, refname, branch, &v->s, err))
+				return -1;
 			continue;
 		} else if (atom->u.remote_ref.push) {
 			const char *branch_name;
@@ -1530,7 +1547,8 @@ static void populate_value(struct ref_array_item *ref)
 				if (!refname)
 					continue;
 			}
-			fill_remote_ref_details(atom, refname, branch, &v->s);
+			if (fill_remote_ref_details(atom, refname, branch, &v->s, err))
+				return -1;
 			continue;
 		} else if (starts_with(name, "color:")) {
 			v->s = atom->u.color;
@@ -1548,7 +1566,9 @@ static void populate_value(struct ref_array_item *ref)
 				v->s = xstrdup(buf + 1);
 			}
 			continue;
-		} else if (!deref && grab_objectname(name, ref->objectname.hash, v, atom)) {
+		} else if (!deref && starts_with(name, "objectname")) {
+			if (grab_objectname(name, ref->objectname.hash, v, atom, err))
+				return -1;
 			continue;
 		} else if (!strcmp(name, "HEAD")) {
 			if (atom->u.head && !strcmp(ref->refname, atom->u.head))
@@ -1590,16 +1610,17 @@ static void populate_value(struct ref_array_item *ref)
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
@@ -1613,20 +1634,23 @@ static void populate_value(struct ref_array_item *ref)
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
@@ -2150,9 +2174,13 @@ static int cmp_ref_sorting(struct ref_sorting *s, struct ref_array_item *a, stru
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
@@ -2231,7 +2259,8 @@ int format_ref_array_item(struct ref_array_item *info,
 			append_literal(cp, sp, &state);
 		if (parse_ref_filter_atom(format, sp + 2, ep, &pos, error_buf))
 			return -1;
-		get_ref_atom_value(info, pos, &atomv);
+		if (get_ref_atom_value(info, pos, &atomv, error_buf))
+			return -1;
 		if (atomv->handler(atomv, &state, error_buf))
 			return -1;
 	}

--
https://github.com/git/git/pull/466
