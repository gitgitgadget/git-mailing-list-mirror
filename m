From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v7 07/12] for-each-ref: rename some functions and make them public
Date: Thu, 11 Jun 2015 21:39:58 +0530
Message-ID: <1434039003-10928-7-git-send-email-karthik.188@gmail.com>
References: <5579B253.4020804@gmail.com>
 <1434039003-10928-1-git-send-email-karthik.188@gmail.com>
Cc: christian.couder@gmail.com, Matthieu.Moy@grenoble-inp.fr,
	Karthik Nayak <karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 11 18:22:47 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z35Fe-0005IW-Ai
	for gcvg-git-2@plane.gmane.org; Thu, 11 Jun 2015 18:22:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753457AbbFKQWl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Jun 2015 12:22:41 -0400
Received: from mail-pa0-f66.google.com ([209.85.220.66]:32986 "EHLO
	mail-pa0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752681AbbFKQWk (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Jun 2015 12:22:40 -0400
Received: by pablj1 with SMTP id lj1so2509582pab.0
        for <git@vger.kernel.org>; Thu, 11 Jun 2015 09:22:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Rpk1dTf5d532/vAYGz+FPad2ouq7dzSMZ09wHU9BmdY=;
        b=mpLmGyNhbCv/TAoVvQVhyocbBbr3OWDBBWoaLklFMNQO4HzWTLySRdIBogW1mnXDDt
         FKZJtG7jTxHn6wPcd4I9/uiuwUJg8PlN8nyr7d8kh+Dg9qQ/R5MYGrB76Kg96X1D9h4C
         1lmzZDMN+9kn3pSVjrk2QRiIAcncnARErBCIbUxANAOJUcMev0wtD/V3xyWyyrJ2fcEN
         01PJXXGbwzQ6z39b/3vFVCoT41jQ/vOTi0m27OIT1lGZFS8vvfYm8FE+U2+yZNXZi+kG
         qw1r/2me0vfj5PruIracpyK31dgAgesylZR8wg2xPbF+64oQ+sUnWcVIvtBr5prhPnhD
         fd9g==
X-Received: by 10.70.109.199 with SMTP id hu7mr16030817pdb.71.1434039039449;
        Thu, 11 Jun 2015 09:10:39 -0700 (PDT)
Received: from ashley.localdomain ([106.51.130.23])
        by mx.google.com with ESMTPSA id f4sm1132981pdc.95.2015.06.11.09.10.37
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 11 Jun 2015 09:10:38 -0700 (PDT)
X-Mailer: git-send-email 2.4.2
In-Reply-To: <1434039003-10928-1-git-send-email-karthik.188@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271435>

Rename some of the functions and make them publicly available.
This is a preparatory step for moving code from 'for-each-ref'
to 'ref-filter' to make meaningful, targeted services available to
other commands via public APIs.

Functions renamed are:
parse_atom()		-> 	parse_ref_filter_atom()
verify_format()		-> 	verify_ref_format()
get_value()		-> 	get_ref_atom_value()
grab_single_ref()	-> 	ref_filter_handler()
sort_refs()		->	ref_array_sort()
show_ref()		->	show_ref_array_item()
default_sort()		->	ref_default_sorting()
opt_parse_sort()	->	parse_opt_ref_sorting()
cmp_ref_sort()		->	cmp_ref_sorting()

Rename 'struct ref_sort' to 'struct ref_sorting' in this context.

Based-on-patch-by: Jeff King <peff@peff.net>
Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Matthieu Moy <matthieu.moy@grenoble-inp.fr>
Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 builtin/for-each-ref.c | 68 +++++++++++++++++++++++++-------------------------
 1 file changed, 34 insertions(+), 34 deletions(-)

diff --git a/builtin/for-each-ref.c b/builtin/for-each-ref.c
index 58396b2..4a6eaba 100644
--- a/builtin/for-each-ref.c
+++ b/builtin/for-each-ref.c
@@ -25,8 +25,8 @@ struct atom_value {
 	unsigned long ul; /* used for sorting when not FIELD_STR */
 };
 
-struct ref_sort {
-	struct ref_sort *next;
+struct ref_sorting {
+	struct ref_sorting *next;
 	int atom; /* index into 'struct atom_value *' array */
 	unsigned reverse : 1;
 };
@@ -113,7 +113,7 @@ static int need_color_reset_at_eol;
 /*
  * Used to parse format string and sort specifiers
  */
-static int parse_atom(const char *atom, const char *ep)
+int parse_ref_filter_atom(const char *atom, const char *ep)
 {
 	const char *sp;
 	int i, at;
@@ -190,7 +190,7 @@ static const char *find_next(const char *cp)
  * Make sure the format string is well formed, and parse out
  * the used atoms.
  */
-static int verify_format(const char *format)
+int verify_ref_format(const char *format)
 {
 	const char *cp, *sp;
 
@@ -202,7 +202,7 @@ static int verify_format(const char *format)
 		if (!ep)
 			return error("malformed format string %s", sp);
 		/* sp points at "%(" and ep points at the closing ")" */
-		at = parse_atom(sp + 2, ep);
+		at = parse_ref_filter_atom(sp + 2, ep);
 		cp = ep + 1;
 
 		if (skip_prefix(used_atom[at], "color:", &color))
@@ -409,7 +409,7 @@ static void grab_date(const char *buf, struct atom_value *v, const char *atomnam
 	/*
 	 * We got here because atomname ends in "date" or "date<something>";
 	 * it's not possible that <something> is not ":<format>" because
-	 * parse_atom() wouldn't have allowed it, so we can assume that no
+	 * parse_ref_filter_atom() wouldn't have allowed it, so we can assume that no
 	 * ":" means no format is specified, and use the default.
 	 */
 	formatp = strchr(atomname, ':');
@@ -849,7 +849,7 @@ static void populate_value(struct ref_array_item *ref)
  * Given a ref, return the value for the atom.  This lazily gets value
  * out of the object by calling populate value.
  */
-static void get_value(struct ref_array_item *ref, int atom, struct atom_value **v)
+static void get_ref_atom_value(struct ref_array_item *ref, int atom, struct atom_value **v)
 {
 	if (!ref->value) {
 		populate_value(ref);
@@ -900,8 +900,7 @@ static struct ref_array_item *new_ref_array_item(const char *refname,
  * A call-back given to for_each_ref().  Filter refs and keep them for
  * later object processing.
  */
-static int grab_single_ref(const char *refname, const struct object_id *oid,
-			   int flag, void *cb_data)
+int ref_filter_handler(const char *refname, const struct object_id *oid, int flag, void *cb_data)
 {
 	struct ref_filter_cbdata *ref_cbdata = cb_data;
 	struct ref_filter *filter = &ref_cbdata->filter;
@@ -947,14 +946,14 @@ void ref_array_clear(struct ref_array *array)
 	array->nr = array->alloc = 0;
 }
 
-static int cmp_ref_sort(struct ref_sort *s, struct ref_array_item *a, struct ref_array_item *b)
+static int cmp_ref_sorting(struct ref_sorting *s, struct ref_array_item *a, struct ref_array_item *b)
 {
 	struct atom_value *va, *vb;
 	int cmp;
 	cmp_type cmp_type = used_atom_type[s->atom];
 
-	get_value(a, s->atom, &va);
-	get_value(b, s->atom, &vb);
+	get_ref_atom_value(a, s->atom, &va);
+	get_ref_atom_value(b, s->atom, &vb);
 	switch (cmp_type) {
 	case FIELD_STR:
 		cmp = strcmp(va->s, vb->s);
@@ -971,24 +970,24 @@ static int cmp_ref_sort(struct ref_sort *s, struct ref_array_item *a, struct ref
 	return (s->reverse) ? -cmp : cmp;
 }
 
-static struct ref_sort *ref_sort;
+static struct ref_sorting *ref_sorting;
 static int compare_refs(const void *a_, const void *b_)
 {
 	struct ref_array_item *a = *((struct ref_array_item **)a_);
 	struct ref_array_item *b = *((struct ref_array_item **)b_);
-	struct ref_sort *s;
+	struct ref_sorting *s;
 
-	for (s = ref_sort; s; s = s->next) {
-		int cmp = cmp_ref_sort(s, a, b);
+	for (s = ref_sorting; s; s = s->next) {
+		int cmp = cmp_ref_sorting(s, a, b);
 		if (cmp)
 			return cmp;
 	}
 	return 0;
 }
 
-static void sort_refs(struct ref_sort *sort, struct ref_array *array)
+void ref_array_sort(struct ref_sorting *sort, struct ref_array *array)
 {
-	ref_sort = sort;
+	ref_sorting = sort;
 	qsort(array->items, array->nr, sizeof(struct ref_array_item *), compare_refs);
 }
 
@@ -1056,7 +1055,7 @@ static void emit(const char *cp, const char *ep)
 	}
 }
 
-static void show_ref(struct ref_array_item *info, const char *format, int quote_style)
+void show_ref_array_item(struct ref_array_item *info, const char *format, int quote_style)
 {
 	const char *cp, *sp, *ep;
 
@@ -1066,7 +1065,7 @@ static void show_ref(struct ref_array_item *info, const char *format, int quote_
 		ep = strchr(sp, ')');
 		if (cp < sp)
 			emit(cp, sp);
-		get_value(info, parse_atom(sp + 2, ep), &atomv);
+		get_ref_atom_value(info, parse_ref_filter_atom(sp + 2, ep), &atomv);
 		print_value(atomv, quote_style);
 	}
 	if (*cp) {
@@ -1085,21 +1084,22 @@ static void show_ref(struct ref_array_item *info, const char *format, int quote_
 	putchar('\n');
 }
 
-static struct ref_sort *default_sort(void)
+/*  If no sorting option is given, use refname to sort as default */
+struct ref_sorting *ref_default_sorting(void)
 {
 	static const char cstr_name[] = "refname";
 
-	struct ref_sort *sort = xcalloc(1, sizeof(*sort));
+	struct ref_sorting *sort = xcalloc(1, sizeof(*sort));
 
 	sort->next = NULL;
-	sort->atom = parse_atom(cstr_name, cstr_name + strlen(cstr_name));
+	sort->atom = parse_ref_filter_atom(cstr_name, cstr_name + strlen(cstr_name));
 	return sort;
 }
 
-static int opt_parse_sort(const struct option *opt, const char *arg, int unset)
+int parse_opt_ref_sorting(const struct option *opt, const char *arg, int unset)
 {
-	struct ref_sort **sort_tail = opt->value;
-	struct ref_sort *s;
+	struct ref_sorting **sort_tail = opt->value;
+	struct ref_sorting *s;
 	int len;
 
 	if (!arg) /* should --no-sort void the list ? */
@@ -1114,7 +1114,7 @@ static int opt_parse_sort(const struct option *opt, const char *arg, int unset)
 		arg++;
 	}
 	len = strlen(arg);
-	s->atom = parse_atom(arg, arg+len);
+	s->atom = parse_ref_filter_atom(arg, arg+len);
 	return 0;
 }
 
@@ -1127,7 +1127,7 @@ int cmd_for_each_ref(int argc, const char **argv, const char *prefix)
 {
 	int i;
 	const char *format = "%(objectname) %(objecttype)\t%(refname)";
-	struct ref_sort *sort = NULL, **sort_tail = &sort;
+	struct ref_sorting *sort = NULL, **sort_tail = &sort;
 	int maxcount = 0, quote_style = 0;
 	struct ref_filter_cbdata ref_cbdata;
 
@@ -1145,7 +1145,7 @@ int cmd_for_each_ref(int argc, const char **argv, const char *prefix)
 		OPT_INTEGER( 0 , "count", &maxcount, N_("show only <n> matched refs")),
 		OPT_STRING(  0 , "format", &format, N_("format"), N_("format to use for the output")),
 		OPT_CALLBACK(0 , "sort", sort_tail, N_("key"),
-			    N_("field name to sort on"), &opt_parse_sort),
+			    N_("field name to sort on"), &parse_opt_ref_sorting),
 		OPT_END(),
 	};
 
@@ -1158,25 +1158,25 @@ int cmd_for_each_ref(int argc, const char **argv, const char *prefix)
 		error("more than one quoting style?");
 		usage_with_options(for_each_ref_usage, opts);
 	}
-	if (verify_format(format))
+	if (verify_ref_format(format))
 		usage_with_options(for_each_ref_usage, opts);
 
 	if (!sort)
-		sort = default_sort();
+		sort = ref_default_sorting();
 
 	/* for warn_ambiguous_refs */
 	git_config(git_default_config, NULL);
 
 	memset(&ref_cbdata, 0, sizeof(ref_cbdata));
 	ref_cbdata.filter.name_patterns = argv;
-	for_each_rawref(grab_single_ref, &ref_cbdata);
+	for_each_rawref(ref_filter_handler, &ref_cbdata);
 
-	sort_refs(sort, &ref_cbdata.array);
+	ref_array_sort(sort, &ref_cbdata.array);
 
 	if (!maxcount || ref_cbdata.array.nr < maxcount)
 		maxcount = ref_cbdata.array.nr;
 	for (i = 0; i < maxcount; i++)
-		show_ref(ref_cbdata.array.items[i], format, quote_style);
+		show_ref_array_item(ref_cbdata.array.items[i], format, quote_style);
 	ref_array_clear(&ref_cbdata.array);
 	return 0;
 }
-- 
2.4.2
