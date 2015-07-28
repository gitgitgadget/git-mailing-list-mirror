From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v6 01/10] ref-filter: introduce 'ref_formatting_state'
Date: Tue, 28 Jul 2015 12:03:22 +0530
Message-ID: <1438065211-3777-1-git-send-email-Karthik.188@gmail.com>
References: <CAOLa=ZR6_2NBB4v0Ynq391=8Jk2RZON6R0YG=HKUNwKx249b7Q@mail.gmail.com>
Cc: christian.couder@gmail.com, Matthieu.Moy@grenoble-inp.fr,
	gitster@pobox.com, Karthik Nayak <Karthik.188@gmail.com>,
	Karthik Nayak <karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 28 08:33:38 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZJySF-0005Ze-8e
	for gcvg-git-2@plane.gmane.org; Tue, 28 Jul 2015 08:33:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753934AbbG1Gdb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Jul 2015 02:33:31 -0400
Received: from mail-pd0-f172.google.com ([209.85.192.172]:34690 "EHLO
	mail-pd0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751909AbbG1Gda (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Jul 2015 02:33:30 -0400
Received: by pdbbh15 with SMTP id bh15so65288930pdb.1
        for <git@vger.kernel.org>; Mon, 27 Jul 2015 23:33:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=O4c7pZS38piRVejHLQWBeiWk16x480yzBJhS1V+jgp8=;
        b=hBD+j7AHi/qUYTaHySSnrlgSOjSsuRFpq0FH1mUT4MdyB5xzfR4WNA6cEwX/4hK2gs
         g1ZD5JOWCvyMnwBrA9RdQ/Sy4bvkZLiy8gSbPP8K6T1sEirdXeMcRk2Qk7XPrb2T9k47
         q0OJFEmeMWdi3bh7IchxJAJgYj6DWEYZN/vfw+1yxEYR0CEU6n+o3nzhsasWdR/IdsDg
         ekZMpWdL9FAN+hq1qk8Vvy4FkNneVzJDLcr1XFlS/AyaN5Wvq2LBkypnruj1iltju+BE
         gXNekfLrj4821eiU0z5eworCii0G33HEt+HZbUK+2rOtGQUqC/rwZt3scerm6qvtihaS
         Z6hw==
X-Received: by 10.70.53.1 with SMTP id x1mr78030794pdo.114.1438065209870;
        Mon, 27 Jul 2015 23:33:29 -0700 (PDT)
Received: from ashley.localdomain ([106.51.130.23])
        by smtp.gmail.com with ESMTPSA id p9sm32976792pds.92.2015.07.27.23.33.27
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 27 Jul 2015 23:33:29 -0700 (PDT)
X-Google-Original-From: Karthik Nayak <Karthik.188@gmail.com>
X-Mailer: git-send-email 2.4.6
In-Reply-To: <CAOLa=ZR6_2NBB4v0Ynq391=8Jk2RZON6R0YG=HKUNwKx249b7Q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274727>

Introduce 'ref_formatting' structure to hold values of pseudo atoms
which help only in formatting. This will eventually be used by atoms
like `color` and the `padright` atom which will be introduced in a
later patch.

Helped-by: Junio C Hamano <gitster@pobox.com>
Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Matthieu Moy <matthieu.moy@grenoble-inp.fr>
Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 ref-filter.c | 71 +++++++++++++++++++++++++++++++++++++++++++++++-------------
 ref-filter.h |  5 +++++
 2 files changed, 61 insertions(+), 15 deletions(-)

diff --git a/ref-filter.c b/ref-filter.c
index 7561727..a919a14 100644
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
 
@@ -1190,30 +1192,47 @@ void ref_array_sort(struct ref_sorting *sorting, struct ref_array *array)
 	qsort(array->items, array->nr, sizeof(struct ref_array_item *), compare_refs);
 }
 
-static void print_value(struct atom_value *v, int quote_style)
+static void apply_formatting_state(struct ref_formatting_state *state,
+				   struct atom_value *v, struct strbuf *value)
 {
-	struct strbuf sb = STRBUF_INIT;
-	switch (quote_style) {
+	/*  Eventually we'll formatt based on the ref_formatting_state */
+	strbuf_addstr(value, v->s);
+}
+
+static void print_value(struct atom_value *v, struct ref_formatting_state *state)
+{
+	struct strbuf value = STRBUF_INIT;
+	struct strbuf formatted = STRBUF_INIT;
+
+	/*
+	 * Some (pesudo) atoms have no immediate side effect, but only
+	 * affect the next atom. Store the relevant information from
+	 * these atoms in the 'state' variable for use when displaying
+	 * the next atom.
+	 */
+	apply_formatting_state(state, v, &value);
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
+	strbuf_release(&value);
+	strbuf_release(&formatted);
 }
 
 static int hex1(char ch)
@@ -1254,9 +1273,26 @@ static void emit(const char *cp, const char *ep)
 	}
 }
 
+static void store_formatting_state(struct ref_formatting_state *state,
+				   struct atom_value *atomv)
+{
+	/*  Here the 'ref_formatting_state' variable will be filled */
+}
+
+static void reset_formatting_state(struct ref_formatting_state *state)
+{
+	int quote_style = state->quote_style;
+	memset(state, 0, sizeof(*state));
+	state->quote_style = quote_style;
+}
+
 void show_ref_array_item(struct ref_array_item *info, const char *format, int quote_style)
 {
 	const char *cp, *sp, *ep;
+	struct ref_formatting_state state;
+
+	memset(&state, 0, sizeof(state));
+	state.quote_style = quote_style;
 
 	for (cp = format; *cp && (sp = find_next(cp)); cp = ep + 1) {
 		struct atom_value *atomv;
@@ -1265,7 +1301,12 @@ void show_ref_array_item(struct ref_array_item *info, const char *format, int qu
 		if (cp < sp)
 			emit(cp, sp);
 		get_ref_atom_value(info, parse_ref_filter_atom(sp + 2, ep), &atomv);
-		print_value(atomv, quote_style);
+		if (atomv->modifier_atom)
+			store_formatting_state(&state, atomv);
+		else {
+			print_value(atomv, &state);
+			reset_formatting_state(&state);
+		}
 	}
 	if (*cp) {
 		sp = cp + strlen(cp);
@@ -1278,7 +1319,7 @@ void show_ref_array_item(struct ref_array_item *info, const char *format, int qu
 		if (color_parse("reset", color) < 0)
 			die("BUG: couldn't parse 'reset' as a color");
 		resetv.s = color;
-		print_value(&resetv, quote_style);
+		print_value(&resetv, &state);
 	}
 	putchar('\n');
 }
diff --git a/ref-filter.h b/ref-filter.h
index 6bf27d8..12e6a6b 100644
--- a/ref-filter.h
+++ b/ref-filter.h
@@ -19,6 +19,11 @@
 struct atom_value {
 	const char *s;
 	unsigned long ul; /* used for sorting when not FIELD_STR */
+	unsigned int modifier_atom : 1; /*  atoms which act as modifiers for the next atom */
+};
+
+struct ref_formatting_state {
+	int quote_style;
 };
 
 struct ref_sorting {
-- 
2.4.6
