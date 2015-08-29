From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v14 06/13] ref-filter: introduce format_ref_array_item()
Date: Sat, 29 Aug 2015 19:42:10 +0530
Message-ID: <1440857537-13968-7-git-send-email-Karthik.188@gmail.com>
References: <1440857537-13968-1-git-send-email-Karthik.188@gmail.com>
Cc: christian.couder@gmail.com, Matthieu.Moy@grenoble-inp.fr,
	gitster@pobox.com, Karthik Nayak <Karthik.188@gmail.com>,
	Karthik Nayak <karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 29 16:12:40 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZVgs2-0003nt-B1
	for gcvg-git-2@plane.gmane.org; Sat, 29 Aug 2015 16:12:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752776AbbH2OM3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 29 Aug 2015 10:12:29 -0400
Received: from mail-pa0-f46.google.com ([209.85.220.46]:35057 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752736AbbH2OM2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 29 Aug 2015 10:12:28 -0400
Received: by pacdd16 with SMTP id dd16so91066185pac.2
        for <git@vger.kernel.org>; Sat, 29 Aug 2015 07:12:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=nKOOdEWt0Ra1rHylXnZJ6JNYRpEj+zJ69fhXp4nh3bA=;
        b=0v2f5EObbrfPN6sITEH3TSwu8DWyXB5kSYcczOvwBWwghj2DGoSYM2tzBSP7mU8RMq
         aaNtSGrGQZWZJNtYWjABe994e1RZvcwd6GcfJyJ/oDpJLOwbbk6Y+Iee+/WCOQ9elhCO
         6tf/FVQ/fBusuKcoq/wSjyGxsxCEHSUwYz9qfexV8DBd8xSCABA4t+ZK6TiTw2KzpSdT
         JAP+UuOYqMNbZxYlM/tG4I8459csUZYACDwDL9ziC3GKJVDOaih+9yb05ynu8pbS1p/n
         s+J8poRplE5MlpZoxAitOcLPpqh66zopvPNBVpDORr0rvzLJFwsBjb4cgBY/ANFtCRIk
         UBEA==
X-Received: by 10.68.112.227 with SMTP id it3mr23490967pbb.132.1440857547677;
        Sat, 29 Aug 2015 07:12:27 -0700 (PDT)
Received: from ashley.localdomain ([106.51.130.23])
        by smtp.gmail.com with ESMTPSA id hy5sm8876807pac.22.2015.08.29.07.12.25
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 29 Aug 2015 07:12:27 -0700 (PDT)
X-Google-Original-From: Karthik Nayak <Karthik.188@gmail.com>
X-Mailer: git-send-email 2.5.0
In-Reply-To: <1440857537-13968-1-git-send-email-Karthik.188@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276783>

Create format_ref_array_item() out of show_ref_array_item(). This will
store the output format for the given ref_array_item into the provided
strbuf. Make show_ref_array_item() a wrapper around this to print the
given ref_array_item with linefeed.

Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Matthieu Moy <matthieu.moy@grenoble-inp.fr>
Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 ref-filter.c | 59 +++++++++++++++++++++++++++++++++--------------------------
 ref-filter.h |  7 +++++--
 2 files changed, 38 insertions(+), 28 deletions(-)

diff --git a/ref-filter.c b/ref-filter.c
index 5d4f93d..1e6754a 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -153,6 +153,27 @@ int parse_ref_filter_atom(const char *atom, const char *ep)
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
 static void push_stack_element(struct ref_formatting_stack **stack)
 {
 	struct ref_formatting_stack *s = xcalloc(1, sizeof(struct ref_formatting_stack));
@@ -665,27 +686,6 @@ static void align_atom_handler(struct atom_value *atomv, struct ref_formatting_s
 	new->cb_data = atomv->align;
 }
 
-static void quote_formatting(struct strbuf *s, const char *str, int quote_style)
-{
-	switch (quote_style) {
-	case QUOTE_NONE:
-		strbuf_addstr(s, str);
-		break;
-	case QUOTE_SHELL:
-		sq_quote_buf(s, str);
-		break;
-	case QUOTE_PERL:
-		perl_quote_buf(s, str);
-		break;
-	case QUOTE_PYTHON:
-		python_quote_buf(s, str);
-		break;
-	case QUOTE_TCL:
-		tcl_quote_buf(s, str);
-		break;
-	}
-}
-
 static void append_atom(struct atom_value *v, struct ref_formatting_state *state)
 {
 	/*
@@ -1445,10 +1445,10 @@ static void append_literal(const char *cp, const char *ep, struct ref_formatting
 	}
 }
 
-void show_ref_array_item(struct ref_array_item *info, const char *format, int quote_style)
+void format_ref_array_item(struct strbuf *out, struct ref_array_item *info,
+			   const char *format, int quote_style)
 {
 	const char *cp, *sp, *ep;
-	struct strbuf *final_buf;
 	struct ref_formatting_state state = REF_FORMATTING_STATE_INIT;
 
 	state.quote_style = quote_style;
@@ -1478,10 +1478,17 @@ void show_ref_array_item(struct ref_array_item *info, const char *format, int qu
 	}
 	if (state.stack->prev)
 		die(_("format: `end` atom missing"));
-	final_buf = &state.stack->output;
-	fwrite(final_buf->buf, 1, final_buf->len, stdout);
+	strbuf_addbuf(out, &state.stack->output);
 	pop_stack_element(&state.stack);
-	putchar('\n');
+}
+
+void show_ref_array_item(struct ref_array_item *item, const char *format, unsigned int quote_style)
+{
+	struct strbuf out = STRBUF_INIT;
+	format_ref_array_item(&out, item, format, quote_style);
+	fwrite(out.buf, out.len, 1, stdout);
+	printf("\n");
+	strbuf_release(&out);
 }
 
 /*  If no sorting option is given, use refname to sort as default */
diff --git a/ref-filter.h b/ref-filter.h
index 0913ba9..082bee5 100644
--- a/ref-filter.h
+++ b/ref-filter.h
@@ -91,8 +91,11 @@ int parse_ref_filter_atom(const char *atom, const char *ep);
 int verify_ref_format(const char *format);
 /*  Sort the given ref_array as per the ref_sorting provided */
 void ref_array_sort(struct ref_sorting *sort, struct ref_array *array);
-/*  Print the ref using the given format and quote_style */
-void show_ref_array_item(struct ref_array_item *info, const char *format, int quote_style);
+/*  Format the ref as per given format and quote_style and store it into the strbuf */
+void format_ref_array_item(struct strbuf *out, struct ref_array_item *info,
+			   const char *format, int quote_style);
+/*  Wrapper around format_ref_array_item() which prints the given ref_array_item */
+void show_ref_array_item(struct ref_array_item *item, const char *format, unsigned int quote_style);
 /*  Callback function for parsing the sort option */
 int parse_opt_ref_sorting(const struct option *opt, const char *arg, int unset);
 /*  Default sort option based on refname */
-- 
2.5.0
