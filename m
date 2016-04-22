From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v5 05/16] ref-filter: introduce format_ref_array_item()
Date: Sat, 23 Apr 2016 00:33:56 +0530
Message-ID: <1461351847-22903-6-git-send-email-Karthik.188@gmail.com>
References: <1461351847-22903-1-git-send-email-Karthik.188@gmail.com>
Cc: jacob.keller@gmail.com, gitster@pobox.com, peff@peff.net,
	Karthik Nayak <Karthik.188@gmail.com>,
	Karthik Nayak <karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 22 21:04:56 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1atgNr-00088a-6R
	for gcvg-git-2@plane.gmane.org; Fri, 22 Apr 2016 21:04:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752963AbcDVTEp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Apr 2016 15:04:45 -0400
Received: from mail-pa0-f65.google.com ([209.85.220.65]:35864 "EHLO
	mail-pa0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752918AbcDVTEm (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Apr 2016 15:04:42 -0400
Received: by mail-pa0-f65.google.com with SMTP id i5so9268804pag.3
        for <git@vger.kernel.org>; Fri, 22 Apr 2016 12:04:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=YAuGrMfogE9bMZs+mT36E3b4/b91gEXSqFD784tIj0s=;
        b=zekG71GOD6+4S6cvOjZC3AfS83zEZlFMIhDfzsmXjfDENi1b1hughOJ7s7ULPHu/AS
         Ogwle2EwCRXPk9XuqSVpY1y1PGm9CBnbYFozFIPwmiWQOkAtrFuul+JdOEIMK0mS4pil
         mJiKw7YreDhiCgLj56u9CA0AnRnc8e6p8gL0WTJT43uzrT/Qli0J608TjjHxzrq5bFkk
         zfrnv7OrPM+Z6hOp4/hPvF5//dMPokv+cUYlE5ZB+Us92btEzImUFPgaAUZSne/F4jW1
         0pokr6FXlrFzpxoOA0Wg+Th1J20fdRkw4LfiKXPkWupQctHVaBJwoFIjwqLzVdQqf9K4
         ibGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=YAuGrMfogE9bMZs+mT36E3b4/b91gEXSqFD784tIj0s=;
        b=CTuOrug/N+3XuEZYcc/W9WxJnxB5MOvo3qu+D4VJciRw+y349l+O8SOC0dX7Em6npS
         mE7PDMTRLXtsen3cHJcQt2NRFwj69u16UeuTrtmIx2Lfg6m0E2FheKYa7j2C0q07WXLu
         Wd40ujxCx6gYY45EKDhsI5+2e8xtjdRvcRUIRWX8OjGB+8+kqB6s2b/CAcXZYxBxSdIY
         8cj14nMBqxaRhWdzq+Ife3Llh0DxsmSoSfpdJ0PV8XhnsV3LPeJMZyEAATkWWXilKvhn
         1rMlNSbyZ5EjJRf2my6sSYcahr80zLHr979eMBnjXw3FLLyqqx+Mx6ijf7/oUae8tbNv
         cWzg==
X-Gm-Message-State: AOPr4FX3ueJM7qTLFqnUhE19h2F+RKQ67LzpcV2k0tnmnTZKsxrz8VSBzQQVd/W/V2aXXw==
X-Received: by 10.67.1.65 with SMTP id be1mr30645862pad.46.1461351881924;
        Fri, 22 Apr 2016 12:04:41 -0700 (PDT)
Received: from ashley.localdomain ([106.216.186.206])
        by smtp.gmail.com with ESMTPSA id t1sm11266470paa.17.2016.04.22.12.04.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 22 Apr 2016 12:04:41 -0700 (PDT)
X-Google-Original-From: Karthik Nayak <Karthik.188@gmail.com>
X-Mailer: git-send-email 2.8.0
In-Reply-To: <1461351847-22903-1-git-send-email-Karthik.188@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292250>

To allow column display, we will need to first render the output in a
string list to allow print_columns() to compute the proper size of
each column before starting the actual output. Introduce the function
format_ref_array_item() that does the formatting of a ref_array_item
to an strbuf.

show_ref_array_item() is kept as a convenience wrapper around it which
obtains the strbuf and prints it the standard output.

Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Matthieu Moy <matthieu.moy@grenoble-inp.fr>
Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 ref-filter.c | 16 ++++++++++++----
 ref-filter.h |  3 +++
 2 files changed, 15 insertions(+), 4 deletions(-)

diff --git a/ref-filter.c b/ref-filter.c
index fcb3353..da2b9ee 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -1813,10 +1813,10 @@ static void append_literal(const char *cp, const char *ep, struct ref_formatting
 	}
 }
 
-void show_ref_array_item(struct ref_array_item *info, const char *format, int quote_style)
+void format_ref_array_item(struct ref_array_item *info, const char *format,
+			   int quote_style, struct strbuf *final_buf)
 {
 	const char *cp, *sp, *ep;
-	struct strbuf *final_buf;
 	struct ref_formatting_state state = REF_FORMATTING_STATE_INIT;
 
 	state.quote_style = quote_style;
@@ -1846,9 +1846,17 @@ void show_ref_array_item(struct ref_array_item *info, const char *format, int qu
 	}
 	if (state.stack->prev)
 		die(_("format: %%(end) atom missing"));
-	final_buf = &state.stack->output;
-	fwrite(final_buf->buf, 1, final_buf->len, stdout);
+	strbuf_addbuf(final_buf, &state.stack->output);
 	pop_stack_element(&state.stack);
+}
+
+void show_ref_array_item(struct ref_array_item *info, const char *format, int quote_style)
+{
+	struct strbuf final_buf = STRBUF_INIT;
+
+	format_ref_array_item(info, format, quote_style, &final_buf);
+	fwrite(final_buf.buf, 1, final_buf.len, stdout);
+	strbuf_release(&final_buf);
 	putchar('\n');
 }
 
diff --git a/ref-filter.h b/ref-filter.h
index 4aea594..0014b92 100644
--- a/ref-filter.h
+++ b/ref-filter.h
@@ -98,6 +98,9 @@ int parse_ref_filter_atom(const char *atom, const char *ep);
 int verify_ref_format(const char *format);
 /*  Sort the given ref_array as per the ref_sorting provided */
 void ref_array_sort(struct ref_sorting *sort, struct ref_array *array);
+/*  Based on the given format and quote_style, fill the strbuf */
+void format_ref_array_item(struct ref_array_item *info, const char *format,
+			   int quote_style, struct strbuf *final_buf);
 /*  Print the ref using the given format and quote_style */
 void show_ref_array_item(struct ref_array_item *info, const char *format, int quote_style);
 /*  Callback function for parsing the sort option */
-- 
2.8.0
