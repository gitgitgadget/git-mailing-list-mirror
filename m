From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v15 05/13] ref-filter: implement an `align` atom
Date: Tue,  1 Sep 2015 23:56:26 +0530
Message-ID: <1441131994-13508-6-git-send-email-Karthik.188@gmail.com>
References: <1441131994-13508-1-git-send-email-Karthik.188@gmail.com>
Cc: christian.couder@gmail.com, Matthieu.Moy@grenoble-inp.fr,
	gitster@pobox.com, Karthik Nayak <Karthik.188@gmail.com>,
	Karthik Nayak <karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 01 20:26:53 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZWqGf-0007BT-F0
	for gcvg-git-2@plane.gmane.org; Tue, 01 Sep 2015 20:26:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755290AbbIAS0q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Sep 2015 14:26:46 -0400
Received: from mail-pa0-f50.google.com ([209.85.220.50]:36468 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754855AbbIAS0o (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Sep 2015 14:26:44 -0400
Received: by pacwi10 with SMTP id wi10so3654512pac.3
        for <git@vger.kernel.org>; Tue, 01 Sep 2015 11:26:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=unF78+f4xL00XRjZxG2Rw6HAWKorcHz99qCikWUydmw=;
        b=0665mhUVIdF4inhIQ13XgpbziSioO09EFHGDeIE6TcGci/+S7ZgKCDxpo57ZSQCfoN
         V/TYLafqIOj62E1xY8lfAGzGsWuIMjGjMZWUJzD0qIylaeJejQOXyo64hj/6kinJIIll
         M7hwiuezBQa23Dvfhq020mt9AoyfYXm6MMQeHn2Udsq1vthQ3/cqZA6FZoJubfxzgS5U
         ryA8h1qZUYKzK9l/X9gL2ncnxwZolBUHr/KbdNelp/DCkEogpqUvJj3JRHMv/b6qXvmZ
         GL1zuWBCjuFQnZ79ihtB4qXj/MMRk8kUbYwyalYwRniE04+gbymqHqMLj+tNwFRyUfz7
         zWoQ==
X-Received: by 10.68.168.161 with SMTP id zx1mr49306502pbb.35.1441132004326;
        Tue, 01 Sep 2015 11:26:44 -0700 (PDT)
Received: from ashley.localdomain ([106.51.130.23])
        by smtp.gmail.com with ESMTPSA id uk6sm19091682pac.27.2015.09.01.11.26.41
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 01 Sep 2015 11:26:43 -0700 (PDT)
X-Google-Original-From: Karthik Nayak <Karthik.188@gmail.com>
X-Mailer: git-send-email 2.5.0
In-Reply-To: <1441131994-13508-1-git-send-email-Karthik.188@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277016>

Implement an `align` atom which left-, middle-, or right-aligns the
content between %(align:..) and %(end).

It is followed by `:<width>,<position>`, where the `<position>` is
either left, right or middle and `<width>` is the size of the area
into which the content will be placed. If the content between
%(align:) and %(end) is more than the width then no alignment is
performed. e.g. to align a refname atom to the middle with a total
width of 40 we can do: --format="%(align:middle,40)%(refname)%(end)".

We have an `at_end` function for each element of the stack which is to
be called when the `end` atom is encountered. Using this we implement
the aling_handler() for the `align` atom, this aligns the final strbuf
by calling `strbuf_utf8_align()` from utf8.c.

Ensure that quote formatting is performed on the whole of
%(align)...%(end) rather than individual atoms inside.  We skip quote
formatting for individual atoms when the current stack element is
handling an %(align) atom and perform quote formatting at the end when
we encounter the %(end) atom.

Add documentation and tests for the same.

Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Matthieu Moy <matthieu.moy@grenoble-inp.fr>
Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 Documentation/git-for-each-ref.txt |   9 ++++
 ref-filter.c                       | 102 ++++++++++++++++++++++++++++++++++++-
 t/t6302-for-each-ref-filter.sh     |  85 +++++++++++++++++++++++++++++++
 3 files changed, 195 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-for-each-ref.txt b/Documentation/git-for-each-ref.txt
index e49d578..cac3128 100644
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
+	performed. If used with '--quote' everything in between
+	%(align:..)  and %(end) is quoted.
+
 In addition to the above, for commit and tag objects, the header
 field names (`tree`, `parent`, `object`, `type`, and `tag`) can
 be used to specify the value in the header field.
diff --git a/ref-filter.c b/ref-filter.c
index a993216..3a5f0a7 100644
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
+	void *cb_data;
 };
 
 struct ref_formatting_state {
@@ -69,6 +79,7 @@ struct ref_formatting_state {
 
 struct atom_value {
 	const char *s;
+	struct align align;
 	void (*handler)(struct atom_value *atomv, struct ref_formatting_state *state);
 	unsigned long ul; /* used for sorting when not FIELD_STR */
 };
@@ -163,9 +174,28 @@ static void quote_formatting(struct strbuf *s, const char *str, int quote_style)
 	}
 }
 
+static void align_handler(struct ref_formatting_stack *stack)
+{
+	struct align *align = (struct align *)stack->cb_data;
+	struct strbuf s = STRBUF_INIT;
+
+	strbuf_utf8_align(&s, align->position, align->width, stack->output.buf);
+	strbuf_swap(&stack->output, &s);
+	strbuf_release(&s);
+}
+
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
@@ -189,6 +219,37 @@ static void pop_stack_element(struct ref_formatting_stack **stack)
 	*stack = prev;
 }
 
+static void align_atom_handler(struct atom_value *atomv, struct ref_formatting_state *state)
+{
+	struct ref_formatting_stack *new;
+
+	push_stack_element(&state->stack);
+	new = state->stack;
+	new->at_end = align_handler;
+	new->cb_data = &atomv->align;
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
+
+	/*
+	 * Perform quote formatting when the stack element is that of
+	 * a modifier atom and right above the first stack element.
+	 */
+	if (!state->stack->prev->prev) {
+		quote_formatting(&s, current->output.buf, state->quote_style);
+		strbuf_swap(&current->output, &s);
+	}
+	strbuf_release(&s);
+	pop_stack_element(&state->stack);
+}
+
 /*
  * In a format string, find the next occurrence of %(atom).
  */
@@ -687,6 +748,7 @@ static void populate_value(struct ref_array_item *ref)
 		int deref = 0;
 		const char *refname;
 		const char *formatp;
+		const char *valp;
 		struct branch *branch = NULL;
 
 		v->handler = append_atom;
@@ -754,6 +816,42 @@ static void populate_value(struct ref_array_item *ref)
 			else
 				v->s = " ";
 			continue;
+		} else if (skip_prefix(name, "align", &valp)) {
+			struct align *align = &v->align;
+			struct strbuf **s;
+
+			if (valp[0] != ':')
+				die(_("format: usage %%(align:<width>,<position>)"));
+			else
+				valp++;
+
+			s = strbuf_split_str(valp, ',', 0);
+
+			/* If the position is given trim the ',' from the first strbuf */
+			if (s[1])
+				strbuf_setlen(s[0], s[0]->len - 1);
+
+			if (strtoul_ui(s[0]->buf, 10, &align->width))
+				die(_("positive width expected align:%s"), s[0]->buf);
+
+			if (!s[1])
+				align->position = ALIGN_LEFT;
+			else if (!strcmp(s[1]->buf, "left"))
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
+			v->handler = align_atom_handler;
+			continue;
+		} else if (!strcmp(name, "end")) {
+			v->handler = end_atom_handler;
+			continue;
 		} else
 			continue;
 
@@ -1328,6 +1426,8 @@ void show_ref_array_item(struct ref_array_item *info, const char *format, int qu
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
