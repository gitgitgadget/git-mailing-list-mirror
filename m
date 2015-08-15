From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v11 03/13] ref-filter: introduce ref_formatting_state
Date: Sat, 15 Aug 2015 23:30:33 +0530
Message-ID: <1439661643-16094-4-git-send-email-Karthik.188@gmail.com>
Cc: christian.couder@gmail.com, Matthieu.Moy@grenoble-inp.fr,
	gitster@pobox.com, Karthik Nayak <Karthik.188@gmail.com>,
	Karthik Nayak <karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 15 20:00:58 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZQflI-0001Hw-J9
	for gcvg-git-2@plane.gmane.org; Sat, 15 Aug 2015 20:00:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754158AbbHOSAy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Aug 2015 14:00:54 -0400
Received: from mail-pa0-f45.google.com ([209.85.220.45]:34695 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754086AbbHOSAq (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Aug 2015 14:00:46 -0400
Received: by paccq16 with SMTP id cq16so35890092pac.1
        for <git@vger.kernel.org>; Sat, 15 Aug 2015 11:00:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=iEDWi7xJsH3FKCGTAwvy7MSjdJp5Z6uaQ/q7xqWYhFU=;
        b=nm0F6VM1sAkmq4emh2NG8Evo0hGaPVzWZo24JruRu91f72ur3v/Tcwpqqd7KSLVqLr
         VWkCjWyjnW8rfR9SfO+xxz/rtOULgBRYtCyjWIxguDrmHGx/TtWQUR2XhUDwCav0Cb+3
         Y6CGdUdChrZtv4qkXAcyjp2B1gGEiN7ybHLRNadvA+cBSObMAVols10MDyCjp4/O1yru
         pIoUnj78AXOMeqluxKXBAhVqxMfMtdaMLrI6Nc57b5W4m601+wajgN+z9tSQKBCqcgeP
         2KRTQZW1T2ZkOpTkMLRgG7jlk7aiIcRlKXcer/HFRQdwOIJft0TyIymJssgUNExpzwGD
         eXWg==
X-Received: by 10.68.95.4 with SMTP id dg4mr101136222pbb.132.1439661646190;
        Sat, 15 Aug 2015 11:00:46 -0700 (PDT)
Received: from ashley.localdomain ([106.51.130.23])
        by smtp.gmail.com with ESMTPSA id pe3sm9424144pdb.55.2015.08.15.11.00.43
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 15 Aug 2015 11:00:45 -0700 (PDT)
X-Google-Original-From: Karthik Nayak <Karthik.188@gmail.com>
X-Mailer: git-send-email 2.5.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275995>

Introduce ref_formatting_state which will hold the formatted
output strbuf and is used for nesting of modifier atoms.

Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Matthieu Moy <matthieu.moy@grenoble-inp.fr>
Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 ref-filter.c | 65 ++++++++++++++++++++++++++++++++++++++++++++----------------
 1 file changed, 48 insertions(+), 17 deletions(-)

diff --git a/ref-filter.c b/ref-filter.c
index edfb1c7..3259363 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -55,6 +55,12 @@ static struct {
 	{ "color" },
 };
 
+struct ref_formatting_state {
+	struct strbuf output;
+	struct ref_formatting_state *prev;
+	int quote_style;
+};
+
 struct atom_value {
 	const char *s;
 	unsigned long ul; /* used for sorting when not FIELD_STR */
@@ -129,6 +135,26 @@ int parse_ref_filter_atom(const char *atom, const char *ep)
 	return at;
 }
 
+static struct ref_formatting_state *push_new_state(struct ref_formatting_state **state)
+{
+	struct ref_formatting_state *new_state = xcalloc(1, sizeof(struct ref_formatting_state));
+	struct ref_formatting_state *tmp = *state;
+
+	*state = new_state;
+	new_state->prev = tmp;
+	return new_state;
+}
+
+static void pop_state(struct ref_formatting_state **state)
+{
+	struct ref_formatting_state *current = *state;
+	struct ref_formatting_state *prev = current->prev;
+
+	strbuf_release(&current->output);
+	free(current);
+	*state = prev;
+}
+
 /*
  * In a format string, find the next occurrence of %(atom).
  */
@@ -1195,23 +1221,23 @@ void ref_array_sort(struct ref_sorting *sorting, struct ref_array *array)
 	qsort(array->items, array->nr, sizeof(struct ref_array_item *), compare_refs);
 }
 
-static void append_atom(struct atom_value *v, int quote_style, struct strbuf *output)
+static void append_atom(struct atom_value *v, struct ref_formatting_state *state)
 {
-	switch (quote_style) {
+	switch (state->quote_style) {
 	case QUOTE_NONE:
-		strbuf_addstr(output, v->s);
+		strbuf_addstr(&state->output, v->s);
 		break;
 	case QUOTE_SHELL:
-		sq_quote_buf(output, v->s);
+		sq_quote_buf(&state->output, v->s);
 		break;
 	case QUOTE_PERL:
-		perl_quote_buf(output, v->s);
+		perl_quote_buf(&state->output, v->s);
 		break;
 	case QUOTE_PYTHON:
-		python_quote_buf(output, v->s);
+		python_quote_buf(&state->output, v->s);
 		break;
 	case QUOTE_TCL:
-		tcl_quote_buf(output, v->s);
+		tcl_quote_buf(&state->output, v->s);
 		break;
 	}
 }
@@ -1234,7 +1260,7 @@ static int hex2(const char *cp)
 		return -1;
 }
 
-static void append_literal(const char *cp, const char *ep, struct strbuf *output)
+static void append_literal(const char *cp, const char *ep, struct ref_formatting_state *state)
 {
 	while (*cp && (!ep || cp < ep)) {
 		if (*cp == '%') {
@@ -1243,13 +1269,13 @@ static void append_literal(const char *cp, const char *ep, struct strbuf *output
 			else {
 				int ch = hex2(cp + 1);
 				if (0 <= ch) {
-					strbuf_addch(output, ch);
+					strbuf_addch(&state->output, ch);
 					cp += 3;
 					continue;
 				}
 			}
 		}
-		strbuf_addch(output, *cp);
+		strbuf_addch(&state->output, *cp);
 		cp++;
 	}
 }
@@ -1257,20 +1283,24 @@ static void append_literal(const char *cp, const char *ep, struct strbuf *output
 void show_ref_array_item(struct ref_array_item *info, const char *format, int quote_style)
 {
 	const char *cp, *sp, *ep;
-	struct strbuf output = STRBUF_INIT;
+	struct strbuf *final_buf;
+	struct ref_formatting_state *state = NULL;
+
+	state = push_new_state(&state);
+	state->quote_style = quote_style;
 
 	for (cp = format; *cp && (sp = find_next(cp)); cp = ep + 1) {
 		struct atom_value *atomv;
 
 		ep = strchr(sp, ')');
 		if (cp < sp)
-			append_literal(cp, sp, &output);
+			append_literal(cp, sp, state);
 		get_ref_atom_value(info, parse_ref_filter_atom(sp + 2, ep), &atomv);
-		append_atom(atomv, quote_style, &output);
+		append_atom(atomv, state);
 	}
 	if (*cp) {
 		sp = cp + strlen(cp);
-		append_literal(cp, sp, &output);
+		append_literal(cp, sp, state);
 	}
 	if (need_color_reset_at_eol) {
 		struct atom_value resetv;
@@ -1279,11 +1309,12 @@ void show_ref_array_item(struct ref_array_item *info, const char *format, int qu
 		if (color_parse("reset", color) < 0)
 			die("BUG: couldn't parse 'reset' as a color");
 		resetv.s = color;
-		append_atom(&resetv, quote_style, &output);
+		append_atom(&resetv, state);
 	}
-	fwrite(output.buf, 1, output.len, stdout);
+	final_buf = &state->output;
+	fwrite(final_buf->buf, 1, final_buf->len, stdout);
+	pop_state(&state);
 	putchar('\n');
-	strbuf_release(&output);
 }
 
 /*  If no sorting option is given, use refname to sort as default */
-- 
2.5.0
