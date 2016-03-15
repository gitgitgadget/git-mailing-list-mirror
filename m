From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v2 06/16] ref-filter: introduce format_ref_array_item()
Date: Tue, 15 Mar 2016 22:17:06 +0530
Message-ID: <1458060436-1215-7-git-send-email-Karthik.188@gmail.com>
References: <1458060436-1215-1-git-send-email-Karthik.188@gmail.com>
Cc: gitster@pobox.com, jacob.keller@gmail.com,
	Karthik Nayak <Karthik.188@gmail.com>,
	Karthik Nayak <karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 15 17:47:44 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1afs8F-0000lK-Q7
	for gcvg-git-2@plane.gmane.org; Tue, 15 Mar 2016 17:47:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965162AbcCOQrj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Mar 2016 12:47:39 -0400
Received: from mail-pf0-f171.google.com ([209.85.192.171]:36060 "EHLO
	mail-pf0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965097AbcCOQri (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Mar 2016 12:47:38 -0400
Received: by mail-pf0-f171.google.com with SMTP id u190so35742116pfb.3
        for <git@vger.kernel.org>; Tue, 15 Mar 2016 09:47:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=H0CQPb0lODeX6V91em6QzE5AKtOEAqPJQBuNk27xMxM=;
        b=yu5edvhxN68ZDUkOFMiwzDu3Ha+2etNq5xTcp2KpgnXxjinonxoZ4bLbjU8+KQUFm6
         8BYa8GZsXZa9jGXBW2Np9/Ljcrn2QrdsBW+HPq57uEB2+gEwzM/xMeoy8/aXP//V93Ta
         ltlHXkbSGnLCodE1xSiwWyunrv/1b7WF72VwIkWizm/cJaNf4Er9DYWVUbJ0gGWrjs2U
         +5CWaX7Ji2UYDTPy/NCCksfPqE3HPfYNx3xMG87xpVmJFTFNiaODaWLARRrgidLEdlVH
         seOEk4tH4YxRHrVOeplbJJP7tjeTrqe5jN1vFVV+0xI90dopWhPqeoAdfyjDY9SaflZF
         7mww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=H0CQPb0lODeX6V91em6QzE5AKtOEAqPJQBuNk27xMxM=;
        b=LB2z23OSkouWg8ZyUnkNNJz1jhfc8HVrv4ZsV5ormoHAnlUjow5g7Or5Lw9necvtZN
         D7Vcr3KY+nsZVRsnWfvK1N9Byllj6DhypWJNUJLMRvZiR+nxK+OYqaAuCPARX+orKFqZ
         P56iJJAhgl0f4Uux0x3+YXSrI4oWwjXX8HvNRrMDiUlONv0IpG0gE7eeqNJCwY9mQJqm
         Gkm6Qi6a4bWmAEA9d5oMNfhk2mxetnl1eQEbVmUEkXp4tcHtv79HtCughFsJ/Re5bE2x
         OgdpryiDXcM9XaNhY+5mblj74XkXDxsEcKVzZcLQ+4EVXw+E2fPEMcrUfkwfeMhrZUvK
         DPlA==
X-Gm-Message-State: AD7BkJKgEV+dCjobsoDyh1ZM7rhiC4vfl0uMddHsw/LxX/dnoamBzb5CgvFbadcQEq+/6w==
X-Received: by 10.98.32.218 with SMTP id m87mr40152178pfj.48.1458060457202;
        Tue, 15 Mar 2016 09:47:37 -0700 (PDT)
Received: from localhost.localdomain ([106.51.243.87])
        by smtp.gmail.com with ESMTPSA id i1sm40874361pfj.17.2016.03.15.09.47.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 15 Mar 2016 09:47:36 -0700 (PDT)
X-Google-Original-From: Karthik Nayak <Karthik.188@gmail.com>
X-Mailer: git-send-email 2.7.3
In-Reply-To: <1458060436-1215-1-git-send-email-Karthik.188@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288866>

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
2.7.3
