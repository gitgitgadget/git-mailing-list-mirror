From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v7 01/11] ref-filter: introduce 'ref_formatting_state'
Date: Thu, 30 Jul 2015 21:05:42 +0530
Message-ID: <1438270552-10333-1-git-send-email-Karthik.188@gmail.com>
References: <CAOLa=ZR6_2NBB4v0Ynq391=8Jk2RZON6R0YG=HKUNwKx249b7Q@mail.gmail.com>
Cc: christian.couder@gmail.com, Matthieu.Moy@grenoble-inp.fr,
	gitster@pobox.com, Karthik Nayak <Karthik.188@gmail.com>,
	Karthik Nayak <karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 30 17:35:56 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZKpsA-0000qq-Go
	for gcvg-git-2@plane.gmane.org; Thu, 30 Jul 2015 17:35:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752323AbbG3Pfv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Jul 2015 11:35:51 -0400
Received: from mail-pa0-f67.google.com ([209.85.220.67]:35678 "EHLO
	mail-pa0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751384AbbG3Pfu (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Jul 2015 11:35:50 -0400
Received: by pacfg11 with SMTP id fg11so2108774pac.2
        for <git@vger.kernel.org>; Thu, 30 Jul 2015 08:35:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=bpzMFwhojAOXdsnhsCThmvhqnN4I/K60XAGcjDCx1nw=;
        b=DkwT6N/+XhmTW9WzWxUNYU2w2dAXcHF41XJfmgzv+RxlEyALsDUTlwW5zQztIkbDcS
         oCmL3e6z59xnFB/93N7BIBY6JUpX8Hc+tIFDnYix4mkWQS7C/TE7fWw1CruJ3x95eq0E
         xeaz5Qko5uE3HJriJFmuW6f0WxfiCrWJFA3ifZmveRuJ+RoChY+CYblnCfpdob2BfX4B
         sOSCBGiI/BXf4plp5TcNlNH0Q0TWDOPs+mrQId5zbT7+JLqFBkxgPiP3erH71G6Bc9bC
         VNpVMssWT0BV/6WnF/0K6ZgWg4+wOgbGVq/7K5Ip66f5g6s9EMHR+RBEKuLQTqXbcGpn
         MLRg==
X-Received: by 10.66.242.1 with SMTP id wm1mr103874435pac.79.1438270550065;
        Thu, 30 Jul 2015 08:35:50 -0700 (PDT)
Received: from ashley.localdomain ([106.51.130.23])
        by smtp.gmail.com with ESMTPSA id oq10sm2790985pdb.75.2015.07.30.08.35.47
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 30 Jul 2015 08:35:49 -0700 (PDT)
X-Google-Original-From: Karthik Nayak <Karthik.188@gmail.com>
X-Mailer: git-send-email 2.4.6
In-Reply-To: <CAOLa=ZR6_2NBB4v0Ynq391=8Jk2RZON6R0YG=HKUNwKx249b7Q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274991>

Introduce 'ref_formatting_state' structure to hold values of modifier
atoms which help only in formatting. This will eventually be used by
atoms like `padright` which will be introduced in a later patch.

Helped-by: Junio C Hamano <gitster@pobox.com>
Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Matthieu Moy <matthieu.moy@grenoble-inp.fr>
Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 ref-filter.c | 70 ++++++++++++++++++++++++++++++++++++++++++++----------------
 ref-filter.h |  5 +++++
 2 files changed, 57 insertions(+), 18 deletions(-)

diff --git a/ref-filter.c b/ref-filter.c
index 7561727..d6510a6 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -10,6 +10,8 @@
 #include "quote.h"
 #include "ref-filter.h"
 #include "revision.h"
+#include "utf8.h"
+#include "git-compat-util.h"
 
 typedef enum { FIELD_STR, FIELD_ULONG, FIELD_TIME } cmp_type;
 
@@ -1190,30 +1192,41 @@ void ref_array_sort(struct ref_sorting *sorting, struct ref_array *array)
 	qsort(array->items, array->nr, sizeof(struct ref_array_item *), compare_refs);
 }
 
-static void print_value(struct atom_value *v, int quote_style)
+static void apply_formatting_state(struct ref_formatting_state *state,
+				   const char *buf, struct strbuf *value)
 {
-	struct strbuf sb = STRBUF_INIT;
-	switch (quote_style) {
+	/* Eventually we'll format based on the ref_formatting_state */
+	strbuf_addstr(value, buf);
+}
+
+static void print_value(struct atom_value *v, struct ref_formatting_state *state)
+{
+	struct strbuf value = STRBUF_INIT;
+	struct strbuf formatted = STRBUF_INIT;
+
+	apply_formatting_state(state, v->s, &value);
+
+	switch (state->quote_style) {
 	case QUOTE_NONE:
-		fputs(v->s, stdout);
+		fputs(value.buf, stdout);
 		break;
 	case QUOTE_SHELL:
-		sq_quote_buf(&sb, v->s);
+		sq_quote_buf(&formatted, value.buf);
 		break;
 	case QUOTE_PERL:
-		perl_quote_buf(&sb, v->s);
+		perl_quote_buf(&formatted, value.buf);
 		break;
 	case QUOTE_PYTHON:
-		python_quote_buf(&sb, v->s);
+		python_quote_buf(&formatted, value.buf);
 		break;
 	case QUOTE_TCL:
-		tcl_quote_buf(&sb, v->s);
+		tcl_quote_buf(&formatted, value.buf);
 		break;
 	}
-	if (quote_style != QUOTE_NONE) {
-		fputs(sb.buf, stdout);
-		strbuf_release(&sb);
-	}
+	if (state->quote_style != QUOTE_NONE)
+		fputs(formatted.buf, stdout);
+	strbuf_release(&value);
+	strbuf_release(&formatted);
 }
 
 static int hex1(char ch)
@@ -1234,8 +1247,12 @@ static int hex2(const char *cp)
 		return -1;
 }
 
-static void emit(const char *cp, const char *ep)
+static void emit(const char *cp, const char *ep,
+		 struct ref_formatting_state *state)
 {
+	struct strbuf value = STRBUF_INIT;
+	struct strbuf format = STRBUF_INIT;
+
 	while (*cp && (!ep || cp < ep)) {
 		if (*cp == '%') {
 			if (cp[1] == '%')
@@ -1249,27 +1266,44 @@ static void emit(const char *cp, const char *ep)
 				}
 			}
 		}
-		putchar(*cp);
+		strbuf_addch(&value, *cp);
 		cp++;
 	}
+	apply_formatting_state(state, value.buf, &format);
+	fputs(format.buf, stdout);
+	strbuf_release(&format);
+	strbuf_release(&value);
+}
+
+static void store_formatting_state(struct ref_formatting_state *state,
+				   struct atom_value *atomv)
+{
+	/*  Here the 'ref_formatting_state' variable will be filled */
 }
 
 void show_ref_array_item(struct ref_array_item *info, const char *format, int quote_style)
 {
 	const char *cp, *sp, *ep;
+	struct ref_formatting_state state;
+
+	memset(&state, 0, sizeof(state));
+	state.quote_style = quote_style;
 
 	for (cp = format; *cp && (sp = find_next(cp)); cp = ep + 1) {
 		struct atom_value *atomv;
 
 		ep = strchr(sp, ')');
 		if (cp < sp)
-			emit(cp, sp);
+			emit(cp, sp, &state);
 		get_ref_atom_value(info, parse_ref_filter_atom(sp + 2, ep), &atomv);
-		print_value(atomv, quote_style);
+		if (atomv->modifier_atom)
+			store_formatting_state(&state, atomv);
+		else
+			print_value(atomv, &state);
 	}
 	if (*cp) {
 		sp = cp + strlen(cp);
-		emit(cp, sp);
+		emit(cp, sp, &state);
 	}
 	if (need_color_reset_at_eol) {
 		struct atom_value resetv;
@@ -1278,7 +1312,7 @@ void show_ref_array_item(struct ref_array_item *info, const char *format, int qu
 		if (color_parse("reset", color) < 0)
 			die("BUG: couldn't parse 'reset' as a color");
 		resetv.s = color;
-		print_value(&resetv, quote_style);
+		print_value(&resetv, &state);
 	}
 	putchar('\n');
 }
diff --git a/ref-filter.h b/ref-filter.h
index 6bf27d8..12e6a6b 100644
--- a/ref-filter.h
+++ b/ref-filter.h
@@ -19,6 +19,11 @@
 struct atom_value {
 	const char *s;
 	unsigned long ul; /* used for sorting when not FIELD_STR */
+	unsigned int modifier_atom : 1; /*  atoms which act as modifiers for the next atom */
+};
+
+struct ref_formatting_state {
+	int quote_style;
 };
 
 struct ref_sorting {
-- 
2.4.6
