Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 11DD11F97E
	for <e@80x24.org>; Tue,  9 Oct 2018 08:18:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726562AbeJIPeJ (ORCPT <rfc822;e@80x24.org>);
        Tue, 9 Oct 2018 11:34:09 -0400
Received: from a7-19.smtp-out.eu-west-1.amazonses.com ([54.240.7.19]:33590
        "EHLO a7-19.smtp-out.eu-west-1.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725866AbeJIPeI (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 9 Oct 2018 11:34:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=uku4taia5b5tsbglxyj6zym32efj7xqv; d=amazonses.com; t=1539073102;
        h=From:To:Message-ID:In-Reply-To:References:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Date:Feedback-ID;
        bh=FCDJTDtA9fsG0HyAOjYue8Ea3BKEydDjtkRTlfE46zU=;
        b=Wkt0zjg2/rx5jFNT+7daJAqxUn4hZDDG2RbNfKSTMeI8CALz38jWOyF56zwy1qg5
        jOEarxYDCn6QUeTquZVfU3YgL4xnvPyYUdGP+RgyXLYZKt/YM/dE4F6yOh/WzL4WVVt
        a+TXncHd0ohiyqbIme+s8u+8nzd2PxyQ2PuohDms=
From:   Olga Telezhnaya <olyatelezhnaya@gmail.com>
To:     git@vger.kernel.org
Message-ID: <0102016657e7d087-be1f65a3-be3e-4b15-95f1-7570d258c70d-000000@eu-west-1.amazonses.com>
In-Reply-To: <0102016657e7cfee-f1343b1e-9a85-4cae-990a-cc7177ea8487-000000@eu-west-1.amazonses.com>
References: <0102016657e7cfee-f1343b1e-9a85-4cae-990a-cc7177ea8487-000000@eu-west-1.amazonses.com>
Subject: [PATCH 3/3] ref-filter: free item->value and item->value->s
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Date:   Tue, 9 Oct 2018 08:18:21 +0000
X-SES-Outgoing: 2018.10.09-54.240.7.19
Feedback-ID: 1.eu-west-1.YYPRFFOog89kHDDPKvTu4MK67j4wW0z7cAgZtFqQH58=:AmazonSES
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Release item->value.
Initialize item->value->s dynamically and then release its resources.
Release some local variables.

Signed-off-by: Olga Telezhnaia <olyatelezhnaya@gmail.com>
---
 ref-filter.c | 95 +++++++++++++++++++++++++++++-----------------------
 1 file changed, 53 insertions(+), 42 deletions(-)

diff --git a/ref-filter.c b/ref-filter.c
index 1b71d08a43a84..4d42c777a9b50 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -875,7 +875,7 @@ static void grab_common_values(struct atom_value *val, int deref, struct expand_
 		if (deref)
 			name++;
 		if (!strcmp(name, "objecttype"))
-			v->s = type_name(oi->type);
+			v->s = xstrdup(type_name(oi->type));
 		else if (!strcmp(name, "objectsize")) {
 			v->value = oi->size;
 			v->s = xstrfmt("%lu", oi->size);
@@ -899,9 +899,9 @@ static void grab_tag_values(struct atom_value *val, int deref, struct object *ob
 		if (deref)
 			name++;
 		if (!strcmp(name, "tag"))
-			v->s = tag->tag;
+			v->s = xstrdup(tag->tag);
 		else if (!strcmp(name, "type") && tag->tagged)
-			v->s = type_name(tag->tagged->type);
+			v->s = xstrdup(type_name(tag->tagged->type));
 		else if (!strcmp(name, "object") && tag->tagged)
 			v->s = xstrdup(oid_to_hex(&tag->tagged->oid));
 	}
@@ -1032,7 +1032,7 @@ static void grab_date(const char *buf, struct atom_value *v, const char *atomnam
 	v->value = timestamp;
 	return;
  bad:
-	v->s = "";
+	v->s = xstrdup("");
 	v->value = 0;
 }
 
@@ -1227,7 +1227,7 @@ static void fill_missing_values(struct atom_value *val)
 	for (i = 0; i < used_atom_cnt; i++) {
 		struct atom_value *v = &val[i];
 		if (v->s == NULL)
-			v->s = "";
+			v->s = xstrdup("");
 	}
 }
 
@@ -1273,7 +1273,8 @@ static inline char *copy_advance(char *dst, const char *src)
 static const char *lstrip_ref_components(const char *refname, int len)
 {
 	long remaining = len;
-	const char *start = refname;
+	const char *start = xstrdup(refname);
+	const char *to_free = start;
 
 	if (len < 0) {
 		int i;
@@ -1294,20 +1295,24 @@ static const char *lstrip_ref_components(const char *refname, int len)
 	while (remaining > 0) {
 		switch (*start++) {
 		case '\0':
-			return "";
+			free((char *)to_free);
+			return xstrdup("");
 		case '/':
 			remaining--;
 			break;
 		}
 	}
 
+	start = xstrdup(start);
+	free((char *)to_free);
 	return start;
 }
 
 static const char *rstrip_ref_components(const char *refname, int len)
 {
 	long remaining = len;
-	char *start = xstrdup(refname);
+	const char *start = xstrdup(refname);
+	const char *to_free = start;
 
 	if (len < 0) {
 		int i;
@@ -1327,9 +1332,10 @@ static const char *rstrip_ref_components(const char *refname, int len)
 
 	while (remaining-- > 0) {
 		char *p = strrchr(start, '/');
-		if (p == NULL)
-			return "";
-		else
+		if (p == NULL) {
+			free((char *)to_free);
+			return xstrdup("");
+		} else
 			p[0] = '\0';
 	}
 	return start;
@@ -1344,7 +1350,7 @@ static const char *show_ref(struct refname_atom *atom, const char *refname)
 	else if (atom->option == R_RSTRIP)
 		return rstrip_ref_components(refname, atom->rstrip);
 	else
-		return refname;
+		return xstrdup(refname);
 }
 
 static void fill_remote_ref_details(struct used_atom *atom, const char *refname,
@@ -1358,7 +1364,7 @@ static void fill_remote_ref_details(struct used_atom *atom, const char *refname,
 				       NULL, AHEAD_BEHIND_FULL) < 0) {
 			*s = xstrdup(msgs.gone);
 		} else if (!num_ours && !num_theirs)
-			*s = "";
+			*s = xstrdup("");
 		else if (!num_ours)
 			*s = xstrfmt(msgs.behind, num_theirs);
 		else if (!num_theirs)
@@ -1373,36 +1379,31 @@ static void fill_remote_ref_details(struct used_atom *atom, const char *refname,
 		}
 	} else if (atom->u.remote_ref.option == RR_TRACKSHORT) {
 		if (stat_tracking_info(branch, &num_ours, &num_theirs,
-				       NULL, AHEAD_BEHIND_FULL) < 0)
+				       NULL, AHEAD_BEHIND_FULL) < 0) {
+			*s = xstrdup("");
 			return;
-
+		}
 		if (!num_ours && !num_theirs)
-			*s = "=";
+			*s = xstrdup("=");
 		else if (!num_ours)
-			*s = "<";
+			*s = xstrdup("<");
 		else if (!num_theirs)
-			*s = ">";
+			*s = xstrdup(">");
 		else
-			*s = "<>";
+			*s = xstrdup("<>");
 	} else if (atom->u.remote_ref.option == RR_REMOTE_NAME) {
 		int explicit;
 		const char *remote = atom->u.remote_ref.push ?
 			pushremote_for_branch(branch, &explicit) :
 			remote_for_branch(branch, &explicit);
-		if (explicit)
-			*s = xstrdup(remote);
-		else
-			*s = "";
+		*s = explicit ? xstrdup(remote) : xstrdup("");
 	} else if (atom->u.remote_ref.option == RR_REMOTE_REF) {
 		int explicit;
 		const char *merge;
 
 		merge = remote_ref_for_branch(branch, atom->u.remote_ref.push,
 					      &explicit);
-		if (explicit)
-			*s = xstrdup(merge);
-		else
-			*s = "";
+		*s = explicit ? xstrdup(merge) : xstrdup("");
 	} else
 		BUG("unhandled RR_* enum");
 }
@@ -1451,7 +1452,7 @@ char *get_head_description(void)
 static const char *get_symref(struct used_atom *atom, struct ref_array_item *ref)
 {
 	if (!ref->symref)
-		return "";
+		return xstrdup("");
 	else
 		return show_ref(&atom->u.refname, ref->symref);
 }
@@ -1510,7 +1511,7 @@ static int populate_value(struct ref_array_item *ref, struct strbuf *err)
 		ref->symref = resolve_refdup(ref->refname, RESOLVE_REF_READING,
 					     NULL, NULL);
 		if (!ref->symref)
-			ref->symref = "";
+			ref->symref = xstrdup("");
 	}
 
 	/* Fill in specials first */
@@ -1536,20 +1537,23 @@ static int populate_value(struct ref_array_item *ref, struct strbuf *err)
 			refname = get_symref(atom, ref);
 		else if (starts_with(name, "upstream")) {
 			const char *branch_name;
-			v->s = "";
 			/* only local branches may have an upstream */
 			if (!skip_prefix(ref->refname, "refs/heads/",
-					 &branch_name))
+					 &branch_name)) {
+				v->s = xstrdup("");
 				continue;
+			}
 			branch = branch_get(branch_name);
 
 			refname = branch_get_upstream(branch, NULL);
 			if (refname)
 				fill_remote_ref_details(atom, refname, branch, &v->s);
+			else
+				v->s = xstrdup("");
 			continue;
 		} else if (atom->u.remote_ref.push) {
 			const char *branch_name;
-			v->s = "";
+			v->s = xstrdup("");
 			if (!skip_prefix(ref->refname, "refs/heads/",
 					 &branch_name))
 				continue;
@@ -1562,10 +1566,11 @@ static int populate_value(struct ref_array_item *ref, struct strbuf *err)
 				if (!refname)
 					continue;
 			}
+			free((char *)v->s); // we will definitely re-init it on the next line
 			fill_remote_ref_details(atom, refname, branch, &v->s);
 			continue;
 		} else if (starts_with(name, "color:")) {
-			v->s = atom->u.color;
+			v->s = xstrdup(atom->u.color);
 			continue;
 		} else if (!strcmp(name, "flag")) {
 			char buf[256], *cp = buf;
@@ -1574,7 +1579,7 @@ static int populate_value(struct ref_array_item *ref, struct strbuf *err)
 			if (ref->flag & REF_ISPACKED)
 				cp = copy_advance(cp, ",packed");
 			if (cp == buf)
-				v->s = "";
+				v->s = xstrdup("");
 			else {
 				*cp = '\0';
 				v->s = xstrdup(buf + 1);
@@ -1584,40 +1589,42 @@ static int populate_value(struct ref_array_item *ref, struct strbuf *err)
 			continue;
 		} else if (!strcmp(name, "HEAD")) {
 			if (atom->u.head && !strcmp(ref->refname, atom->u.head))
-				v->s = "*";
+				v->s = xstrdup("*");
 			else
-				v->s = " ";
+				v->s = xstrdup(" ");
 			continue;
 		} else if (starts_with(name, "align")) {
 			v->handler = align_atom_handler;
-			v->s = "";
+			v->s = xstrdup("");
 			continue;
 		} else if (!strcmp(name, "end")) {
 			v->handler = end_atom_handler;
-			v->s = "";
+			v->s = xstrdup("");
 			continue;
 		} else if (starts_with(name, "if")) {
 			const char *s;
-			v->s = "";
 			if (skip_prefix(name, "if:", &s))
 				v->s = xstrdup(s);
+			else
+				v->s = xstrdup("");
 			v->handler = if_atom_handler;
 			continue;
 		} else if (!strcmp(name, "then")) {
 			v->handler = then_atom_handler;
-			v->s = "";
+			v->s = xstrdup("");
 			continue;
 		} else if (!strcmp(name, "else")) {
 			v->handler = else_atom_handler;
-			v->s = "";
+			v->s = xstrdup("");
 			continue;
 		} else
 			continue;
 
 		if (!deref)
-			v->s = refname;
+			v->s = xstrdup(refname);
 		else
 			v->s = xstrfmt("%s^{}", refname);
+		free((char *)refname);
 	}
 
 	for (i = 0; i < used_atom_cnt; i++) {
@@ -1988,6 +1995,10 @@ static int ref_filter_handler(const char *refname, const struct object_id *oid,
 static void free_array_item(struct ref_array_item *item)
 {
 	free((char *)item->symref);
+	if (item->value) {
+		free((char *)item->value->s);
+		free(item->value);
+	}
 	free(item);
 }
 

--
https://github.com/git/git/pull/538
