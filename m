From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 23/34] mailinfo: move [ps]_hdr_data to struct mailinfo
Date: Mon, 19 Oct 2015 00:28:40 -0700
Message-ID: <1445239731-10677-24-git-send-email-gitster@pobox.com>
References: <1444855557-2127-1-git-send-email-gitster@pobox.com>
 <1445239731-10677-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 19 09:30:21 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zo4tg-0003JK-2y
	for gcvg-git-2@plane.gmane.org; Mon, 19 Oct 2015 09:30:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753253AbbJSHaO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Oct 2015 03:30:14 -0400
Received: from mail-pa0-f47.google.com ([209.85.220.47]:36476 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752928AbbJSH3W (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Oct 2015 03:29:22 -0400
Received: by pacfv9 with SMTP id fv9so86976177pac.3
        for <git@vger.kernel.org>; Mon, 19 Oct 2015 00:29:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:subject:date:message-id:in-reply-to:references;
        bh=SS2ZKMtIDCV4z6DgSnSCkvWNr+VOS4FmFw6GUt4y94s=;
        b=eTgAipzR2SsctEvp877FOeoTHN02f3VfT2VCi7pvBrygK7RVVBK+Ed30OrsIQzyfTi
         3XgFyoAdKuV4P/6KednViwziGbGltp4cDvkyv9H6i7ojUrdp9PfKu0NPhwQNxSqwKQP6
         pt9NisZXxi4/F0VTjMpG9PK7YL81YBUdlldGRMVJQO8nWI4a31bWJY08HCbce5R6dr7D
         6eY0JV3NRyda9AKenvKsJ4T/hbsgZPTbMl27wNKT6R52Q+TY4RVZ7TsmZAO8jAIyMD+M
         D9C7qKjc+4kfgVD4ylnhu3ae6l7qA2J/owGoHQiFF1GB2YDa7Dew7euQ3ZpOCYCU8DJO
         9Fzg==
X-Received: by 10.68.65.67 with SMTP id v3mr27479301pbs.69.1445239761392;
        Mon, 19 Oct 2015 00:29:21 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:f5db:ee54:4f5:9373])
        by smtp.gmail.com with ESMTPSA id fa14sm34815625pac.8.2015.10.19.00.29.20
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 19 Oct 2015 00:29:20 -0700 (PDT)
X-Mailer: git-send-email 2.6.2-388-g10c4a0e
In-Reply-To: <1445239731-10677-1-git-send-email-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279857>

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/mailinfo.c | 37 +++++++++++++++++++++++--------------
 1 file changed, 23 insertions(+), 14 deletions(-)

diff --git a/builtin/mailinfo.c b/builtin/mailinfo.c
index b8b94d6..2c194da 100644
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
 
@@ -733,7 +733,7 @@ static int handle_commit_msg(struct mailinfo *mi, struct strbuf *line)
 	}
 
 	if (mi->use_inbody_headers && mi->header_stage) {
-		mi->header_stage = check_header(mi, line, s_hdr_data, 0);
+		mi->header_stage = check_header(mi, line, mi->s_hdr_data, 0);
 		if (mi->header_stage)
 			return 0;
 	} else
@@ -758,9 +758,9 @@ static int handle_commit_msg(struct mailinfo *mi, struct strbuf *line)
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
@@ -842,7 +842,7 @@ again:
 
 	/* slurp in this section's info */
 	while (read_one_header_line(line, mi->input))
-		check_header(mi, line, p_hdr_data, 0);
+		check_header(mi, line, mi->p_hdr_data, 0);
 
 	strbuf_release(&newline);
 	/* replenish line */
@@ -943,10 +943,10 @@ static void handle_info(struct mailinfo *mi)
 
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
 
@@ -986,8 +986,8 @@ static int mailinfo(struct mailinfo *mi, const char *msg, const char *patch)
 		return -1;
 	}
 
-	p_hdr_data = xcalloc(MAX_HDR_PARSED, sizeof(*p_hdr_data));
-	s_hdr_data = xcalloc(MAX_HDR_PARSED, sizeof(*s_hdr_data));
+	mi->p_hdr_data = xcalloc(MAX_HDR_PARSED, sizeof(*(mi->p_hdr_data)));
+	mi->s_hdr_data = xcalloc(MAX_HDR_PARSED, sizeof(*(mi->s_hdr_data)));
 
 	do {
 		peek = fgetc(mi->input);
@@ -996,7 +996,7 @@ static int mailinfo(struct mailinfo *mi, const char *msg, const char *patch)
 
 	/* process the email header */
 	while (read_one_header_line(&line, mi->input))
-		check_header(mi, &line, p_hdr_data, 1);
+		check_header(mi, &line, mi->p_hdr_data, 1);
 
 	handle_body(mi, &line);
 	fclose(mi->patchfile);
@@ -1033,10 +1033,19 @@ static void setup_mailinfo(struct mailinfo *mi)
 
 static void clear_mailinfo(struct mailinfo *mi)
 {
+	int i;
+
 	strbuf_release(&mi->name);
 	strbuf_release(&mi->email);
 	strbuf_release(&mi->charset);
 	free(mi->message_id);
+
+	for (i = 0; mi->p_hdr_data[i]; i++)
+		strbuf_release(mi->p_hdr_data[i]);
+	free(mi->p_hdr_data);
+	for (i = 0; mi->s_hdr_data[i]; i++)
+		strbuf_release(mi->s_hdr_data[i]);
+	free(mi->s_hdr_data);
 }
 
 static const char mailinfo_usage[] =
-- 
2.6.2-383-g144b2e6
