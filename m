From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v16 02/14] ref-filter: introduce ref_formatting_state and ref_formatting_stack
Date: Sun,  6 Sep 2015 00:22:03 +0530
Message-ID: <1441479135-5285-3-git-send-email-Karthik.188@gmail.com>
References: <1441479135-5285-1-git-send-email-Karthik.188@gmail.com>
Cc: christian.couder@gmail.com, Matthieu.Moy@grenoble-inp.fr,
	gitster@pobox.com, Karthik Nayak <Karthik.188@gmail.com>,
	Karthik Nayak <karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 05 20:52:45 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZYIZs-000291-N7
	for gcvg-git-2@plane.gmane.org; Sat, 05 Sep 2015 20:52:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752133AbbIESwd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Sep 2015 14:52:33 -0400
Received: from mail-pa0-f41.google.com ([209.85.220.41]:33564 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751577AbbIESwM (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Sep 2015 14:52:12 -0400
Received: by pacex6 with SMTP id ex6so55052998pac.0
        for <git@vger.kernel.org>; Sat, 05 Sep 2015 11:52:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=MyoHN4dqCUtA/8gFsBYZZgRh+u2ucJdRnPNESCenQnY=;
        b=csvtVdpobSlgrqPboC3wp98wvsYDJQYed4eOaxTvjGVIQTN0zuFg56wvtlYPcAqw7U
         ednuZsUz6cZNSc8kYvsnWaCieNvqWP3VFn/IgTKj46VUN290IN6ll3NMs65AkOadBNZ/
         Zxn0UclGLYB0b6vdwJX/HwW2IE1C/+llqI2jHGyhQhvcYA9NdQ8Xp2pQdD1hiiTedcUE
         slVdUlYuJl0Zt9nqTd/bBFxc44AGx7d/V1mhv4X1w5mQPdGl+u2QqLP+yXmSfleHdQ9y
         3upwwhckNDqd1D4rqGZ4Y8HfvLCPgr3IrYdtZSh0G8S/TsryqG4FjOoTSjIz1Sbsf6eZ
         3Apw==
X-Received: by 10.68.247.226 with SMTP id yh2mr24259892pbc.12.1441479132056;
        Sat, 05 Sep 2015 11:52:12 -0700 (PDT)
Received: from ashley.localdomain ([106.51.130.23])
        by smtp.gmail.com with ESMTPSA id ch3sm6583639pbb.18.2015.09.05.11.52.09
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 05 Sep 2015 11:52:11 -0700 (PDT)
X-Google-Original-From: Karthik Nayak <Karthik.188@gmail.com>
X-Mailer: git-send-email 2.5.1
In-Reply-To: <1441479135-5285-1-git-send-email-Karthik.188@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277398>

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
index e53c77e..432cea0 100644
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
 
+static void push_stack_element(struct ref_formatting_stack **stack)
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
+	push_stack_element(&state.stack);
 
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
2.5.1
