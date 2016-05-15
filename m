From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v6 06/17] ref-filter: introduce format_ref_array_item()
Date: Sun, 15 May 2016 16:15:22 +0530
Message-ID: <1463309133-14503-7-git-send-email-Karthik.188@gmail.com>
References: <1463309133-14503-1-git-send-email-Karthik.188@gmail.com>
Cc: gitster@pobox.com, peff@peff.net,
	Karthik Nayak <Karthik.188@gmail.com>,
	Karthik Nayak <karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 15 12:46:13 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b1tYe-0003aG-Ma
	for gcvg-git-2@plane.gmane.org; Sun, 15 May 2016 12:46:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754166AbcEOKp4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 May 2016 06:45:56 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:34885 "EHLO
	mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754164AbcEOKpx (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 May 2016 06:45:53 -0400
Received: by mail-pf0-f195.google.com with SMTP id b66so5171399pfb.2
        for <git@vger.kernel.org>; Sun, 15 May 2016 03:45:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=F1DD22E+RdRgzyiyzKBjVJo+l29RDwsBctMxLmCUErk=;
        b=IJM2hPJr1hx7QKWF4gb7j8wv4kYILbQlT6pxb+xx2cx3f4g02d4T9+pBDO7oTiP1fh
         m+FtXGc9zz89b64+F9/lHrZdJ0Olxv8iRE8N5N0Ty6IyJRNJSElHafeWqJIz/TDVVdst
         7i7itZGTfkDgjzE4j4KjImv/HSA+Ul45CAJMsiol4Uizg4TW1WCcKczOTNrfUq7j0EJa
         rUhPrZcC624EuLy/5G7RRz6pPUN59sk4VUq2Mb1ynF6ws8hkYXCEPyIVW3OwwPtBAJue
         gfyRhFNyj2Qkiz8U9l64tdwcy6kbRYp5siVJS3gbzf3yGKqq+UXPxu5fykBRjl5X9AjN
         d14w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=F1DD22E+RdRgzyiyzKBjVJo+l29RDwsBctMxLmCUErk=;
        b=VFtkO2AAR8fuASBaY2+KKUZ7EuFlhm+Rt/MoDCA3481n/+zt5hJHfvGqJEvHi7tqg+
         dbhqSTRm9C6mEImlm/x8gzdYFPoZGNaTUfX1JZnvO+N28a7cEiXQFev/UoNCo/SDnk23
         stc0vkaBE75TWv9K/vqZFOn8lu6lXxqaMR4t6QTnCo2taW3QJ4tt8GOEXbkzBQq+vnRD
         FhTrs8mr8Y0DnNov5hH9uV2dIEX9wJ6YG/BFcOyOC7h02KdQp4+LOOS22ITPhkRQNOUK
         mYtOznkW2YJwIFWwPL17Cn7szcetpkk0f4buhb04d5spQMYJqusNby+9IqUubdDEEZC0
         xWJw==
X-Gm-Message-State: AOPr4FVsvYU0CUITA0EZAXt2r0eAVeZl1XJ1CicC0KCVJ7S52PYzn9C7vR0Xwyl0Ab+QQg==
X-Received: by 10.98.3.4 with SMTP id 4mr36806682pfd.33.1463309153008;
        Sun, 15 May 2016 03:45:53 -0700 (PDT)
Received: from ashley.localdomain ([106.51.133.65])
        by smtp.gmail.com with ESMTPSA id 71sm39866747pfy.32.2016.05.15.03.45.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 15 May 2016 03:45:52 -0700 (PDT)
X-Google-Original-From: Karthik Nayak <Karthik.188@gmail.com>
X-Mailer: git-send-email 2.8.2
In-Reply-To: <1463309133-14503-1-git-send-email-Karthik.188@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294655>

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
2.8.2
