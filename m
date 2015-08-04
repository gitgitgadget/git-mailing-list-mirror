From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v9 01/11] ref-filter: print output to strbuf for formatting
Date: Tue,  4 Aug 2015 18:12:58 +0530
Message-ID: <1438692188-14367-1-git-send-email-Karthik.188@gmail.com>
References: <CAOLa=ZSBMk9y1VGTVKSVsGMdYuPtjhPADciVUaEVwESRdSvWZg@mail.gmail.com>
Cc: christian.couder@gmail.com, Matthieu.Moy@grenoble-inp.fr,
	gitster@pobox.com, Karthik Nayak <Karthik.188@gmail.com>,
	Karthik Nayak <karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 04 14:43:20 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZMbYt-0004DQ-6L
	for gcvg-git-2@plane.gmane.org; Tue, 04 Aug 2015 14:43:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756065AbbHDMnP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Aug 2015 08:43:15 -0400
Received: from mail-pd0-f180.google.com ([209.85.192.180]:36329 "EHLO
	mail-pd0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755854AbbHDMnO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Aug 2015 08:43:14 -0400
Received: by pdco4 with SMTP id o4so4058024pdc.3
        for <git@vger.kernel.org>; Tue, 04 Aug 2015 05:43:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Z8CzxQ/hdkjGL8EErReTwI8U9M8i0q++grfKjFsuVM0=;
        b=aD5rOJuYKmwnoF/8evudVG7RvebJ5VyIPIjR+lWwlaCLpyOkQpbuueNif921KtWsD2
         1QSJe0T1YTX3ttK5S/MAI/CugMmzHDg59G8vB4vwMBWkoDnDq8pjSQ2GMfbfIju/bzES
         gtzzi9dj7jdt18J7fbLeQ/nP4mGs30UeVfBWv9YIQ5hphqNYY/ZbM61lpJQEmCIGlv88
         82QnLz/j8RbzPqX5SwQZSRBRdGUbDo/TYfdUyfjIBRucURnWCL2e9exkLWmWB1PcArwW
         CrEJn6RfXsu3PRuV4BKPkazyaLYpdabmWcVlS4C0eZgqZTy6lY7K+dLz8JTd4H4Dqp4G
         bFBQ==
X-Received: by 10.70.41.130 with SMTP id f2mr7510166pdl.86.1438692193987;
        Tue, 04 Aug 2015 05:43:13 -0700 (PDT)
Received: from ashley.localdomain ([106.51.130.23])
        by smtp.gmail.com with ESMTPSA id m2sm1359951pdr.64.2015.08.04.05.43.11
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 04 Aug 2015 05:43:13 -0700 (PDT)
X-Google-Original-From: Karthik Nayak <Karthik.188@gmail.com>
X-Mailer: git-send-email 2.5.0
In-Reply-To: <CAOLa=ZSBMk9y1VGTVKSVsGMdYuPtjhPADciVUaEVwESRdSvWZg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275253>

Introduce a strbuf `output` which will act as a substitute rather than
printing directly to stdout. This will be used for formatting
eventually.

Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Matthieu Moy <matthieu.moy@grenoble-inp.fr>
Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 ref-filter.c | 36 ++++++++++++++++++------------------
 1 file changed, 18 insertions(+), 18 deletions(-)

diff --git a/ref-filter.c b/ref-filter.c
index 46963a5..91482c9 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -1190,30 +1190,25 @@ void ref_array_sort(struct ref_sorting *sorting, struct ref_array *array)
 	qsort(array->items, array->nr, sizeof(struct ref_array_item *), compare_refs);
 }
 
-static void print_value(struct atom_value *v, int quote_style)
+static void print_value(struct atom_value *v, int quote_style, struct strbuf *output)
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
@@ -1234,7 +1229,7 @@ static int hex2(const char *cp)
 		return -1;
 }
 
-static void emit(const char *cp, const char *ep)
+static void emit(const char *cp, const char *ep, struct strbuf *output)
 {
 	while (*cp && (!ep || cp < ep)) {
 		if (*cp == '%') {
@@ -1243,13 +1238,13 @@ static void emit(const char *cp, const char *ep)
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
@@ -1257,19 +1252,21 @@ static void emit(const char *cp, const char *ep)
 void show_ref_array_item(struct ref_array_item *info, const char *format, int quote_style)
 {
 	const char *cp, *sp, *ep;
+	struct strbuf output = STRBUF_INIT;
+	int i;
 
 	for (cp = format; *cp && (sp = find_next(cp)); cp = ep + 1) {
 		struct atom_value *atomv;
 
 		ep = strchr(sp, ')');
 		if (cp < sp)
-			emit(cp, sp);
+			emit(cp, sp, &output);
 		get_ref_atom_value(info, parse_ref_filter_atom(sp + 2, ep), &atomv);
-		print_value(atomv, quote_style);
+		print_value(atomv, quote_style, &output);
 	}
 	if (*cp) {
 		sp = cp + strlen(cp);
-		emit(cp, sp);
+		emit(cp, sp, &output);
 	}
 	if (need_color_reset_at_eol) {
 		struct atom_value resetv;
@@ -1278,9 +1275,12 @@ void show_ref_array_item(struct ref_array_item *info, const char *format, int qu
 		if (color_parse("reset", color) < 0)
 			die("BUG: couldn't parse 'reset' as a color");
 		resetv.s = color;
-		print_value(&resetv, quote_style);
+		print_value(&resetv, quote_style, &output);
 	}
+	for (i = 0; i < output.len; i++)
+		printf("%c", output.buf[i]);
 	putchar('\n');
+	strbuf_release(&output);
 }
 
 /*  If no sorting option is given, use refname to sort as default */
-- 
2.5.0
