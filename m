From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v17 06/14] ref-filter: implement an `align` atom
Date: Fri, 11 Sep 2015 20:31:59 +0530
Message-ID: <1441983719-32733-1-git-send-email-Karthik.188@gmail.com>
References: <1441900110-4015-6-git-send-email-Karthik.188@gmail.com>
Cc: christian.couder@gmail.com, Matthieu.Moy@grenoble-inp.fr,
	gitster@pobox.com, Karthik Nayak <Karthik.188@gmail.com>,
	Karthik Nayak <karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 11 17:02:02 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZaPpu-0006uL-K9
	for gcvg-git-2@plane.gmane.org; Fri, 11 Sep 2015 17:01:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753157AbbIKPBy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Sep 2015 11:01:54 -0400
Received: from mail-pa0-f47.google.com ([209.85.220.47]:33088 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752794AbbIKPBx (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Sep 2015 11:01:53 -0400
Received: by pacex6 with SMTP id ex6so77485748pac.0
        for <git@vger.kernel.org>; Fri, 11 Sep 2015 08:01:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=G0iJ9tb5IeBWSYJM6yF8gF3bBaGUNNalVvr6GEO76Jk=;
        b=C5M29eA20qdk2ANI4Cej7Bf05dGdKel027r7kRNYmUVXMVaqjc8w0XWpwJQV5rJzBW
         PieGHM82tE1lKbnPdwmIHvhlKG+nxizf8mywka6b3GCA/CjIDkpGTc7qHcz83JoHVwsy
         SFdZVGJBjQUgTmxXN10HsO1ibff8vDAOzk84FpsDbr0Yk6ur0PwpvXJbVfs9BlgBS7hF
         zTslistQMypdpJizWEdDzZi7A4oyQWdkptJ9rHNFAuxjOQqgEuK66C05mS/NapGR/0BF
         HrnTR0WZcZwNGyoEr5Mf1kS09zQKJUqogvlmOrEizbI0jty1CZi3lgP4RPAcvhD9WAEU
         eTOg==
X-Received: by 10.66.157.137 with SMTP id wm9mr38654809pab.30.1441983711825;
        Fri, 11 Sep 2015 08:01:51 -0700 (PDT)
Received: from ashley.localdomain ([106.51.130.23])
        by smtp.gmail.com with ESMTPSA id le8sm916023pbc.24.2015.09.11.08.01.48
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 11 Sep 2015 08:01:50 -0700 (PDT)
X-Google-Original-From: Karthik Nayak <Karthik.188@gmail.com>
X-Mailer: git-send-email 2.5.1
In-Reply-To: <1441900110-4015-6-git-send-email-Karthik.188@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277661>

Implement an `align` atom which left-, middle-, or right-aligns the
content between %(align:...) and %(end).

The "align:" is followed by `<width>` and `<position>` in any order
separated by a comma, where the `<position>` is either left, right or
middle, default being left and `<width>` is the total length of the
content with alignment. If the contents length is more than the width
then no alignment is performed.  e.g. to align a refname atom to the
middle with a total width of 40 we can do:
--format="%(align:middle,40)%(refname)%(end)".

We introduce an `at_end` function for each element of the stack which
is to be called when the `end` atom is encountered. Using this we
implement end_align_handler() for the `align` atom, this aligns the
final strbuf by calling `strbuf_utf8_align()` from utf8.c.

Ensure that quote formatting is performed on the whole of
%(align:...)...%(end) rather than individual atoms inside. We skip
quote formatting for individual atoms when the current stack element
is handling an %(align:...) atom and perform quote formatting at the
end when we encounter the %(end) atom of the second element of then
stack.

Add documentation and tests for the same.

Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Matthieu Moy <matthieu.moy@grenoble-inp.fr>
Helped-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 Documentation/git-for-each-ref.txt |  11 ++++
 ref-filter.c                       | 110 ++++++++++++++++++++++++++++++++++++-
 t/t6302-for-each-ref-filter.sh     |  82 +++++++++++++++++++++++++++
 3 files changed, 202 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-for-each-ref.txt b/Documentation/git-for-each-ref.txt
index e49d578..3a271bf 100644
--- a/Documentation/git-for-each-ref.txt
+++ b/Documentation/git-for-each-ref.txt
@@ -127,6 +127,17 @@ color::
 	Change output color.  Followed by `:<colorname>`, where names
 	are described in `color.branch.*`.
 
+align::
+	Left-, middle-, or right-align the content between
+	%(align:...) and %(end). The "align:" is followed by `<width>`
+	and `<position>` in any order separated by a comma, where the
+	`<position>` is either left, right or middle, default being
+	left and `<width>` is the total length of the content with
+	alignment. If the contents length is more than the width then
+	no alignment is performed. If used with '--quote' everything
+	in between %(align:...) and %(end) is quoted, but if nested
+	then only the topmost level performs quoting.
+
 In addition to the above, for commit and tag objects, the header
 field names (`tree`, `parent`, `object`, `type`, and `tag`) can
 be used to specify the value in the header field.
diff --git a/ref-filter.c b/ref-filter.c
index 514de34..c65cd60 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -10,6 +10,7 @@
 #include "quote.h"
 #include "ref-filter.h"
 #include "revision.h"
+#include "utf8.h"
 
 typedef enum { FIELD_STR, FIELD_ULONG, FIELD_TIME } cmp_type;
 
@@ -53,13 +54,22 @@ static struct {
 	{ "flag" },
 	{ "HEAD" },
 	{ "color" },
+	{ "align" },
+	{ "end" },
 };
 
 #define REF_FORMATTING_STATE_INIT  { 0, NULL }
 
+struct align {
+	align_type position;
+	unsigned int width;
+};
+
 struct ref_formatting_stack {
 	struct ref_formatting_stack *prev;
 	struct strbuf output;
+	void (*at_end)(struct ref_formatting_stack *stack);
+	void *at_end_data;
 };
 
 struct ref_formatting_state {
@@ -69,6 +79,9 @@ struct ref_formatting_state {
 
 struct atom_value {
 	const char *s;
+	union {
+		struct align align;
+	} u;
 	void (*handler)(struct atom_value *atomv, struct ref_formatting_state *state);
 	unsigned long ul; /* used for sorting when not FIELD_STR */
 };
@@ -165,7 +178,16 @@ static void quote_formatting(struct strbuf *s, const char *str, int quote_style)
 
 static void append_atom(struct atom_value *v, struct ref_formatting_state *state)
 {
-	quote_formatting(&state->stack->output, v->s, state->quote_style);
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
 }
 
 static void push_stack_element(struct ref_formatting_stack **stack)
@@ -189,6 +211,48 @@ static void pop_stack_element(struct ref_formatting_stack **stack)
 	*stack = prev;
 }
 
+static void end_align_handler(struct ref_formatting_stack *stack)
+{
+	struct align *align = (struct align *)stack->at_end_data;
+	struct strbuf s = STRBUF_INIT;
+
+	strbuf_utf8_align(&s, align->position, align->width, stack->output.buf);
+	strbuf_swap(&stack->output, &s);
+	strbuf_release(&s);
+}
+
+static void align_atom_handler(struct atom_value *atomv, struct ref_formatting_state *state)
+{
+	struct ref_formatting_stack *new;
+
+	push_stack_element(&state->stack);
+	new = state->stack;
+	new->at_end = end_align_handler;
+	new->at_end_data = &atomv->u.align;
+}
+
+static void end_atom_handler(struct atom_value *atomv, struct ref_formatting_state *state)
+{
+	struct ref_formatting_stack *current = state->stack;
+	struct strbuf s = STRBUF_INIT;
+
+	if (!current->at_end)
+		die(_("format: %%(end) atom used without corresponding atom"));
+	current->at_end(current);
+
+	/*
+	 * Perform quote formatting when the stack element is that of
+	 * a supporting atom. If nested then perform quote formatting
+	 * only on the topmost supporting atom.
+	 */
+	if (!state->stack->prev->prev) {
+		quote_formatting(&s, current->output.buf, state->quote_style);
+		strbuf_swap(&current->output, &s);
+	}
+	strbuf_release(&s);
+	pop_stack_element(&state->stack);
+}
+
 static int match_atom_name(const char *name, const char *atom_name, const char **val)
 {
 	const char *body;
@@ -773,6 +837,48 @@ static void populate_value(struct ref_array_item *ref)
 			else
 				v->s = " ";
 			continue;
+		} else if (match_atom_name(name, "align", &valp)) {
+			struct align *align = &v->u.align;
+			struct strbuf **s, **to_free;
+			int width = -1;
+
+			if (!valp)
+				die(_("expected format: %%(align:<width>,<position>)"));
+
+			/*
+			 * TODO: Implement a function similar to strbuf_split_str()
+			 * which would omit the separator from the end of each value.
+			 */
+			s = to_free = strbuf_split_str(valp, ',', 0);
+
+			align->position = ALIGN_LEFT;
+
+			while (*s) {
+				/*  Strip trailing comma */
+				if (s[1])
+					strbuf_setlen(s[0], s[0]->len - 1);
+				if (!strtoul_ui(s[0]->buf, 10, (unsigned int *)&width))
+					;
+				else if (!strcmp(s[0]->buf, "left"))
+					align->position = ALIGN_LEFT;
+				else if (!strcmp(s[0]->buf, "right"))
+					align->position = ALIGN_RIGHT;
+				else if (!strcmp(s[0]->buf, "middle"))
+					align->position = ALIGN_MIDDLE;
+				else
+					die(_("improper format entered align:%s"), s[0]->buf);
+				s++;
+			}
+
+			if (width < 0)
+				die(_("positive width expected with the %%(align) atom"));
+			align->width = width;
+			strbuf_list_free(to_free);
+			v->handler = align_atom_handler;
+			continue;
+		} else if (!strcmp(name, "end")) {
+			v->handler = end_atom_handler;
+			continue;
 		} else
 			continue;
 
@@ -1347,6 +1453,8 @@ void show_ref_array_item(struct ref_array_item *info, const char *format, int qu
 		resetv.s = color;
 		append_atom(&resetv, &state);
 	}
+	if (state.stack->prev)
+		die(_("format: %%(end) atom missing"));
 	final_buf = &state.stack->output;
 	fwrite(final_buf->buf, 1, final_buf->len, stdout);
 	pop_stack_element(&state.stack);
diff --git a/t/t6302-for-each-ref-filter.sh b/t/t6302-for-each-ref-filter.sh
index c4f0378..f596035 100755
--- a/t/t6302-for-each-ref-filter.sh
+++ b/t/t6302-for-each-ref-filter.sh
@@ -85,4 +85,86 @@ test_expect_success '%(color) must fail' '
 	test_must_fail git for-each-ref --format="%(color)%(refname)"
 '
 
+test_expect_success 'left alignment is default' '
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
+	git for-each-ref --format="%(align:30)refname is %(refname)%(end)|%(refname)" >actual &&
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
+	git for-each-ref --format="|%(align:middle,30)refname is %(refname)%(end)|%(refname)" >actual &&
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
+# Individual atoms inside %(align:...) and %(end) must not be quoted.
+
+test_expect_success 'alignment with format quote' "
+	cat >expect <<-\EOF &&
+	|'      '\''master| A U Thor'\''      '|
+	|'       '\''side| A U Thor'\''       '|
+	|'     '\''odd/spot| A U Thor'\''     '|
+	|'        '\''double-tag| '\''        '|
+	|'       '\''four| A U Thor'\''       '|
+	|'       '\''one| A U Thor'\''        '|
+	|'        '\''signed-tag| '\''        '|
+	|'      '\''three| A U Thor'\''       '|
+	|'       '\''two| A U Thor'\''        '|
+	EOF
+	git for-each-ref --shell --format=\"|%(align:30,middle)'%(refname:short)| %(authorname)'%(end)|\" >actual &&
+	test_cmp expect actual
+"
+
+test_expect_success 'nested alignment with quote formatting' "
+	cat >expect <<-\EOF &&
+	|'         master               '|
+	|'           side               '|
+	|'       odd/spot               '|
+	|'     double-tag               '|
+	|'           four               '|
+	|'            one               '|
+	|'     signed-tag               '|
+	|'          three               '|
+	|'            two               '|
+	EOF
+	git for-each-ref --shell --format='|%(align:30,left)%(align:15,right)%(refname:short)%(end)%(end)|' >actual &&
+	test_cmp expect actual
+"
+
 test_done
-- 
2.5.1
