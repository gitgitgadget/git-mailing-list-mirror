From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH 05/15] ref-filter: introduce format_ref_array_item()
Date: Sun,  6 Mar 2016 17:34:52 +0530
Message-ID: <1457265902-7949-6-git-send-email-Karthik.188@gmail.com>
References: <1457265902-7949-1-git-send-email-Karthik.188@gmail.com>
Cc: gitster@pobox.com, Karthik Nayak <Karthik.188@gmail.com>,
	Karthik Nayak <karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 06 13:05:37 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1acXRG-00020g-5V
	for gcvg-git-2@plane.gmane.org; Sun, 06 Mar 2016 13:05:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751462AbcCFMF1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Mar 2016 07:05:27 -0500
Received: from mail-pa0-f44.google.com ([209.85.220.44]:33950 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751298AbcCFMFU (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Mar 2016 07:05:20 -0500
Received: by mail-pa0-f44.google.com with SMTP id fy10so61755708pac.1
        for <git@vger.kernel.org>; Sun, 06 Mar 2016 04:05:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Y7EzHbNztahD1VL95+1rhKAtltKIMP5BIZRhFey02fs=;
        b=f5E5hgOvCX1ThCZsfFbIGDq0StqaXYg1qazm0whD7HWaYtvMGvZr6Ec2dPFl+lO/G1
         3KAwY3hlKTtMGzWRC8DV+ADwG9LOhGJtf+WDCkEJtbVyIrIb10I0CrkO7oCdlV7Ku9cb
         dyEP6GrNBlgFPNik2n0xKPJ8iIb7uWbTmlJd0tqk9OFjOxmBjsAmunm3nohSgq2//Hxo
         Zyb/JQNbIFzuGLDbzwunUNl3iCenLfKjKnek8oxV1k0q6Fr4uN2TKhdxrPPEUZhMRLYx
         E4BbM5LzPL8de2roRNeoW6lSAf53KyTjsecb/ujm12gJzVz3Q8z/UiCROMBtUQkAFGbL
         ZlhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Y7EzHbNztahD1VL95+1rhKAtltKIMP5BIZRhFey02fs=;
        b=NQ0mYf0Rc4XgnvPt/Xo9JoxkrtPD2FvgkLeqWEifiIk3BruOzNwF7do0MugJbeGvy2
         U6MXgGYSKDqCxvG0yT5N99ESeOL3zIV7qC0sj7KSmyNU2eRy1hmIybR3E/QtGvgn0sdb
         bvm3VWZJG5Z9R7ms4xIpx9MxbcWHP1GAerKJ5CMFqq2pSBRWUTvhSfQIUIirrF6lFRsB
         nqAkyMBoSIth1bmkA42sX3w10YyhwBrXSvXcbs6/sxIhWW81mOQMyw0dDtUOM0SZ+TTn
         Ueq/mt2K++y23IlgihGEFxalG2zwieWIkYhInVRXGVwFHrebDObzxHDUcyyzeL0qdf6C
         Y5YA==
X-Gm-Message-State: AD7BkJKpFtuwqFuDu6lUnVhKdtuzr7f6GFnO9a6UhLvMLOdqTonDVZWOv1S2r06/yfluHA==
X-Received: by 10.66.90.136 with SMTP id bw8mr25919305pab.52.1457265919336;
        Sun, 06 Mar 2016 04:05:19 -0800 (PST)
Received: from localhost.localdomain ([106.51.240.143])
        by smtp.gmail.com with ESMTPSA id n66sm17536850pfj.39.2016.03.06.04.05.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 06 Mar 2016 04:05:18 -0800 (PST)
X-Google-Original-From: Karthik Nayak <Karthik.188@gmail.com>
X-Mailer: git-send-email 2.7.2
In-Reply-To: <1457265902-7949-1-git-send-email-Karthik.188@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288346>

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
index f02344c..2896cde 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -1803,10 +1803,10 @@ static void append_literal(const char *cp, const char *ep, struct ref_formatting
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
@@ -1836,9 +1836,17 @@ void show_ref_array_item(struct ref_array_item *info, const char *format, int qu
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
2.7.2
