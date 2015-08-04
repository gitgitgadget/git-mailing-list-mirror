From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v9 02/11] ref-filter: introduce ref_formatting_state
Date: Tue,  4 Aug 2015 18:12:59 +0530
Message-ID: <1438692188-14367-2-git-send-email-Karthik.188@gmail.com>
References: <CAOLa=ZSBMk9y1VGTVKSVsGMdYuPtjhPADciVUaEVwESRdSvWZg@mail.gmail.com>
 <1438692188-14367-1-git-send-email-Karthik.188@gmail.com>
Cc: christian.couder@gmail.com, Matthieu.Moy@grenoble-inp.fr,
	gitster@pobox.com, Karthik Nayak <Karthik.188@gmail.com>,
	Karthik Nayak <karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 04 14:43:26 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZMbYz-0004FQ-8F
	for gcvg-git-2@plane.gmane.org; Tue, 04 Aug 2015 14:43:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756201AbbHDMnT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Aug 2015 08:43:19 -0400
Received: from mail-pd0-f173.google.com ([209.85.192.173]:36349 "EHLO
	mail-pd0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755854AbbHDMnR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Aug 2015 08:43:17 -0400
Received: by pdco4 with SMTP id o4so4058466pdc.3
        for <git@vger.kernel.org>; Tue, 04 Aug 2015 05:43:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=pEJ+dN7+08u2neGoGWCq5SFd5LaTCDFPTBgqQ6Gee1s=;
        b=xjLOXOZOo9Eh58hO80FLOIG2bLog9dFYHlgKQnwsgyw/uHwlHmYuGAaX6A/6qxw8cN
         0njtRDayWde57K4FOx89wR0n6fr+6q28vyQal60xIEwERlZCDDyMfLKLjroncwG+p6oG
         hYNZl7EtLC123TLwT7Tb/ZEbdTPYq03rEuh+YqjouNs2UZfTFWbjv+BHOO+CqGRKWQDT
         6g//1+zXA/UnDmFvXwCv6TdFZbo+CpQ/COMmD5jx25o17U+OYkkxBwEMJV/zgvb9rfkn
         8PWJWsDx0biuGmwleJQveVsc0LFbyRIPnMZXDh0ghWtILJta8bbmInxKg6N6miCQ+9ky
         sbCw==
X-Received: by 10.70.88.37 with SMTP id bd5mr7475033pdb.159.1438692196690;
        Tue, 04 Aug 2015 05:43:16 -0700 (PDT)
Received: from ashley.localdomain ([106.51.130.23])
        by smtp.gmail.com with ESMTPSA id m2sm1359951pdr.64.2015.08.04.05.43.14
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 04 Aug 2015 05:43:16 -0700 (PDT)
X-Google-Original-From: Karthik Nayak <Karthik.188@gmail.com>
X-Mailer: git-send-email 2.5.0
In-Reply-To: <1438692188-14367-1-git-send-email-Karthik.188@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275254>

Introduce a ref_formatting_state which will eventually hold the values
of modifier atoms. Implement this within ref-filter.

Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Matthieu Moy <matthieu.moy@grenoble-inp.fr>
Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 ref-filter.c | 64 +++++++++++++++++++++++++++++++++++++++++-------------------
 ref-filter.h |  5 +++++
 2 files changed, 49 insertions(+), 20 deletions(-)

diff --git a/ref-filter.c b/ref-filter.c
index 91482c9..2c074a1 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -1190,23 +1190,23 @@ void ref_array_sort(struct ref_sorting *sorting, struct ref_array *array)
 	qsort(array->items, array->nr, sizeof(struct ref_array_item *), compare_refs);
 }
 
-static void print_value(struct atom_value *v, int quote_style, struct strbuf *output)
+static void print_value(struct atom_value *v, struct ref_formatting_state *state)
 {
-	switch (quote_style) {
+	switch (state->quote_style) {
 	case QUOTE_NONE:
-		strbuf_addstr(output, v->s);
+		strbuf_addstr(state->output, v->s);
 		break;
 	case QUOTE_SHELL:
-		sq_quote_buf(output, v->s);
+		sq_quote_buf(state->output, v->s);
 		break;
 	case QUOTE_PERL:
-		perl_quote_buf(output, v->s);
+		perl_quote_buf(state->output, v->s);
 		break;
 	case QUOTE_PYTHON:
-		python_quote_buf(output, v->s);
+		python_quote_buf(state->output, v->s);
 		break;
 	case QUOTE_TCL:
-		tcl_quote_buf(output, v->s);
+		tcl_quote_buf(state->output, v->s);
 		break;
 	}
 }
@@ -1229,7 +1229,7 @@ static int hex2(const char *cp)
 		return -1;
 }
 
-static void emit(const char *cp, const char *ep, struct strbuf *output)
+static void emit(const char *cp, const char *ep, struct ref_formatting_state *state)
 {
 	while (*cp && (!ep || cp < ep)) {
 		if (*cp == '%') {
@@ -1238,35 +1238,58 @@ static void emit(const char *cp, const char *ep, struct strbuf *output)
 			else {
 				int ch = hex2(cp + 1);
 				if (0 <= ch) {
-					strbuf_addch(output, ch);
+					strbuf_addch(state->output, ch);
 					cp += 3;
 					continue;
 				}
 			}
 		}
-		strbuf_addch(output, *cp);
+		strbuf_addch(state->output, *cp);
 		cp++;
 	}
 }
 
+static void process_formatting_state(struct atom_value *atomv, struct ref_formatting_state *state)
+{
+	/* Based on the atomv values, the formatting state is set */
+}
+
+static void apply_formatting_state(struct ref_formatting_state *state, struct strbuf *final)
+{
+	/* More formatting options to be evetually added */
+	strbuf_addbuf(final, state->output);
+	strbuf_release(state->output);
+}
+
 void show_ref_array_item(struct ref_array_item *info, const char *format, int quote_style)
 {
 	const char *cp, *sp, *ep;
-	struct strbuf output = STRBUF_INIT;
+	struct strbuf value = STRBUF_INIT;
+	struct strbuf final_buf = STRBUF_INIT;
+	struct ref_formatting_state state;
 	int i;
 
+	memset(&state, 0, sizeof(state));
+	state.quote_style = quote_style;
+	state.output = &value;
+
 	for (cp = format; *cp && (sp = find_next(cp)); cp = ep + 1) {
-		struct atom_value *atomv;
+		struct atom_value *atomv = NULL;
 
 		ep = strchr(sp, ')');
-		if (cp < sp)
-			emit(cp, sp, &output);
+		if (cp < sp) {
+			emit(cp, sp, &state);
+			apply_formatting_state(&state, &final_buf);
+		}
 		get_ref_atom_value(info, parse_ref_filter_atom(sp + 2, ep), &atomv);
-		print_value(atomv, quote_style, &output);
+		process_formatting_state(atomv, &state);
+		print_value(atomv, &state);
+		apply_formatting_state(&state, &final_buf);
 	}
 	if (*cp) {
 		sp = cp + strlen(cp);
-		emit(cp, sp, &output);
+		emit(cp, sp, &state);
+		apply_formatting_state(&state, &final_buf);
 	}
 	if (need_color_reset_at_eol) {
 		struct atom_value resetv;
@@ -1275,12 +1298,13 @@ void show_ref_array_item(struct ref_array_item *info, const char *format, int qu
 		if (color_parse("reset", color) < 0)
 			die("BUG: couldn't parse 'reset' as a color");
 		resetv.s = color;
-		print_value(&resetv, quote_style, &output);
+		print_value(&resetv, &state);
+		apply_formatting_state(&state, &final_buf);
 	}
-	for (i = 0; i < output.len; i++)
-		printf("%c", output.buf[i]);
+	for (i = 0; i < final_buf.len; i++)
+		printf("%c", final_buf.buf[i]);
 	putchar('\n');
-	strbuf_release(&output);
+	strbuf_release(&final_buf);
 }
 
 /*  If no sorting option is given, use refname to sort as default */
diff --git a/ref-filter.h b/ref-filter.h
index 6bf27d8..9e6c2d4 100644
--- a/ref-filter.h
+++ b/ref-filter.h
@@ -16,6 +16,11 @@
 #define FILTER_REFS_INCLUDE_BROKEN 0x1
 #define FILTER_REFS_ALL 0x2
 
+struct ref_formatting_state {
+	int quote_style;
+	struct strbuf *output;
+};
+
 struct atom_value {
 	const char *s;
 	unsigned long ul; /* used for sorting when not FIELD_STR */
-- 
2.5.0
