From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 11/31] mailinfo: move global "FILE *fin, *fout" to struct mailinfo
Date: Wed, 14 Oct 2015 13:45:37 -0700
Message-ID: <1444855557-2127-12-git-send-email-gitster@pobox.com>
References: <1444778207-859-1-git-send-email-gitster@pobox.com>
 <1444855557-2127-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 14 22:46:51 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZmSwk-0001mB-PE
	for gcvg-git-2@plane.gmane.org; Wed, 14 Oct 2015 22:46:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932896AbbJNUqf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Oct 2015 16:46:35 -0400
Received: from mail-pa0-f41.google.com ([209.85.220.41]:33837 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932384AbbJNUqN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Oct 2015 16:46:13 -0400
Received: by payp3 with SMTP id p3so16206768pay.1
        for <git@vger.kernel.org>; Wed, 14 Oct 2015 13:46:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:subject:date:message-id:in-reply-to:references;
        bh=rIH0bZU+MVjnRD+mG2qCeBFqivq5XP8QB8ZM33B36BQ=;
        b=fCWsK0Gf5bpDeaqBvim52bRguTAQ8kYINupciIQ6K4OQpWQ3xcCO5zXiXDT9fwz1Fo
         a0nLouXyDCXWCHpHW4R8HkCxKY/pic+kzEm1dhnQEPVp32qI4l/dVU18/fxgTKbynOpi
         EyZarxaSEw1q3Ei/TsMqy1NiF5HAmpEt0UL1VqgNrIVe+JnjCpeBqi95PAZH0tBtTyLq
         Uwo0CpVpF3Eba8m0CRsACgglmVmL6sJtwDn8WE/tJvaPe76rr9xkhcLwamHOdzQvRNaz
         qYagixQSPtxDgtx2cQ/wF6ps4mvP04UMlvGdPyDqJyGs/i1EAbXISMACemyEtVO5t8yf
         OWRQ==
X-Received: by 10.66.235.42 with SMTP id uj10mr5772768pac.32.1444855573137;
        Wed, 14 Oct 2015 13:46:13 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:7964:41eb:7b4:cd77])
        by smtp.gmail.com with ESMTPSA id yh3sm11259204pbb.82.2015.10.14.13.46.12
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 14 Oct 2015 13:46:12 -0700 (PDT)
X-Mailer: git-send-email 2.6.1-320-g86a1181
In-Reply-To: <1444855557-2127-1-git-send-email-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279597>

This requires us to pass "struct mailinfo" to more functions
throughout the codepath that read input lines, which makes
later steps easier.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/mailinfo.c | 54 ++++++++++++++++++++++++++++--------------------------
 1 file changed, 28 insertions(+), 26 deletions(-)

diff --git a/builtin/mailinfo.c b/builtin/mailinfo.c
index 855d813..68a085e 100644
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
@@ -1069,5 +1069,7 @@ int cmd_mailinfo(int argc, const char **argv, const char *prefix)
 	if (argc != 3)
 		usage(mailinfo_usage);
 
-	return !!mailinfo(&mi, stdin, stdout, argv[1], argv[2]);
+	mi.input = stdin;
+	mi.output = stdout;
+	return !!mailinfo(&mi, argv[1], argv[2]);
 }
-- 
2.6.1-320-g86a1181
