From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 14/34] mailinfo: move filter/header stage to struct mailinfo
Date: Mon, 19 Oct 2015 00:28:31 -0700
Message-ID: <1445239731-10677-15-git-send-email-gitster@pobox.com>
References: <1444855557-2127-1-git-send-email-gitster@pobox.com>
 <1445239731-10677-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 19 09:30:38 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zo4tx-0003Uj-9I
	for gcvg-git-2@plane.gmane.org; Mon, 19 Oct 2015 09:30:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753255AbbJSHab (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Oct 2015 03:30:31 -0400
Received: from mail-pa0-f46.google.com ([209.85.220.46]:35743 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750868AbbJSH3L (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Oct 2015 03:29:11 -0400
Received: by pasz6 with SMTP id z6so22260776pas.2
        for <git@vger.kernel.org>; Mon, 19 Oct 2015 00:29:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:subject:date:message-id:in-reply-to:references;
        bh=sAt33G2vbaNvviyz9gzO+CflLS4OZOcSdKk+6KF+S1Y=;
        b=vNVaBMJCzdm/LeuK4m/xsE7O5W/2RdujdWk5Sr1v1Qpg7C5bg53kGhGl7b6DDCrbqL
         b/0DVTtgPWRzUp+wjKhMisWfbRhyBseYIgcgKnCWgjPvTm+08O2/Uw79HgiavlZ/5lOQ
         UE0Gemqc+3jaQ8Va5o+cxp87aEaahKyOa6u5Qp51vJdUNhTld0UP+fz5q4+2cfsg3Izh
         aPnHvjbeXqR2pJy8HBeS+OOGxZWb5SqOaXCwpQX6uL62bQrXJug8sEBW/OTNIkobl+XE
         SoOpbehrreEs6kidk7SmOChN4nFP79VPOiTHPhEJInLVzPiP+/D1jR5MYGFW3yZXr3O/
         0WqQ==
X-Received: by 10.68.204.37 with SMTP id kv5mr32826285pbc.64.1445239750733;
        Mon, 19 Oct 2015 00:29:10 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:f5db:ee54:4f5:9373])
        by smtp.gmail.com with ESMTPSA id qy7sm34855914pab.37.2015.10.19.00.29.09
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 19 Oct 2015 00:29:10 -0700 (PDT)
X-Mailer: git-send-email 2.6.2-388-g10c4a0e
In-Reply-To: <1445239731-10677-1-git-send-email-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279859>

Earlier we got rid of two function-scope static variables that kept
track of the states of helper functions by making them extra arguments
that are passed throughout the callchain.  Now we have a convenient
place to store and pass them around in the form of "struct mailinfo",
change them into two fields in the struct.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/mailinfo.c | 42 ++++++++++++++++++++++--------------------
 1 file changed, 22 insertions(+), 20 deletions(-)

diff --git a/builtin/mailinfo.c b/builtin/mailinfo.c
index b150936..5823ae5 100644
--- a/builtin/mailinfo.c
+++ b/builtin/mailinfo.c
@@ -19,6 +19,9 @@ struct mailinfo {
 	struct strbuf email;
 	int keep_subject;
 	int keep_non_patch_brackets_in_subject;
+
+	int filter_stage; /* still reading log or are we copying patch? */
+	int header_stage; /* still checking in-body headers? */
 };
 static char *message_id;
 
@@ -28,6 +31,7 @@ static enum  {
 
 static struct strbuf charset = STRBUF_INIT;
 static int patch_lines;
+
 static struct strbuf **p_hdr_data, **s_hdr_data;
 static int use_scissors;
 static int add_message_id;
@@ -718,25 +722,25 @@ static int is_scissors_line(const struct strbuf *line)
 		gap * 2 < perforation);
 }
 
-static int handle_commit_msg(struct strbuf *line, int *still_looking)
+static int handle_commit_msg(struct mailinfo *mi, struct strbuf *line)
 {
 	if (!cmitmsg)
 		return 0;
 
-	if (*still_looking) {
+	if (mi->header_stage) {
 		if (!line->len || (line->len == 1 && line->buf[0] == '\n'))
 			return 0;
 	}
 
-	if (use_inbody_headers && *still_looking) {
-		*still_looking = check_header(line, s_hdr_data, 0);
-		if (*still_looking)
+	if (use_inbody_headers && mi->header_stage) {
+		mi->header_stage = check_header(line, s_hdr_data, 0);
+		if (mi->header_stage)
 			return 0;
 	} else
 		/* Only trim the first (blank) line of the commit message
 		 * when ignoring in-body headers.
 		 */
-		*still_looking = 0;
+		mi->header_stage = 0;
 
 	/* normalize the log message to UTF-8. */
 	if (metainfo_charset)
@@ -748,7 +752,7 @@ static int handle_commit_msg(struct strbuf *line, int *still_looking)
 			die_errno("Could not rewind output message file");
 		if (ftruncate(fileno(cmitmsg), 0))
 			die_errno("Could not truncate output message file at scissors");
-		*still_looking = 1;
+		mi->header_stage = 1;
 
 		/*
 		 * We may have already read "secondary headers"; purge
@@ -780,13 +784,13 @@ static void handle_patch(const struct strbuf *line)
 	patch_lines++;
 }
 
-static void handle_filter(struct strbuf *line, int *filter_stage, int *header_stage)
+static void handle_filter(struct mailinfo *mi, struct strbuf *line)
 {
-	switch (*filter_stage) {
+	switch (mi->filter_stage) {
 	case 0:
-		if (!handle_commit_msg(line, header_stage))
+		if (!handle_commit_msg(mi, line))
 			break;
-		(*filter_stage)++;
+		mi->filter_stage++;
 	case 1:
 		handle_patch(line);
 		break;
@@ -802,8 +806,7 @@ static int find_boundary(struct mailinfo *mi, struct strbuf *line)
 	return 0;
 }
 
-static int handle_boundary(struct mailinfo *mi, struct strbuf *line,
-			   int *filter_stage, int *header_stage)
+static int handle_boundary(struct mailinfo *mi, struct strbuf *line)
 {
 	struct strbuf newline = STRBUF_INIT;
 
@@ -825,7 +828,7 @@ again:
 					"can't recover\n");
 			exit(1);
 		}
-		handle_filter(&newline, filter_stage, header_stage);
+		handle_filter(mi, &newline);
 		strbuf_release(&newline);
 
 		/* skip to the next boundary */
@@ -853,8 +856,6 @@ again:
 static void handle_body(struct mailinfo *mi, struct strbuf *line)
 {
 	struct strbuf prev = STRBUF_INIT;
-	int filter_stage = 0;
-	int header_stage = 1;
 
 	/* Skip up to the first boundary */
 	if (*content_top) {
@@ -867,10 +868,10 @@ static void handle_body(struct mailinfo *mi, struct strbuf *line)
 		if (*content_top && is_multipart_boundary(line)) {
 			/* flush any leftover */
 			if (prev.len) {
-				handle_filter(&prev, &filter_stage, &header_stage);
+				handle_filter(mi, &prev);
 				strbuf_reset(&prev);
 			}
-			if (!handle_boundary(mi, line, &filter_stage, &header_stage))
+			if (!handle_boundary(mi, line))
 				goto handle_body_out;
 		}
 
@@ -900,7 +901,7 @@ static void handle_body(struct mailinfo *mi, struct strbuf *line)
 						strbuf_addbuf(&prev, sb);
 						break;
 					}
-				handle_filter(sb, &filter_stage, &header_stage);
+				handle_filter(mi, sb);
 			}
 			/*
 			 * The partial chunk is saved in "prev" and will be
@@ -910,7 +911,7 @@ static void handle_body(struct mailinfo *mi, struct strbuf *line)
 			break;
 		}
 		default:
-			handle_filter(line, &filter_stage, &header_stage);
+			handle_filter(mi, line);
 		}
 
 	} while (!strbuf_getwholeline(line, mi->input, '\n'));
@@ -1023,6 +1024,7 @@ static void setup_mailinfo(struct mailinfo *mi)
 	memset(mi, 0, sizeof(*mi));
 	strbuf_init(&mi->name, 0);
 	strbuf_init(&mi->email, 0);
+	mi->header_stage = 1;
 	git_config(git_mailinfo_config, &mi);
 }
 
-- 
2.6.2-383-g144b2e6
