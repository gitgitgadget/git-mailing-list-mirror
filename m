From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v10 03/13] ref-filter: introduce ref_formatting_state
Date: Sun,  9 Aug 2015 19:41:36 +0530
Message-ID: <1439129506-9989-4-git-send-email-Karthik.188@gmail.com>
References: <1439129506-9989-1-git-send-email-Karthik.188@gmail.com>
Cc: christian.couder@gmail.com, Matthieu.Moy@grenoble-inp.fr,
	gitster@pobox.com, Karthik Nayak <Karthik.188@gmail.com>,
	Karthik Nayak <karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 09 16:12:28 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZORKs-0006u7-UM
	for gcvg-git-2@plane.gmane.org; Sun, 09 Aug 2015 16:12:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933004AbbHIOMJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Aug 2015 10:12:09 -0400
Received: from mail-pa0-f49.google.com ([209.85.220.49]:34663 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754535AbbHIOLx (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Aug 2015 10:11:53 -0400
Received: by pawu10 with SMTP id u10so121412651paw.1
        for <git@vger.kernel.org>; Sun, 09 Aug 2015 07:11:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=5by5liQXgVOvBwkK31kVZCbdKoISThsvsMPsNvWKfxg=;
        b=Y86idjjEztWiNnKhCdKlcZb8d+pasYhknFkdqB7Q70BTr8ycnOnQQAkdxvWtwiVE3s
         vbVKu1HIdN7TkMTs3GZSiHqk9fZ6r8sIThT66ICzzHsBAkQDSEQYIzHpJkGID9qJYnlp
         CZyySGs4sOSD3bbo8a1Eu+aIg09nltKfpvX/mTHJP4gB0iSj09TMDvJbAmRkxDQjGW7d
         ZvlzxOhhB0oLr7fJUoArk5sDqCpng2VnmMBNfdt7I30in8vHrEywpbita2mctSlBTWxB
         lrWlTHYxRqF8QtmeXkQbP2WXFUJK9hyty4+k2ZHRQK4PX2BO9eBLeEDln9L3k5KiByEX
         cKxg==
X-Received: by 10.68.234.167 with SMTP id uf7mr35366334pbc.51.1439129512528;
        Sun, 09 Aug 2015 07:11:52 -0700 (PDT)
Received: from ashley.localdomain ([106.51.130.23])
        by smtp.gmail.com with ESMTPSA id la4sm72920pbc.76.2015.08.09.07.11.50
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 09 Aug 2015 07:11:52 -0700 (PDT)
X-Google-Original-From: Karthik Nayak <Karthik.188@gmail.com>
X-Mailer: git-send-email 2.5.0
In-Reply-To: <1439129506-9989-1-git-send-email-Karthik.188@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275539>

Introduce a ref_formatting_state which will eventually hold the values
of modifier atoms. Implement this within ref-filter.

Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Matthieu Moy <matthieu.moy@grenoble-inp.fr>
Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 ref-filter.c | 65 +++++++++++++++++++++++++++++++++++++++++++-----------------
 1 file changed, 47 insertions(+), 18 deletions(-)

diff --git a/ref-filter.c b/ref-filter.c
index 95f027b..e2df209 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -1195,23 +1195,29 @@ void ref_array_sort(struct ref_sorting *sorting, struct ref_array *array)
 	qsort(array->items, array->nr, sizeof(struct ref_array_item *), compare_refs);
 }
 
-static void format_quote_value(struct atom_value *v, int quote_style, struct strbuf *output)
+
+struct ref_formatting_state {
+	struct strbuf output;
+	int quote_style;
+};
+
+static void format_quote_value(struct atom_value *v, struct ref_formatting_state *state)
 {
-	switch (quote_style) {
+	switch (state->quote_style) {
 	case QUOTE_NONE:
-		strbuf_addstr(output, v->s);
+		strbuf_addstr(&state->output, v->s);
 		break;
 	case QUOTE_SHELL:
-		sq_quote_buf(output, v->s);
+		sq_quote_buf(&state->output, v->s);
 		break;
 	case QUOTE_PERL:
-		perl_quote_buf(output, v->s);
+		perl_quote_buf(&state->output, v->s);
 		break;
 	case QUOTE_PYTHON:
-		python_quote_buf(output, v->s);
+		python_quote_buf(&state->output, v->s);
 		break;
 	case QUOTE_TCL:
-		tcl_quote_buf(output, v->s);
+		tcl_quote_buf(&state->output, v->s);
 		break;
 	}
 }
@@ -1234,7 +1240,7 @@ static int hex2(const char *cp)
 		return -1;
 }
 
-static void append_non_atom(const char *cp, const char *ep, struct strbuf *output)
+static void append_non_atom(const char *cp, const char *ep, struct ref_formatting_state *state)
 {
 	while (*cp && (!ep || cp < ep)) {
 		if (*cp == '%') {
@@ -1243,34 +1249,55 @@ static void append_non_atom(const char *cp, const char *ep, struct strbuf *outpu
 			else {
 				int ch = hex2(cp + 1);
 				if (0 <= ch) {
-					strbuf_addch(output, ch);
+					strbuf_addch(&state->output, ch);
 					cp += 3;
 					continue;
 				}
 			}
 		}
-		strbuf_addch(output, *cp);
+		strbuf_addch(&state->output, *cp);
 		cp++;
 	}
 }
 
+static void set_formatting_state(struct atom_value *atomv, struct ref_formatting_state *state)
+{
+	/* Based on the atomv values, the formatting state is set */
+}
+
+static void perform_state_formatting(struct ref_formatting_state *state, struct strbuf *final)
+{
+	/* More formatting options to be eventually added */
+	strbuf_addbuf(final, &state->output);
+	strbuf_reset(&state->output);
+}
+
 void show_ref_array_item(struct ref_array_item *info, const char *format, int quote_style)
 {
 	const char *cp, *sp, *ep;
-	struct strbuf output = STRBUF_INIT;
+	struct strbuf final_buf = STRBUF_INIT;
+	struct ref_formatting_state state;
+
+	state.quote_style = quote_style;
+	strbuf_init(&state.output, 0);
 
 	for (cp = format; *cp && (sp = find_next(cp)); cp = ep + 1) {
 		struct atom_value *atomv;
 
 		ep = strchr(sp, ')');
-		if (cp < sp)
-			append_non_atom(cp, sp, &output);
+		if (cp < sp) {
+			append_non_atom(cp, sp, &state);
+			perform_state_formatting(&state, &final_buf);
+		}
 		get_ref_atom_value(info, parse_ref_filter_atom(sp + 2, ep), &atomv);
-		format_quote_value(atomv, quote_style, &output);
+		set_formatting_state(atomv, &state);
+		format_quote_value(atomv, &state);
+		perform_state_formatting(&state, &final_buf);
 	}
 	if (*cp) {
 		sp = cp + strlen(cp);
-		append_non_atom(cp, sp, &output);
+		append_non_atom(cp, sp, &state);
+		perform_state_formatting(&state, &final_buf);
 	}
 	if (need_color_reset_at_eol) {
 		struct atom_value resetv;
@@ -1279,11 +1306,13 @@ void show_ref_array_item(struct ref_array_item *info, const char *format, int qu
 		if (color_parse("reset", color) < 0)
 			die("BUG: couldn't parse 'reset' as a color");
 		resetv.s = color;
-		format_quote_value(&resetv, quote_style, &output);
+		format_quote_value(&resetv, &state);
+		perform_state_formatting(&state, &final_buf);
 	}
-	fwrite(output.buf, 1, output.len, stdout);
+	fwrite(final_buf.buf, 1, final_buf.len, stdout);
 	putchar('\n');
-	strbuf_release(&output);
+	strbuf_release(&final_buf);
+	strbuf_release(&state.output);
 }
 
 /*  If no sorting option is given, use refname to sort as default */
-- 
2.5.0
