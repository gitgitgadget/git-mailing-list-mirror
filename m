From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH 2/9] ref-filter: implement %(if:equals=<string>) and %(if:notequals=<string>)
Date: Fri,  2 Oct 2015 23:08:59 +0530
Message-ID: <1443807546-5985-3-git-send-email-Karthik.188@gmail.com>
References: <1443807546-5985-1-git-send-email-Karthik.188@gmail.com>
Cc: christian.couder@gmail.com, Matthieu.Moy@grenoble-inp.fr,
	gitster@pobox.com, Karthik Nayak <Karthik.188@gmail.com>,
	Karthik Nayak <karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 02 19:41:34 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zi4Ko-0005y6-Fy
	for gcvg-git-2@plane.gmane.org; Fri, 02 Oct 2015 19:41:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752706AbbJBRlY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Oct 2015 13:41:24 -0400
Received: from mail-pa0-f66.google.com ([209.85.220.66]:36587 "EHLO
	mail-pa0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754024AbbJBRjN (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Oct 2015 13:39:13 -0400
Received: by pacik9 with SMTP id ik9so12566088pac.3
        for <git@vger.kernel.org>; Fri, 02 Oct 2015 10:39:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=m52Or2XZ/e2Ha8bJ1v2mzK0oLapqOOXUaibUIZ/Q12s=;
        b=LFEfAimbYAQbu+u+2+JgManGSrRsQwXgyXx+nguGeCxwB0jort/t5aqwtfgJ+5ynlC
         TSVmBwtXm3+Jn/pOmCyX6hC886eoZcItEcAcJL/qudIf4b6SpkXMAUX5vVekWhD8F+xC
         Fo/iAXyMCohSyMsP84dpjVOW03tYEQziupiwfo/j7F+khcKOzyxLaueZa0vt87QUaoJX
         zlGGbmoZl7EUM7NHMn0WWjhuGbVv1Qfpi5pssDnpQxJHBZWk4Vd/p83ciuddThxbvTT7
         FD18/2UWEyfs1TE/qMk9z/psp0L5JvyIRdgyWj/ttlTyDlfp7QdCU4zatsTwDr78qatg
         5ZIg==
X-Received: by 10.66.97.73 with SMTP id dy9mr21474808pab.115.1443807552877;
        Fri, 02 Oct 2015 10:39:12 -0700 (PDT)
Received: from ashley.localdomain ([106.51.130.23])
        by smtp.gmail.com with ESMTPSA id pq1sm12993384pbb.91.2015.10.02.10.39.10
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 02 Oct 2015 10:39:12 -0700 (PDT)
X-Google-Original-From: Karthik Nayak <Karthik.188@gmail.com>
X-Mailer: git-send-email 2.6.0
In-Reply-To: <1443807546-5985-1-git-send-email-Karthik.188@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278935>

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
index 768a512..5c12c2f 100644
--- a/Documentation/git-for-each-ref.txt
+++ b/Documentation/git-for-each-ref.txt
@@ -141,7 +141,9 @@ if::
 	If there is an atom with value or string literal after the
 	%(if) then everything after the %(then) is printed, else if
 	the %(else) atom is used, then everything after %(else) is
-	printed.
+	printed. Append ":equals=<string>" or ":notequals=<string>" to
+	compare the value between the %(if:...) and %(then) atoms with the
+	given string.
 
 In addition to the above, for commit and tag objects, the header
 field names (`tree`, `parent`, `object`, `type`, and `tag`) can
diff --git a/ref-filter.c b/ref-filter.c
index 93b07f5..da7723b 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -73,6 +73,8 @@ struct contents {
 };
 
 struct if_then_else {
+	const char *if_equals,
+		*not_equals;
 	unsigned int if_atom : 1,
 		then_atom : 1,
 		else_atom : 1,
@@ -277,8 +279,16 @@ static void if_atom_handler(struct atom_value *atomv, struct ref_formatting_stat
 {
 	struct ref_formatting_stack *new;
 	struct if_then_else *if_then_else = xcalloc(sizeof(struct if_then_else), 1);
+	const char *valp;
 
 	if_then_else->if_atom = 1;
+	if (skip_prefix(atomv->s, "equals=", &valp))
+		if_then_else->if_equals = valp;
+	else if (skip_prefix(atomv->s, "notequals=", &valp))
+		if_then_else->not_equals = valp;
+	else if (atomv->s[0])
+		die(_("format: unknown format if:%s"), atomv->s);
+
 	push_stack_element(&state->stack);
 	new = state->stack;
 	new->at_end = if_then_else_handler;
@@ -302,11 +312,19 @@ static void then_atom_handler(struct atom_value *atomv, struct ref_formatting_st
 	if (!if_then_else)
 		die(_("format: %%(then) atom used without an %%(if) atom"));
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
@@ -1013,8 +1031,10 @@ static void populate_value(struct ref_array_item *ref)
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
index 7ce1cc4..d7f7a18 100755
--- a/t/t6302-for-each-ref-filter.sh
+++ b/t/t6302-for-each-ref-filter.sh
@@ -303,4 +303,22 @@ test_expect_success 'check %(if)...%(then)...%(else)...%(end) atoms' '
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
