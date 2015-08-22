From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v13 04/12] ref-filter: implement an `align` atom
Date: Sat, 22 Aug 2015 09:09:40 +0530
Message-ID: <1440214788-1309-5-git-send-email-Karthik.188@gmail.com>
References: <1440214788-1309-1-git-send-email-Karthik.188@gmail.com>
Cc: christian.couder@gmail.com, Matthieu.Moy@grenoble-inp.fr,
	gitster@pobox.com, Karthik Nayak <Karthik.188@gmail.com>,
	Karthik Nayak <karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 22 05:40:08 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZSzf4-0002IM-Ri
	for gcvg-git-2@plane.gmane.org; Sat, 22 Aug 2015 05:40:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753142AbbHVDj5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Aug 2015 23:39:57 -0400
Received: from mail-pd0-f173.google.com ([209.85.192.173]:34197 "EHLO
	mail-pd0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753137AbbHVDj4 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Aug 2015 23:39:56 -0400
Received: by pdbfa8 with SMTP id fa8so32886207pdb.1
        for <git@vger.kernel.org>; Fri, 21 Aug 2015 20:39:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=qSPRYpkvv+guO+AtIYN/1bZ3VIq/aGU9LRonvtiww+o=;
        b=TpVNZ+TWNFkNRAvvkOuRSSgjPLdXKEyIZ/C/fuEat5n+cvTQt4tbZNQYddjsaJjxqa
         kk6gDfCLojBPiAickUhf5Y4xOenpADqd5D1JiyewhDq1vp3Gr71YO6h1+secDwFR7ARW
         8+qNlXVIY0Fmu9Ruo/Fxpnc4zMsnA/x7028fi2C/uYi/ZpDD5OIis8a3/7CrJgFcgbxd
         efUZL58hN8O930W1pB9Ce2H5g7do5GXTcxULVTA20YrvuD3o3z9D01W+57hbOQ5lydV+
         2W6qmUziEI9FHfo8bhJVyuo5eM9iDeyKE4JqXQg9vY+UVaQGhNWmxVpE8ziPAUxS5O5C
         l59A==
X-Received: by 10.70.38.35 with SMTP id d3mr23736297pdk.33.1440214795708;
        Fri, 21 Aug 2015 20:39:55 -0700 (PDT)
Received: from ashley.localdomain ([106.51.130.23])
        by smtp.gmail.com with ESMTPSA id e4sm9393515pdd.45.2015.08.21.20.39.53
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 21 Aug 2015 20:39:55 -0700 (PDT)
X-Google-Original-From: Karthik Nayak <Karthik.188@gmail.com>
X-Mailer: git-send-email 2.5.0
In-Reply-To: <1440214788-1309-1-git-send-email-Karthik.188@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276368>

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
 ref-filter.c                       | 124 ++++++++++++++++++++++++++++++++++---
 t/t6302-for-each-ref-filter.sh     |  69 +++++++++++++++++++++
 3 files changed, 192 insertions(+), 10 deletions(-)

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
index d0d8df0..ffec10a 100644
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
 
@@ -632,6 +644,51 @@ static inline char *copy_advance(char *dst, const char *src)
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
+	push_new_stack_element(&state->stack);
+	new = state->stack;
+	new->at_end = align_handler;
+	new->cb_data = atomv->align;
+}
+
+static void perform_quote_formatting(struct strbuf *s, const char *str, int quote_style);
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
+	if (!state->stack->prev->prev) {
+		perform_quote_formatting(&s, current->output.buf, state->quote_style);
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
@@ -660,6 +717,7 @@ static void populate_value(struct ref_array_item *ref)
 		int deref = 0;
 		const char *refname;
 		const char *formatp;
+		const char *valp;
 		struct branch *branch = NULL;
 
 		if (*name == '*') {
@@ -725,6 +783,35 @@ static void populate_value(struct ref_array_item *ref)
 			else
 				v->s = " ";
 			continue;
+		} else if (skip_prefix(name, "align:", &valp)) {
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
 
@@ -1228,29 +1315,33 @@ void ref_array_sort(struct ref_sorting *sorting, struct ref_array *array)
 	qsort(array->items, array->nr, sizeof(struct ref_array_item *), compare_refs);
 }
 
-static void append_atom(struct atom_value *v, struct ref_formatting_state *state)
+static void perform_quote_formatting(struct strbuf *s, const char *str, int quote_style)
 {
-	struct strbuf *s = &state->stack->output;
-
-	switch (state->quote_style) {
+	switch (quote_style) {
 	case QUOTE_NONE:
-		strbuf_addstr(s, v->s);
+		strbuf_addstr(s, str);
 		break;
 	case QUOTE_SHELL:
-		sq_quote_buf(s, v->s);
+		sq_quote_buf(s, str);
 		break;
 	case QUOTE_PERL:
-		perl_quote_buf(s, v->s);
+		perl_quote_buf(s, str);
 		break;
 	case QUOTE_PYTHON:
-		python_quote_buf(s, v->s);
+		python_quote_buf(s, str);
 		break;
 	case QUOTE_TCL:
-		tcl_quote_buf(s, v->s);
+		tcl_quote_buf(s, str);
 		break;
 	}
 }
 
+static void append_atom(struct atom_value *v, struct ref_formatting_state *state)
+{
+	struct strbuf *s = &state->stack->output;
+	perform_quote_formatting(s, v->s, state->quote_style);
+}
+
 static int hex1(char ch)
 {
 	if ('0' <= ch && ch <= '9')
@@ -1307,7 +1398,18 @@ void show_ref_array_item(struct ref_array_item *info, const char *format, int qu
 		if (cp < sp)
 			append_literal(cp, sp, &state);
 		get_ref_atom_value(info, parse_ref_filter_atom(sp + 2, ep), &atomv);
-		append_atom(atomv, &state);
+		/*
+		 * If the atom is a modifier atom, then call the handler function.
+		 * Else, if this is the first element on the stack, then we need to
+		 * format the atom as per the given quote. Else we just add the atom value
+		 * to the current stack element and handle quote formatting at the end.
+		 */
+		if (atomv->handler)
+			atomv->handler(atomv, &state);
+		else if (!state.stack->prev)
+			append_atom(atomv, &state);
+		else
+			strbuf_addstr(&state.stack->output, atomv->s);
 	}
 	if (*cp) {
 		sp = cp + strlen(cp);
@@ -1322,6 +1424,8 @@ void show_ref_array_item(struct ref_array_item *info, const char *format, int qu
 		resetv.s = color;
 		append_atom(&resetv, &state);
 	}
+	if (state.stack->prev)
+		die(_("format: `end` atom missing"));
 	final_buf = &state.stack->output;
 	fwrite(final_buf->buf, 1, final_buf->len, stdout);
 	pop_stack_element(&state.stack);
diff --git a/t/t6302-for-each-ref-filter.sh b/t/t6302-for-each-ref-filter.sh
index 505a360..227992b 100755
--- a/t/t6302-for-each-ref-filter.sh
+++ b/t/t6302-for-each-ref-filter.sh
@@ -81,4 +81,73 @@ test_expect_success 'filtering with --contains' '
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
 test_done
-- 
2.5.0
