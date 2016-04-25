From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v5b 03/17] ref-filter: implement %(if:equals=<string>) and %(if:notequals=<string>)
Date: Mon, 25 Apr 2016 20:47:44 +0530
Message-ID: <1461597478-31855-3-git-send-email-Karthik.188@gmail.com>
References: <1461581558-32348-1-git-send-email-Karthik.188@gmail.com>
Cc: jacob.keller@gmail.com, gitster@pobox.com, peff@peff.net,
	Karthik Nayak <Karthik.188@gmail.com>,
	Karthik Nayak <karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 25 17:18:24 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1auiHF-0005g7-0c
	for gcvg-git-2@plane.gmane.org; Mon, 25 Apr 2016 17:18:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754880AbcDYPSM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Apr 2016 11:18:12 -0400
Received: from mail-pf0-f180.google.com ([209.85.192.180]:35520 "EHLO
	mail-pf0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752601AbcDYPSL (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Apr 2016 11:18:11 -0400
Received: by mail-pf0-f180.google.com with SMTP id n1so69619102pfn.2
        for <git@vger.kernel.org>; Mon, 25 Apr 2016 08:18:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=C7ieyZnzt9M94dFRzMIYiJBRG0Fk0qSH3Po4FeuqWho=;
        b=MiJapwbf75JV8yO44u3vDknhgz0IuJfWOte0aki2/seQXqlfFojXCa+OkEkJFhp74d
         HQpqXJEU4GAS07a/m5SppAcW3x5VMz73E29zMPUSdobmVJ6B35FxyayxCdN732znMWBC
         IEpbTQbHE66/rv5pbcE4tqV13+IV28fjfK6MpuzRQmi3TfJRcEWbtxhvyv7UXL2yNxap
         Q4+eRoIqHZnnxnBT0Q52l6jd13EztLVBM+U5lAk92gBQsrYgc1vJCpTafIAb0oeo+b7R
         YX7/guxIRyq5m04ImDIQEWXYxlFNwH6d+ddxM2dP7cm7UKoMoMmtQPCKTFUMW3SJAf+t
         biTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=C7ieyZnzt9M94dFRzMIYiJBRG0Fk0qSH3Po4FeuqWho=;
        b=P/CCsn33aCndeTNQFK6B0u7gbK+hk1IIa2FaT4+oPBCTFJyoiEeY+V+Ts2kHvD7DEC
         ZY+y+gueJML6Qw6DW+lcsOv0PIpwU7oKDs6oCvzjXOyCSaDiudGfVJKGzzO3Lo2YNU4u
         /8gbbr5JtumLocIaJ4jLMMoKPFKwlgr5x623Ci3AVFHL3yaoatA5nRKdk2saoAywFjaD
         jk59vCNcI0rfHjnpra38a7t2iS0G7PI2tjb8NjfMazC2usM3xqbcyCskVkPR1y3QBKUw
         tkqVNjoNPpMOWu6yrZVgpgRbD9q6k56XboVa8mlrrB5hIZRYXKTSfKFwVyapvWMBkgih
         8MRg==
X-Gm-Message-State: AOPr4FVtf11y5kWeUTaI0k5ZRPCGENEExmWKZ0CTxei3gk3phSxEGGVxxc8x3fzP4dWtug==
X-Received: by 10.98.102.20 with SMTP id a20mr9801458pfc.137.1461597490246;
        Mon, 25 Apr 2016 08:18:10 -0700 (PDT)
Received: from ashley.localdomain ([106.51.234.108])
        by smtp.gmail.com with ESMTPSA id ut1sm30812527pac.46.2016.04.25.08.18.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 25 Apr 2016 08:18:09 -0700 (PDT)
X-Google-Original-From: Karthik Nayak <Karthik.188@gmail.com>
X-Mailer: git-send-email 2.8.0
In-Reply-To: <1461581558-32348-1-git-send-email-Karthik.188@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292490>

Implement %(if:equals=<string>) wherein the if condition is only
satisfied if the value obtained between the %(if:...) and %(then) atom
is the same as the given '<string>'.

Similarly, implement (if:notequals=<string>) wherein the if condition
is only satisfied if the value obtained between the %(if:...) and
%(then) atom is differnt from the given '<string>'.

This is done by introducing 'if_atom_parser()' which parses the given
%(if) atom and then stores the data in used_atom which is later passed
on to the used_atom of the %(then) atom, so that it can do the required
comparisons.

Add tests and Documentation for the same.

Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Matthieu Moy <matthieu.moy@grenoble-inp.fr>
Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 Documentation/git-for-each-ref.txt |  3 +++
 ref-filter.c                       | 43 +++++++++++++++++++++++++++++++++-----
 t/t6302-for-each-ref-filter.sh     | 18 ++++++++++++++++
 3 files changed, 59 insertions(+), 5 deletions(-)

diff --git a/Documentation/git-for-each-ref.txt b/Documentation/git-for-each-ref.txt
index 473b6bf..3e7db10 100644
--- a/Documentation/git-for-each-ref.txt
+++ b/Documentation/git-for-each-ref.txt
@@ -152,6 +152,9 @@ if::
 	evaluating the string before %(then), this is useful when we
 	use the %(HEAD) atom which prints either "*" or " " and we
 	want to apply the 'if' condition only on the 'HEAD' ref.
+	Append ":equals=<string>" or ":notequals=<string>" to compare
+	the value between the %(if:...) and %(then) atoms with the
+	given string.
 
 In addition to the above, for commit and tag objects, the header
 field names (`tree`, `parent`, `object`, `type`, and `tag`) can
diff --git a/ref-filter.c b/ref-filter.c
index 12e646c..857a8b5 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -22,6 +22,8 @@ struct align {
 };
 
 struct if_then_else {
+	const char *if_equals,
+		*not_equals;
 	unsigned int then_atom_seen : 1,
 		else_atom_seen : 1,
 		condition_satisfied : 1;
@@ -49,6 +51,10 @@ static struct used_atom {
 			enum { C_BARE, C_BODY, C_BODY_DEP, C_LINES, C_SIG, C_SUB } option;
 			unsigned int nlines;
 		} contents;
+		struct {
+			const char *if_equals,
+				*not_equals;
+		} if_then_else;
 		enum { O_FULL, O_SHORT } objectname;
 	} u;
 } *used_atom;
@@ -169,6 +175,19 @@ static void align_atom_parser(struct used_atom *atom, const char *arg)
 	string_list_clear(&params, 0);
 }
 
+static void if_atom_parser(struct used_atom *atom, const char *arg)
+{
+	if (!arg)
+		return;
+	else if (skip_prefix(arg, "equals=", &atom->u.if_then_else.if_equals))
+		 ;
+	else if (skip_prefix(arg, "notequals=", &atom->u.if_then_else.not_equals))
+		;
+	else
+		die(_("unrecognized %%(if) argument: %s"), arg);
+}
+
+
 static struct {
 	const char *name;
 	cmp_type cmp_type;
@@ -209,7 +228,7 @@ static struct {
 	{ "color", FIELD_STR, color_atom_parser },
 	{ "align", FIELD_STR, align_atom_parser },
 	{ "end" },
-	{ "if" },
+	{ "if", FIELD_STR, if_atom_parser },
 	{ "then" },
 	{ "else" },
 };
@@ -410,6 +429,9 @@ static void if_atom_handler(struct atom_value *atomv, struct ref_formatting_stat
 	struct ref_formatting_stack *new;
 	struct if_then_else *if_then_else = xcalloc(sizeof(struct if_then_else), 1);
 
+	if_then_else->if_equals = atomv->atom->u.if_then_else.if_equals;
+	if_then_else->not_equals = atomv->atom->u.if_then_else.not_equals;
+
 	push_stack_element(&state->stack);
 	new = state->stack;
 	new->at_end = if_then_else_handler;
@@ -441,10 +463,17 @@ static void then_atom_handler(struct atom_value *atomv, struct ref_formatting_st
 		die(_("format: %%(then) atom used after %%(else)"));
 	if_then_else->then_atom_seen = 1;
 	/*
-	 * If there exists non-empty string between the 'if' and
-	 * 'then' atom then the 'if' condition is satisfied.
+	 * If the 'equals' or 'notequals' attribute is used then
+	 * perform the required comparison. If not, only non-empty
+	 * strings satisfy the 'if' condition.
 	 */
-	if (cur->output.len && !is_empty(cur->output.buf))
+	if (if_then_else->if_equals) {
+		if (!strcmp(if_then_else->if_equals, cur->output.buf))
+			if_then_else->condition_satisfied = 1;
+	} else 	if (if_then_else->not_equals) {
+		if (strcmp(if_then_else->not_equals, cur->output.buf))
+			if_then_else->condition_satisfied = 1;
+	} else if (cur->output.len && !is_empty(cur->output.buf))
 		if_then_else->condition_satisfied = 1;
 	strbuf_reset(&cur->output);
 }
@@ -1137,7 +1166,11 @@ static void populate_value(struct ref_array_item *ref)
 		} else if (!strcmp(name, "end")) {
 			v->handler = end_atom_handler;
 			continue;
-		} else if (!strcmp(name, "if")) {
+		} else if (starts_with(name, "if")) {
+			const char *s;
+
+			if (skip_prefix(name, "if:", &s))
+				v->s = xstrdup(s);
 			v->handler = if_atom_handler;
 			continue;
 		} else if (!strcmp(name, "then")) {
diff --git a/t/t6302-for-each-ref-filter.sh b/t/t6302-for-each-ref-filter.sh
index 05935b3..206ad67 100755
--- a/t/t6302-for-each-ref-filter.sh
+++ b/t/t6302-for-each-ref-filter.sh
@@ -404,4 +404,22 @@ test_expect_success 'ignore spaces in %(if) atom usage' '
 	test_cmp expect actual
 '
 
+test_expect_success 'check %(if:equals=<string>)' '
+	git for-each-ref --format="%(if:equals=master)%(refname:short)%(then)Found master%(else)Not master%(end)" refs/heads/ >actual &&
+	cat >expect <<-\EOF &&
+	Found master
+	Not master
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success 'check %(if:notequals=<string>)' '
+	git for-each-ref --format="%(if:notequals=master)%(refname:short)%(then)Not master%(else)Found master%(end)" refs/heads/ >actual &&
+	cat >expect <<-\EOF &&
+	Found master
+	Not master
+	EOF
+	test_cmp expect actual
+'
+
 test_done
-- 
2.8.0
