From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v2 02/10] ref-filter: implement %(if:equals=<string>) and %(if:notequals=<string>)
Date: Thu,  8 Oct 2015 14:47:57 +0530
Message-ID: <1444295885-1657-3-git-send-email-Karthik.188@gmail.com>
References: <1444295885-1657-1-git-send-email-Karthik.188@gmail.com>
Cc: christian.couder@gmail.com, Matthieu.Moy@grenoble-inp.fr,
	gitster@pobox.com, Karthik Nayak <Karthik.188@gmail.com>,
	Karthik Nayak <karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 08 11:18:16 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zk7L4-0007Tw-B1
	for gcvg-git-2@plane.gmane.org; Thu, 08 Oct 2015 11:18:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755224AbbJHJSK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Oct 2015 05:18:10 -0400
Received: from mail-pa0-f44.google.com ([209.85.220.44]:35308 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755040AbbJHJSG (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Oct 2015 05:18:06 -0400
Received: by pabve7 with SMTP id ve7so8801408pab.2
        for <git@vger.kernel.org>; Thu, 08 Oct 2015 02:18:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Zk1eid8YA9PXNjLUZmPkXclsDsnjIiPdqSY89z4ZmcA=;
        b=D4PRjnrfWvhwTxl6SoW8xVziWE+guODjuwojmeoI/m5EKPryFgIG9yDz2+t6n9kMT5
         VsRNYKMBc/T506ql1AOwtvSQRidjMplNO08fVR5yiVzyTbC5BjpUjXVX72zgW5EuA1E2
         qCKJMVuaO4b+Ck08Bb9ZH3FnIja4tmI2NCC6xlnYpDHYCnn4b+xDIbdBdX6qdXKh9qv5
         Ozt5a3MaL3DDYNZz3ZEPUvJsvaawDUKzbweCOVXwlyDbkOMhhwz8f+ZQ5UK0/MAY3Ds4
         e83ZfqOjYgt8evPZB9SqeDrpC/0eNpU3Z+oneO8NTSJzG9Zwfh1bIa901JsIlLNmYCPe
         wBAg==
X-Received: by 10.68.219.4 with SMTP id pk4mr7027111pbc.138.1444295885442;
        Thu, 08 Oct 2015 02:18:05 -0700 (PDT)
Received: from ashley.localdomain ([106.51.20.153])
        by smtp.gmail.com with ESMTPSA id sv9sm44171159pbc.44.2015.10.08.02.18.01
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 08 Oct 2015 02:18:05 -0700 (PDT)
X-Google-Original-From: Karthik Nayak <Karthik.188@gmail.com>
X-Mailer: git-send-email 2.6.1
In-Reply-To: <1444295885-1657-1-git-send-email-Karthik.188@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279225>

Implement %(if:equals=<string>) wherein the if condition is only
satisfied if the value obtained between the %(if:...) and %(then) atom
is the same as the given '<string>'.

Similarly, implement (if:notequals=<string>) wherein the if condition
is only satisfied if the value obtained between the %(if:...) and
%(then) atom is differnt from the given '<string>'.

Add tests and Documentation for the same.

Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Matthieu Moy <matthieu.moy@grenoble-inp.fr>
Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 Documentation/git-for-each-ref.txt |  4 +++-
 ref-filter.c                       | 28 ++++++++++++++++++++++++----
 t/t6302-for-each-ref-filter.sh     | 18 ++++++++++++++++++
 3 files changed, 45 insertions(+), 5 deletions(-)

diff --git a/Documentation/git-for-each-ref.txt b/Documentation/git-for-each-ref.txt
index 7345acb..206d646 100644
--- a/Documentation/git-for-each-ref.txt
+++ b/Documentation/git-for-each-ref.txt
@@ -144,7 +144,9 @@ if::
 	printed. We ignore space when evaluating the string before
 	%(then), this is useful when we use the %(HEAD) atom which
 	prints either "*" or " " and we want to apply the 'if'
-	condition only on the 'HEAD' ref.
+	condition only on the 'HEAD' ref. Append ":equals=<string>" or
+	":notequals=<string>" to compare the value between the
+	%(if:...) and %(then) atoms with the given string.
 
 In addition to the above, for commit and tag objects, the header
 field names (`tree`, `parent`, `object`, `type`, and `tag`) can
diff --git a/ref-filter.c b/ref-filter.c
index 95f007c..359c76d 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -73,6 +73,8 @@ struct contents {
 };
 
 struct if_then_else {
+	const char *if_equals,
+		*not_equals;
 	unsigned int then_atom : 1,
 		else_atom : 1,
 		condition_satisfied : 1;
@@ -281,6 +283,14 @@ static void if_atom_handler(struct atom_value *atomv, struct ref_formatting_stat
 {
 	struct ref_formatting_stack *new;
 	struct if_then_else *if_then_else = xcalloc(sizeof(struct if_then_else), 1);
+	const char *valp;
+
+	if (skip_prefix(atomv->s, "equals=", &valp))
+		if_then_else->if_equals = valp;
+	else if (skip_prefix(atomv->s, "notequals=", &valp))
+		if_then_else->not_equals = valp;
+	else if (atomv->s[0])
+		die(_("format: unknown format if:%s"), atomv->s);
 
 	push_stack_element(&state->stack);
 	new = state->stack;
@@ -309,11 +319,19 @@ static void then_atom_handler(struct atom_value *atomv, struct ref_formatting_st
 	if (if_then_else->then_atom)
 		die(_("format: %%(then) atom used more than once"));
 	if_then_else->then_atom = 1;
+
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
@@ -1024,8 +1042,10 @@ static void populate_value(struct ref_array_item *ref)
 		} else if (!strcmp(name, "end")) {
 			v->handler = end_atom_handler;
 			continue;
-		} else if (!strcmp(name, "if")) {
+		} else if (match_atom_name(name, "if", &valp)) {
 			v->handler = if_atom_handler;
+			if (valp)
+				v->s = xstrdup(valp);
 			continue;
 		} else if (!strcmp(name, "then")) {
 			v->handler = then_atom_handler;
diff --git a/t/t6302-for-each-ref-filter.sh b/t/t6302-for-each-ref-filter.sh
index 617fa1f..f45ac1f 100755
--- a/t/t6302-for-each-ref-filter.sh
+++ b/t/t6302-for-each-ref-filter.sh
@@ -322,4 +322,22 @@ test_expect_success 'ignore spaces in %(if) atom usage' '
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
2.6.0
