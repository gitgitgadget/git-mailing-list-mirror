From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH 6/9] ref-filter: introduce format_ref_array_item()
Date: Fri,  2 Oct 2015 23:09:03 +0530
Message-ID: <1443807546-5985-7-git-send-email-Karthik.188@gmail.com>
References: <1443807546-5985-1-git-send-email-Karthik.188@gmail.com>
Cc: christian.couder@gmail.com, Matthieu.Moy@grenoble-inp.fr,
	gitster@pobox.com, Karthik Nayak <Karthik.188@gmail.com>,
	Karthik Nayak <karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 02 19:39:51 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zi4J0-00040e-1V
	for gcvg-git-2@plane.gmane.org; Fri, 02 Oct 2015 19:39:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754082AbbJBRjb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Oct 2015 13:39:31 -0400
Received: from mail-pa0-f67.google.com ([209.85.220.67]:35676 "EHLO
	mail-pa0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753806AbbJBRj3 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Oct 2015 13:39:29 -0400
Received: by pacgz1 with SMTP id gz1so12494812pac.2
        for <git@vger.kernel.org>; Fri, 02 Oct 2015 10:39:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ObFsIKH/dFf5nkIPEARKCeROeGvRbtnHqXDX6uLROQY=;
        b=nI5cU7r5DuUi5J1mE0vWgtgFYUL2G5qBlKXWIyBiuUTOj7LgGpsds0vchyHEZuwvOD
         fQwsft8tMkmGGaX0k/Qz8dTTwMTwoZMnwghXIyFaOEaeKlzp6r6qtHAZiAOUNkMhaDEQ
         Qr/cazsXNPb9Sal1O3nh/5Y5puLAA9tEocsySrukw/VCuXG4bSPL4B3QP+lRM3NM8yaP
         s6bumnFtXglNKzXWRN0yHEaTxBRIjEM1GdZ3CA7kcvnK+anqS8hUHlCJ8ft/kXLekyXw
         YNquXgu0QZO4ZafRBS0mNvDz6/5C0eKfhtFX5F0EQCwpkROtUJOaSlCFJ59+t7mW55sQ
         uo6A==
X-Received: by 10.68.218.137 with SMTP id pg9mr21700124pbc.160.1443807568260;
        Fri, 02 Oct 2015 10:39:28 -0700 (PDT)
Received: from ashley.localdomain ([106.51.130.23])
        by smtp.gmail.com with ESMTPSA id pq1sm12993384pbb.91.2015.10.02.10.39.24
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 02 Oct 2015 10:39:27 -0700 (PDT)
X-Google-Original-From: Karthik Nayak <Karthik.188@gmail.com>
X-Mailer: git-send-email 2.6.0
In-Reply-To: <1443807546-5985-1-git-send-email-Karthik.188@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278931>

Introduce format_ref_array_item() which will output the details of a
given ref_array_item as per the given format and quote_style to the
given strbuf.

This is derived from show_ref_array_item() which is now reduced to a
wrapper around format_ref_array_item().  show_ref_array_item() obtains
the strbuf and prints it the standard output.

This is needed when we port over the printing options of ref-filter to
branch.c.

Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Matthieu Moy <matthieu.moy@grenoble-inp.fr>
Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 ref-filter.c | 16 ++++++++++++----
 ref-filter.h |  3 +++
 2 files changed, 15 insertions(+), 4 deletions(-)

diff --git a/ref-filter.c b/ref-filter.c
index 15df421..099acd6 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -1748,10 +1748,10 @@ static void append_literal(const char *cp, const char *ep, struct ref_formatting
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
@@ -1781,9 +1781,17 @@ void show_ref_array_item(struct ref_array_item *info, const char *format, int qu
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
index 14d435e..e0b26e8 100644
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
