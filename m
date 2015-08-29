From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v14 04/13] ref-filter: implement an `align` atom
Date: Sat, 29 Aug 2015 19:42:08 +0530
Message-ID: <1440857537-13968-5-git-send-email-Karthik.188@gmail.com>
References: <1440857537-13968-1-git-send-email-Karthik.188@gmail.com>
Cc: christian.couder@gmail.com, Matthieu.Moy@grenoble-inp.fr,
	gitster@pobox.com, Karthik Nayak <Karthik.188@gmail.com>,
	Karthik Nayak <karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 29 16:12:32 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZVgrt-0003dq-8A
	for gcvg-git-2@plane.gmane.org; Sat, 29 Aug 2015 16:12:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752738AbbH2OMZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 29 Aug 2015 10:12:25 -0400
Received: from mail-pa0-f51.google.com ([209.85.220.51]:32952 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752736AbbH2OMX (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 29 Aug 2015 10:12:23 -0400
Received: by pacgr6 with SMTP id gr6so4979239pac.0
        for <git@vger.kernel.org>; Sat, 29 Aug 2015 07:12:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=b25sala73RIWVj5cnHBSkbzh9qzBg1vUr42c2p5SkYQ=;
        b=rjxPUfzN6sg+kavMDjAPRQy1jJgi37eHntZrX528Isqw6lEy1Xtl3K43cFj3ukCMhG
         GZZcksVAPp87VCyf069Jau+tr+MYIqClv+q+tAmRxHAJbR+78Pb6HT5tb6NhIHlV3lO9
         nELteZQ5m7cXH0aL6TwZ0jULohWtNLFer51SoUl5rEL4aGGZh6ObbNgWvlCbDLTt+aEH
         iDIrxu+mWxSQ1OyS/QSbqwU0voVupWyadAg+9yeWePwTtwmbjd9lCm/9znnoUpz2GCLA
         ei2dwFm81zGTLKxxNy6VtUTUQZDCGGBSlshAxTw2swfy8REbdJCbR2wGX5UQ3LGN6I+J
         A7Xg==
X-Received: by 10.66.175.7 with SMTP id bw7mr22903055pac.155.1440857542961;
        Sat, 29 Aug 2015 07:12:22 -0700 (PDT)
Received: from ashley.localdomain ([106.51.130.23])
        by smtp.gmail.com with ESMTPSA id hy5sm8876807pac.22.2015.08.29.07.12.20
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 29 Aug 2015 07:12:21 -0700 (PDT)
X-Google-Original-From: Karthik Nayak <Karthik.188@gmail.com>
X-Mailer: git-send-email 2.5.0
In-Reply-To: <1440857537-13968-1-git-send-email-Karthik.188@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276781>

Implement an `align` atom which left-, middle-, or right-aligns the
content between %(align:..) and %(end).

It is followed by `:<width>,<position>`, where the `<position>` is
either left, right or middle and `<width>` is the size of the area
into which the content will be placed. If the content between
%(align:) and %(end) is more than the width then no alignment is
performed. e.g. to align a refname atom to the middle with a total
width of 40 we can do: --format="%(align:middle,40)%(refname)%(end)".

We now have a `handler()` for each atom_value which will be called
when that atom_value is being parsed, and similarly an `at_end`
function for each element of the stack which is to be called when the
`end` atom is encountered. Using this we implement the `align` atom
which aligns the given strbuf by calling `strbuf_utf8_align()` from
utf8.c.

Extract perform_quote_formatting() from append_atom(). Given a string
a quote_value and a strbuf, perform_quote_formatting() formats the
string based on the quote_value and stores it into the strbuf.

Ensure that quote formatting is performed on the whole of
%(align)...%(end) rather than individual atoms. We do this by skipping
individual quote formatting for atoms whenever the stack has more than
one element, and performing formatting for the entire stack element
when the `%(end)` atoms is encountered.

Add documentation and tests for the same.

Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Matthieu Moy <matthieu.moy@grenoble-inp.fr>
Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 Documentation/git-for-each-ref.txt |   9 +++
 ref-filter.c                       | 151 +++++++++++++++++++++++++++++++------
 t/t6302-for-each-ref-filter.sh     |  85 +++++++++++++++++++++
 3 files changed, 221 insertions(+), 24 deletions(-)

diff --git a/Documentation/git-for-each-ref.txt b/Documentation/git-for-each-ref.txt
index e49d578..943975d 100644
--- a/Documentation/git-for-each-ref.txt
+++ b/Documentation/git-for-each-ref.txt
@@ -127,6 +127,15 @@ color::
 	Change output color.  Followed by `:<colorname>`, where names
 	are described in `color.branch.*`.
 
+align::
+	Left-, middle-, or right-align the content between %(align:..)
+	and %(end). Followed by `:<width>,<position>`, where the
+	`<position>` is either left, right or middle and `<width>` is
+	the total length of the content with alignment. If the
+	contents length is more than the width then no alignment is
+	performed. If used with '--quote' everything in between %(align:..)
+	and %(end) is quoted.
+
 In addition to the above, for commit and tag objects, the header
 field names (`tree`, `parent`, `object`, `type`, and `tag`) can
 be used to specify the value in the header field.
diff --git a/ref-filter.c b/ref-filter.c
index 432cea0..21c8b5f 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -10,6 +10,7 @@
 #include "quote.h"
 #include "ref-filter.h"
 #include "revision.h"
+#include "utf8.h"
 
 typedef enum { FIELD_STR, FIELD_ULONG, FIELD_TIME } cmp_type;
 
@@ -53,6 +54,13 @@ static struct {
 	{ "flag" },
 	{ "HEAD" },
 	{ "color" },
+	{ "align" },
+	{ "end" },
+};
+
+struct align {
+	align_type position;
+	unsigned int width;
 };
 
 #define REF_FORMATTING_STATE_INIT  { 0, NULL }
@@ -60,6 +68,8 @@ static struct {
 struct ref_formatting_stack {
 	struct ref_formatting_stack *prev;
 	struct strbuf output;
+	void (*at_end)(struct ref_formatting_stack *stack);
+	void *cb_data;
 };
 
 struct ref_formatting_state {
@@ -69,6 +79,8 @@ struct ref_formatting_state {
 
 struct atom_value {
 	const char *s;
+	struct align *align;
+	void (*handler)(struct atom_value *atomv, struct ref_formatting_state *state);
 	unsigned long ul; /* used for sorting when not FIELD_STR */
 };
 
@@ -632,6 +644,84 @@ static inline char *copy_advance(char *dst, const char *src)
 	return dst;
 }
 
+static void align_handler(struct ref_formatting_stack *stack)
+{
+	struct align *align = (struct align *)stack->cb_data;
+	struct strbuf s = STRBUF_INIT;
+
+	strbuf_utf8_align(&s, align->position, align->width, stack->output.buf);
+	strbuf_swap(&stack->output, &s);
+	strbuf_release(&s);
+	free(align);
+}
+
+static void align_atom_handler(struct atom_value *atomv, struct ref_formatting_state *state)
+{
+	struct ref_formatting_stack *new;
+
+	push_stack_element(&state->stack);
+	new = state->stack;
+	new->at_end = align_handler;
+	new->cb_data = atomv->align;
+}
+
+static void quote_formatting(struct strbuf *s, const char *str, int quote_style)
+{
+	switch (quote_style) {
+	case QUOTE_NONE:
+		strbuf_addstr(s, str);
+		break;
+	case QUOTE_SHELL:
+		sq_quote_buf(s, str);
+		break;
+	case QUOTE_PERL:
+		perl_quote_buf(s, str);
+		break;
+	case QUOTE_PYTHON:
+		python_quote_buf(s, str);
+		break;
+	case QUOTE_TCL:
+		tcl_quote_buf(s, str);
+		break;
+	}
+}
+
+static void append_atom(struct atom_value *v, struct ref_formatting_state *state)
+{
+	/*
+	 * Quote formatting is only done when the stack has a single
+	 * element. Otherwise quote formatting is done on the
+	 * element's entire output strbuf when the %(end) atom is
+	 * encountered.
+	 */
+	if (!state->stack->prev)
+		quote_formatting(&state->stack->output, v->s, state->quote_style);
+	else
+		strbuf_addstr(&state->stack->output, v->s);
+}
+
+static void end_atom_handler(struct atom_value *atomv, struct ref_formatting_state *state)
+{
+	struct ref_formatting_stack *current = state->stack;
+	struct strbuf s = STRBUF_INIT;
+
+	if (!current->at_end)
+		die(_("format: `end` atom used without a supporting atom"));
+	current->at_end(current);
+	/*
+	 * Whenever we have more than one stack element that means we
+	 * are using a certain modifier atom. In that case we need to
+	 * perform quote formatting.
+	 */
+	if (state->stack->prev) {
+		quote_formatting(&s, current->output.buf, state->quote_style);
+		strbuf_reset(&current->output);
+		strbuf_addbuf(&current->output, &s);
+	}
+	strbuf_release(&s);
+	pop_stack_element(&state->stack);
+}
+
 /*
  * Parse the object referred by ref, and grab needed value.
  */
@@ -660,8 +750,11 @@ static void populate_value(struct ref_array_item *ref)
 		int deref = 0;
 		const char *refname;
 		const char *formatp;
+		const char *valp;
 		struct branch *branch = NULL;
 
+		v->handler = append_atom;
+
 		if (*name == '*') {
 			deref = 1;
 			name++;
@@ -725,6 +818,37 @@ static void populate_value(struct ref_array_item *ref)
 			else
 				v->s = " ";
 			continue;
+		} else if (!strcmp(name, "align"))
+			die(_("format: incomplete use of the `align` atom"));
+		else if (skip_prefix(name, "align:", &valp)) {
+			struct align *align = xmalloc(sizeof(struct align));
+			struct strbuf **s = strbuf_split_str(valp, ',', 0);
+
+			/* If the position is given trim the ',' from the first strbuf */
+			if (s[1])
+				strbuf_remove(s[0], s[0]->len - 1, 1);
+
+			if (strtoul_ui(s[0]->buf, 10, &align->width))
+				die(_("positive width expected align:%s"), s[0]->buf);
+
+			/* If no position is given, default to ALIGN_LEFT */
+			if (!s[1] || !strcmp(s[1]->buf, "left"))
+				align->position = ALIGN_LEFT;
+			else if (!strcmp(s[1]->buf, "right"))
+				align->position = ALIGN_RIGHT;
+			else if (!strcmp(s[1]->buf, "middle"))
+				align->position = ALIGN_MIDDLE;
+			else
+				die(_("improper format entered align:%s"), s[1]->buf);
+
+			strbuf_list_free(s);
+
+			v->align = align;
+			v->handler = align_atom_handler;
+			continue;
+		} else if (!strcmp(name, "end")) {
+			v->handler = end_atom_handler;
+			continue;
 		} else
 			continue;
 
@@ -1228,29 +1352,6 @@ void ref_array_sort(struct ref_sorting *sorting, struct ref_array *array)
 	qsort(array->items, array->nr, sizeof(struct ref_array_item *), compare_refs);
 }
 
-static void append_atom(struct atom_value *v, struct ref_formatting_state *state)
-{
-	struct strbuf *s = &state->stack->output;
-
-	switch (state->quote_style) {
-	case QUOTE_NONE:
-		strbuf_addstr(s, v->s);
-		break;
-	case QUOTE_SHELL:
-		sq_quote_buf(s, v->s);
-		break;
-	case QUOTE_PERL:
-		perl_quote_buf(s, v->s);
-		break;
-	case QUOTE_PYTHON:
-		python_quote_buf(s, v->s);
-		break;
-	case QUOTE_TCL:
-		tcl_quote_buf(s, v->s);
-		break;
-	}
-}
-
 static int hex1(char ch)
 {
 	if ('0' <= ch && ch <= '9')
@@ -1307,7 +1408,7 @@ void show_ref_array_item(struct ref_array_item *info, const char *format, int qu
 		if (cp < sp)
 			append_literal(cp, sp, &state);
 		get_ref_atom_value(info, parse_ref_filter_atom(sp + 2, ep), &atomv);
-		append_atom(atomv, &state);
+		atomv->handler(atomv, &state);
 	}
 	if (*cp) {
 		sp = cp + strlen(cp);
@@ -1322,6 +1423,8 @@ void show_ref_array_item(struct ref_array_item *info, const char *format, int qu
 		resetv.s = color;
 		append_atom(&resetv, &state);
 	}
+	if (state.stack->prev)
+		die(_("format: `end` atom missing"));
 	final_buf = &state.stack->output;
 	fwrite(final_buf->buf, 1, final_buf->len, stdout);
 	pop_stack_element(&state.stack);
diff --git a/t/t6302-for-each-ref-filter.sh b/t/t6302-for-each-ref-filter.sh
index 505a360..cef7a41 100755
--- a/t/t6302-for-each-ref-filter.sh
+++ b/t/t6302-for-each-ref-filter.sh
@@ -81,4 +81,89 @@ test_expect_success 'filtering with --contains' '
 	test_cmp expect actual
 '
 
+test_expect_success 'left alignment' '
+	cat >expect <<-\EOF &&
+	refname is refs/heads/master  |refs/heads/master
+	refname is refs/heads/side    |refs/heads/side
+	refname is refs/odd/spot      |refs/odd/spot
+	refname is refs/tags/double-tag|refs/tags/double-tag
+	refname is refs/tags/four     |refs/tags/four
+	refname is refs/tags/one      |refs/tags/one
+	refname is refs/tags/signed-tag|refs/tags/signed-tag
+	refname is refs/tags/three    |refs/tags/three
+	refname is refs/tags/two      |refs/tags/two
+	EOF
+	git for-each-ref --format="%(align:30,left)refname is %(refname)%(end)|%(refname)" >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'middle alignment' '
+	cat >expect <<-\EOF &&
+	| refname is refs/heads/master |refs/heads/master
+	|  refname is refs/heads/side  |refs/heads/side
+	|   refname is refs/odd/spot   |refs/odd/spot
+	|refname is refs/tags/double-tag|refs/tags/double-tag
+	|  refname is refs/tags/four   |refs/tags/four
+	|   refname is refs/tags/one   |refs/tags/one
+	|refname is refs/tags/signed-tag|refs/tags/signed-tag
+	|  refname is refs/tags/three  |refs/tags/three
+	|   refname is refs/tags/two   |refs/tags/two
+	EOF
+	git for-each-ref --format="|%(align:30,middle)refname is %(refname)%(end)|%(refname)" >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'right alignment' '
+	cat >expect <<-\EOF &&
+	|  refname is refs/heads/master|refs/heads/master
+	|    refname is refs/heads/side|refs/heads/side
+	|      refname is refs/odd/spot|refs/odd/spot
+	|refname is refs/tags/double-tag|refs/tags/double-tag
+	|     refname is refs/tags/four|refs/tags/four
+	|      refname is refs/tags/one|refs/tags/one
+	|refname is refs/tags/signed-tag|refs/tags/signed-tag
+	|    refname is refs/tags/three|refs/tags/three
+	|      refname is refs/tags/two|refs/tags/two
+	EOF
+	git for-each-ref --format="|%(align:30,right)refname is %(refname)%(end)|%(refname)" >actual &&
+	test_cmp expect actual
+'
+
+# Everything in between the %(align)...%(end) atom must be quoted, hence we test this by
+# introducing single quote's in %(align)...%(end), which must not be escaped.
+
+sq="'"
+
+test_expect_success 'alignment with format quote' '
+	cat >expect <<-EOF &&
+	refname is ${sq}           ${sq}\\${sq}${sq}master${sq}\\${sq}${sq}           ${sq}|
+	refname is ${sq}            ${sq}\\${sq}${sq}side${sq}\\${sq}${sq}            ${sq}|
+	refname is ${sq}          ${sq}\\${sq}${sq}odd/spot${sq}\\${sq}${sq}          ${sq}|
+	refname is ${sq}         ${sq}\\${sq}${sq}double-tag${sq}\\${sq}${sq}         ${sq}|
+	refname is ${sq}            ${sq}\\${sq}${sq}four${sq}\\${sq}${sq}            ${sq}|
+	refname is ${sq}            ${sq}\\${sq}${sq}one${sq}\\${sq}${sq}             ${sq}|
+	refname is ${sq}         ${sq}\\${sq}${sq}signed-tag${sq}\\${sq}${sq}         ${sq}|
+	refname is ${sq}           ${sq}\\${sq}${sq}three${sq}\\${sq}${sq}            ${sq}|
+	refname is ${sq}            ${sq}\\${sq}${sq}two${sq}\\${sq}${sq}             ${sq}|
+	EOF
+	git for-each-ref --shell --format="refname is %(align:30,middle)${sq}%(refname:short)${sq}%(end)|" >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'nested alignment' '
+	cat >expect <<-\EOF &&
+	|         master               |
+	|           side               |
+	|       odd/spot               |
+	|     double-tag               |
+	|           four               |
+	|            one               |
+	|     signed-tag               |
+	|          three               |
+	|            two               |
+	EOF
+	git for-each-ref --format="|%(align:30,left)%(align:15,right)%(refname:short)%(end)%(end)|" >actual &&
+	test_cmp expect actual
+'
+
 test_done
-- 
2.5.0
