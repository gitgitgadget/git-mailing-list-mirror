From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v10 02/13] ref-filter: print output to strbuf for formatting
Date: Sun,  9 Aug 2015 19:41:35 +0530
Message-ID: <1439129506-9989-3-git-send-email-Karthik.188@gmail.com>
References: <1439129506-9989-1-git-send-email-Karthik.188@gmail.com>
Cc: christian.couder@gmail.com, Matthieu.Moy@grenoble-inp.fr,
	gitster@pobox.com, Karthik Nayak <Karthik.188@gmail.com>,
	Karthik Nayak <karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 09 16:12:27 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZORKs-0006u7-Aj
	for gcvg-git-2@plane.gmane.org; Sun, 09 Aug 2015 16:12:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932888AbbHIOMH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Aug 2015 10:12:07 -0400
Received: from mail-pa0-f43.google.com ([209.85.220.43]:35532 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754533AbbHIOLu (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Aug 2015 10:11:50 -0400
Received: by pacgr6 with SMTP id gr6so8151231pac.2
        for <git@vger.kernel.org>; Sun, 09 Aug 2015 07:11:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=fcH63eEC1SeutwW9wZNN4vWZqXI3AENkCikXfqsjMNQ=;
        b=igy/IobQxh5Spr++WzFeNEN9gxQj7niiy/9qjiaI3ae34NQ92G9wXov7vDVXAAV7I3
         gi2/jHvnhjnRPrwIaaDwSdXaEp20XozoNeLyNhH9SZmOh3Gu1KeOkCrc+AUzk/KupYET
         n932DizY5QxPLgK76amgr86ysJpPhXRQfDvGsY3fjTQH1G33YSLR5cHVUHpX8rfOjtYN
         F163iL1XK6mL+yaMvdYm08TWR+rkI0YyGr6nl5//RiXE6WzoZc1BEIxOm+SteWMQYYAE
         Q+Ofedn7ON5YqC+p3IkpMzVYEx7LzW18GueAJ8G5qHPZAGsksVuJb8HHbIepN5Cyc+MY
         IqYA==
X-Received: by 10.69.26.196 with SMTP id ja4mr14784068pbd.121.1439129509815;
        Sun, 09 Aug 2015 07:11:49 -0700 (PDT)
Received: from ashley.localdomain ([106.51.130.23])
        by smtp.gmail.com with ESMTPSA id la4sm72920pbc.76.2015.08.09.07.11.47
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 09 Aug 2015 07:11:49 -0700 (PDT)
X-Google-Original-From: Karthik Nayak <Karthik.188@gmail.com>
X-Mailer: git-send-email 2.5.0
In-Reply-To: <1439129506-9989-1-git-send-email-Karthik.188@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275538>

Introduce a strbuf `output` which will act as a substitute rather than
printing directly to stdout. This will be used for formatting
eventually.

Rename some functions to reflect the changes made:
print_value() -> format_quote_value()
emit()        -> append_non_atom()

Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Matthieu Moy <matthieu.moy@grenoble-inp.fr>
Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 ref-filter.c | 34 ++++++++++++++++------------------
 1 file changed, 16 insertions(+), 18 deletions(-)

diff --git a/ref-filter.c b/ref-filter.c
index 07949f4..95f027b 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -1195,30 +1195,25 @@ void ref_array_sort(struct ref_sorting *sorting, struct ref_array *array)
 	qsort(array->items, array->nr, sizeof(struct ref_array_item *), compare_refs);
 }
 
-static void print_value(struct atom_value *v, int quote_style)
+static void format_quote_value(struct atom_value *v, int quote_style, struct strbuf *output)
 {
-	struct strbuf sb = STRBUF_INIT;
 	switch (quote_style) {
 	case QUOTE_NONE:
-		fputs(v->s, stdout);
+		strbuf_addstr(output, v->s);
 		break;
 	case QUOTE_SHELL:
-		sq_quote_buf(&sb, v->s);
+		sq_quote_buf(output, v->s);
 		break;
 	case QUOTE_PERL:
-		perl_quote_buf(&sb, v->s);
+		perl_quote_buf(output, v->s);
 		break;
 	case QUOTE_PYTHON:
-		python_quote_buf(&sb, v->s);
+		python_quote_buf(output, v->s);
 		break;
 	case QUOTE_TCL:
-		tcl_quote_buf(&sb, v->s);
+		tcl_quote_buf(output, v->s);
 		break;
 	}
-	if (quote_style != QUOTE_NONE) {
-		fputs(sb.buf, stdout);
-		strbuf_release(&sb);
-	}
 }
 
 static int hex1(char ch)
@@ -1239,7 +1234,7 @@ static int hex2(const char *cp)
 		return -1;
 }
 
-static void emit(const char *cp, const char *ep)
+static void append_non_atom(const char *cp, const char *ep, struct strbuf *output)
 {
 	while (*cp && (!ep || cp < ep)) {
 		if (*cp == '%') {
@@ -1248,13 +1243,13 @@ static void emit(const char *cp, const char *ep)
 			else {
 				int ch = hex2(cp + 1);
 				if (0 <= ch) {
-					putchar(ch);
+					strbuf_addch(output, ch);
 					cp += 3;
 					continue;
 				}
 			}
 		}
-		putchar(*cp);
+		strbuf_addch(output, *cp);
 		cp++;
 	}
 }
@@ -1262,19 +1257,20 @@ static void emit(const char *cp, const char *ep)
 void show_ref_array_item(struct ref_array_item *info, const char *format, int quote_style)
 {
 	const char *cp, *sp, *ep;
+	struct strbuf output = STRBUF_INIT;
 
 	for (cp = format; *cp && (sp = find_next(cp)); cp = ep + 1) {
 		struct atom_value *atomv;
 
 		ep = strchr(sp, ')');
 		if (cp < sp)
-			emit(cp, sp);
+			append_non_atom(cp, sp, &output);
 		get_ref_atom_value(info, parse_ref_filter_atom(sp + 2, ep), &atomv);
-		print_value(atomv, quote_style);
+		format_quote_value(atomv, quote_style, &output);
 	}
 	if (*cp) {
 		sp = cp + strlen(cp);
-		emit(cp, sp);
+		append_non_atom(cp, sp, &output);
 	}
 	if (need_color_reset_at_eol) {
 		struct atom_value resetv;
@@ -1283,9 +1279,11 @@ void show_ref_array_item(struct ref_array_item *info, const char *format, int qu
 		if (color_parse("reset", color) < 0)
 			die("BUG: couldn't parse 'reset' as a color");
 		resetv.s = color;
-		print_value(&resetv, quote_style);
+		format_quote_value(&resetv, quote_style, &output);
 	}
+	fwrite(output.buf, 1, output.len, stdout);
 	putchar('\n');
+	strbuf_release(&output);
 }
 
 /*  If no sorting option is given, use refname to sort as default */
-- 
2.5.0
