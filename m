From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 13/34] mailinfo: move global "FILE *fin, *fout" to struct mailinfo
Date: Mon, 19 Oct 2015 00:28:30 -0700
Message-ID: <1445239731-10677-14-git-send-email-gitster@pobox.com>
References: <1444855557-2127-1-git-send-email-gitster@pobox.com>
 <1445239731-10677-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 19 09:29:26 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zo4sn-0002f8-V6
	for gcvg-git-2@plane.gmane.org; Mon, 19 Oct 2015 09:29:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752224AbbJSH3O (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Oct 2015 03:29:14 -0400
Received: from mail-pa0-f54.google.com ([209.85.220.54]:33938 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750904AbbJSH3J (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Oct 2015 03:29:09 -0400
Received: by padhk11 with SMTP id hk11so21770686pad.1
        for <git@vger.kernel.org>; Mon, 19 Oct 2015 00:29:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:subject:date:message-id:in-reply-to:references;
        bh=bbrMr3EGDwRSIVhaZmncu7723Vg45/Uk3wbz3UtLUO4=;
        b=IuMih+yRPSyGzFSNoWs4SE5rcazWkwSUvWrYH5S3lDnbrJIMaHz6l4b9EioiHnVt/E
         nTBRJawpauc/p/EAvfwTlVWXyJpdVbTmgeLaiPSF1pK419fVsPAQuceaPbMjGQQmfhSK
         cQa9lxFYIFKBuW3BbQ/+KeZcO1YL06DCNB2lFZDms7sohwCY8Mlz6LjxwfwC3bZRhib2
         2Dj/DbYwVBnZbw7lxgx1MHdBp8DyzkjMGfyV0rrZc1/cSokObd5PU9LuT8u/+I9xQ+xw
         j5GO6ZQHaiLEGIrJJVB0DCcv1+ngqrc6aj1mNZ3DIxKJ2AKdHaSTy2SxvXtyEV7l/syJ
         Jryw==
X-Received: by 10.68.139.100 with SMTP id qx4mr25442524pbb.149.1445239749337;
        Mon, 19 Oct 2015 00:29:09 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:f5db:ee54:4f5:9373])
        by smtp.gmail.com with ESMTPSA id we9sm34803499pab.3.2015.10.19.00.29.08
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 19 Oct 2015 00:29:08 -0700 (PDT)
X-Mailer: git-send-email 2.6.2-388-g10c4a0e
In-Reply-To: <1445239731-10677-1-git-send-email-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279839>

This requires us to pass "struct mailinfo" to more functions
throughout the codepath that read input lines.  Incidentally,
later steps are helped by this patch passing the struct to
more callchains.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/mailinfo.c | 54 ++++++++++++++++++++++++++++--------------------------
 1 file changed, 28 insertions(+), 26 deletions(-)

diff --git a/builtin/mailinfo.c b/builtin/mailinfo.c
index 08c67f5..b150936 100644
--- a/builtin/mailinfo.c
+++ b/builtin/mailinfo.c
@@ -7,11 +7,14 @@
 #include "utf8.h"
 #include "strbuf.h"
 
-static FILE *cmitmsg, *patchfile, *fin, *fout;
+static FILE *cmitmsg, *patchfile;
 
 static const char *metainfo_charset;
 
 struct mailinfo {
+	FILE *input;
+	FILE *output;
+
 	struct strbuf name;
 	struct strbuf email;
 	int keep_subject;
@@ -790,16 +793,17 @@ static void handle_filter(struct strbuf *line, int *filter_stage, int *header_st
 	}
 }
 
-static int find_boundary(struct strbuf *line)
+static int find_boundary(struct mailinfo *mi, struct strbuf *line)
 {
-	while (!strbuf_getline(line, fin, '\n')) {
+	while (!strbuf_getline(line, mi->input, '\n')) {
 		if (*content_top && is_multipart_boundary(line))
 			return 1;
 	}
 	return 0;
 }
 
-static int handle_boundary(struct strbuf *line, int *filter_stage, int *header_stage)
+static int handle_boundary(struct mailinfo *mi, struct strbuf *line,
+			   int *filter_stage, int *header_stage)
 {
 	struct strbuf newline = STRBUF_INIT;
 
@@ -825,7 +829,7 @@ again:
 		strbuf_release(&newline);
 
 		/* skip to the next boundary */
-		if (!find_boundary(line))
+		if (!find_boundary(mi, line))
 			return 0;
 		goto again;
 	}
@@ -835,18 +839,18 @@ again:
 	strbuf_reset(&charset);
 
 	/* slurp in this section's info */
-	while (read_one_header_line(line, fin))
+	while (read_one_header_line(line, mi->input))
 		check_header(line, p_hdr_data, 0);
 
 	strbuf_release(&newline);
 	/* replenish line */
-	if (strbuf_getline(line, fin, '\n'))
+	if (strbuf_getline(line, mi->input, '\n'))
 		return 0;
 	strbuf_addch(line, '\n');
 	return 1;
 }
 
-static void handle_body(struct strbuf *line)
+static void handle_body(struct mailinfo *mi, struct strbuf *line)
 {
 	struct strbuf prev = STRBUF_INIT;
 	int filter_stage = 0;
@@ -854,7 +858,7 @@ static void handle_body(struct strbuf *line)
 
 	/* Skip up to the first boundary */
 	if (*content_top) {
-		if (!find_boundary(line))
+		if (!find_boundary(mi, line))
 			goto handle_body_out;
 	}
 
@@ -866,7 +870,7 @@ static void handle_body(struct strbuf *line)
 				handle_filter(&prev, &filter_stage, &header_stage);
 				strbuf_reset(&prev);
 			}
-			if (!handle_boundary(line, &filter_stage, &header_stage))
+			if (!handle_boundary(mi, line, &filter_stage, &header_stage))
 				goto handle_body_out;
 		}
 
@@ -909,7 +913,7 @@ static void handle_body(struct strbuf *line)
 			handle_filter(line, &filter_stage, &header_stage);
 		}
 
-	} while (!strbuf_getwholeline(line, fin, '\n'));
+	} while (!strbuf_getwholeline(line, mi->input, '\n'));
 
 handle_body_out:
 	strbuf_release(&prev);
@@ -951,29 +955,25 @@ static void handle_info(struct mailinfo *mi)
 				cleanup_subject(mi, hdr);
 				cleanup_space(hdr);
 			}
-			output_header_lines(fout, "Subject", hdr);
+			output_header_lines(mi->output, "Subject", hdr);
 		} else if (!strcmp(header[i], "From")) {
 			cleanup_space(hdr);
 			handle_from(mi, hdr);
-			fprintf(fout, "Author: %s\n", mi->name.buf);
-			fprintf(fout, "Email: %s\n", mi->email.buf);
+			fprintf(mi->output, "Author: %s\n", mi->name.buf);
+			fprintf(mi->output, "Email: %s\n", mi->email.buf);
 		} else {
 			cleanup_space(hdr);
-			fprintf(fout, "%s: %s\n", header[i], hdr->buf);
+			fprintf(mi->output, "%s: %s\n", header[i], hdr->buf);
 		}
 	}
-	fprintf(fout, "\n");
+	fprintf(mi->output, "\n");
 }
 
-static int mailinfo(struct mailinfo *mi,
-		    FILE *in, FILE *out, const char *msg, const char *patch)
+static int mailinfo(struct mailinfo *mi, const char *msg, const char *patch)
 {
 	int peek;
 	struct strbuf line = STRBUF_INIT;
 
-	fin = in;
-	fout = out;
-
 	cmitmsg = fopen(msg, "w");
 	if (!cmitmsg) {
 		perror(msg);
@@ -990,15 +990,15 @@ static int mailinfo(struct mailinfo *mi,
 	s_hdr_data = xcalloc(MAX_HDR_PARSED, sizeof(*s_hdr_data));
 
 	do {
-		peek = fgetc(in);
+		peek = fgetc(mi->input);
 	} while (isspace(peek));
-	ungetc(peek, in);
+	ungetc(peek, mi->input);
 
 	/* process the email header */
-	while (read_one_header_line(&line, fin))
+	while (read_one_header_line(&line, mi->input))
 		check_header(&line, p_hdr_data, 1);
 
-	handle_body(&line);
+	handle_body(mi, &line);
 	fclose(patchfile);
 
 	handle_info(mi);
@@ -1076,7 +1076,9 @@ int cmd_mailinfo(int argc, const char **argv, const char *prefix)
 	if (argc != 3)
 		usage(mailinfo_usage);
 
-	status = !!mailinfo(&mi, stdin, stdout, argv[1], argv[2]);
+	mi.input = stdin;
+	mi.output = stdout;
+	status = !!mailinfo(&mi, argv[1], argv[2]);
 	clear_mailinfo(&mi);
 
 	return status;
-- 
2.6.2-383-g144b2e6
