From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v16 04/14] ref-filter: introduce handler function for each atom
Date: Sun,  6 Sep 2015 00:22:05 +0530
Message-ID: <1441479135-5285-5-git-send-email-Karthik.188@gmail.com>
References: <1441479135-5285-1-git-send-email-Karthik.188@gmail.com>
Cc: christian.couder@gmail.com, Matthieu.Moy@grenoble-inp.fr,
	gitster@pobox.com, Karthik Nayak <Karthik.188@gmail.com>,
	Karthik Nayak <karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 05 20:52:45 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZYIZu-000291-JP
	for gcvg-git-2@plane.gmane.org; Sat, 05 Sep 2015 20:52:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752584AbbIESwj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Sep 2015 14:52:39 -0400
Received: from mail-pa0-f45.google.com ([209.85.220.45]:34537 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751801AbbIESwR (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Sep 2015 14:52:17 -0400
Received: by padhy16 with SMTP id hy16so52760963pad.1
        for <git@vger.kernel.org>; Sat, 05 Sep 2015 11:52:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Zw9qM+FhOFKMYOV/iagWpwaSsStqQG54cfRrYkrvf50=;
        b=OCWYLb3S66f1jmcr4sgJSzV0OxXDgKIPC6WoQUgEvYLwWlEyq9zJSPGI8+zv4kkqsy
         yxgOiaCSiE/Ql6c3tOH9sWdQwvQz77c83JAlh8/HTONM/BJIc/r/MfZzFuRvi0jsSmkp
         5LpuvnF/X4f+GVDfjWK+y3x+j4QQC3DRn56X7zfj6hriL95rfA0Q61USf/LGT6NugQGh
         KZPSCSAWiykHDPii47vR3lQ3qk8oMqmfkm+eyZS+IzNt4wP3Xr5jqTWhfZgvIxQPwtIx
         5RMOaySthljVKn15A6wK/P6wBWC0aZK10+Mo9dhZKysVPr9m3Z6Zrd4iF4gUnV1BL79d
         18yg==
X-Received: by 10.66.122.4 with SMTP id lo4mr23882580pab.1.1441479137074;
        Sat, 05 Sep 2015 11:52:17 -0700 (PDT)
Received: from ashley.localdomain ([106.51.130.23])
        by smtp.gmail.com with ESMTPSA id ch3sm6583639pbb.18.2015.09.05.11.52.14
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 05 Sep 2015 11:52:16 -0700 (PDT)
X-Google-Original-From: Karthik Nayak <Karthik.188@gmail.com>
X-Mailer: git-send-email 2.5.1
In-Reply-To: <1441479135-5285-1-git-send-email-Karthik.188@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277396>

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
2.5.1
