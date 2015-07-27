From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v5 01/11] ref-filter: introduce 'ref_formatting_state'
Date: Mon, 27 Jul 2015 12:57:05 +0530
Message-ID: <1437982035-6658-1-git-send-email-Karthik.188@gmail.com>
References: <CAOLa=ZTtAepdO5U8zo62VBn_z4-LcKoguPxVGaAnNZULEwzrQQ@mail.gmail.com>
Cc: christian.couder@gmail.com, Matthieu.Moy@grenoble-inp.fr,
	gitster@pobox.com, Karthik Nayak <Karthik.188@gmail.com>,
	Karthik Nayak <karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 27 09:27:21 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZJcoh-0000W6-30
	for gcvg-git-2@plane.gmane.org; Mon, 27 Jul 2015 09:27:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751090AbbG0H1P (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Jul 2015 03:27:15 -0400
Received: from mail-pa0-f45.google.com ([209.85.220.45]:34871 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751007AbbG0H1O (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Jul 2015 03:27:14 -0400
Received: by pabkd10 with SMTP id kd10so47112845pab.2
        for <git@vger.kernel.org>; Mon, 27 Jul 2015 00:27:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=HxHP2ENLltESWvci/xbb2qF9Nci8585SIEVF6bvNT0Y=;
        b=cDMgKK3XLNFOybgSaF4hn7vdfxId9KnOH1q0nSwLO0GnatiiYkNHCeASKWjhe8VUKV
         6cMb06ssv8isrrtzpIohYMOkZkEn2z91ZPvtlxi4tYj35Wl3rCbNx7grbHew8RajJA79
         E2RA2jRNbtPsFoOv78wSF4khfsWd0SE5RKofeiy3oJhG3BFH23ikJTS6O811rZF6IZWz
         UZ80vkg1UynVdCG5XwsdlZzQE9W5uzsOGVVqxlgNN8I4VA45l+nIDO213IJ5F6CJLWZM
         O4VvM43EfusVg634aE5LVmNa37wWOcXPAxm62FFsCWl2GUCWgwh5Wj1F7UQlZRoJyAsa
         qtLA==
X-Received: by 10.66.62.133 with SMTP id y5mr66217525par.8.1437982033692;
        Mon, 27 Jul 2015 00:27:13 -0700 (PDT)
Received: from ashley.localdomain ([106.51.241.234])
        by smtp.gmail.com with ESMTPSA id wv4sm27732769pac.2.2015.07.27.00.27.11
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 27 Jul 2015 00:27:13 -0700 (PDT)
X-Google-Original-From: Karthik Nayak <Karthik.188@gmail.com>
X-Mailer: git-send-email 2.4.6
In-Reply-To: <CAOLa=ZTtAepdO5U8zo62VBn_z4-LcKoguPxVGaAnNZULEwzrQQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274651>

Introduce 'ref_formatting' structure to hold values of pseudo atoms
which help only in formatting. This will eventually be used by atoms
like `color` and the `padright` atom which will be introduced in a
later patch.

Helped-by: Junio C Hamano <gitster@pobox.com>
Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Matthieu Moy <matthieu.moy@grenoble-inp.fr>
Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 ref-filter.c | 46 +++++++++++++++++++++++++++++++---------------
 ref-filter.h |  5 +++++
 2 files changed, 36 insertions(+), 15 deletions(-)

diff --git a/ref-filter.c b/ref-filter.c
index 7561727..a3625e8 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -10,6 +10,8 @@
 #include "quote.h"
 #include "ref-filter.h"
 #include "revision.h"
+#include "utf8.h"
+#include "git-compat-util.h"
 
 typedef enum { FIELD_STR, FIELD_ULONG, FIELD_TIME } cmp_type;
 
@@ -620,7 +622,7 @@ static void populate_value(struct ref_array_item *ref)
 		const char *name = used_atom[i];
 		struct atom_value *v = &ref->value[i];
 		int deref = 0;
-		const char *refname;
+		const char *refname = NULL;
 		const char *formatp;
 		struct branch *branch = NULL;
 
@@ -1190,30 +1192,40 @@ void ref_array_sort(struct ref_sorting *sorting, struct ref_array *array)
 	qsort(array->items, array->nr, sizeof(struct ref_array_item *), compare_refs);
 }
 
-static void print_value(struct atom_value *v, int quote_style)
+static void ref_formatting(struct ref_formatting_state *state,
+			   struct atom_value *v, struct strbuf *value)
 {
-	struct strbuf sb = STRBUF_INIT;
-	switch (quote_style) {
+	strbuf_addf(value, "%s", v->s);
+}
+
+static void print_value(struct ref_formatting_state *state, struct atom_value *v)
+{
+	struct strbuf value = STRBUF_INIT;
+	struct strbuf formatted = STRBUF_INIT;
+
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
@@ -1257,6 +1269,10 @@ static void emit(const char *cp, const char *ep)
 void show_ref_array_item(struct ref_array_item *info, const char *format, int quote_style)
 {
 	const char *cp, *sp, *ep;
+	struct ref_formatting_state state;
+
+	memset(&state, 0, sizeof(state));
+	state.quote_style = quote_style;
 
 	for (cp = format; *cp && (sp = find_next(cp)); cp = ep + 1) {
 		struct atom_value *atomv;
@@ -1265,7 +1281,7 @@ void show_ref_array_item(struct ref_array_item *info, const char *format, int qu
 		if (cp < sp)
 			emit(cp, sp);
 		get_ref_atom_value(info, parse_ref_filter_atom(sp + 2, ep), &atomv);
-		print_value(atomv, quote_style);
+		print_value(&state, atomv);
 	}
 	if (*cp) {
 		sp = cp + strlen(cp);
@@ -1278,7 +1294,7 @@ void show_ref_array_item(struct ref_array_item *info, const char *format, int qu
 		if (color_parse("reset", color) < 0)
 			die("BUG: couldn't parse 'reset' as a color");
 		resetv.s = color;
-		print_value(&resetv, quote_style);
+		print_value(&state, &resetv);
 	}
 	putchar('\n');
 }
diff --git a/ref-filter.h b/ref-filter.h
index 6bf27d8..f24e3ef 100644
--- a/ref-filter.h
+++ b/ref-filter.h
@@ -19,6 +19,11 @@
 struct atom_value {
 	const char *s;
 	unsigned long ul; /* used for sorting when not FIELD_STR */
+	unsigned int pseudo_atom : 1; /*  atoms which aren't placeholders for ref attributes */
+};
+
+struct ref_formatting_state {
+	int quote_style;
 };
 
 struct ref_sorting {
-- 
2.4.6
