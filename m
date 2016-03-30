From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v3 03/16] ref-filter: implement %(if:equals=<string>) and %(if:notequals=<string>)
Date: Wed, 30 Mar 2016 15:09:47 +0530
Message-ID: <1459330800-12525-4-git-send-email-Karthik.188@gmail.com>
References: <1459330800-12525-1-git-send-email-Karthik.188@gmail.com>
Cc: gitster@pobox.com, jacob.keller@gmail.com,
	Karthik Nayak <Karthik.188@gmail.com>,
	Karthik Nayak <karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 30 11:40:37 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1alCc6-0001fQ-HG
	for gcvg-git-2@plane.gmane.org; Wed, 30 Mar 2016 11:40:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752136AbcC3Jk0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Mar 2016 05:40:26 -0400
Received: from mail-pf0-f182.google.com ([209.85.192.182]:36429 "EHLO
	mail-pf0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751954AbcC3JkR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Mar 2016 05:40:17 -0400
Received: by mail-pf0-f182.google.com with SMTP id e128so16657465pfe.3
        for <git@vger.kernel.org>; Wed, 30 Mar 2016 02:40:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=2saz3H/BrBuywIBt8LcuOjzojx0L3srTcgbq8Phgvqo=;
        b=lHKa4CcrElF02VKid9KzNt1hXmO0dV1CeiS+K4MfI6ydWXNGzAah06fWNs3RaQnNjp
         NGPAlN+9KrOlKYwK4E893XmvTA3cky+Z2fSXLLUERJbKMz4vDizIOTVUc3UFCZtrTSU5
         yV+5MYlS02sPOzFiDlnZccnEUdQYVQD8NzfbcNhfqrxf0yE9th9s2uUPM0tCzfGd+XHp
         gWhymgZy+CjDw3qhDS55hQqvJLzNPW5Pd92VtgrUL0VfoxzMca/MRRUAESS8bizqCm2l
         w32hrOjC8g/8MJ0gJ0BoJB1+Ur38jM//OJTLwBDUKo583jxY+wjNRe5e+c+TXtHGy1h1
         yE4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=2saz3H/BrBuywIBt8LcuOjzojx0L3srTcgbq8Phgvqo=;
        b=eZR8FvQnqZSFcL5C2/hoc9o7qPNZj4Oe4OjHOFPZXD55xisktzFKSyfmU+CkXJEdxH
         E8DilI0l7rOixVhA/sRhIIaC+eJ7lanQpMzzHb2yZn8FeTFfIgHap0TgTUHKTlsyyFhE
         5/3BoKcUN2IEWrmSHc3gCRkGrfaxf96NoUNpU1pT7ZYMw1x0KzSUMhCPFoHWjw8Iegjl
         yJ09reRPd54Fdwhyo65PPoUOPSqrRQFHU5cnuYzr2mr3l+Q3S90YMwPmKS3KwLFW6wy1
         PrGAreRJk0juogoLnJ0yaKm3D41SE1VrWV/upWI74lKIExdfaP3ZRH6B5++p4OAvsmUt
         ue2w==
X-Gm-Message-State: AD7BkJJgmDTCBClMyAufxRiyQEJKPqrGst8szKg6yjvjiDDvLWHwmBuSVHjCFc6vG5xp/w==
X-Received: by 10.98.11.78 with SMTP id t75mr11346282pfi.72.1459330816462;
        Wed, 30 Mar 2016 02:40:16 -0700 (PDT)
Received: from localhost.localdomain ([106.51.243.45])
        by smtp.gmail.com with ESMTPSA id r65sm4402606pfa.27.2016.03.30.02.40.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 30 Mar 2016 02:40:15 -0700 (PDT)
X-Google-Original-From: Karthik Nayak <Karthik.188@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1459330800-12525-1-git-send-email-Karthik.188@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290284>

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
index d048561..e1b1a66 100644
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
index 954b12a..83716e4 100755
--- a/t/t6302-for-each-ref-filter.sh
+++ b/t/t6302-for-each-ref-filter.sh
@@ -367,4 +367,22 @@ test_expect_success 'ignore spaces in %(if) atom usage' '
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
2.7.4
