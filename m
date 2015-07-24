From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v4 01/10] ref-filter: add option to align atoms to the left
Date: Sat, 25 Jul 2015 00:34:36 +0530
Message-ID: <1437764685-8633-2-git-send-email-Karthik.188@gmail.com>
References: <1437764685-8633-1-git-send-email-Karthik.188@gmail.com>
Cc: christian.couder@gmail.com, Matthieu.Moy@grenoble-inp.fr,
	gitster@pobox.com, Karthik Nayak <karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 24 21:05:55 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZIiI3-0003jO-Po
	for gcvg-git-2@plane.gmane.org; Fri, 24 Jul 2015 21:05:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932095AbbGXTFR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Jul 2015 15:05:17 -0400
Received: from mail-pa0-f54.google.com ([209.85.220.54]:35944 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752539AbbGXTFP (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Jul 2015 15:05:15 -0400
Received: by pachj5 with SMTP id hj5so18480200pac.3
        for <git@vger.kernel.org>; Fri, 24 Jul 2015 12:05:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ZmeJui2EhXR5SsKBe1q6KpQSxk1UjEjQ2/iV8Hz8TYo=;
        b=mMl5nn/Hqb4sKH4X99AUUnZXmkqIouGr+yL12JbfPH4YRww4w+uYFqxK3Uxs7cgsVT
         eIoF3JvmMLDihdNv5+mqDO1OxSnjiPW8D4dOd1Syncjy+H3zmx/SXvo2gzZ+3QYtljUA
         piMFmJ21Vtcc7Snq3QCIuR4oBLvuBHfpdTakk+1wHfdWAPU906+ywztjAJ3uKEP0Mdjn
         nbxaktj21pqYu5LIusm0pUGdQcLs2t/pVgTlDVrBXB814/sr7gMZDbNksmIQNEyAgZf8
         ZisgJw2eJpJJuo3vAvVvuar00LK5tLu2UmlRwNhVGGLytCuQAgtqNzOkshM41dZm3N6w
         bmXg==
X-Received: by 10.70.23.98 with SMTP id l2mr34300610pdf.74.1437764715026;
        Fri, 24 Jul 2015 12:05:15 -0700 (PDT)
Received: from ashley.localdomain ([106.51.130.23])
        by smtp.gmail.com with ESMTPSA id ns14sm15922915pdb.17.2015.07.24.12.05.12
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 24 Jul 2015 12:05:13 -0700 (PDT)
X-Google-Original-From: Karthik Nayak <Karthik.188@gmail.com>
X-Mailer: git-send-email 2.4.6
In-Reply-To: <1437764685-8633-1-git-send-email-Karthik.188@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274586>

From: Karthik Nayak <karthik.188@gmail.com>

Add a new atom "align" and support %(align:X) where X is a number.
This will align the preceeding atom value to the left followed by
spaces for a total length of X characters. If X is less than the item
size, the entire atom value is printed.

Helped-by: Duy Nguyen <pclouds@gmail.com>
Helped-by: Junio C Hamano <gitster@pobox.com>
Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Matthieu Moy <matthieu.moy@grenoble-inp.fr>
Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 ref-filter.c | 93 ++++++++++++++++++++++++++++++++++++++++++++++--------------
 ref-filter.h |  6 ++++
 2 files changed, 77 insertions(+), 22 deletions(-)

diff --git a/ref-filter.c b/ref-filter.c
index 7561727..3c90ffc 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -10,6 +10,8 @@
 #include "quote.h"
 #include "ref-filter.h"
 #include "revision.h"
+#include "utf8.h"
+#include "git-compat-util.h"
 
 typedef enum { FIELD_STR, FIELD_ULONG, FIELD_TIME } cmp_type;
 
@@ -53,6 +55,7 @@ static struct {
 	{ "flag" },
 	{ "HEAD" },
 	{ "color" },
+	{ "align" },
 };
 
 /*
@@ -597,7 +600,8 @@ static inline char *copy_advance(char *dst, const char *src)
 /*
  * Parse the object referred by ref, and grab needed value.
  */
-static void populate_value(struct ref_array_item *ref)
+static void populate_value(struct ref_formatting_state *state,
+			   struct ref_array_item *ref)
 {
 	void *buf;
 	struct object *obj;
@@ -620,7 +624,7 @@ static void populate_value(struct ref_array_item *ref)
 		const char *name = used_atom[i];
 		struct atom_value *v = &ref->value[i];
 		int deref = 0;
-		const char *refname;
+		const char *refname = NULL;
 		const char *formatp;
 		struct branch *branch = NULL;
 
@@ -687,6 +691,18 @@ static void populate_value(struct ref_array_item *ref)
 			else
 				v->s = " ";
 			continue;
+		} else if (starts_with(name, "align:")) {
+			const char *valp = NULL;
+
+			skip_prefix(name, "align:", &valp);
+			if (!valp[0])
+				die(_("no value given with 'align:'"));
+			if (strtoul_ui(valp, 10, &state->pad_to_right))
+				die(_("positive integer expected after ':' in align:%u\n"),
+				    state->pad_to_right);
+			v->pseudo_atom = 1;
+			v->s = "";
+			continue;
 		} else
 			continue;
 
@@ -809,10 +825,15 @@ static void populate_value(struct ref_array_item *ref)
  * Given a ref, return the value for the atom.  This lazily gets value
  * out of the object by calling populate value.
  */
-static void get_ref_atom_value(struct ref_array_item *ref, int atom, struct atom_value **v)
+static void get_ref_atom_value(struct ref_formatting_state *state,
+			       struct ref_array_item *ref, int atom, struct atom_value **v)
 {
-	if (!ref->value) {
-		populate_value(ref);
+	/*
+	 * If the atom is a pseudo_atom then we re-populate the value
+	 * into the ref_formatting_state stucture.
+	 */
+	if (!ref->value || ref->value[atom].pseudo_atom) {
+		populate_value(state, ref);
 		fill_missing_values(ref->value);
 	}
 	*v = &ref->value[atom];
@@ -1150,9 +1171,12 @@ static int cmp_ref_sorting(struct ref_sorting *s, struct ref_array_item *a, stru
 	struct atom_value *va, *vb;
 	int cmp;
 	cmp_type cmp_type = used_atom_type[s->atom];
+	struct ref_formatting_state state;
 
-	get_ref_atom_value(a, s->atom, &va);
-	get_ref_atom_value(b, s->atom, &vb);
+	memset(&state, 0, sizeof(state));
+
+	get_ref_atom_value(&state, a, s->atom, &va);
+	get_ref_atom_value(&state, b, s->atom, &vb);
 	switch (cmp_type) {
 	case FIELD_STR:
 		cmp = strcmp(va->s, vb->s);
@@ -1190,30 +1214,50 @@ void ref_array_sort(struct ref_sorting *sorting, struct ref_array *array)
 	qsort(array->items, array->nr, sizeof(struct ref_array_item *), compare_refs);
 }
 
-static void print_value(struct atom_value *v, int quote_style)
+static void ref_formatting(struct ref_formatting_state *state, struct atom_value *v,
+			   struct strbuf *value)
 {
-	struct strbuf sb = STRBUF_INIT;
-	switch (quote_style) {
+	if (state->pad_to_right) {
+		if (!is_utf8(v->s))
+			strbuf_addf(value, "%-*s", state->pad_to_right, v->s);
+		else {
+			int len = strlen(v->s) - utf8_strwidth(v->s);
+			strbuf_addf(value, "%-*s", state->pad_to_right + len, v->s);
+		}
+	} else
+		strbuf_addf(value, "%s", v->s);
+}
+
+static void print_value(struct ref_formatting_state *state, struct atom_value *v)
+{
+	struct strbuf value = STRBUF_INIT;
+	struct strbuf formatted = STRBUF_INIT;
+
+	if (v->pseudo_atom)
+		return;
+	ref_formatting(state, v, &value);
+
+	switch (state->quote_style) {
 	case QUOTE_NONE:
-		fputs(v->s, stdout);
+		fputs(value.buf, stdout);
 		break;
 	case QUOTE_SHELL:
-		sq_quote_buf(&sb, v->s);
+		sq_quote_buf(&formatted, value.buf);
 		break;
 	case QUOTE_PERL:
-		perl_quote_buf(&sb, v->s);
+		perl_quote_buf(&formatted, value.buf);
 		break;
 	case QUOTE_PYTHON:
-		python_quote_buf(&sb, v->s);
+		python_quote_buf(&formatted, value.buf);
 		break;
 	case QUOTE_TCL:
-		tcl_quote_buf(&sb, v->s);
+		tcl_quote_buf(&formatted, value.buf);
 		break;
 	}
-	if (quote_style != QUOTE_NONE) {
-		fputs(sb.buf, stdout);
-		strbuf_release(&sb);
-	}
+	if (state->quote_style != QUOTE_NONE)
+		fputs(formatted.buf, stdout);
+	strbuf_release(&formatted);
+	strbuf_release(&value);
 }
 
 static int hex1(char ch)
@@ -1257,6 +1301,10 @@ static void emit(const char *cp, const char *ep)
 void show_ref_array_item(struct ref_array_item *info, const char *format, int quote_style)
 {
 	const char *cp, *sp, *ep;
+	struct ref_formatting_state state;
+
+	memset(&state, 0, sizeof(state));
+	state.quote_style = quote_style;
 
 	for (cp = format; *cp && (sp = find_next(cp)); cp = ep + 1) {
 		struct atom_value *atomv;
@@ -1264,8 +1312,9 @@ void show_ref_array_item(struct ref_array_item *info, const char *format, int qu
 		ep = strchr(sp, ')');
 		if (cp < sp)
 			emit(cp, sp);
-		get_ref_atom_value(info, parse_ref_filter_atom(sp + 2, ep), &atomv);
-		print_value(atomv, quote_style);
+		get_ref_atom_value(&state, info,
+				   parse_ref_filter_atom(sp + 2, ep), &atomv);
+		print_value(&state, atomv);
 	}
 	if (*cp) {
 		sp = cp + strlen(cp);
@@ -1278,7 +1327,7 @@ void show_ref_array_item(struct ref_array_item *info, const char *format, int qu
 		if (color_parse("reset", color) < 0)
 			die("BUG: couldn't parse 'reset' as a color");
 		resetv.s = color;
-		print_value(&resetv, quote_style);
+		print_value(&state, &resetv);
 	}
 	putchar('\n');
 }
diff --git a/ref-filter.h b/ref-filter.h
index 6bf27d8..ea2d0e6 100644
--- a/ref-filter.h
+++ b/ref-filter.h
@@ -19,6 +19,7 @@
 struct atom_value {
 	const char *s;
 	unsigned long ul; /* used for sorting when not FIELD_STR */
+	unsigned int pseudo_atom : 1; /*  atoms which aren't placeholders for ref attributes */
 };
 
 struct ref_sorting {
@@ -27,6 +28,11 @@ struct ref_sorting {
 	unsigned reverse : 1;
 };
 
+struct ref_formatting_state {
+	unsigned int pad_to_right; /*pad atoms to the right*/
+	int quote_style;
+};
+
 struct ref_array_item {
 	unsigned char objectname[20];
 	int flag;
-- 
2.4.6
