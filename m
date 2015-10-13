From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 20/26] mailinfo: move [ps]_hdr_data to struct mailinfo
Date: Tue, 13 Oct 2015 16:16:41 -0700
Message-ID: <1444778207-859-21-git-send-email-gitster@pobox.com>
References: <1444778207-859-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 14 01:18:26 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zm8pt-0007Qk-Ol
	for gcvg-git-2@plane.gmane.org; Wed, 14 Oct 2015 01:18:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753421AbbJMXSS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Oct 2015 19:18:18 -0400
Received: from mail-pa0-f41.google.com ([209.85.220.41]:34220 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751733AbbJMXRN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Oct 2015 19:17:13 -0400
Received: by pabws5 with SMTP id ws5so3477413pab.1
        for <git@vger.kernel.org>; Tue, 13 Oct 2015 16:17:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:subject:date:message-id:in-reply-to:references;
        bh=hizIZuo0ddAPZZIyY57fxadYtHk3RdbCWkPGHCPpx5M=;
        b=S+VuO8BySmg4AOI64DAgJS8OLzByEGD+9ykkq1jRLJeJPUUn1C4wk/YbJ1NFkMkXpv
         OtVSPj2OVb5/gX9Lh6YRYz8K0ulfDsTvx4qZqoWab3FFD+/vPOGIoHOjlITt1tBvYpT4
         GDQHEtNX6WeoPudgy6iO7/PIhtR5Tb906ZZpklU3E0beq2HhNO4rfsHgzNojUCVaIYnJ
         xv6MH25jPHbvbhyOjQ8doRGfbn4RB+47ad5KO61BUiefYMQ6CR3SGLzze7obNTnVymak
         /fWDTiLTLC//ao/9CUNUXvSJOet+5maD6I0sDbbtM1+iSCWBN3szk/cYFFpE2dwsXOUl
         Ztog==
X-Received: by 10.68.197.196 with SMTP id iw4mr43149351pbc.153.1444778232928;
        Tue, 13 Oct 2015 16:17:12 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:45f3:915b:d2ba:37bc])
        by smtp.gmail.com with ESMTPSA id xm9sm5842121pbc.32.2015.10.13.16.17.12
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 13 Oct 2015 16:17:12 -0700 (PDT)
X-Mailer: git-send-email 2.6.1-320-g86a1181
In-Reply-To: <1444778207-859-1-git-send-email-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279555>

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/mailinfo.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/builtin/mailinfo.c b/builtin/mailinfo.c
index b591a2f..c9629c8 100644
--- a/builtin/mailinfo.c
+++ b/builtin/mailinfo.c
@@ -30,10 +30,10 @@ struct mailinfo {
 	int patch_lines;
 	int filter_stage; /* still reading log or are we copying patch? */
 	int header_stage; /* still checking in-body headers? */
+	struct strbuf **p_hdr_data;
+	struct strbuf **s_hdr_data;
 };
 
-static struct strbuf **p_hdr_data, **s_hdr_data;
-
 #define MAX_HDR_PARSED 10
 #define MAX_BOUNDARIES 5
 
@@ -743,7 +743,7 @@ static int handle_commit_msg(struct mailinfo *mi, struct strbuf *line)
 	}
 
 	if (mi->use_inbody_headers && mi->header_stage) {
-		int is_known_header = check_header(mi, line, s_hdr_data, 0);
+		int is_known_header = check_header(mi, line, mi->s_hdr_data, 0);
 
 		if (mi->header_stage == 2) {
 			/*
@@ -786,9 +786,9 @@ static int handle_commit_msg(struct mailinfo *mi, struct strbuf *line)
 		 * them to give ourselves a clean restart.
 		 */
 		for (i = 0; header[i]; i++) {
-			if (s_hdr_data[i])
-				strbuf_release(s_hdr_data[i]);
-			s_hdr_data[i] = NULL;
+			if (mi->s_hdr_data[i])
+				strbuf_release(mi->s_hdr_data[i]);
+			mi->s_hdr_data[i] = NULL;
 		}
 		return 0;
 	}
@@ -870,7 +870,7 @@ again:
 
 	/* slurp in this section's info */
 	while (read_one_header_line(line, mi->input))
-		check_header(mi, line, p_hdr_data, 0);
+		check_header(mi, line, mi->p_hdr_data, 0);
 
 	strbuf_release(&newline);
 	/* replenish line */
@@ -971,10 +971,10 @@ static void handle_info(struct mailinfo *mi)
 
 	for (i = 0; header[i]; i++) {
 		/* only print inbody headers if we output a patch file */
-		if (mi->patch_lines && s_hdr_data[i])
-			hdr = s_hdr_data[i];
-		else if (p_hdr_data[i])
-			hdr = p_hdr_data[i];
+		if (mi->patch_lines && mi->s_hdr_data[i])
+			hdr = mi->s_hdr_data[i];
+		else if (mi->p_hdr_data[i])
+			hdr = mi->p_hdr_data[i];
 		else
 			continue;
 
@@ -1014,8 +1014,8 @@ static int mailinfo(struct mailinfo *mi, const char *msg, const char *patch)
 		return -1;
 	}
 
-	p_hdr_data = xcalloc(MAX_HDR_PARSED, sizeof(*p_hdr_data));
-	s_hdr_data = xcalloc(MAX_HDR_PARSED, sizeof(*s_hdr_data));
+	mi->p_hdr_data = xcalloc(MAX_HDR_PARSED, sizeof(*(mi->p_hdr_data)));
+	mi->s_hdr_data = xcalloc(MAX_HDR_PARSED, sizeof(*(mi->s_hdr_data)));
 
 	do {
 		peek = fgetc(mi->input);
@@ -1024,7 +1024,7 @@ static int mailinfo(struct mailinfo *mi, const char *msg, const char *patch)
 
 	/* process the email header */
 	while (read_one_header_line(&line, mi->input))
-		check_header(mi, &line, p_hdr_data, 1);
+		check_header(mi, &line, mi->p_hdr_data, 1);
 
 	handle_body(mi, &line);
 	handle_info(mi);
-- 
2.6.1-320-g86a1181
