From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v16 06/14] ref-filter: implement an `align` atom
Date: Sun,  6 Sep 2015 00:22:07 +0530
Message-ID: <1441479135-5285-7-git-send-email-Karthik.188@gmail.com>
References: <1441479135-5285-1-git-send-email-Karthik.188@gmail.com>
Cc: christian.couder@gmail.com, Matthieu.Moy@grenoble-inp.fr,
	gitster@pobox.com, Karthik Nayak <Karthik.188@gmail.com>,
	Karthik Nayak <karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 05 20:52:54 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZYIa3-0002Ha-He
	for gcvg-git-2@plane.gmane.org; Sat, 05 Sep 2015 20:52:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752738AbbIESwo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Sep 2015 14:52:44 -0400
Received: from mail-pa0-f68.google.com ([209.85.220.68]:35752 "EHLO
	mail-pa0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751848AbbIESwX (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Sep 2015 14:52:23 -0400
Received: by pactg12 with SMTP id tg12so5917219pac.2
        for <git@vger.kernel.org>; Sat, 05 Sep 2015 11:52:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=I641MWZc6FrEAFFkv94Z//Fw5RY7vkvBGctnhKTSixk=;
        b=AutlxzU8T0ZgzXBVqQ5KqzAhyB45G15XkNyaPDJHSNPRC/CUlDuBLJX8vMw8G5Ya2F
         FjPQu4DfIpdJ8OdMjXfXY/dILo7YMWl8YySeSe+Uc3VO5NN4MhmQLGd0Jbn4gfp0Lk2+
         sJIVsPuotQzgatXgAjA2CO+KgmmaL2QfTMlwhC8VdW1wrX3RDnuGqmVYpMywqOYAiCF3
         nyD0s8MJoeDU5oJv0daA6PShDg/hB5NCxvst0s/X1XU/25mmf8x+fQYAzBeAEJXBBuSe
         eWXPH71Bp1xrVVDk5WLsLPsOa5W7RrWowqqgj2cX5U6piOhqEPyE8bvae1y8vJphFDPs
         mWzA==
X-Received: by 10.66.163.161 with SMTP id yj1mr23949066pab.34.1441479142441;
        Sat, 05 Sep 2015 11:52:22 -0700 (PDT)
Received: from ashley.localdomain ([106.51.130.23])
        by smtp.gmail.com with ESMTPSA id ch3sm6583639pbb.18.2015.09.05.11.52.19
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 05 Sep 2015 11:52:21 -0700 (PDT)
X-Google-Original-From: Karthik Nayak <Karthik.188@gmail.com>
X-Mailer: git-send-email 2.5.1
In-Reply-To: <1441479135-5285-1-git-send-email-Karthik.188@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277401>

Implement an `align` atom which left-, middle-, or right-aligns the
content between %(align:...) and %(end).

It is followed by `:<width>,<position>`, where the `<position>` is
either left, right or middle and `<width>` is the size of the area
into which the content will be placed. If the content between
%(align:...) and %(end) is more than the width then no alignment is
performed. e.g. to align a refname atom to the middle with a total
width of 40 we can do: --format="%(align:middle,40)%(refname)%(end)".

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
Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 Documentation/git-for-each-ref.txt |  10 ++++
 ref-filter.c                       | 112 ++++++++++++++++++++++++++++++++++++-
 t/t6302-for-each-ref-filter.sh     |  82 +++++++++++++++++++++++++++
 3 files changed, 203 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-for-each-ref.txt b/Documentation/git-for-each-ref.txt
index e49d578..b23412d 100644
--- a/Documentation/git-for-each-ref.txt
+++ b/Documentation/git-for-each-ref.txt
@@ -127,6 +127,16 @@ color::
 	Change output color.  Followed by `:<colorname>`, where names
 	are described in `color.branch.*`.
 
+align::
+	Left-, middle-, or right-align the content between %(align:...)
+	and %(end). Followed by `:<width>,<position>`, where the
+	`<position>` is either left, right or middle and `<width>` is
+	the total length of the content with alignment. If the
+	contents length is more than the width then no alignment is
+	performed. If used with '--quote' everything in between
+	%(align:...) and %(end) is quoted, but if nested then only the
+	topmost level performs quoting.
+
 In addition to the above, for commit and tag objects, the header
 field names (`tree`, `parent`, `object`, `type`, and `tag`) can
 be used to specify the value in the header field.
diff --git a/ref-filter.c b/ref-filter.c
index e99c342..6c9ef08 100644
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
@@ -773,6 +837,50 @@ static void populate_value(struct ref_array_item *ref)
 			else
 				v->s = " ";
 			continue;
+		} else if (match_atom_name(name, "align", &valp)) {
+			struct align *align = &v->u.align;
+			struct strbuf **s;
+
+			if (!valp)
+				die(_("expected format: %%(align:<width>, <position>)"));
+
+			/*
+			 * TODO: Implement a function similar to strbuf_split_str()
+			 * which would strip the terminator at the end.
+			 */
+			s = strbuf_split_str(valp, ',', 0);
+
+			/* If the position is given trim the ',' from the first strbuf */
+			if (s[1])
+				strbuf_setlen(s[0], s[0]->len - 1);
+			if (s[2])
+				die(_("align:<width>,<position> followed by garbage: %s"), s[2]->buf);
+
+			if (strtoul_ui(s[0]->buf, 10, &align->width))
+				die(_("positive width expected align:%s"), s[0]->buf);
+
+			/*
+			 * TODO: Implement a more general check, so that the values
+			 * do not always have to be in a specific order.
+			 */
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
 
@@ -1347,6 +1455,8 @@ void show_ref_array_item(struct ref_array_item *info, const char *format, int qu
 		resetv.s = color;
 		append_atom(&resetv, &state);
 	}
+	if (state.stack->prev)
+		die(_("format: %%(end) atom missing"));
 	final_buf = &state.stack->output;
 	fwrite(final_buf->buf, 1, final_buf->len, stdout);
 	pop_stack_element(&state.stack);
diff --git a/t/t6302-for-each-ref-filter.sh b/t/t6302-for-each-ref-filter.sh
index c4f0378..d0c0139 100755
--- a/t/t6302-for-each-ref-filter.sh
+++ b/t/t6302-for-each-ref-filter.sh
@@ -85,4 +85,86 @@ test_expect_success '%(color) must fail' '
 	test_must_fail git for-each-ref --format="%(color)%(refname)"
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
+# Individual atoms inside %(align:...) and %(end) must not be quoted.
+
+test_expect_success 'alignment with format quote' "
+	cat >expect <<-\EOF &&
+	|'       master| A U Thor       '|
+	|'        side| A U Thor        '|
+	|'      odd/spot| A U Thor      '|
+	|'         double-tag|          '|
+	|'        four| A U Thor        '|
+	|'        one| A U Thor         '|
+	|'         signed-tag|          '|
+	|'       three| A U Thor        '|
+	|'        two| A U Thor         '|
+	EOF
+	git for-each-ref --shell --format='|%(align:30,middle)%(refname:short)| %(authorname)%(end)|' >actual &&
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
