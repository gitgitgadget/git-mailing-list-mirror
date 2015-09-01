From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v15 04/13] ref-filter: introduce handler function for each atom
Date: Tue,  1 Sep 2015 23:56:25 +0530
Message-ID: <1441131994-13508-5-git-send-email-Karthik.188@gmail.com>
References: <1441131994-13508-1-git-send-email-Karthik.188@gmail.com>
Cc: christian.couder@gmail.com, Matthieu.Moy@grenoble-inp.fr,
	gitster@pobox.com, Karthik Nayak <Karthik.188@gmail.com>,
	Karthik Nayak <karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 01 20:26:49 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZWqGe-0007BT-SR
	for gcvg-git-2@plane.gmane.org; Tue, 01 Sep 2015 20:26:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755286AbbIAS0m (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Sep 2015 14:26:42 -0400
Received: from mail-pa0-f43.google.com ([209.85.220.43]:36417 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754855AbbIAS0l (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Sep 2015 14:26:41 -0400
Received: by pacwi10 with SMTP id wi10so3653319pac.3
        for <git@vger.kernel.org>; Tue, 01 Sep 2015 11:26:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=NCuWu2nR181jV5EgRAC0tdEK3gO+TGAGpm+gLrDu7+Q=;
        b=WkNlXJxy1H1o153gYXpuA1AQctawrCZy9Oajbo+WOJ2liYlhLvCSKU/hdpFpv2C53D
         eo/PWdKllJJ07IXFIpxDi2x87bd3lAonV0QScyJLr/sglOTRjK5mXiDTcnYsFtESN0mO
         O0Ml2QBKXbhAk7zS+pzmfAas9f9Z3KDTqdg5V/cygP9v6XNjUANKJHtWrbyiE+iElWGZ
         U5Wbs2CKg+WME+hgW4ygdAldvruer8NQJXSS4WrytwSWeeOKEEMT1VGBteBylkgnuT7P
         ecF6NQbxUNlqc3cR+46ublAzUHR3VnlhVjPrsccJHX41V0/gTIEa1PQvIU8vy68FxIUO
         5C+g==
X-Received: by 10.68.228.36 with SMTP id sf4mr19129501pbc.0.1441132001331;
        Tue, 01 Sep 2015 11:26:41 -0700 (PDT)
Received: from ashley.localdomain ([106.51.130.23])
        by smtp.gmail.com with ESMTPSA id uk6sm19091682pac.27.2015.09.01.11.26.38
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 01 Sep 2015 11:26:40 -0700 (PDT)
X-Google-Original-From: Karthik Nayak <Karthik.188@gmail.com>
X-Mailer: git-send-email 2.5.0
In-Reply-To: <1441131994-13508-1-git-send-email-Karthik.188@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277014>

Introduce a handler function for each atom, which is called when the
atom is processed in show_ref_array_item().

In this context make append_atom() as the default handler function and
extract quote_formatting() out of append_atom(). Bump this to the top.

Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Matthieu Moy <matthieu.moy@grenoble-inp.fr>
Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 ref-filter.c | 54 ++++++++++++++++++++++++++++++------------------------
 1 file changed, 30 insertions(+), 24 deletions(-)

diff --git a/ref-filter.c b/ref-filter.c
index 432cea0..a993216 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -69,6 +69,7 @@ struct ref_formatting_state {
 
 struct atom_value {
 	const char *s;
+	void (*handler)(struct atom_value *atomv, struct ref_formatting_state *state);
 	unsigned long ul; /* used for sorting when not FIELD_STR */
 };
 
@@ -141,6 +142,32 @@ int parse_ref_filter_atom(const char *atom, const char *ep)
 	return at;
 }
 
+static void quote_formatting(struct strbuf *s, const char *str, int quote_style)
+{
+	switch (quote_style) {
+	case QUOTE_NONE:
+		strbuf_addstr(s, str);
+		break;
+	case QUOTE_SHELL:
+		sq_quote_buf(s, str);
+		break;
+	case QUOTE_PERL:
+		perl_quote_buf(s, str);
+		break;
+	case QUOTE_PYTHON:
+		python_quote_buf(s, str);
+		break;
+	case QUOTE_TCL:
+		tcl_quote_buf(s, str);
+		break;
+	}
+}
+
+static void append_atom(struct atom_value *v, struct ref_formatting_state *state)
+{
+	quote_formatting(&state->stack->output, v->s, state->quote_style);
+}
+
 static void push_stack_element(struct ref_formatting_stack **stack)
 {
 	struct ref_formatting_stack *s = xcalloc(1, sizeof(struct ref_formatting_stack));
@@ -662,6 +689,8 @@ static void populate_value(struct ref_array_item *ref)
 		const char *formatp;
 		struct branch *branch = NULL;
 
+		v->handler = append_atom;
+
 		if (*name == '*') {
 			deref = 1;
 			name++;
@@ -1228,29 +1257,6 @@ void ref_array_sort(struct ref_sorting *sorting, struct ref_array *array)
 	qsort(array->items, array->nr, sizeof(struct ref_array_item *), compare_refs);
 }
 
-static void append_atom(struct atom_value *v, struct ref_formatting_state *state)
-{
-	struct strbuf *s = &state->stack->output;
-
-	switch (state->quote_style) {
-	case QUOTE_NONE:
-		strbuf_addstr(s, v->s);
-		break;
-	case QUOTE_SHELL:
-		sq_quote_buf(s, v->s);
-		break;
-	case QUOTE_PERL:
-		perl_quote_buf(s, v->s);
-		break;
-	case QUOTE_PYTHON:
-		python_quote_buf(s, v->s);
-		break;
-	case QUOTE_TCL:
-		tcl_quote_buf(s, v->s);
-		break;
-	}
-}
-
 static int hex1(char ch)
 {
 	if ('0' <= ch && ch <= '9')
@@ -1307,7 +1313,7 @@ void show_ref_array_item(struct ref_array_item *info, const char *format, int qu
 		if (cp < sp)
 			append_literal(cp, sp, &state);
 		get_ref_atom_value(info, parse_ref_filter_atom(sp + 2, ep), &atomv);
-		append_atom(atomv, &state);
+		atomv->handler(atomv, &state);
 	}
 	if (*cp) {
 		sp = cp + strlen(cp);
-- 
2.5.0
