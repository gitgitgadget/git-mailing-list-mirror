From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v5b 06/17] ref-filter: introduce format_ref_array_item()
Date: Mon, 25 Apr 2016 20:47:47 +0530
Message-ID: <1461597478-31855-6-git-send-email-Karthik.188@gmail.com>
References: <1461581558-32348-1-git-send-email-Karthik.188@gmail.com>
Cc: jacob.keller@gmail.com, gitster@pobox.com, peff@peff.net,
	Karthik Nayak <Karthik.188@gmail.com>,
	Karthik Nayak <karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 25 17:18:34 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1auiHS-0005mc-15
	for gcvg-git-2@plane.gmane.org; Mon, 25 Apr 2016 17:18:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932098AbcDYPSV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Apr 2016 11:18:21 -0400
Received: from mail-pa0-f49.google.com ([209.85.220.49]:33477 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754842AbcDYPSU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Apr 2016 11:18:20 -0400
Received: by mail-pa0-f49.google.com with SMTP id zm5so66186060pac.0
        for <git@vger.kernel.org>; Mon, 25 Apr 2016 08:18:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=YAuGrMfogE9bMZs+mT36E3b4/b91gEXSqFD784tIj0s=;
        b=HZxw2U1DINKmysCl9Gr2w09eAS2y1pZ8E2N0wipvJz1CiVitxNZoAFUpjEiL7CPNmS
         nDrVUmnQL7nbzAs1WTuy1wcq9SsN4ivHM3NxEez9feq2ygJdeIRtuAhNnd66hJHs50Xf
         jX1IDvPLbJs2LgXOlxymkj4NuN8ZHPo0jTRrfdfVwSLLF4wy3vbgFkl1VkJ1AwD9JlG1
         Ric/gt6nwBu+CrlUTWC3Y/YC+NGVDF9QzfHRd7cchRYZhI7RiYlQCWIwmtdq0QleA8Al
         Ay0HDqbaeh9D6jZXnkfYYDtRxi/9vDXuMDs8BqXA7ztFueoskeqPiFqCKhuL89JWAfAr
         5aNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=YAuGrMfogE9bMZs+mT36E3b4/b91gEXSqFD784tIj0s=;
        b=ASe69IIMLAX+W4YM48huOvzhk+qc+wyFHYGzPY9MxfkUAPvtdIkvwuycIeZR+Eh69l
         RQtf1hQ/BGyX2cvkrma3/TmqXJmnMsQxtiKUfXAFWKMPvvxld8OgfMcaR0t7RU6ZRqJ0
         UuQlcSA4JicBNYSEFshZ7HwTWEiXRvCF/HzlwShcGkEQyhZ1M4yD1IsdYXZbsU4AexpS
         So4wf9TwYra/0Sp7W6YOzZhDBn1kxxUM3WktIHZF3W+wVeikryFHjYYLAGcLuBhhfWHw
         BEKr8aUTCcmCEOggjOMxIsfI7mO3BPhxZDeszvgjP6QkvNED0uYaguSiYMh5GpuMr7r2
         RASw==
X-Gm-Message-State: AOPr4FWDtnG4RkyIKA8QnmeJYBbTGLnboPwvv9AiatTqeDnUn5RJVboBB7JCdzFoqyhCfQ==
X-Received: by 10.66.65.133 with SMTP id x5mr50097427pas.108.1461597499486;
        Mon, 25 Apr 2016 08:18:19 -0700 (PDT)
Received: from ashley.localdomain ([106.51.234.108])
        by smtp.gmail.com with ESMTPSA id ut1sm30812527pac.46.2016.04.25.08.18.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 25 Apr 2016 08:18:18 -0700 (PDT)
X-Google-Original-From: Karthik Nayak <Karthik.188@gmail.com>
X-Mailer: git-send-email 2.8.0
In-Reply-To: <1461581558-32348-1-git-send-email-Karthik.188@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292491>

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
