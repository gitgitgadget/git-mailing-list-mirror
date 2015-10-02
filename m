From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH 1/9] ref-filter: implement %(if), %(then), and %(else) atoms
Date: Fri,  2 Oct 2015 23:08:58 +0530
Message-ID: <1443807546-5985-2-git-send-email-Karthik.188@gmail.com>
References: <1443807546-5985-1-git-send-email-Karthik.188@gmail.com>
Cc: christian.couder@gmail.com, Matthieu.Moy@grenoble-inp.fr,
	gitster@pobox.com, Karthik Nayak <Karthik.188@gmail.com>,
	Karthik Nayak <karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 02 19:41:26 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zi4Kh-0005lA-7G
	for gcvg-git-2@plane.gmane.org; Fri, 02 Oct 2015 19:41:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754040AbbJBRjP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Oct 2015 13:39:15 -0400
Received: from mail-pa0-f65.google.com ([209.85.220.65]:34746 "EHLO
	mail-pa0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753798AbbJBRjK (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Oct 2015 13:39:10 -0400
Received: by pablk4 with SMTP id lk4so12536394pab.1
        for <git@vger.kernel.org>; Fri, 02 Oct 2015 10:39:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=3sf2nj9b5DGXhKsInrUqbZxFx7OVqO7zQxjtLnGdcrg=;
        b=YKFw07XMh1gR/DXdf/epUUZlstLTd+SkM/KVn80zcTAGsscndDXi4jx29/6ud4e6+Z
         XLlDFLCL63KO/UvAiw/wT9TrqRUEkXGGNDoDv/K8ZQBPuq0tAiYsswBo4lDKZIfU8rMH
         q18la/5WiMrinT79bTeevNUG/WBurXmiANFp71KyfuX+29JDtp1wcygGkKMOVWzunMqH
         PQkRt3w+uOa7FSJ3a0XdHQq/pTqEdwcQiSDNfoGR2YmVcwaw49qCOUu8W4JZnlA8nh2Z
         7S53nZ+kakweYbEfJXpca9gWs5DTFa2lmRkflt62oj1grUlWKT/Sv9gPW3tNvgN/veWD
         vHLQ==
X-Received: by 10.68.181.130 with SMTP id dw2mr21506545pbc.70.1443807549737;
        Fri, 02 Oct 2015 10:39:09 -0700 (PDT)
Received: from ashley.localdomain ([106.51.130.23])
        by smtp.gmail.com with ESMTPSA id pq1sm12993384pbb.91.2015.10.02.10.39.05
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 02 Oct 2015 10:39:09 -0700 (PDT)
X-Google-Original-From: Karthik Nayak <Karthik.188@gmail.com>
X-Mailer: git-send-email 2.6.0
In-Reply-To: <1443807546-5985-1-git-send-email-Karthik.188@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278934>

Implement %(if), %(then) and %(else) atoms. Used as
%(if)..%(then)..%(end) or %(if)..%(then)..%(else)..%(end). If there is
an atom with value or string literal after the %(if) then everything
after the %(then) is printed, else if the %(else) atom is used, then
everything after %(else) is printed. If the string contains only
whitespaces, then it is not considered. Nesting of this construct is
possible.

This is in preperation for porting over `git branch -l` to use
ref-filter APIs for printing.

Add Documentation and tests regarding the same.

Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Matthieu Moy <matthieu.moy@grenoble-inp.fr>
Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 Documentation/git-for-each-ref.txt |  23 +++++++-
 ref-filter.c                       | 116 ++++++++++++++++++++++++++++++++++---
 t/t6302-for-each-ref-filter.sh     |  48 +++++++++++++++
 3 files changed, 177 insertions(+), 10 deletions(-)

diff --git a/Documentation/git-for-each-ref.txt b/Documentation/git-for-each-ref.txt
index 16b4ac5..768a512 100644
--- a/Documentation/git-for-each-ref.txt
+++ b/Documentation/git-for-each-ref.txt
@@ -134,9 +134,14 @@ align::
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
+	printed.
 
 In addition to the above, for commit and tag objects, the header
 field names (`tree`, `parent`, `object`, `type`, and `tag`) can
@@ -169,6 +174,18 @@ the date by adding one of `:default`, `:relative`, `:short`, `:local`,
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
+When a scripting language specific quoting is in effect, everything
+between a top-level opening atom and its matching %(end) is evaluated
+according to the semantics of the opening atom and its result is
+quoted.
 
 EXAMPLES
 --------
diff --git a/ref-filter.c b/ref-filter.c
index dbd8fce..93b07f5 100644
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
@@ -69,10 +72,17 @@ struct contents {
 	struct object_id oid;
 };
 
+struct if_then_else {
+	unsigned int if_atom : 1,
+		then_atom : 1,
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
 
@@ -216,13 +226,14 @@ static void pop_stack_element(struct ref_formatting_stack **stack)
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
 
@@ -236,6 +247,85 @@ static void align_atom_handler(struct atom_value *atomv, struct ref_formatting_s
 	new->at_end_data = &atomv->u.align;
 }
 
+static void if_then_else_handler(struct ref_formatting_stack **stack)
+{
+	struct ref_formatting_stack *cur = *stack;
+	struct ref_formatting_stack *prev = cur->prev;
+	struct if_then_else *if_then_else = (struct if_then_else *)cur->at_end_data;
+
+	/*
+	 * If the 'if' condition is satisfied, then if there exists an
+	 * 'else' atom drop the 'else' atom's state. Else we swap the
+	 * buffer of the 'else' atom with the previous state and drop
+	 * that state. If the condition is satisfied and no 'else' atom
+	 * exists, then just clear the buffer.
+	 */
+	if (if_then_else->condition_satisfied && if_then_else->else_atom) {
+		strbuf_reset(&cur->output);
+		pop_stack_element(&cur);
+	} else if (if_then_else->else_atom) {
+		strbuf_swap(&cur->output, &prev->output);
+		strbuf_reset(&cur->output);
+		pop_stack_element(&cur);
+	} else if (!if_then_else->condition_satisfied)
+		strbuf_reset(&cur->output);
+	*stack = cur;
+	free(if_then_else);
+}
+
+static void if_atom_handler(struct atom_value *atomv, struct ref_formatting_state *state)
+{
+	struct ref_formatting_stack *new;
+	struct if_then_else *if_then_else = xcalloc(sizeof(struct if_then_else), 1);
+
+	if_then_else->if_atom = 1;
+	push_stack_element(&state->stack);
+	new = state->stack;
+	new->at_end = if_then_else_handler;
+	new->at_end_data = if_then_else;
+}
+
+static int is_empty(const char * s){
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
+	struct if_then_else *if_then_else = (struct if_then_else *)cur->at_end_data;
+
+	if (!if_then_else)
+		die(_("format: %%(then) atom used without an %%(if) atom"));
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
+	struct if_then_else *if_then_else = (struct if_then_else *)state->stack->at_end_data;
+
+	if (!if_then_else)
+		die(_("format: %%(else) atom used without an %%(if) atom"));
+	if (!if_then_else->then_atom)
+		die(_("format: %%(else) atom used without a %%(then) atom"));
+	if_then_else->else_atom = 1;
+	push_stack_element(&state->stack);
+	state->stack->at_end_data = prev->at_end_data;
+	state->stack->at_end = prev->at_end;
+}
+
 static void end_atom_handler(struct atom_value *atomv, struct ref_formatting_state *state)
 {
 	struct ref_formatting_stack *current = state->stack;
@@ -243,14 +333,17 @@ static void end_atom_handler(struct atom_value *atomv, struct ref_formatting_sta
 
 	if (!current->at_end)
 		die(_("format: %%(end) atom used without corresponding atom"));
-	current->at_end(current);
+	current->at_end(&state->stack);
+
+	/*  Stack may have been popped, hence reset the current pointer */
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
@@ -920,6 +1013,15 @@ static void populate_value(struct ref_array_item *ref)
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
index fe4796c..7ce1cc4 100755
--- a/t/t6302-for-each-ref-filter.sh
+++ b/t/t6302-for-each-ref-filter.sh
@@ -255,4 +255,52 @@ test_expect_success 'reverse version sort' '
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
 test_done
-- 
2.6.0
