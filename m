From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 22/34] mailinfo: move cmitmsg and patchfile to struct mailinfo
Date: Mon, 19 Oct 2015 00:28:39 -0700
Message-ID: <1445239731-10677-23-git-send-email-gitster@pobox.com>
References: <1444855557-2127-1-git-send-email-gitster@pobox.com>
 <1445239731-10677-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 19 09:30:13 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zo4tY-0003DY-Kj
	for gcvg-git-2@plane.gmane.org; Mon, 19 Oct 2015 09:30:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752911AbbJSH3W (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Oct 2015 03:29:22 -0400
Received: from mail-pa0-f45.google.com ([209.85.220.45]:32934 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752906AbbJSH3U (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Oct 2015 03:29:20 -0400
Received: by pabrc13 with SMTP id rc13so183000809pab.0
        for <git@vger.kernel.org>; Mon, 19 Oct 2015 00:29:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:subject:date:message-id:in-reply-to:references;
        bh=KGZPi/TRUZjfSefXhXu2DfcceXQhbH1+N29Sww0omvE=;
        b=UTKfXZIWBuuRpqlXyiYPrvEG+Kax5T83QNis3R5xWEy+i/jJ8PX9L9GSzqepc/ORj6
         J2sEsx1ZKWh6nkeZ5OrUk7RQ/m+sJT3PKWrErSAjdx+hYbwudIK2CV+twoKeB+KK/V2O
         ntmoBCNPGPtX0/us8WZlnRcoYt1UIYp+3uOTgypcgBvmh8af+WWOe+NoZrtOG6rcDjEL
         Qm0NNaHjk646g1ees9t8XCIzB3DjZOToYEUVkVJ8B7+E0aF6UrIGqI4KzKPs6Q9zkwBx
         dje+YK5LSceFvyaq/p56Uw6zM1rMwanpgrANxCasshGUiykAaFPaVt7e1q3tCyI0Co36
         Pzsw==
X-Received: by 10.69.1.5 with SMTP id bc5mr32946499pbd.151.1445239760266;
        Mon, 19 Oct 2015 00:29:20 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:f5db:ee54:4f5:9373])
        by smtp.gmail.com with ESMTPSA id hq1sm22865571pbb.43.2015.10.19.00.29.19
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 19 Oct 2015 00:29:19 -0700 (PDT)
X-Mailer: git-send-email 2.6.2-388-g10c4a0e
In-Reply-To: <1445239731-10677-1-git-send-email-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279854>

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/mailinfo.c | 32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/builtin/mailinfo.c b/builtin/mailinfo.c
index 810d132..b8b94d6 100644
--- a/builtin/mailinfo.c
+++ b/builtin/mailinfo.c
@@ -7,11 +7,11 @@
 #include "utf8.h"
 #include "strbuf.h"
 
-static FILE *cmitmsg, *patchfile;
-
 struct mailinfo {
 	FILE *input;
 	FILE *output;
+	FILE *cmitmsg;
+	FILE *patchfile;
 
 	struct strbuf name;
 	struct strbuf email;
@@ -724,7 +724,7 @@ static int is_scissors_line(const struct strbuf *line)
 
 static int handle_commit_msg(struct mailinfo *mi, struct strbuf *line)
 {
-	if (!cmitmsg)
+	if (!mi->cmitmsg)
 		return 0;
 
 	if (mi->header_stage) {
@@ -747,9 +747,9 @@ static int handle_commit_msg(struct mailinfo *mi, struct strbuf *line)
 
 	if (mi->use_scissors && is_scissors_line(line)) {
 		int i;
-		if (fseek(cmitmsg, 0L, SEEK_SET))
+		if (fseek(mi->cmitmsg, 0L, SEEK_SET))
 			die_errno("Could not rewind output message file");
-		if (ftruncate(fileno(cmitmsg), 0))
+		if (ftruncate(fileno(mi->cmitmsg), 0))
 			die_errno("Could not truncate output message file at scissors");
 		mi->header_stage = 1;
 
@@ -767,19 +767,19 @@ static int handle_commit_msg(struct mailinfo *mi, struct strbuf *line)
 
 	if (patchbreak(line)) {
 		if (mi->message_id)
-			fprintf(cmitmsg, "Message-Id: %s\n", mi->message_id);
-		fclose(cmitmsg);
-		cmitmsg = NULL;
+			fprintf(mi->cmitmsg, "Message-Id: %s\n", mi->message_id);
+		fclose(mi->cmitmsg);
+		mi->cmitmsg = NULL;
 		return 1;
 	}
 
-	fputs(line->buf, cmitmsg);
+	fputs(line->buf, mi->cmitmsg);
 	return 0;
 }
 
 static void handle_patch(struct mailinfo *mi, const struct strbuf *line)
 {
-	fwrite(line->buf, 1, line->len, patchfile);
+	fwrite(line->buf, 1, line->len, mi->patchfile);
 	mi->patch_lines++;
 }
 
@@ -974,15 +974,15 @@ static int mailinfo(struct mailinfo *mi, const char *msg, const char *patch)
 	int peek;
 	struct strbuf line = STRBUF_INIT;
 
-	cmitmsg = fopen(msg, "w");
-	if (!cmitmsg) {
+	mi->cmitmsg = fopen(msg, "w");
+	if (!mi->cmitmsg) {
 		perror(msg);
 		return -1;
 	}
-	patchfile = fopen(patch, "w");
-	if (!patchfile) {
+	mi->patchfile = fopen(patch, "w");
+	if (!mi->patchfile) {
 		perror(patch);
-		fclose(cmitmsg);
+		fclose(mi->cmitmsg);
 		return -1;
 	}
 
@@ -999,7 +999,7 @@ static int mailinfo(struct mailinfo *mi, const char *msg, const char *patch)
 		check_header(mi, &line, p_hdr_data, 1);
 
 	handle_body(mi, &line);
-	fclose(patchfile);
+	fclose(mi->patchfile);
 
 	handle_info(mi);
 
-- 
2.6.2-383-g144b2e6
