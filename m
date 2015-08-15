From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v11 02/13] ref-filter: print output to strbuf for formatting
Date: Sat, 15 Aug 2015 23:30:32 +0530
Message-ID: <1439661643-16094-3-git-send-email-Karthik.188@gmail.com>
Cc: christian.couder@gmail.com, Matthieu.Moy@grenoble-inp.fr,
	gitster@pobox.com, Karthik Nayak <Karthik.188@gmail.com>,
	Karthik Nayak <karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 15 20:00:58 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZQflJ-0001Hw-5f
	for gcvg-git-2@plane.gmane.org; Sat, 15 Aug 2015 20:00:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754112AbbHOSAw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Aug 2015 14:00:52 -0400
Received: from mail-pa0-f52.google.com ([209.85.220.52]:35423 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754085AbbHOSAo (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Aug 2015 14:00:44 -0400
Received: by pacgr6 with SMTP id gr6so79474492pac.2
        for <git@vger.kernel.org>; Sat, 15 Aug 2015 11:00:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=VXI8oC7mpRxW/wYXhgel4HGaw7EQvUtFhxAjRFqzWmQ=;
        b=djHyQOYQ+JsyrT9731LuB9Kc/QLKuGwZfyYHV7VA+3z8Z/7zBFkM5JPkXXC+gkBPis
         +Z86MBhJ6jHveweeFe4QDJrJL5N8OpW9iQ3zuerOdmpEeFiUpb1VIKgxw2Aq/mvRiNyv
         ev/zyBHVA9sUHPQsnejG6BhT8dcSYT7zrmEd8cLbnCjKmvEQWteB8Cq7p1j2JLmtUlao
         L5+gWqE/JNzJ1jGOeKStj9rId+8Fw9C9uu6KwW5OgbliEXOkS0ad9HHvQRSR0vizZ0yI
         M03tU8n+5n6smh5GahXQM1KMNJszQA8DGP6LsJmQyPcCgz412FybPTq6bDsW0Nw+YZJ2
         qgew==
X-Received: by 10.68.195.231 with SMTP id ih7mr101499238pbc.26.1439661643562;
        Sat, 15 Aug 2015 11:00:43 -0700 (PDT)
Received: from ashley.localdomain ([106.51.130.23])
        by smtp.gmail.com with ESMTPSA id pe3sm9424144pdb.55.2015.08.15.11.00.41
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 15 Aug 2015 11:00:43 -0700 (PDT)
X-Google-Original-From: Karthik Nayak <Karthik.188@gmail.com>
X-Mailer: git-send-email 2.5.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275993>

Introduce a strbuf `output` which will act as a substitute rather than
printing directly to stdout. This will be used for formatting
eventually.

Rename some functions to reflect the changes made:
print_value() -> append_atom()
emit()        -> append_literal()

Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Matthieu Moy <matthieu.moy@grenoble-inp.fr>
Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 ref-filter.c | 34 ++++++++++++++++------------------
 1 file changed, 16 insertions(+), 18 deletions(-)

diff --git a/ref-filter.c b/ref-filter.c
index e53c77e..edfb1c7 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -1195,30 +1195,25 @@ void ref_array_sort(struct ref_sorting *sorting, struct ref_array *array)
 	qsort(array->items, array->nr, sizeof(struct ref_array_item *), compare_refs);
 }
 
-static void print_value(struct atom_value *v, int quote_style)
+static void append_atom(struct atom_value *v, int quote_style, struct strbuf *output)
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
+static void append_literal(const char *cp, const char *ep, struct strbuf *output)
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
+			append_literal(cp, sp, &output);
 		get_ref_atom_value(info, parse_ref_filter_atom(sp + 2, ep), &atomv);
-		print_value(atomv, quote_style);
+		append_atom(atomv, quote_style, &output);
 	}
 	if (*cp) {
 		sp = cp + strlen(cp);
-		emit(cp, sp);
+		append_literal(cp, sp, &output);
 	}
 	if (need_color_reset_at_eol) {
 		struct atom_value resetv;
@@ -1283,9 +1279,11 @@ void show_ref_array_item(struct ref_array_item *info, const char *format, int qu
 		if (color_parse("reset", color) < 0)
 			die("BUG: couldn't parse 'reset' as a color");
 		resetv.s = color;
-		print_value(&resetv, quote_style);
+		append_atom(&resetv, quote_style, &output);
 	}
+	fwrite(output.buf, 1, output.len, stdout);
 	putchar('\n');
+	strbuf_release(&output);
 }
 
 /*  If no sorting option is given, use refname to sort as default */
-- 
2.5.0
