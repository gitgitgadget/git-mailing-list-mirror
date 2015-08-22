From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v13 02/12] ref-filter: introduce ref_formatting_state and ref_formatting_stack
Date: Sat, 22 Aug 2015 09:09:38 +0530
Message-ID: <1440214788-1309-3-git-send-email-Karthik.188@gmail.com>
References: <1440214788-1309-1-git-send-email-Karthik.188@gmail.com>
Cc: christian.couder@gmail.com, Matthieu.Moy@grenoble-inp.fr,
	gitster@pobox.com, Karthik Nayak <Karthik.188@gmail.com>,
	Karthik Nayak <karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 22 05:40:02 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZSzew-0002CT-Cl
	for gcvg-git-2@plane.gmane.org; Sat, 22 Aug 2015 05:39:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753035AbbHVDjv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Aug 2015 23:39:51 -0400
Received: from mail-pa0-f51.google.com ([209.85.220.51]:33436 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752520AbbHVDjv (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Aug 2015 23:39:51 -0400
Received: by pacgr6 with SMTP id gr6so6589769pac.0
        for <git@vger.kernel.org>; Fri, 21 Aug 2015 20:39:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=K4baGXKA80q9DkMRU+BCnfFYxoiV6F3HTWvN3Rx1pBk=;
        b=H1gDjiOgAHocytOR7tVlPZLmt+qJNyCZf6Q52Jc4q+gLus4z55kTjJXlIkqZlvcC8k
         YeZqj4OX4MUEgNFryx83Lqk0rdJDnDY6/7lGAu2a0LJ2ibcf7D1W3rKiR36eYeKoyDHc
         GqUwlBChqbjNRTcHUV31xE64ULsdLpxiru9OOcMqYQ9bQyrDxI8Nar/l8Jzuno8mLexD
         6XoBaEzdV3rHc0M6Eb+TxeCOrKNU4VhCVbHLb+XFhg9fqLO9Q7aNT6E7kTjnYNwmz2EM
         5pJIiPGevZKzZaxwlGc1Pp5aiQEQXalgNazrHG6XnN9KxBGrICPimK02A1OiiCQxMIqf
         WCrw==
X-Received: by 10.66.245.142 with SMTP id xo14mr23162614pac.151.1440214790420;
        Fri, 21 Aug 2015 20:39:50 -0700 (PDT)
Received: from ashley.localdomain ([106.51.130.23])
        by smtp.gmail.com with ESMTPSA id e4sm9393515pdd.45.2015.08.21.20.39.48
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 21 Aug 2015 20:39:50 -0700 (PDT)
X-Google-Original-From: Karthik Nayak <Karthik.188@gmail.com>
X-Mailer: git-send-email 2.5.0
In-Reply-To: <1440214788-1309-1-git-send-email-Karthik.188@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276366>

Introduce ref_formatting_state which will hold the formatted output
strbuf instead of directly printing to stdout. This will help us in
creating modifier atoms which modify the format specified before
printing to stdout.

Implement a stack machinery for ref_formatting_state, this allows us
to push and pop elements onto the stack. Whenever we pop an element
from the stack, the strbuf from that element is appended to the strbuf
of the next element on the stack, this will allow us to support
nesting of modifier atoms.

Rename some functions to reflect the changes made:
print_value() -> append_atom()
emit()        -> append_literal()

Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Matthieu Moy <matthieu.moy@grenoble-inp.fr>
Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 ref-filter.c | 78 +++++++++++++++++++++++++++++++++++++++++++++---------------
 1 file changed, 59 insertions(+), 19 deletions(-)

diff --git a/ref-filter.c b/ref-filter.c
index e53c77e..d0d8df0 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -55,6 +55,18 @@ static struct {
 	{ "color" },
 };
 
+#define REF_FORMATTING_STATE_INIT  { 0, NULL }
+
+struct ref_formatting_stack {
+	struct ref_formatting_stack *prev;
+	struct strbuf output;
+};
+
+struct ref_formatting_state {
+	int quote_style;
+	struct ref_formatting_stack *stack;
+};
+
 struct atom_value {
 	const char *s;
 	unsigned long ul; /* used for sorting when not FIELD_STR */
@@ -129,6 +141,27 @@ int parse_ref_filter_atom(const char *atom, const char *ep)
 	return at;
 }
 
+static void push_new_stack_element(struct ref_formatting_stack **stack)
+{
+	struct ref_formatting_stack *s = xcalloc(1, sizeof(struct ref_formatting_stack));
+
+	strbuf_init(&s->output, 0);
+	s->prev = *stack;
+	*stack = s;
+}
+
+static void pop_stack_element(struct ref_formatting_stack **stack)
+{
+	struct ref_formatting_stack *current = *stack;
+	struct ref_formatting_stack *prev = current->prev;
+
+	if (prev)
+		strbuf_addbuf(&prev->output, &current->output);
+	strbuf_release(&current->output);
+	free(current);
+	*stack = prev;
+}
+
 /*
  * In a format string, find the next occurrence of %(atom).
  */
@@ -1195,30 +1228,27 @@ void ref_array_sort(struct ref_sorting *sorting, struct ref_array *array)
 	qsort(array->items, array->nr, sizeof(struct ref_array_item *), compare_refs);
 }
 
-static void print_value(struct atom_value *v, int quote_style)
+static void append_atom(struct atom_value *v, struct ref_formatting_state *state)
 {
-	struct strbuf sb = STRBUF_INIT;
-	switch (quote_style) {
+	struct strbuf *s = &state->stack->output;
+
+	switch (state->quote_style) {
 	case QUOTE_NONE:
-		fputs(v->s, stdout);
+		strbuf_addstr(s, v->s);
 		break;
 	case QUOTE_SHELL:
-		sq_quote_buf(&sb, v->s);
+		sq_quote_buf(s, v->s);
 		break;
 	case QUOTE_PERL:
-		perl_quote_buf(&sb, v->s);
+		perl_quote_buf(s, v->s);
 		break;
 	case QUOTE_PYTHON:
-		python_quote_buf(&sb, v->s);
+		python_quote_buf(s, v->s);
 		break;
 	case QUOTE_TCL:
-		tcl_quote_buf(&sb, v->s);
+		tcl_quote_buf(s, v->s);
 		break;
 	}
-	if (quote_style != QUOTE_NONE) {
-		fputs(sb.buf, stdout);
-		strbuf_release(&sb);
-	}
 }
 
 static int hex1(char ch)
@@ -1239,8 +1269,10 @@ static int hex2(const char *cp)
 		return -1;
 }
 
-static void emit(const char *cp, const char *ep)
+static void append_literal(const char *cp, const char *ep, struct ref_formatting_state *state)
 {
+	struct strbuf *s = &state->stack->output;
+
 	while (*cp && (!ep || cp < ep)) {
 		if (*cp == '%') {
 			if (cp[1] == '%')
@@ -1248,13 +1280,13 @@ static void emit(const char *cp, const char *ep)
 			else {
 				int ch = hex2(cp + 1);
 				if (0 <= ch) {
-					putchar(ch);
+					strbuf_addch(s, ch);
 					cp += 3;
 					continue;
 				}
 			}
 		}
-		putchar(*cp);
+		strbuf_addch(s, *cp);
 		cp++;
 	}
 }
@@ -1262,19 +1294,24 @@ static void emit(const char *cp, const char *ep)
 void show_ref_array_item(struct ref_array_item *info, const char *format, int quote_style)
 {
 	const char *cp, *sp, *ep;
+	struct strbuf *final_buf;
+	struct ref_formatting_state state = REF_FORMATTING_STATE_INIT;
+
+	state.quote_style = quote_style;
+	push_new_stack_element(&state.stack);
 
 	for (cp = format; *cp && (sp = find_next(cp)); cp = ep + 1) {
 		struct atom_value *atomv;
 
 		ep = strchr(sp, ')');
 		if (cp < sp)
-			emit(cp, sp);
+			append_literal(cp, sp, &state);
 		get_ref_atom_value(info, parse_ref_filter_atom(sp + 2, ep), &atomv);
-		print_value(atomv, quote_style);
+		append_atom(atomv, &state);
 	}
 	if (*cp) {
 		sp = cp + strlen(cp);
-		emit(cp, sp);
+		append_literal(cp, sp, &state);
 	}
 	if (need_color_reset_at_eol) {
 		struct atom_value resetv;
@@ -1283,8 +1320,11 @@ void show_ref_array_item(struct ref_array_item *info, const char *format, int qu
 		if (color_parse("reset", color) < 0)
 			die("BUG: couldn't parse 'reset' as a color");
 		resetv.s = color;
-		print_value(&resetv, quote_style);
+		append_atom(&resetv, &state);
 	}
+	final_buf = &state.stack->output;
+	fwrite(final_buf->buf, 1, final_buf->len, stdout);
+	pop_stack_element(&state.stack);
 	putchar('\n');
 }
 
-- 
2.5.0
