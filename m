From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH/WIP v3 3/4] for-each-ref: rename some functions and make them public
Date: Thu, 28 May 2015 23:13:44 +0530
Message-ID: <1432835025-13291-3-git-send-email-karthik.188@gmail.com>
References: <5567527A.6090607@gmail.com>
Cc: christian.couder@gmail.com, Matthieu.Moy@grenoble-inp.fr,
	Karthik Nayak <karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 28 19:44:25 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yy1qq-0005SY-Cw
	for gcvg-git-2@plane.gmane.org; Thu, 28 May 2015 19:44:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754326AbbE1RoL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 May 2015 13:44:11 -0400
Received: from mail-pd0-f181.google.com ([209.85.192.181]:33020 "EHLO
	mail-pd0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753959AbbE1RoH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 May 2015 13:44:07 -0400
Received: by pdbqa5 with SMTP id qa5so46705869pdb.0
        for <git@vger.kernel.org>; Thu, 28 May 2015 10:44:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=9Xwlb9bmWQ3cKcNbnIVDMm4Ve7elVO2Ntp1bfbrechY=;
        b=PTwnXeZSozOwgYPMhS5KbeH6YygQYW+8S7tqEiVx/JPwfjCEn4U17upeGrJCW0ZWyW
         QiFwB6GXtudlfZGOv4gAgOXDX2UuzPyeWp/gaMhwiip6I7FbFITF0xAWyt/RSyEvx4nQ
         4SJ4fbGCXFnD1pGcn0BEOmgr1XcSrVKYknPFILmfTplmOmnD6spiovyMxakHC9LkVk3b
         UQ7Qotq+yeH+hOxzcgxqVLJk0LoLLlgFkL4tUw7b+GR/Juj+k5FZB52Qsz8CY4EXvzsw
         eqa3ZKBIsu67Jx5JZA2ABh2AjEMz31hiL5Bcx7bsu8+qoB8etSX7YSkGcd1qDDEoM38D
         MbRw==
X-Received: by 10.69.27.66 with SMTP id je2mr7525662pbd.156.1432835046486;
        Thu, 28 May 2015 10:44:06 -0700 (PDT)
Received: from ashley.localdomain ([106.51.130.23])
        by mx.google.com with ESMTPSA id k13sm3003649pbq.79.2015.05.28.10.44.04
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 28 May 2015 10:44:05 -0700 (PDT)
X-Mailer: git-send-email 2.4.1
In-Reply-To: <5567527A.6090607@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270167>

Rename some of the functions and make them publically available.
This is a preparatory step for moving code from 'for-each-ref'
to 'ref-filter' to make meaningful, targeted services available to
other commands via public APIs.

Based-on-patch-by: Jeff King <peff@peff.net>
Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Matthieu Moy <matthieu.moy@grenoble-inp.fr>
Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 builtin/for-each-ref.c | 45 +++++++++++++++++++++++----------------------
 1 file changed, 23 insertions(+), 22 deletions(-)

diff --git a/builtin/for-each-ref.c b/builtin/for-each-ref.c
index d9fd512..f045def 100644
--- a/builtin/for-each-ref.c
+++ b/builtin/for-each-ref.c
@@ -112,7 +112,7 @@ static int need_color_reset_at_eol;
 /*
  * Used to parse format string and sort specifiers
  */
-static int parse_atom(const char *atom, const char *ep)
+int parse_ref_filter_atom(const char *atom, const char *ep)
 {
 	const char *sp;
 	int i, at;
@@ -189,7 +189,7 @@ static const char *find_next(const char *cp)
  * Make sure the format string is well formed, and parse out
  * the used atoms.
  */
-static int verify_format(const char *format)
+int verify_ref_format(const char *format)
 {
 	const char *cp, *sp;
 
@@ -201,7 +201,7 @@ static int verify_format(const char *format)
 		if (!ep)
 			return error("malformed format string %s", sp);
 		/* sp points at "%(" and ep points at the closing ")" */
-		at = parse_atom(sp + 2, ep);
+		at = parse_ref_filter_atom(sp + 2, ep);
 		cp = ep + 1;
 
 		if (skip_prefix(used_atom[at], "color:", &color))
@@ -408,7 +408,7 @@ static void grab_date(const char *buf, struct atom_value *v, const char *atomnam
 	/*
 	 * We got here because atomname ends in "date" or "date<something>";
 	 * it's not possible that <something> is not ":<format>" because
-	 * parse_atom() wouldn't have allowed it, so we can assume that no
+	 * parse_ref_filter_atom() wouldn't have allowed it, so we can assume that no
 	 * ":" means no format is specified, and use the default.
 	 */
 	formatp = strchr(atomname, ':');
@@ -835,7 +835,7 @@ static void populate_value(struct ref_array_item *ref)
  * Given a ref, return the value for the atom.  This lazily gets value
  * out of the object by calling populate value.
  */
-static void get_value(struct ref_array_item *ref, int atom, struct atom_value **v)
+static void get_ref_atom_value(struct ref_array_item *ref, int atom, struct atom_value **v)
 {
 	if (!ref->value) {
 		populate_value(ref);
@@ -882,10 +882,10 @@ static struct ref_array_item *new_ref_array_item(const char *refname,
 }
 
 /*
- * A call-back given to for_each_ref().  Filter refs and keep them for
+ * A call-back given to for_each_ref(). Filter refs and keep them for
  * later object processing.
  */
-static int grab_single_ref(const char *refname, const unsigned char *sha1, int flag, void *cb_data)
+int ref_filter_handler(const char *refname, const unsigned char *sha1, int flag, void *cb_data)
 {
 	struct ref_filter_cbdata *ref_cbdata = cb_data;
 	struct ref_filter *filter = &ref_cbdata->filter;
@@ -925,8 +925,8 @@ static int cmp_ref_sort(struct ref_sort *s, struct ref_array_item *a, struct ref
 	int cmp;
 	cmp_type cmp_type = used_atom_type[s->atom];
 
-	get_value(a, s->atom, &va);
-	get_value(b, s->atom, &vb);
+	get_ref_atom_value(a, s->atom, &va);
+	get_ref_atom_value(b, s->atom, &vb);
 	switch (cmp_type) {
 	case FIELD_STR:
 		cmp = strcmp(va->s, vb->s);
@@ -958,7 +958,7 @@ static int compare_refs(const void *a_, const void *b_)
 	return 0;
 }
 
-static void sort_refs(struct ref_sort *sort, struct ref_array *array)
+void sort_ref_array(struct ref_sort *sort, struct ref_array *array)
 {
 	ref_sort = sort;
 	qsort(array->items, array->nr, sizeof(struct ref_array_item *), compare_refs);
@@ -1028,7 +1028,7 @@ static void emit(const char *cp, const char *ep)
 	}
 }
 
-static void show_ref(struct ref_array_item *info, const char *format, int quote_style)
+void show_ref_array_item(struct ref_array_item *info, const char *format, int quote_style)
 {
 	const char *cp, *sp, *ep;
 
@@ -1038,7 +1038,7 @@ static void show_ref(struct ref_array_item *info, const char *format, int quote_
 		ep = strchr(sp, ')');
 		if (cp < sp)
 			emit(cp, sp);
-		get_value(info, parse_atom(sp + 2, ep), &atomv);
+		get_ref_atom_value(info, parse_ref_filter_atom(sp + 2, ep), &atomv);
 		print_value(atomv, quote_style);
 	}
 	if (*cp) {
@@ -1057,18 +1057,19 @@ static void show_ref(struct ref_array_item *info, const char *format, int quote_
 	putchar('\n');
 }
 
-static struct ref_sort *default_sort(void)
+/*  If no sorting option is given, use refname to sort as default */
+struct ref_sort *ref_default_sort(void)
 {
 	static const char cstr_name[] = "refname";
 
 	struct ref_sort *sort = xcalloc(1, sizeof(*sort));
 
 	sort->next = NULL;
-	sort->atom = parse_atom(cstr_name, cstr_name + strlen(cstr_name));
+	sort->atom = parse_ref_filter_atom(cstr_name, cstr_name + strlen(cstr_name));
 	return sort;
 }
 
-static int opt_parse_sort(const struct option *opt, const char *arg, int unset)
+int opt_parse_ref_sort(const struct option *opt, const char *arg, int unset)
 {
 	struct ref_sort **sort_tail = opt->value;
 	struct ref_sort *s;
@@ -1086,7 +1087,7 @@ static int opt_parse_sort(const struct option *opt, const char *arg, int unset)
 		arg++;
 	}
 	len = strlen(arg);
-	s->atom = parse_atom(arg, arg+len);
+	s->atom = parse_ref_filter_atom(arg, arg+len);
 	return 0;
 }
 
@@ -1118,7 +1119,7 @@ int cmd_for_each_ref(int argc, const char **argv, const char *prefix)
 		OPT_INTEGER( 0 , "count", &maxcount, N_("show only <n> matched refs")),
 		OPT_STRING(  0 , "format", &format, N_("format"), N_("format to use for the output")),
 		OPT_CALLBACK(0 , "sort", sort_tail, N_("key"),
-			    N_("field name to sort on"), &opt_parse_sort),
+			    N_("field name to sort on"), &opt_parse_ref_sort),
 		OPT_END(),
 	};
 
@@ -1131,24 +1132,24 @@ int cmd_for_each_ref(int argc, const char **argv, const char *prefix)
 		error("more than one quoting style?");
 		usage_with_options(for_each_ref_usage, opts);
 	}
-	if (verify_format(format))
+	if (verify_ref_format(format))
 		usage_with_options(for_each_ref_usage, opts);
 
 	if (!sort)
-		sort = default_sort();
+		sort = ref_default_sort();
 
 	/* for warn_ambiguous_refs */
 	git_config(git_default_config, NULL);
 
 	ref_cbdata.filter.name_patterns = argv;
-	for_each_rawref(grab_single_ref, &ref_cbdata);
+	for_each_rawref(ref_filter_handler, &ref_cbdata);
 
-	sort_refs(sort, &ref_cbdata.array);
+	sort_ref_array(sort, &ref_cbdata.array);
 
 	if (!maxcount || ref_cbdata.array.nr < maxcount)
 		maxcount = ref_cbdata.array.nr;
 	for (i = 0; i < maxcount; i++)
-		show_ref(ref_cbdata.array.items[i], format, quote_style);
+		show_ref_array_item(ref_cbdata.array.items[i], format, quote_style);
 	ref_filter_clear_data(&ref_cbdata);
 	return 0;
 }
-- 
2.4.1
