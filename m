From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v4 06/16] ref-filter: introduce format_ref_array_item()
Date: Sun, 10 Apr 2016 00:15:05 +0530
Message-ID: <1460227515-28437-7-git-send-email-Karthik.188@gmail.com>
References: <1460227515-28437-1-git-send-email-Karthik.188@gmail.com>
Cc: jacob.keller@gmail.com, gitster@pobox.com,
	Karthik Nayak <Karthik.188@gmail.com>,
	Karthik Nayak <karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 09 20:45:43 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aoxt8-0003Zh-El
	for gcvg-git-2@plane.gmane.org; Sat, 09 Apr 2016 20:45:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758986AbcDISph (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Apr 2016 14:45:37 -0400
Received: from mail-io0-f194.google.com ([209.85.223.194]:34797 "EHLO
	mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758956AbcDISpf (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Apr 2016 14:45:35 -0400
Received: by mail-io0-f194.google.com with SMTP id z133so20476111iod.1
        for <git@vger.kernel.org>; Sat, 09 Apr 2016 11:45:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=3Um+h2HaYYeXkKiz8vf7TyfCO7LYxhAbZwaUdEvh1xU=;
        b=HtZlPkQnJW27gCDsrQq7NrlS4kklW2NNT0QN69TThWIeAxaKmpfQV/H81HgpzC8h3L
         jwg7B7j7g352uE8wd/ztEIqTCM1GvDYO0swOhIVKS+ZOqIGxsPLJuJhMqEuJrCFcjGDL
         50JZYpgMGJz2WvB1VTDc7qQ8zddFAB0P7BRdaQDRfkwCf6H7uw3m8CvifRpIpaATFlJ0
         shs9GQFE3WU2bVdXOJbPp+N4OvcazvU6wZr8NK3MvXzYdTLNqiGxGKYpIpvprFKmxzd9
         rzNDveaH409H4HJGcId4jbjNeSkrrpfX35x+Ju82OL96aVnwXhfQZKATyZOAGTRU0OYC
         tHxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=3Um+h2HaYYeXkKiz8vf7TyfCO7LYxhAbZwaUdEvh1xU=;
        b=WR4KMS0u73oA36jIDMT2bNZx7CgxiotLuoAJuZsAeaovjtNKGkIiZDpi3gi7PtasUv
         oI+VK6QOtZzGFt9SoPlOh9Cz6NLvyJiHgq+EwKnrIFX+1ZkzsAXyMzWJf+//DpAirlkd
         QARNsbYv+3/9ZcJMOpBX/Cg3WO87i5RsGdWvy7lg983DzigSoTHENXhslMbv/ak+np5e
         bUYLhMBCpQHG40NpaASNbvwkkSObGe+YbE8/dAUxYCD9IAWrrk5TBS6cYk4IpzbWU3ra
         1XjmzjKNWRYgPu8TotNnGEtjLNkj+/4hG7BAPQJkUo8HjpzybuNaQn8ltDzTXiWqdyPC
         hk4g==
X-Gm-Message-State: AD7BkJJgaS7z+H7i2syFvvCaLn8tGkpOjfcjAjCVL0Lz+wPtrnm2t6XGckJBzc8Ze1ay4g==
X-Received: by 10.107.163.84 with SMTP id m81mr17239984ioe.105.1460227534645;
        Sat, 09 Apr 2016 11:45:34 -0700 (PDT)
Received: from localhost.localdomain ([106.51.241.12])
        by smtp.gmail.com with ESMTPSA id be7sm7132351igb.1.2016.04.09.11.45.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 09 Apr 2016 11:45:34 -0700 (PDT)
X-Google-Original-From: Karthik Nayak <Karthik.188@gmail.com>
X-Mailer: git-send-email 2.8.0
In-Reply-To: <1460227515-28437-1-git-send-email-Karthik.188@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291110>

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
2.8.0
