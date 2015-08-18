From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v12 02/13] ref-filter: introduce ref_formatting_state
Date: Wed, 19 Aug 2015 00:07:21 +0530
Message-ID: <1439923052-7373-3-git-send-email-Karthik.188@gmail.com>
References: <1439923052-7373-1-git-send-email-Karthik.188@gmail.com>
Cc: christian.couder@gmail.com, Matthieu.Moy@grenoble-inp.fr,
	gitster@pobox.com, Karthik Nayak <Karthik.188@gmail.com>,
	Karthik Nayak <karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 18 20:37:45 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZRllT-0008CK-Lu
	for gcvg-git-2@plane.gmane.org; Tue, 18 Aug 2015 20:37:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753959AbbHRShh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Aug 2015 14:37:37 -0400
Received: from mail-pd0-f179.google.com ([209.85.192.179]:33702 "EHLO
	mail-pd0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751612AbbHRShg (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Aug 2015 14:37:36 -0400
Received: by pdrh1 with SMTP id h1so71709833pdr.0
        for <git@vger.kernel.org>; Tue, 18 Aug 2015 11:37:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=9DbNy9l8JOt7m0W/Ij1fgKeeeuyOBGoIYekk+wzJSr4=;
        b=VW/4T48RStozKvB+ikr+V8HUmMuWQgq1Uk+Gl9glf/Uccs8iiwd5wCJ5qWlKRKsryL
         3hKXkuYAGijkTC0JpdD/YUWf6Xuc7b+N2N2kMZRiWc5OhPuB8iPj0U89hQ34BLNwdFWs
         cyJKfCD+8/Vas/fB8yVwbFnMByrUFjnAMv2bfEE8mqPectmaF4i8qjR7gv97MAqOk4q3
         qNIo5RnUYN5g67cJ6idS53+DoCTyiAqMk0jFELdfvN4VIYVNGuVqganxwI/y+i78sLyC
         t35yIex7V+v9fsUR8tVbIkReSesaPE/5GhUcGVX055KB9vgMuTDZUIqRlH90GGOYig0W
         U1ng==
X-Received: by 10.70.48.72 with SMTP id j8mr15753507pdn.99.1439923055783;
        Tue, 18 Aug 2015 11:37:35 -0700 (PDT)
Received: from ashley.localdomain ([106.51.130.23])
        by smtp.gmail.com with ESMTPSA id i9sm18858190pbq.44.2015.08.18.11.37.30
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 18 Aug 2015 11:37:34 -0700 (PDT)
X-Google-Original-From: Karthik Nayak <Karthik.188@gmail.com>
X-Mailer: git-send-email 2.5.0
In-Reply-To: <1439923052-7373-1-git-send-email-Karthik.188@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276134>

Introduce ref_formatting_state which will hold the formatted output
strbuf instead of directly printing to stdout. This will help us in
creating modifier atoms which modify the format specified before
printing to stdout.

Rename some functions to reflect the changes made:
print_value() -> append_atom()
emit()        -> append_literal()

Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Matthieu Moy <matthieu.moy@grenoble-inp.fr>
Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 ref-filter.c | 44 +++++++++++++++++++++++++-------------------
 1 file changed, 25 insertions(+), 19 deletions(-)

diff --git a/ref-filter.c b/ref-filter.c
index e53c77e..dd62640 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -55,6 +55,11 @@ static struct {
 	{ "color" },
 };
 
+struct ref_formatting_state {
+	struct strbuf output;
+	int quote_style;
+};
+
 struct atom_value {
 	const char *s;
 	unsigned long ul; /* used for sorting when not FIELD_STR */
@@ -1195,30 +1200,25 @@ void ref_array_sort(struct ref_sorting *sorting, struct ref_array *array)
 	qsort(array->items, array->nr, sizeof(struct ref_array_item *), compare_refs);
 }
 
-static void print_value(struct atom_value *v, int quote_style)
+static void append_atom(struct atom_value *v, struct ref_formatting_state *state)
 {
-	struct strbuf sb = STRBUF_INIT;
-	switch (quote_style) {
+	switch (state->quote_style) {
 	case QUOTE_NONE:
-		fputs(v->s, stdout);
+		strbuf_addstr(&state->output, v->s);
 		break;
 	case QUOTE_SHELL:
-		sq_quote_buf(&sb, v->s);
+		sq_quote_buf(&state->output, v->s);
 		break;
 	case QUOTE_PERL:
-		perl_quote_buf(&sb, v->s);
+		perl_quote_buf(&state->output, v->s);
 		break;
 	case QUOTE_PYTHON:
-		python_quote_buf(&sb, v->s);
+		python_quote_buf(&state->output, v->s);
 		break;
 	case QUOTE_TCL:
-		tcl_quote_buf(&sb, v->s);
+		tcl_quote_buf(&state->output, v->s);
 		break;
 	}
-	if (quote_style != QUOTE_NONE) {
-		fputs(sb.buf, stdout);
-		strbuf_release(&sb);
-	}
 }
 
 static int hex1(char ch)
@@ -1239,7 +1239,7 @@ static int hex2(const char *cp)
 		return -1;
 }
 
-static void emit(const char *cp, const char *ep)
+static void append_literal(const char *cp, const char *ep, struct ref_formatting_state *state)
 {
 	while (*cp && (!ep || cp < ep)) {
 		if (*cp == '%') {
@@ -1248,13 +1248,13 @@ static void emit(const char *cp, const char *ep)
 			else {
 				int ch = hex2(cp + 1);
 				if (0 <= ch) {
-					putchar(ch);
+					strbuf_addch(&state->output, ch);
 					cp += 3;
 					continue;
 				}
 			}
 		}
-		putchar(*cp);
+		strbuf_addch(&state->output, *cp);
 		cp++;
 	}
 }
@@ -1262,19 +1262,23 @@ static void emit(const char *cp, const char *ep)
 void show_ref_array_item(struct ref_array_item *info, const char *format, int quote_style)
 {
 	const char *cp, *sp, *ep;
+	struct ref_formatting_state state;
+
+	strbuf_init(&state.output, 0);
+	state.quote_style = quote_style;
 
 	for (cp = format; *cp && (sp = find_next(cp)); cp = ep + 1) {
 		struct atom_value *atomv;
 
 		ep = strchr(sp, ')');
 		if (cp < sp)
-			emit(cp, sp);
+			append_literal(cp, sp, &state);
 		get_ref_atom_value(info, parse_ref_filter_atom(sp + 2, ep), &atomv);
-		print_value(atomv, quote_style);
+		append_atom(atomv, &state);
 	}
 	if (*cp) {
 		sp = cp + strlen(cp);
-		emit(cp, sp);
+		append_literal(cp, sp, &state);
 	}
 	if (need_color_reset_at_eol) {
 		struct atom_value resetv;
@@ -1283,9 +1287,11 @@ void show_ref_array_item(struct ref_array_item *info, const char *format, int qu
 		if (color_parse("reset", color) < 0)
 			die("BUG: couldn't parse 'reset' as a color");
 		resetv.s = color;
-		print_value(&resetv, quote_style);
+		append_atom(&resetv, &state);
 	}
+	fwrite(state.output.buf, 1, state.output.len, stdout);
 	putchar('\n');
+	strbuf_release(&state.output);
 }
 
 /*  If no sorting option is given, use refname to sort as default */
-- 
2.5.0
