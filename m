From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v2 01/10] ref-filter: implement %(if), %(then), and %(else) atoms
Date: Thu,  8 Oct 2015 14:47:56 +0530
Message-ID: <1444295885-1657-2-git-send-email-Karthik.188@gmail.com>
References: <1444295885-1657-1-git-send-email-Karthik.188@gmail.com>
Cc: christian.couder@gmail.com, Matthieu.Moy@grenoble-inp.fr,
	gitster@pobox.com, Karthik Nayak <Karthik.188@gmail.com>,
	Karthik Nayak <karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 08 11:18:19 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zk7L3-0007Tw-I2
	for gcvg-git-2@plane.gmane.org; Thu, 08 Oct 2015 11:18:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755150AbbJHJSG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Oct 2015 05:18:06 -0400
Received: from mail-pa0-f52.google.com ([209.85.220.52]:35216 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753631AbbJHJSB (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Oct 2015 05:18:01 -0400
Received: by pabve7 with SMTP id ve7so8799465pab.2
        for <git@vger.kernel.org>; Thu, 08 Oct 2015 02:18:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=bOkKxFmyB/eCdcFHRQA/GrKS+2lcSOak0Aq1asLvT6w=;
        b=hN4PWP7RPBEV4gjtHEppq9BhJom7LhbVC6M6MJjEM7RX+J5qZZmAgpnIcUrFprLaHO
         65LU6cWRuANUZCIGohOoOKn1TtsxM4KdqAHjomaXFpHtMxAjFmD7w5t91KAqnPxQgo0z
         BUo7eK/VCXB2f6p0nV1cEYgcHHeU9dep6mlJCllaMX9bMmipOS8lEW5C1n26pKWXJdja
         w5ZrzeaeoYQh4nIxhPlZpl4gcNrHk5GTMyHzK2I2FngjedkmEnQOYiLwCXXkJUqUqwoe
         apEbgCVYKjpgHvV+gH11NVasAtxcribozFjmYnlsUSxuRMfWWD3GX7z/iP8zmcIAgv96
         JBQg==
X-Received: by 10.68.166.68 with SMTP id ze4mr7002165pbb.74.1444295881198;
        Thu, 08 Oct 2015 02:18:01 -0700 (PDT)
Received: from ashley.localdomain ([106.51.20.153])
        by smtp.gmail.com with ESMTPSA id sv9sm44171159pbc.44.2015.10.08.02.17.57
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 08 Oct 2015 02:18:00 -0700 (PDT)
X-Google-Original-From: Karthik Nayak <Karthik.188@gmail.com>
X-Mailer: git-send-email 2.6.1
In-Reply-To: <1444295885-1657-1-git-send-email-Karthik.188@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279224>

Implement %(if), %(then) and %(else) atoms. Used as
%(if)...%(then)...%(end) or %(if)...%(then)...%(else)...%(end). If the
format string between %(if) and %(then) expands to an empty string, or
to only whitespaces, then the whole %(if)...%(end) expands to the
string following %(then). Otherwise, it expands to the string
following %(else), if any. Nesting of this construct is possible.

This is in preperation for porting over `git branch -l` to use
ref-filter APIs for printing.

Add Documentation and tests regarding the same.

Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Matthieu Moy <matthieu.moy@grenoble-inp.fr>
Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 Documentation/git-for-each-ref.txt |  47 +++++++++++++-
 ref-filter.c                       | 127 +++++++++++++++++++++++++++++++++++--
 t/t6302-for-each-ref-filter.sh     |  67 +++++++++++++++++++
 3 files changed, 231 insertions(+), 10 deletions(-)

diff --git a/Documentation/git-for-each-ref.txt b/Documentation/git-for-each-ref.txt
index 16b4ac5..7345acb 100644
--- a/Documentation/git-for-each-ref.txt
+++ b/Documentation/git-for-each-ref.txt
@@ -134,9 +134,17 @@ align::
 	`<position>` is either left, right or middle, default being
 	left and `<width>` is the total length of the content with
 	alignment. If the contents length is more than the width then
-	no alignment is performed. If used with '--quote' everything
-	in between %(align:...) and %(end) is quoted, but if nested
-	then only the topmost level performs quoting.
+	no alignment is performed.
+
+if::
+	Used as %(if)..%(then)..(%end) or %(if)..%(then)..%(else)..%(end).
+	If there is an atom with value or string literal after the
+	%(if) then everything after the %(then) is printed, else if
+	the %(else) atom is used, then everything after %(else) is
+	printed. We ignore space when evaluating the string before
+	%(then), this is useful when we use the %(HEAD) atom which
+	prints either "*" or " " and we want to apply the 'if'
+	condition only on the 'HEAD' ref.
 
 In addition to the above, for commit and tag objects, the header
 field names (`tree`, `parent`, `object`, `type`, and `tag`) can
@@ -169,6 +177,19 @@ the date by adding one of `:default`, `:relative`, `:short`, `:local`,
 `:iso8601`, `:rfc2822` or `:raw` to the end of the fieldname; e.g.
 `%(taggerdate:relative)`.
 
+Some atoms like %(align) and %(if) always require a matching %(end).
+We call them "opening atoms" and sometimes denote them as %($open).
+
+When a scripting language specific quoting is in effect, except for
+opening atoms, replacement from every %(atom) is quoted when and only
+when it appears at the top-level (that is, when it appears outside
+%($open)...%(end)).
+
+When a scripting language specific quoting is in effect (i.e. one of
+`--shell`, `--perl`, `--python`, `--tcl` is used), everything between
+a top-level opening atom and its matching %(end) is evaluated
+according to the semantics of the opening atom and its result is
+quoted.
 
 EXAMPLES
 --------
@@ -256,6 +277,26 @@ eval=`git for-each-ref --shell --format="$fmt" \
 eval "$eval"
 ------------
 
+
+An example to show the usage of %(if)...%(then)...%(else)...%(end).
+This prefixes the current branch with a star.
+
+------------
+#!/bin/sh
+
+git for-each-ref --format="%(if)%(HEAD)%(then)* %(else)  %(end)%(refname:short)" refs/heads/
+------------
+
+
+An example to show the usage of %(if)...%(then)...%(end).
+This adds a red color to authorname, if present
+
+------------
+#!/bin/sh
+
+git for-each-ref --format="%(refname)%(if)%(authorname)%(then)%(color:red)%(end) %(authorname)"
+------------
+
 SEE ALSO
 --------
 linkgit:git-show-ref[1]
diff --git a/ref-filter.c b/ref-filter.c
index dbd8fce..95f007c 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -55,6 +55,9 @@ static struct {
 	{ "color" },
 	{ "align" },
 	{ "end" },
+	{ "if" },
+	{ "then" },
+	{ "else" },
 };
 
 #define REF_FORMATTING_STATE_INIT  { 0, NULL }
@@ -69,10 +72,16 @@ struct contents {
 	struct object_id oid;
 };
 
+struct if_then_else {
+	unsigned int then_atom : 1,
+		else_atom : 1,
+		condition_satisfied : 1;
+};
+
 struct ref_formatting_stack {
 	struct ref_formatting_stack *prev;
 	struct strbuf output;
-	void (*at_end)(struct ref_formatting_stack *stack);
+	void (*at_end)(struct ref_formatting_stack **stack);
 	void *at_end_data;
 };
 
@@ -216,13 +225,14 @@ static void pop_stack_element(struct ref_formatting_stack **stack)
 	*stack = prev;
 }
 
-static void end_align_handler(struct ref_formatting_stack *stack)
+static void end_align_handler(struct ref_formatting_stack **stack)
 {
-	struct align *align = (struct align *)stack->at_end_data;
+	struct ref_formatting_stack *cur = *stack;
+	struct align *align = (struct align *)cur->at_end_data;
 	struct strbuf s = STRBUF_INIT;
 
-	strbuf_utf8_align(&s, align->position, align->width, stack->output.buf);
-	strbuf_swap(&stack->output, &s);
+	strbuf_utf8_align(&s, align->position, align->width, cur->output.buf);
+	strbuf_swap(&cur->output, &s);
 	strbuf_release(&s);
 }
 
@@ -236,6 +246,97 @@ static void align_atom_handler(struct atom_value *atomv, struct ref_formatting_s
 	new->at_end_data = &atomv->u.align;
 }
 
+static void if_then_else_handler(struct ref_formatting_stack **stack)
+{
+	struct ref_formatting_stack *cur = *stack;
+	struct ref_formatting_stack *prev = cur->prev;
+	struct if_then_else *if_then_else = (struct if_then_else *)cur->at_end_data;
+
+	if (if_then_else->else_atom) {
+		/*
+		 * There is an %(else) atom: we need to drop one state from the
+		 * stack, either the %(else) branch if the condition is satisfied, or
+		 * the %(then) branch if it isn't.
+		 */
+		if (if_then_else->condition_satisfied) {
+			strbuf_reset(&cur->output);
+			pop_stack_element(&cur);
+		} else {
+			strbuf_swap(&cur->output, &prev->output);
+			strbuf_reset(&cur->output);
+			pop_stack_element(&cur);
+		}
+	} else if (!if_then_else->condition_satisfied)
+		/*
+		 * No %(else) atom: just drop the %(then) branch if the
+		 * condition is not satisfied.
+		 */
+		strbuf_reset(&cur->output);
+
+	*stack = cur;
+	free(if_then_else);
+}
+
+static void if_atom_handler(struct atom_value *atomv, struct ref_formatting_state *state)
+{
+	struct ref_formatting_stack *new;
+	struct if_then_else *if_then_else = xcalloc(sizeof(struct if_then_else), 1);
+
+	push_stack_element(&state->stack);
+	new = state->stack;
+	new->at_end = if_then_else_handler;
+	new->at_end_data = if_then_else;
+}
+
+static int is_empty(const char *s){
+	while (*s != '\0') {
+		if (!isspace(*s))
+			return 0;
+		s++;
+	}
+	return 1;
+}
+
+static void then_atom_handler(struct atom_value *atomv, struct ref_formatting_state *state)
+{
+	struct ref_formatting_stack *cur = state->stack;
+	struct if_then_else *if_then_else = NULL;
+
+	if (cur->at_end == if_then_else_handler)
+		if_then_else = (struct if_then_else *)cur->at_end_data;
+	if (!if_then_else)
+		die(_("format: %%(then) atom used without an %%(if) atom"));
+	if (if_then_else->then_atom)
+		die(_("format: %%(then) atom used more than once"));
+	if_then_else->then_atom = 1;
+	/*
+	 * If there exists non-empty string between the 'if' and
+	 * 'then' atom then the 'if' condition is satisfied.
+	 */
+	if (cur->output.len && !is_empty(cur->output.buf))
+		if_then_else->condition_satisfied = 1;
+	strbuf_reset(&cur->output);
+}
+
+static void else_atom_handler(struct atom_value *atomv, struct ref_formatting_state *state)
+{
+	struct ref_formatting_stack *prev = state->stack;
+	struct if_then_else *if_then_else = NULL;
+
+	if (prev->at_end == if_then_else_handler)
+		if_then_else = (struct if_then_else *)prev->at_end_data;
+	if (!if_then_else)
+		die(_("format: %%(else) atom used without an %%(if) atom"));
+	if (!if_then_else->then_atom)
+		die(_("format: %%(else) atom used without a %%(then) atom"));
+	if (if_then_else->else_atom)
+		die(_("format: %%(else) atom used more than once"));
+	if_then_else->else_atom = 1;
+	push_stack_element(&state->stack);
+	state->stack->at_end_data = prev->at_end_data;
+	state->stack->at_end = prev->at_end;
+}
+
 static void end_atom_handler(struct atom_value *atomv, struct ref_formatting_state *state)
 {
 	struct ref_formatting_stack *current = state->stack;
@@ -243,14 +344,17 @@ static void end_atom_handler(struct atom_value *atomv, struct ref_formatting_sta
 
 	if (!current->at_end)
 		die(_("format: %%(end) atom used without corresponding atom"));
-	current->at_end(current);
+	current->at_end(&state->stack);
+
+	/*  Stack may have been popped within at_end(), hence reset the current pointer */
+	current = state->stack;
 
 	/*
 	 * Perform quote formatting when the stack element is that of
 	 * a supporting atom. If nested then perform quote formatting
 	 * only on the topmost supporting atom.
 	 */
-	if (!state->stack->prev->prev) {
+	if (!current->prev->prev) {
 		quote_formatting(&s, current->output.buf, state->quote_style);
 		strbuf_swap(&current->output, &s);
 	}
@@ -920,6 +1024,15 @@ static void populate_value(struct ref_array_item *ref)
 		} else if (!strcmp(name, "end")) {
 			v->handler = end_atom_handler;
 			continue;
+		} else if (!strcmp(name, "if")) {
+			v->handler = if_atom_handler;
+			continue;
+		} else if (!strcmp(name, "then")) {
+			v->handler = then_atom_handler;
+			continue;
+		} else if (!strcmp(name, "else")) {
+			v->handler = else_atom_handler;
+			continue;
 		} else
 			continue;
 
diff --git a/t/t6302-for-each-ref-filter.sh b/t/t6302-for-each-ref-filter.sh
index fe4796c..617fa1f 100755
--- a/t/t6302-for-each-ref-filter.sh
+++ b/t/t6302-for-each-ref-filter.sh
@@ -255,4 +255,71 @@ test_expect_success 'reverse version sort' '
 	test_cmp expect actual
 '
 
+test_expect_success 'improper usage of %(if), %(then), %(else) and %(end) atoms' '
+	test_must_fail git for-each-ref --format="%(if)" &&
+	test_must_fail git for-each-ref --format="%(then)" &&
+	test_must_fail git for-each-ref --format="%(else)" &&
+	test_must_fail git for-each-ref --format="%(if) %(else)" &&
+	test_must_fail git for-each-ref --format="%(then) %(else)" &&
+	test_must_fail git for-each-ref --format="%(if) %(else)" &&
+	test_must_fail git for-each-ref --format="%(if) %(then) %(else)"
+'
+
+test_expect_success 'check %(if)...%(then)...%(end) atoms' '
+	git for-each-ref --format="%(if)%(authorname)%(then)%(authorname): %(refname)%(end)" >actual &&
+	cat >expect <<-\EOF &&
+	A U Thor: refs/heads/master
+	A U Thor: refs/heads/side
+	A U Thor: refs/odd/spot
+	
+	A U Thor: refs/tags/foo1.10
+	A U Thor: refs/tags/foo1.3
+	A U Thor: refs/tags/foo1.6
+	A U Thor: refs/tags/four
+	A U Thor: refs/tags/one
+	
+	A U Thor: refs/tags/three
+	A U Thor: refs/tags/two
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success 'check %(if)...%(then)...%(else)...%(end) atoms' '
+	git for-each-ref --format="%(if)%(authorname)%(then)%(authorname)%(else)No author%(end): %(refname)" >actual &&
+	cat >expect <<-\EOF &&
+	A U Thor: refs/heads/master
+	A U Thor: refs/heads/side
+	A U Thor: refs/odd/spot
+	No author: refs/tags/double-tag
+	A U Thor: refs/tags/foo1.10
+	A U Thor: refs/tags/foo1.3
+	A U Thor: refs/tags/foo1.6
+	A U Thor: refs/tags/four
+	A U Thor: refs/tags/one
+	No author: refs/tags/signed-tag
+	A U Thor: refs/tags/three
+	A U Thor: refs/tags/two
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success 'ignore spaces in %(if) atom usage' '
+	git for-each-ref --format="%(refname:short): %(if)%(HEAD)%(then)Head ref%(else)Not Head ref%(end)" >actual &&
+	cat >expect <<-\EOF &&
+	master: Head ref
+	side: Not Head ref
+	odd/spot: Not Head ref
+	double-tag: Not Head ref
+	foo1.10: Not Head ref
+	foo1.3: Not Head ref
+	foo1.6: Not Head ref
+	four: Not Head ref
+	one: Not Head ref
+	signed-tag: Not Head ref
+	three: Not Head ref
+	two: Not Head ref
+	EOF
+	test_cmp expect actual
+'
+
 test_done
-- 
2.6.0
