From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v2 03/16] ref-filter: implement %(if:equals=<string>) and %(if:notequals=<string>)
Date: Tue, 15 Mar 2016 22:17:03 +0530
Message-ID: <1458060436-1215-4-git-send-email-Karthik.188@gmail.com>
References: <1458060436-1215-1-git-send-email-Karthik.188@gmail.com>
Cc: gitster@pobox.com, jacob.keller@gmail.com,
	Karthik Nayak <Karthik.188@gmail.com>,
	Karthik Nayak <karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 15 17:47:39 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1afs8A-0000hn-Ep
	for gcvg-git-2@plane.gmane.org; Tue, 15 Mar 2016 17:47:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934726AbcCOQre (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Mar 2016 12:47:34 -0400
Received: from mail-pf0-f172.google.com ([209.85.192.172]:34934 "EHLO
	mail-pf0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964950AbcCOQra (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Mar 2016 12:47:30 -0400
Received: by mail-pf0-f172.google.com with SMTP id n5so35748494pfn.2
        for <git@vger.kernel.org>; Tue, 15 Mar 2016 09:47:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=d5TErIQWZr2/dvrwoSKXO0HxOyNQhHycR/bUZuolORs=;
        b=g7NoQBqxe+5IK2eW5nB/JBPhw/4Aul1nasxHU4FBxt8yrh8UTa7IhLUUJMNim15D8w
         Vej4EE5FSPiUGa9FL6nRLQQcietqJUxTuuUep6v/dC8ikEFls2tddqkT22QxTAE2iggL
         Hflrh5N0o0Ija+CZuVUTEoq9uDq7TZpj5R8zoIC33wkSy7za/lxLNfMLmHV9lRWCfcYY
         yV+rMvYbP5s8xzu1RYe9JjYT5kvX6Qxx+llJMxzhGxUVEsAOSbSYB/zPtesnmjnI3Xhx
         K7zCle+QBz91iCv+7g4ZuZuBOBxdkRtTdf7UqISFJiolDeB0EfEYzdc1z0lDRuyiJixg
         sMVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=d5TErIQWZr2/dvrwoSKXO0HxOyNQhHycR/bUZuolORs=;
        b=FKVO8aXQyvwdfuVUnyc32d2nbkDSz7zfZPA98GHMZyOHtogQhcSy1Sn4YrXo574sgL
         VeL/9PzYZWBBlvNjGMtl+SIuKEROOQOT5IC3cHSNaxf1l4fzseP2omVnN8l/McE8lQz8
         QZ7f2mOrSATN2c34V6hpQBwwMKXZbdOHgXE2w2C1XSiyOpqQhRVRgVwFIQh5AvJ+zymB
         LNm2IpDuYaoyqZcRF2LbLt3h3IcBYsR2z3xaiOG9vnL0YNh73fOc/zQRToeDteZi6baS
         +q7cUfKBIS3yMhz3SSoy7McxiOoTLuyj+aQoHdhE93Ft1NaPW8L9cCwayCuWh/QmagAM
         /wYQ==
X-Gm-Message-State: AD7BkJILhuNv94OdjH2hJbDbUWxoSgxrKNxCq4a4RL13UFyxKNIZ1HIJQjHpdspmIDIHww==
X-Received: by 10.66.246.165 with SMTP id xx5mr47917755pac.87.1458060449833;
        Tue, 15 Mar 2016 09:47:29 -0700 (PDT)
Received: from localhost.localdomain ([106.51.243.87])
        by smtp.gmail.com with ESMTPSA id i1sm40874361pfj.17.2016.03.15.09.47.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 15 Mar 2016 09:47:29 -0700 (PDT)
X-Google-Original-From: Karthik Nayak <Karthik.188@gmail.com>
X-Mailer: git-send-email 2.7.3
In-Reply-To: <1458060436-1215-1-git-send-email-Karthik.188@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288865>

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
2.7.3
