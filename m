From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v2 06/10] ref-filter: introduce format_ref_array_item()
Date: Thu,  8 Oct 2015 14:48:01 +0530
Message-ID: <1444295885-1657-7-git-send-email-Karthik.188@gmail.com>
References: <1444295885-1657-1-git-send-email-Karthik.188@gmail.com>
Cc: christian.couder@gmail.com, Matthieu.Moy@grenoble-inp.fr,
	gitster@pobox.com, Karthik Nayak <Karthik.188@gmail.com>,
	Karthik Nayak <karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 08 11:18:34 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zk7LL-0007im-Gc
	for gcvg-git-2@plane.gmane.org; Thu, 08 Oct 2015 11:18:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755263AbbJHJS0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Oct 2015 05:18:26 -0400
Received: from mail-pa0-f52.google.com ([209.85.220.52]:34470 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755253AbbJHJSW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Oct 2015 05:18:22 -0400
Received: by padhy16 with SMTP id hy16so49624383pad.1
        for <git@vger.kernel.org>; Thu, 08 Oct 2015 02:18:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=eRsJiLObYbtyIoMR/N/fkABTbVN3+gF0CD6oJNMiVmA=;
        b=DGRRYmNZPYiupP87RUAz7fcCPrvhR57eOYQ2BEn8ayljjax+mtKBRYJ2ysjF/T9Tr9
         REUltUffue6NDdfOHkfYxeqQGIE7JIEdSn/GFCEfmNL3w4niQcEimABApE8AmZs0AQ8/
         bnmlEGNKAOqy1bFvh1XXkcxJpZjigtOHkAA4d1pLELv9L9TeB6gOMFdUvg9LNe152WMm
         YErGenC9CRJIQHGRgk9Z8JK+GQF+zSnRu22NTWheoiM9qdCf/7HkXECTWB8m79yecx7A
         VNN99AeMpS9UjTurIusjn2nAiHVelGa+4po8IeP/MIyJ4zdO8lsosrUpQsS+grv3kv5d
         WAiQ==
X-Received: by 10.66.162.227 with SMTP id yd3mr7057796pab.53.1444295902350;
        Thu, 08 Oct 2015 02:18:22 -0700 (PDT)
Received: from ashley.localdomain ([106.51.20.153])
        by smtp.gmail.com with ESMTPSA id sv9sm44171159pbc.44.2015.10.08.02.18.17
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 08 Oct 2015 02:18:21 -0700 (PDT)
X-Google-Original-From: Karthik Nayak <Karthik.188@gmail.com>
X-Mailer: git-send-email 2.6.1
In-Reply-To: <1444295885-1657-1-git-send-email-Karthik.188@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279229>

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
index a3cc3af..38e4424 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -1756,10 +1756,10 @@ static void append_literal(const char *cp, const char *ep, struct ref_formatting
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
@@ -1789,9 +1789,17 @@ void show_ref_array_item(struct ref_array_item *info, const char *format, int qu
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
2.6.0
