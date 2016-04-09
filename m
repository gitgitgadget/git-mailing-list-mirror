From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v4 01/16] ref-filter: implement %(if), %(then), and %(else) atoms
Date: Sun, 10 Apr 2016 00:15:00 +0530
Message-ID: <1460227515-28437-2-git-send-email-Karthik.188@gmail.com>
References: <1460227515-28437-1-git-send-email-Karthik.188@gmail.com>
Cc: jacob.keller@gmail.com, gitster@pobox.com,
	Karthik Nayak <Karthik.188@gmail.com>,
	Karthik Nayak <karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 09 20:45:30 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aoxst-0003PV-Gh
	for gcvg-git-2@plane.gmane.org; Sat, 09 Apr 2016 20:45:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758723AbcDISpX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Apr 2016 14:45:23 -0400
Received: from mail-io0-f195.google.com ([209.85.223.195]:34710 "EHLO
	mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758040AbcDISpW (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Apr 2016 14:45:22 -0400
Received: by mail-io0-f195.google.com with SMTP id z133so20475556iod.1
        for <git@vger.kernel.org>; Sat, 09 Apr 2016 11:45:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=OUo7pNzsaDRHIj4nicV5dgNI4rfXZoDZo04rj86+Fsk=;
        b=hsRuMem3L7kE23tlpRQlN4sGMmag4Lq9iRrIlbh5gE9T1pgw0tOFaB03LdTcdejtwI
         khVMZ1zLUqEicuE0bSm3QVkJ615tja0KnqxKG0OM3rlv8+3Kmtu9BRyHZMC/RoutqvDD
         1QfJ2Hm6DM+s8Ac43q+Oam5usZpbkChS9JsS3VGj2V1kM8in7taI+HM5ykPfdIfWceJa
         gDftPhaEnkT4AXSoh/1r/EMp3ISOql96MINj2sH9QZSTQGEPX9baa2nu6vhrP3Cw1DQP
         G564p7P3+N5bf65NjFw5YusFtnph51kDaWassjC8AVRO7ayQZGDnGNfQ2gMT52bZkX1P
         PzPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=OUo7pNzsaDRHIj4nicV5dgNI4rfXZoDZo04rj86+Fsk=;
        b=gLN3/1UGFEeh4PXry5BOr61/W0GGFWs5ry2mrbOpLiv9myHD+stNBxXMaIfuLRtldR
         Ei1nU3QIF1si9Y1in7j1oECIQEdHtvpBLBPLX1qhcCbr4q+4WXIGIMtZU086zSSagih2
         molsdIg3oIzbyQ8/9XWhucTZOBOAZryPU8pWzCuYhMrzF/wdctqOGapCy2aHkEjPBVbW
         6RQU1HmhIz4AxGXOQz4cITJTQx5aPkD/lz21pNqq3ehmP4d0HJOOP1P9A0azeZpyPJK6
         WIyRlc2bBruBSy17mRTtZGmGNxp4LznjcXLAfaytZW20jQcBXdHXO4UyRHnd/t5cehQX
         fkgQ==
X-Gm-Message-State: AD7BkJJ6WhcqgUmmSy+7aHpiQq0py3jijF42I9YrWNECcFEuJOuFn81hXr2s1IRv2A5+IA==
X-Received: by 10.107.8.193 with SMTP id h62mr17855655ioi.7.1460227521050;
        Sat, 09 Apr 2016 11:45:21 -0700 (PDT)
Received: from localhost.localdomain ([106.51.241.12])
        by smtp.gmail.com with ESMTPSA id be7sm7132351igb.1.2016.04.09.11.45.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 09 Apr 2016 11:45:20 -0700 (PDT)
X-Google-Original-From: Karthik Nayak <Karthik.188@gmail.com>
X-Mailer: git-send-email 2.8.0
In-Reply-To: <1460227515-28437-1-git-send-email-Karthik.188@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291107>

Implement %(if), %(then) and %(else) atoms. Used as
%(if)...%(then)...%(end) or %(if)...%(then)...%(else)...%(end). If the
format string between %(if) and %(then) expands to an empty string, or
to only whitespaces, then the whole %(if)...%(end) expands to the string
following %(then). Otherwise, it expands to the string following
%(else), if any. Nesting of this construct is possible.

This is in preparation for porting over `git branch -l` to use
ref-filter APIs for printing.

Add Documentation and tests regarding the same.

Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Matthieu Moy <matthieu.moy@grenoble-inp.fr>
Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 Documentation/git-for-each-ref.txt |  45 +++++++++++--
 ref-filter.c                       | 133 +++++++++++++++++++++++++++++++++++--
 t/t6302-for-each-ref-filter.sh     |  76 +++++++++++++++++++++
 3 files changed, 243 insertions(+), 11 deletions(-)

diff --git a/Documentation/git-for-each-ref.txt b/Documentation/git-for-each-ref.txt
index 012e8f9..d048561 100644
--- a/Documentation/git-for-each-ref.txt
+++ b/Documentation/git-for-each-ref.txt
@@ -141,10 +141,17 @@ align::
 	"width=" and/or "position=" prefixes may be omitted, and bare
 	<width> and <position> used instead.  For instance,
 	`%(align:<width>,<position>)`. If the contents length is more
-	than the width then no alignment is performed. If used with
-	'--quote' everything in between %(align:...) and %(end) is
-	quoted, but if nested then only the topmost level performs
-	quoting.
+	than the width then no alignment is performed.
+
+if::
+	Used as %(if)...%(then)...(%end) or
+	%(if)...%(then)...%(else)...%(end).  If there is an atom with
+	value or string literal after the %(if) then everything after
+	the %(then) is printed, else if the %(else) atom is used, then
+	everything after %(else) is printed. We ignore space when
+	evaluating the string before %(then), this is useful when we
+	use the %(HEAD) atom which prints either "*" or " " and we
+	want to apply the 'if' condition only on the 'HEAD' ref.
 
 In addition to the above, for commit and tag objects, the header
 field names (`tree`, `parent`, `object`, `type`, and `tag`) can
@@ -181,6 +188,20 @@ As a special case for the date-type fields, you may specify a format for
 the date by adding `:` followed by date format name (see the
 values the `--date` option to linkgit::git-rev-list[1] takes).
 
+Some atoms like %(align) and %(if) always require a matching %(end).
+We call them "opening atoms" and sometimes denote them as %($open).
+
+When a scripting language specific quoting is in effect (i.e. one of
+`--shell`, `--perl`, `--python`, `--tcl` is used), except for opening
+atoms, replacement from every %(atom) is quoted when and only when it
+appears at the top-level (that is, when it appears outside
+%($open)...%(end)).
+
+When a scripting language specific quoting is in effect, everything
+between a top-level opening atom and its matching %(end) is evaluated
+according to the semantics of the opening atom and its result is
+quoted.
+
 
 EXAMPLES
 --------
@@ -268,6 +289,22 @@ eval=`git for-each-ref --shell --format="$fmt" \
 eval "$eval"
 ------------
 
+
+An example to show the usage of %(if)...%(then)...%(else)...%(end).
+This prefixes the current branch with a star.
+
+------------
+git for-each-ref --format="%(if)%(HEAD)%(then)* %(else)  %(end)%(refname:short)" refs/heads/
+------------
+
+
+An example to show the usage of %(if)...%(then)...%(end).
+This prints the authorname, if present.
+
+------------
+git for-each-ref --format="%(refname)%(if)%(authorname)%(then) %(color:red)Authored by: %(authorname)%(end)"
+------------
+
 SEE ALSO
 --------
 linkgit:git-show-ref[1]
diff --git a/ref-filter.c b/ref-filter.c
index bc551a7..41e73f0 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -21,6 +21,12 @@ struct align {
 	unsigned int width;
 };
 
+struct if_then_else {
+	unsigned int then_atom_seen : 1,
+		else_atom_seen : 1,
+		condition_satisfied : 1;
+};
+
 /*
  * An atom is a valid field atom listed below, possibly prefixed with
  * a "*" to denote deref_tag().
@@ -203,6 +209,9 @@ static struct {
 	{ "color", FIELD_STR, color_atom_parser },
 	{ "align", FIELD_STR, align_atom_parser },
 	{ "end" },
+	{ "if" },
+	{ "then" },
+	{ "else" },
 };
 
 #define REF_FORMATTING_STATE_INIT  { 0, NULL }
@@ -210,7 +219,7 @@ static struct {
 struct ref_formatting_stack {
 	struct ref_formatting_stack *prev;
 	struct strbuf output;
-	void (*at_end)(struct ref_formatting_stack *stack);
+	void (*at_end)(struct ref_formatting_stack **stack);
 	void *at_end_data;
 };
 
@@ -343,13 +352,14 @@ static void pop_stack_element(struct ref_formatting_stack **stack)
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
 
@@ -363,6 +373,103 @@ static void align_atom_handler(struct atom_value *atomv, struct ref_formatting_s
 	new->at_end_data = &atomv->u.align;
 }
 
+static void if_then_else_handler(struct ref_formatting_stack **stack)
+{
+	struct ref_formatting_stack *cur = *stack;
+	struct ref_formatting_stack *prev = cur->prev;
+	struct if_then_else *if_then_else = (struct if_then_else *)cur->at_end_data;
+
+	if (!if_then_else->then_atom_seen)
+		die(_("format: %%(if) atom used without a %%(then) atom"));
+
+	if (if_then_else->else_atom_seen) {
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
+static int is_empty(const char *s)
+{
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
+	if (if_then_else->then_atom_seen)
+		die(_("format: %%(then) atom used more than once"));
+	if (if_then_else->else_atom_seen)
+		die(_("format: %%(then) atom used after %%(else)"));
+	if_then_else->then_atom_seen = 1;
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
+	if (!if_then_else->then_atom_seen)
+		die(_("format: %%(else) atom used without a %%(then) atom"));
+	if (if_then_else->else_atom_seen)
+		die(_("format: %%(else) atom used more than once"));
+	if_then_else->else_atom_seen = 1;
+	push_stack_element(&state->stack);
+	state->stack->at_end_data = prev->at_end_data;
+	state->stack->at_end = prev->at_end;
+}
+
 static void end_atom_handler(struct atom_value *atomv, struct ref_formatting_state *state)
 {
 	struct ref_formatting_stack *current = state->stack;
@@ -370,14 +477,17 @@ static void end_atom_handler(struct atom_value *atomv, struct ref_formatting_sta
 
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
@@ -1029,6 +1139,15 @@ static void populate_value(struct ref_array_item *ref)
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
index 70afb44..05935b3 100755
--- a/t/t6302-for-each-ref-filter.sh
+++ b/t/t6302-for-each-ref-filter.sh
@@ -328,4 +328,80 @@ test_expect_success 'reverse version sort' '
 	test_cmp expect actual
 '
 
+test_expect_success 'improper usage of %(if), %(then), %(else) and %(end) atoms' '
+	test_must_fail git for-each-ref --format="%(if)" &&
+	test_must_fail git for-each-ref --format="%(then) %(end)" &&
+	test_must_fail git for-each-ref --format="%(else) %(end)" &&
+	test_must_fail git for-each-ref --format="%(if) %(else) %(end)" &&
+	test_must_fail git for-each-ref --format="%(if) %(then) %(then) %(end)" &&
+	test_must_fail git for-each-ref --format="%(then) %(else) %(end)" &&
+	test_must_fail git for-each-ref --format="%(if) %(else) %(end)" &&
+	test_must_fail git for-each-ref --format="%(if) %(then) %(else)" &&
+	test_must_fail git for-each-ref --format="%(if) %(else) %(then) %(end)" &&
+	test_must_fail git for-each-ref --format="%(if) %(then) %(else) %(else) %(end)" &&
+	test_must_fail git for-each-ref --format="%(if) %(end)"
+'
+
+test_expect_success 'check %(if)...%(then)...%(end) atoms' '
+	git for-each-ref --format="%(if)%(authorname)%(then)%(authorname): %(refname)%(end)" >actual &&
+	cat >expect <<-\EOF &&
+	A U Thor: refs/heads/master
+	A U Thor: refs/heads/side
+	A U Thor: refs/odd/spot
+	
+	
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
+	No author: refs/tags/annotated-tag
+	No author: refs/tags/doubly-annotated-tag
+	No author: refs/tags/doubly-signed-tag
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
+test_expect_success 'ignore spaces in %(if) atom usage' '
+	git for-each-ref --format="%(refname:short): %(if)%(HEAD)%(then)Head ref%(else)Not Head ref%(end)" >actual &&
+	cat >expect <<-\EOF &&
+	master: Head ref
+	side: Not Head ref
+	odd/spot: Not Head ref
+	annotated-tag: Not Head ref
+	doubly-annotated-tag: Not Head ref
+	doubly-signed-tag: Not Head ref
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
2.8.0
