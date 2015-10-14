From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 20/31] mailinfo: move cmitmsg and patchfile to struct mailinfo
Date: Wed, 14 Oct 2015 13:45:46 -0700
Message-ID: <1444855557-2127-21-git-send-email-gitster@pobox.com>
References: <1444778207-859-1-git-send-email-gitster@pobox.com>
 <1444855557-2127-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 14 22:48:35 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZmSyQ-0003ZX-TD
	for gcvg-git-2@plane.gmane.org; Wed, 14 Oct 2015 22:48:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932880AbbJNUs2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Oct 2015 16:48:28 -0400
Received: from mail-pa0-f51.google.com ([209.85.220.51]:33596 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932715AbbJNUqZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Oct 2015 16:46:25 -0400
Received: by pabrc13 with SMTP id rc13so64157848pab.0
        for <git@vger.kernel.org>; Wed, 14 Oct 2015 13:46:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:subject:date:message-id:in-reply-to:references;
        bh=YJBa4vdfkhumpStsHT4fLrXmkILAitmjd7f3uIYrBOc=;
        b=qv3MVGIbqn7MipF1eLSnjIJ44Gx9+js0D3Enp4mveRyutEK/kde6NxM73gSbbb9/mW
         CWuJXN5hmnoLB+xShU6mrXStekQECKXeOxOzw6fvQPCaJH2A4xgNaWr23qAdp7bFps5R
         +zUJ1nt9n4UO0UQR7jLCCRzTenadzLNdyzBiI6wJ9UQ/14wh9FTYMtUqfPzjZclUrZr3
         GvSRN4D07ktg6yoBLpFscaVFONcvbCChHrfS76M9wUPxNKD+1ygQhbEX+HCcKgqzs0fN
         Gk8nbEZ3xBO9q5CoI+thvS146AsH7LQmqPemVi1CFPA5iXb8v65/RAnwXfwr2mgavj34
         3Vpg==
X-Received: by 10.66.254.230 with SMTP id al6mr5588195pad.75.1444855584556;
        Wed, 14 Oct 2015 13:46:24 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:7964:41eb:7b4:cd77])
        by smtp.gmail.com with ESMTPSA id kw10sm11291188pbc.25.2015.10.14.13.46.23
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 14 Oct 2015 13:46:23 -0700 (PDT)
X-Mailer: git-send-email 2.6.1-320-g86a1181
In-Reply-To: <1444855557-2127-1-git-send-email-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279621>

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/mailinfo.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/builtin/mailinfo.c b/builtin/mailinfo.c
index f48a260..5809e13 100644
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
@@ -746,9 +746,9 @@ static int handle_commit_msg(struct mailinfo *mi, struct strbuf *line)
 
 	if (mi->use_scissors && is_scissors_line(line)) {
 		int i;
-		if (fseek(cmitmsg, 0L, SEEK_SET))
+		if (fseek(mi->cmitmsg, 0L, SEEK_SET))
 			die_errno("Could not rewind output message file");
-		if (ftruncate(fileno(cmitmsg), 0))
+		if (ftruncate(fileno(mi->cmitmsg), 0))
 			die_errno("Could not truncate output message file at scissors");
 		mi->header_stage = 1;
 
@@ -766,19 +766,19 @@ static int handle_commit_msg(struct mailinfo *mi, struct strbuf *line)
 
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
 
@@ -973,15 +973,15 @@ static int mailinfo(struct mailinfo *mi, const char *msg, const char *patch)
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
 
-- 
2.6.1-320-g86a1181
