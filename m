From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 10/26] mailinfo: move global "FILE *fin, *fout" to struct mailinfo
Date: Tue, 13 Oct 2015 16:16:31 -0700
Message-ID: <1444778207-859-11-git-send-email-gitster@pobox.com>
References: <1444778207-859-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 14 01:17:30 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zm8oy-0006OA-7h
	for gcvg-git-2@plane.gmane.org; Wed, 14 Oct 2015 01:17:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753367AbbJMXRX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Oct 2015 19:17:23 -0400
Received: from mail-pa0-f52.google.com ([209.85.220.52]:35766 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752243AbbJMXRC (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Oct 2015 19:17:02 -0400
Received: by padcn9 with SMTP id cn9so3396009pad.2
        for <git@vger.kernel.org>; Tue, 13 Oct 2015 16:17:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:subject:date:message-id:in-reply-to:references;
        bh=/o2E+uV+L3dT82pBMjdgodp8i07+Ti1McgXx2AJElD4=;
        b=EDR8DQMjGMtdG9ZJr+DFH5LBh41447deV3e61hSfakKMyueatVtR9SGoniC034bUeM
         zgWm4Qlq5mCQuLBA/ngB/DLrdpIMk5gU6a6L2C8LN+WcuMfkErzUurieVzrovtJoybNk
         j1qrnrkvQLwVkfpsS9zs/gpTDPUAES0yzg+ld1urA+gmdC0TG9xSlCCKeDy5soy4a9ic
         MJD7ksxg5RX7c5KYtdf13KnNVfh1fNpje2J2HmMsqDQqiv1f2j3NVcjbJ0C0+jE+DqNM
         5x4kuTfpncejnXP5Ql7DZd9TkmDqvQ+E2GHzgDY01LMLLzLriPazuQvL24ohx+nBjDUw
         El2Q==
X-Received: by 10.66.144.199 with SMTP id so7mr67018pab.42.1444778221546;
        Tue, 13 Oct 2015 16:17:01 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:45f3:915b:d2ba:37bc])
        by smtp.gmail.com with ESMTPSA id g12sm5859661pat.36.2015.10.13.16.17.01
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 13 Oct 2015 16:17:01 -0700 (PDT)
X-Mailer: git-send-email 2.6.1-320-g86a1181
In-Reply-To: <1444778207-859-1-git-send-email-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279538>

This requires us to pass "struct mailinfo" to more functions
throughout the codepath that read input lines, which makes
later steps easier.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/mailinfo.c | 54 ++++++++++++++++++++++++++++--------------------------
 1 file changed, 28 insertions(+), 26 deletions(-)

diff --git a/builtin/mailinfo.c b/builtin/mailinfo.c
index d642b0d..a9da338 100644
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
@@ -819,16 +822,17 @@ static void handle_filter(struct strbuf *line, int *filter_stage, int *header_st
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
 
@@ -854,7 +858,7 @@ again:
 		strbuf_release(&newline);
 
 		/* skip to the next boundary */
-		if (!find_boundary(line))
+		if (!find_boundary(mi, line))
 			return 0;
 		goto again;
 	}
@@ -864,18 +868,18 @@ again:
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
@@ -883,7 +887,7 @@ static void handle_body(struct strbuf *line)
 
 	/* Skip up to the first boundary */
 	if (*content_top) {
-		if (!find_boundary(line))
+		if (!find_boundary(mi, line))
 			goto handle_body_out;
 	}
 
@@ -895,7 +899,7 @@ static void handle_body(struct strbuf *line)
 				handle_filter(&prev, &filter_stage, &header_stage);
 				strbuf_reset(&prev);
 			}
-			if (!handle_boundary(line, &filter_stage, &header_stage))
+			if (!handle_boundary(mi, line, &filter_stage, &header_stage))
 				goto handle_body_out;
 		}
 
@@ -938,7 +942,7 @@ static void handle_body(struct strbuf *line)
 			handle_filter(line, &filter_stage, &header_stage);
 		}
 
-	} while (!strbuf_getwholeline(line, fin, '\n'));
+	} while (!strbuf_getwholeline(line, mi->input, '\n'));
 
 handle_body_out:
 	strbuf_release(&prev);
@@ -980,29 +984,25 @@ static void handle_info(struct mailinfo *mi)
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
@@ -1019,15 +1019,15 @@ static int mailinfo(struct mailinfo *mi,
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
 	handle_info(mi);
 
 	return 0;
@@ -1096,5 +1096,7 @@ int cmd_mailinfo(int argc, const char **argv, const char *prefix)
 	if (argc != 3)
 		usage(mailinfo_usage);
 
-	return !!mailinfo(&mi, stdin, stdout, argv[1], argv[2]);
+	mi.input = stdin;
+	mi.output = stdout;
+	return !!mailinfo(&mi, argv[1], argv[2]);
 }
-- 
2.6.1-320-g86a1181
