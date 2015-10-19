From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 26/34] mailinfo: keep the parsed log message in a strbuf
Date: Mon, 19 Oct 2015 00:28:43 -0700
Message-ID: <1445239731-10677-27-git-send-email-gitster@pobox.com>
References: <1444855557-2127-1-git-send-email-gitster@pobox.com>
 <1445239731-10677-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 19 09:30:02 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zo4tN-000365-Gi
	for gcvg-git-2@plane.gmane.org; Mon, 19 Oct 2015 09:30:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753214AbbJSH3y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Oct 2015 03:29:54 -0400
Received: from mail-pa0-f45.google.com ([209.85.220.45]:36546 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752884AbbJSH3Z (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Oct 2015 03:29:25 -0400
Received: by pacfv9 with SMTP id fv9so86977882pac.3
        for <git@vger.kernel.org>; Mon, 19 Oct 2015 00:29:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:subject:date:message-id:in-reply-to:references;
        bh=rSMGTTU/r1BMFVkd8sJ1qLDqIloqE7iXcyiLR91BCAk=;
        b=N3daTs4evyJIszSxQU0W3nTWFkWhGVafCG58VT02ucrZ7nek3fDAJxRabVqFP9HRYg
         S4xOwtDndaQBMiGhhJlIoGEFyhvnBhjlFm14sT/j3OJWkStp94+4qu+FSN/alx+TOofk
         x+DbdBQfPW7OwONSZd6sW2q/IH0z0YMaUrcOZxsBk2pFPH7C76OVr0ZMLvKE/pACkj24
         wuo68zF7XQUub0qBJ7x/NnbHZdcZglFxSQOdh82IUSP8CiYYs91QPYfOxwU78Z2Hf2u1
         g8tDK56hOiL1p6dAxSyj3Pmlb48Q+1x/uczLEt9yg5486MEXSvxOex+nycWN23pD84G4
         rXNg==
X-Received: by 10.68.204.197 with SMTP id la5mr7492583pbc.159.1445239765067;
        Mon, 19 Oct 2015 00:29:25 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:f5db:ee54:4f5:9373])
        by smtp.gmail.com with ESMTPSA id ln10sm34857332pab.29.2015.10.19.00.29.24
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 19 Oct 2015 00:29:24 -0700 (PDT)
X-Mailer: git-send-email 2.6.2-388-g10c4a0e
In-Reply-To: <1445239731-10677-1-git-send-email-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279850>

When mailinfo() is eventually libified, the calling "git am" still
will have to write out the log message in the "msg" file for hooks
and other users of the information, but it does not have to reopen
and reread what it wrote earlier if the function kept it in a strbuf.

This also removes the need for seeking and truncating the output
file when we see a scissors mark in the input, which in turn allows
us to lose two callsites of die_errno().

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/mailinfo.c | 28 ++++++++++++++++------------
 1 file changed, 16 insertions(+), 12 deletions(-)

diff --git a/builtin/mailinfo.c b/builtin/mailinfo.c
index 286eda0..81bb3c7 100644
--- a/builtin/mailinfo.c
+++ b/builtin/mailinfo.c
@@ -12,7 +12,6 @@
 struct mailinfo {
 	FILE *input;
 	FILE *output;
-	FILE *cmitmsg;
 	FILE *patchfile;
 
 	struct strbuf name;
@@ -36,6 +35,8 @@ struct mailinfo {
 	int header_stage; /* still checking in-body headers? */
 	struct strbuf **p_hdr_data;
 	struct strbuf **s_hdr_data;
+
+	struct strbuf log_message;
 };
 
 #define MAX_HDR_PARSED 10
@@ -747,10 +748,8 @@ static int handle_commit_msg(struct mailinfo *mi, struct strbuf *line)
 
 	if (mi->use_scissors && is_scissors_line(line)) {
 		int i;
-		if (fseek(mi->cmitmsg, 0L, SEEK_SET))
-			die_errno("Could not rewind output message file");
-		if (ftruncate(fileno(mi->cmitmsg), 0))
-			die_errno("Could not truncate output message file at scissors");
+
+		strbuf_setlen(&mi->log_message, 0);
 		mi->header_stage = 1;
 
 		/*
@@ -767,13 +766,12 @@ static int handle_commit_msg(struct mailinfo *mi, struct strbuf *line)
 
 	if (patchbreak(line)) {
 		if (mi->message_id)
-			fprintf(mi->cmitmsg, "Message-Id: %s\n", mi->message_id);
-		fclose(mi->cmitmsg);
-		mi->cmitmsg = NULL;
+			strbuf_addf(&mi->log_message,
+				    "Message-Id: %s\n", mi->message_id);
 		return 1;
 	}
 
-	fputs(line->buf, mi->cmitmsg);
+	strbuf_addbuf(&mi->log_message, line);
 	return 0;
 }
 
@@ -971,18 +969,19 @@ static void handle_info(struct mailinfo *mi)
 
 static int mailinfo(struct mailinfo *mi, const char *msg, const char *patch)
 {
+	FILE *cmitmsg;
 	int peek;
 	struct strbuf line = STRBUF_INIT;
 
-	mi->cmitmsg = fopen(msg, "w");
-	if (!mi->cmitmsg) {
+	cmitmsg = fopen(msg, "w");
+	if (!cmitmsg) {
 		perror(msg);
 		return -1;
 	}
 	mi->patchfile = fopen(patch, "w");
 	if (!mi->patchfile) {
 		perror(patch);
-		fclose(mi->cmitmsg);
+		fclose(cmitmsg);
 		return -1;
 	}
 
@@ -999,6 +998,8 @@ static int mailinfo(struct mailinfo *mi, const char *msg, const char *patch)
 		check_header(mi, &line, mi->p_hdr_data, 1);
 
 	handle_body(mi, &line);
+	fwrite(mi->log_message.buf, 1, mi->log_message.len, cmitmsg);
+	fclose(cmitmsg);
 	fclose(mi->patchfile);
 
 	handle_info(mi);
@@ -1026,6 +1027,7 @@ static void setup_mailinfo(struct mailinfo *mi)
 	strbuf_init(&mi->name, 0);
 	strbuf_init(&mi->email, 0);
 	strbuf_init(&mi->charset, 0);
+	strbuf_init(&mi->log_message, 0);
 	mi->header_stage = 1;
 	mi->use_inbody_headers = 1;
 	mi->content_top = mi->content;
@@ -1052,6 +1054,8 @@ static void clear_mailinfo(struct mailinfo *mi)
 		free(*(mi->content_top));
 		mi->content_top--;
 	}
+
+	strbuf_release(&mi->log_message);
 }
 
 static const char mailinfo_usage[] =
-- 
2.6.2-383-g144b2e6
