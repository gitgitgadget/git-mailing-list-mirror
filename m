From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v3 06/16] ref-filter: introduce format_ref_array_item()
Date: Wed, 30 Mar 2016 15:09:50 +0530
Message-ID: <1459330800-12525-7-git-send-email-Karthik.188@gmail.com>
References: <1459330800-12525-1-git-send-email-Karthik.188@gmail.com>
Cc: gitster@pobox.com, jacob.keller@gmail.com,
	Karthik Nayak <Karthik.188@gmail.com>,
	Karthik Nayak <karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 30 11:41:30 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1alCcw-00027Q-Of
	for gcvg-git-2@plane.gmane.org; Wed, 30 Mar 2016 11:41:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752052AbcC3JlT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Mar 2016 05:41:19 -0400
Received: from mail-pa0-f48.google.com ([209.85.220.48]:33676 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752037AbcC3JkY (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Mar 2016 05:40:24 -0400
Received: by mail-pa0-f48.google.com with SMTP id zm5so36435921pac.0
        for <git@vger.kernel.org>; Wed, 30 Mar 2016 02:40:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=LMoIFrQcRGgi386eNjrADhfX6Xc6JsmwgWxPqMjoZE4=;
        b=03gnhOZauMStWqy0SIqWprv2BFj0dpxmB21RFd8RqupPKvmsY8yOtJAX4J4tKqjyg4
         GM0hgq0sE2u5zdgTKUCg6IfzhRkKLxNyB34eKn0kTGmMGhMx8CE06/Zd3r+xWWAlyYbB
         7quFj10+qHpIPTgm8mckctSDMdwPnmb6AOVtJBcFR4OjQpHh6FicrJhGPc2Zhoz7K0K7
         BwxmpvCc5GXZciLtwpYYA7sv1QARvlYzy4Kyrpv5dsf0ZXKmasAsFx1/v7j6cLwzmvcR
         r1+92KuQrMUC5g9H0JLr+ZsJYYvJaOGaQxJ3EoucE3jXkS4Klq+fWYT1OLcUYxIU4Fvy
         1tkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=LMoIFrQcRGgi386eNjrADhfX6Xc6JsmwgWxPqMjoZE4=;
        b=XJpHXUBkQ9e9NdSodAAkQ4Zzt/dq/j6PjQj7aoZUC9aEujEDhOSjZNxOvapUMZVt9O
         opCXuRWa/OncmnOg9ApCm3e0cQmdFS15PtwUBcieR184CEFSmxR0kuaVD+axLPvsMNWK
         h0/t+Q1DxolNucNsaTmHxvWWtNTLtiB8e5W8Bvy5BethC9Nypwt9Dv3AP1nEZCJqTZuQ
         zFen4tiu+felkPDV3k2yEM2yzyIEGHFs6C1ppJxJYnmDFKjxo4MolqRRgr0lTU/hiip0
         rq4htFIlaWBlWx6+Z0kZKEjdYs8U9cfibURJjvyZqpDu6iLvIOb4QKY9448wb7OSDPil
         9ceA==
X-Gm-Message-State: AD7BkJI3qZ/jlyl4TG56O5jYuBPMxohSHpLM5z8seJbYrTWhQ8oG5Tb6mgZe6iRnJEcyBw==
X-Received: by 10.66.190.131 with SMTP id gq3mr11304090pac.42.1459330824012;
        Wed, 30 Mar 2016 02:40:24 -0700 (PDT)
Received: from localhost.localdomain ([106.51.243.45])
        by smtp.gmail.com with ESMTPSA id r65sm4402606pfa.27.2016.03.30.02.40.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 30 Mar 2016 02:40:23 -0700 (PDT)
X-Google-Original-From: Karthik Nayak <Karthik.188@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1459330800-12525-1-git-send-email-Karthik.188@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290298>

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
index 7004bf0..3bb474f 100644
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
2.7.4
