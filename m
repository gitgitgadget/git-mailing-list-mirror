From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v4 03/16] ref-filter: implement %(if:equals=<string>) and %(if:notequals=<string>)
Date: Sun, 10 Apr 2016 00:15:02 +0530
Message-ID: <1460227515-28437-4-git-send-email-Karthik.188@gmail.com>
References: <1460227515-28437-1-git-send-email-Karthik.188@gmail.com>
Cc: jacob.keller@gmail.com, gitster@pobox.com,
	Karthik Nayak <Karthik.188@gmail.com>,
	Karthik Nayak <karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 09 20:45:42 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aoxt7-0003Zh-3i
	for gcvg-git-2@plane.gmane.org; Sat, 09 Apr 2016 20:45:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758895AbcDISp3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Apr 2016 14:45:29 -0400
Received: from mail-io0-f193.google.com ([209.85.223.193]:36065 "EHLO
	mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758858AbcDISp1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Apr 2016 14:45:27 -0400
Received: by mail-io0-f193.google.com with SMTP id s2so20553287iod.3
        for <git@vger.kernel.org>; Sat, 09 Apr 2016 11:45:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=LR/u7iKlHbayfdgDs+iO6PaAtjW8h37lAuX9Q5Euo7E=;
        b=y0IAY61SaZ2k0tw9PQWn5SRnSrKzY5SzCB6XsujWBbWSUfmWGsks8CaYsNxVCQhfdK
         hvu9utPfreHYgCgPgD0fKIuollk/79cL6mpeJvy16VNZHaTXIRcZ9zGA/4nd9TC1ffG8
         geMbxz3Hu2MNHzGEMamGLL5PiJWwGCZTc4pppEJ6LVUeBHfUqG0dI/N4Oke0WnKFbIyk
         cvH7Uau+C7ox8i6f/4uLsbihRn62NllPVR/jquJGoutflEYefRBeisZM0myhXyHpS1wz
         EG0wepKAGfOfWEIjcNtrtaQifcGxgrS/BKzi6qfWlVr+OOmwtjRFumRhE2mDbtZ8XUfX
         b9oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=LR/u7iKlHbayfdgDs+iO6PaAtjW8h37lAuX9Q5Euo7E=;
        b=iq9/xceKYOgpU0dAZ8bpCvNs9clKz5jSylo60NCd8lufOOo4mqKDSo3dRcTzVQJ9lI
         jQ2T93++AM0tIi4HmZ+kmlarSRrwLGsxLhBTT6S8gocikv+O+6y9oOllKtn97KoVGVWX
         wRP93JSU+S6p/6qNXORR2jF8WBlUQkMffs77YdaKV9SXDfymFB51XuUELqcUtvXCNKct
         +mPqLY3SHjMp5u0iR2rvzwgXVqaPhVl/vzcZVVV4O1RRdty+0ftC2cpkJfDMEN+5wJ5J
         KjidqI/xcX+XJSGqKYlBhbZkbTg9ErQjtZZFGu98jqQ3U9Rv0QpJrBb542h5mytGPt54
         efkA==
X-Gm-Message-State: AD7BkJKwGlTPVxkI0i6hhrcHzAsQFYc0dHti8Hccc/Yeg34VpqGNq/WWtQwy7evplxb+lQ==
X-Received: by 10.107.10.144 with SMTP id 16mr17063067iok.48.1460227526361;
        Sat, 09 Apr 2016 11:45:26 -0700 (PDT)
Received: from localhost.localdomain ([106.51.241.12])
        by smtp.gmail.com with ESMTPSA id be7sm7132351igb.1.2016.04.09.11.45.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 09 Apr 2016 11:45:25 -0700 (PDT)
X-Google-Original-From: Karthik Nayak <Karthik.188@gmail.com>
X-Mailer: git-send-email 2.8.0
In-Reply-To: <1460227515-28437-1-git-send-email-Karthik.188@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291112>

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
