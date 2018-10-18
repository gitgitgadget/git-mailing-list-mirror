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
	by dcvr.yhbt.net (Postfix) with ESMTP id A11751F453
	for <e@80x24.org>; Thu, 18 Oct 2018 07:28:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727481AbeJRP2h (ORCPT <rfc822;e@80x24.org>);
        Thu, 18 Oct 2018 11:28:37 -0400
Received: from a7-11.smtp-out.eu-west-1.amazonses.com ([54.240.7.11]:48232
        "EHLO a7-11.smtp-out.eu-west-1.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727454AbeJRP2g (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 18 Oct 2018 11:28:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=uku4taia5b5tsbglxyj6zym32efj7xqv; d=amazonses.com; t=1539847734;
        h=From:To:Message-ID:In-Reply-To:References:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Date:Feedback-ID;
        bh=8D1LqhAmq6fOqlTq7wYd8ACPTMBOWpz6hXti3pdMlDU=;
        b=eqbxguv5AzYPaef6kIKZR4NiJlf3qbgPyHzC+OMDytB09wdlDqff+CwuT1AOKugM
        bHPzz1TXzj5QgVQOlgWYdYCg8SW31YhK6kOzxfwoDanB+1wAOpZ7rEza/XZKjDrSqtb
        jJljbpPETSPeEqXBx9U+JBX6J41w7UZXg3nwV7GU=
From:   Olga Telezhnaya <olyatelezhnaya@gmail.com>
To:     git@vger.kernel.org
Message-ID: <010201668613c4dd-aa890c7f-39a9-4d01-b242-e38fb4ab9518-000000@eu-west-1.amazonses.com>
In-Reply-To: <010201668613c3de-23d41696-1476-4949-9834-a31adeb0650e-000000@eu-west-1.amazonses.com>
References: <010201668613c3de-23d41696-1476-4949-9834-a31adeb0650e-000000@eu-west-1.amazonses.com>
Subject: [PATCH v2 3/3] ref-filter: free item->value and item->value->s
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Date:   Thu, 18 Oct 2018 07:28:54 +0000
X-SES-Outgoing: 2018.10.18-54.240.7.11
Feedback-ID: 1.eu-west-1.YYPRFFOog89kHDDPKvTu4MK67j4wW0z7cAgZtFqQH58=:AmazonSES
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Release item->value.
Initialize item->value->s dynamically and then release its resources.
Release some local variables.

Final goal of this patch is to reduce number of memory leaks.

Signed-off-by: Olga Telezhnaia <olyatelezhnaya@gmail.com>
---
 ref-filter.c | 96 +++++++++++++++++++++++++++++-----------------------
 1 file changed, 54 insertions(+), 42 deletions(-)

diff --git a/ref-filter.c b/ref-filter.c
index 70f1d13ab3beb..ca52ee4608c2a 100644
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
+		*s = xstrdup(explicit ? remote : "");
 	} else if (atom->u.remote_ref.option == RR_REMOTE_REF) {
 		int explicit;
 		const char *merge;
 
 		merge = remote_ref_for_branch(branch, atom->u.remote_ref.push,
 					      &explicit);
-		if (explicit)
-			*s = xstrdup(merge);
-		else
-			*s = "";
+		*s = xstrdup(explicit ? merge : "");
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
@@ -1562,10 +1566,12 @@ static int populate_value(struct ref_array_item *ref, struct strbuf *err)
 				if (!refname)
 					continue;
 			}
+			/* We will definitely re-init v->s on the next line. */
+			free((char *)v->s);
 			fill_remote_ref_details(atom, refname, branch, &v->s);
 			continue;
 		} else if (starts_with(name, "color:")) {
-			v->s = atom->u.color;
+			v->s = xstrdup(atom->u.color);
 			continue;
 		} else if (!strcmp(name, "flag")) {
 			char buf[256], *cp = buf;
@@ -1574,7 +1580,7 @@ static int populate_value(struct ref_array_item *ref, struct strbuf *err)
 			if (ref->flag & REF_ISPACKED)
 				cp = copy_advance(cp, ",packed");
 			if (cp == buf)
-				v->s = "";
+				v->s = xstrdup("");
 			else {
 				*cp = '\0';
 				v->s = xstrdup(buf + 1);
@@ -1584,40 +1590,42 @@ static int populate_value(struct ref_array_item *ref, struct strbuf *err)
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
@@ -1988,6 +1996,10 @@ static int ref_filter_handler(const char *refname, const struct object_id *oid,
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
