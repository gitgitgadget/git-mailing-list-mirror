From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 19/26] mailinfo: move cmitmsg and patchfile to struct mailinfo
Date: Tue, 13 Oct 2015 16:16:40 -0700
Message-ID: <1444778207-859-20-git-send-email-gitster@pobox.com>
References: <1444778207-859-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 14 01:18:27 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zm8pu-0007Qk-DK
	for gcvg-git-2@plane.gmane.org; Wed, 14 Oct 2015 01:18:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932072AbbJMXST (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Oct 2015 19:18:19 -0400
Received: from mail-pa0-f47.google.com ([209.85.220.47]:34879 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752019AbbJMXRM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Oct 2015 19:17:12 -0400
Received: by padcn9 with SMTP id cn9so3399313pad.2
        for <git@vger.kernel.org>; Tue, 13 Oct 2015 16:17:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:subject:date:message-id:in-reply-to:references;
        bh=wWSZjAxJ1lfpWGMt7ocyDEd4hHfy/Bx+SDHN4noGsHU=;
        b=rFwlIlv4aMex3b5fJjAOZUTP31d/diJ2JXFuRmMDrpmzziZ9k60eLoK8tvhGqwS5ro
         Yi6R62s3ERNUXtDiVyROcmpz1cBUYCUG1GObXJ7qD+1QyoGSScqIX63+MVzb4COK3s9E
         iUcHLRiq+0mqzft/IHSpUAN4WLnv8IZSeqSfW9srNq2PkzFEwJsxbNN3JKFLM3KVsWeW
         Kqr7cTnn9cREIfolHRajra1dvuPwMdLDnmY+0sYTNU9O6/vutzWBLQOa0jUK1LVk6P11
         5Vl2NKv8i+xoJXtgoxlO2Y9zyVur534e17xlB1I14ElMp3CRigbVzU6zAGNpZSpoNX9V
         aOlQ==
X-Received: by 10.68.93.133 with SMTP id cu5mr6645pbb.71.1444778231588;
        Tue, 13 Oct 2015 16:17:11 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:45f3:915b:d2ba:37bc])
        by smtp.gmail.com with ESMTPSA id u3sm5840400pbs.33.2015.10.13.16.17.10
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 13 Oct 2015 16:17:11 -0700 (PDT)
X-Mailer: git-send-email 2.6.1-320-g86a1181
In-Reply-To: <1444778207-859-1-git-send-email-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279556>

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/mailinfo.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/builtin/mailinfo.c b/builtin/mailinfo.c
index 256d04a..b591a2f 100644
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
@@ -775,9 +775,9 @@ static int handle_commit_msg(struct mailinfo *mi, struct strbuf *line)
 
 	if (mi->use_scissors && is_scissors_line(line)) {
 		int i;
-		if (fseek(cmitmsg, 0L, SEEK_SET))
+		if (fseek(mi->cmitmsg, 0L, SEEK_SET))
 			die_errno("Could not rewind output message file");
-		if (ftruncate(fileno(cmitmsg), 0))
+		if (ftruncate(fileno(mi->cmitmsg), 0))
 			die_errno("Could not truncate output message file at scissors");
 		mi->header_stage = 1;
 
@@ -795,19 +795,19 @@ static int handle_commit_msg(struct mailinfo *mi, struct strbuf *line)
 
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
 
@@ -1002,15 +1002,15 @@ static int mailinfo(struct mailinfo *mi, const char *msg, const char *patch)
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
