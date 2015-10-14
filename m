From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 06/31] mailinfo: get rid of function-local static states
Date: Wed, 14 Oct 2015 13:45:32 -0700
Message-ID: <1444855557-2127-7-git-send-email-gitster@pobox.com>
References: <1444778207-859-1-git-send-email-gitster@pobox.com>
 <1444855557-2127-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 14 22:47:44 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZmSxb-0002bU-0R
	for gcvg-git-2@plane.gmane.org; Wed, 14 Oct 2015 22:47:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932864AbbJNUqa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Oct 2015 16:46:30 -0400
Received: from mail-pa0-f46.google.com ([209.85.220.46]:36405 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932308AbbJNUqH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Oct 2015 16:46:07 -0400
Received: by pabws5 with SMTP id ws5so145162pab.3
        for <git@vger.kernel.org>; Wed, 14 Oct 2015 13:46:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:subject:date:message-id:in-reply-to:references;
        bh=Rh7K7oBzk6fOyBWsY/foSw+efJwUfM7/bgREQwr9lAQ=;
        b=IqV5DQ9j9gPZjuMJ+gym8Lwqr4FWhEpQNHOzX9A/0/S77+vi2cHdMQjCcgJi4njhvL
         pcC3GbDpFcYXMMqY+Sl8ZxEMnf4X3OChrAq8lVJW0zhfLPY95aRqWj7H03Jx35wkSEPy
         7aKVWFIsBX50ntfG2I0zt2S5nrrZQYnYMLBJ2RuKOOt3wGkHw9T8gNFmVNcytr7cfiPo
         c3jlKBY2j+pvQVOdaP8nmNj6pXxePyZ101KYIcEU2YO2DZEk7EsUSTbCne/iE9x6YgOo
         f5fW2KiRUnfANjJG7DPAOBm8R5Ynq0mvtq6eXMf3PKqjA6ksBHkjrgotw70qHX44yUix
         d+8w==
X-Received: by 10.66.141.42 with SMTP id rl10mr5758420pab.18.1444855566768;
        Wed, 14 Oct 2015 13:46:06 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:7964:41eb:7b4:cd77])
        by smtp.gmail.com with ESMTPSA id bo5sm11261873pbb.76.2015.10.14.13.46.05
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 14 Oct 2015 13:46:06 -0700 (PDT)
X-Mailer: git-send-email 2.6.1-320-g86a1181
In-Reply-To: <1444855557-2127-1-git-send-email-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279613>

Two helper functions use "static int" in their scope to keep track
of the state while repeatedly getting called once for each input
line.  Move these state variables their ultimate caller and pass
down pointers to them, as a small step in preparation for making
this entire callchain more reentrant.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/mailinfo.c | 41 +++++++++++++++++++----------------------
 1 file changed, 19 insertions(+), 22 deletions(-)

diff --git a/builtin/mailinfo.c b/builtin/mailinfo.c
index 2b7f97b..1518708 100644
--- a/builtin/mailinfo.c
+++ b/builtin/mailinfo.c
@@ -713,27 +713,25 @@ static int is_scissors_line(const struct strbuf *line)
 		gap * 2 < perforation);
 }
 
-static int handle_commit_msg(struct strbuf *line)
+static int handle_commit_msg(struct strbuf *line, int *still_looking)
 {
-	static int still_looking = 1;
-
 	if (!cmitmsg)
 		return 0;
 
-	if (still_looking) {
+	if (*still_looking) {
 		if (!line->len || (line->len == 1 && line->buf[0] == '\n'))
 			return 0;
 	}
 
-	if (use_inbody_headers && still_looking) {
-		still_looking = check_header(line, s_hdr_data, 0);
-		if (still_looking)
+	if (use_inbody_headers && *still_looking) {
+		*still_looking = check_header(line, s_hdr_data, 0);
+		if (*still_looking)
 			return 0;
 	} else
 		/* Only trim the first (blank) line of the commit message
 		 * when ignoring in-body headers.
 		 */
-		still_looking = 0;
+		*still_looking = 0;
 
 	/* normalize the log message to UTF-8. */
 	if (metainfo_charset)
@@ -745,7 +743,7 @@ static int handle_commit_msg(struct strbuf *line)
 			die_errno("Could not rewind output message file");
 		if (ftruncate(fileno(cmitmsg), 0))
 			die_errno("Could not truncate output message file at scissors");
-		still_looking = 1;
+		*still_looking = 1;
 
 		/*
 		 * We may have already read "secondary headers"; purge
@@ -777,16 +775,13 @@ static void handle_patch(const struct strbuf *line)
 	patch_lines++;
 }
 
-static void handle_filter(struct strbuf *line)
+static void handle_filter(struct strbuf *line, int *filter_stage, int *header_stage)
 {
-	static int filter = 0;
-
-	/* filter tells us which part we left off on */
-	switch (filter) {
+	switch (*filter_stage) {
 	case 0:
-		if (!handle_commit_msg(line))
+		if (!handle_commit_msg(line, header_stage))
 			break;
-		filter++;
+		(*filter_stage)++;
 	case 1:
 		handle_patch(line);
 		break;
@@ -802,7 +797,7 @@ static int find_boundary(void)
 	return 0;
 }
 
-static int handle_boundary(void)
+static int handle_boundary(int *filter_stage, int *header_stage)
 {
 	struct strbuf newline = STRBUF_INIT;
 
@@ -824,7 +819,7 @@ again:
 					"can't recover\n");
 			exit(1);
 		}
-		handle_filter(&newline);
+		handle_filter(&newline, filter_stage, header_stage);
 		strbuf_release(&newline);
 
 		/* skip to the next boundary */
@@ -852,6 +847,8 @@ again:
 static void handle_body(void)
 {
 	struct strbuf prev = STRBUF_INIT;
+	int filter_stage = 0;
+	int header_stage = 1;
 
 	/* Skip up to the first boundary */
 	if (*content_top) {
@@ -864,10 +861,10 @@ static void handle_body(void)
 		if (*content_top && is_multipart_boundary(&line)) {
 			/* flush any leftover */
 			if (prev.len) {
-				handle_filter(&prev);
+				handle_filter(&prev, &filter_stage, &header_stage);
 				strbuf_reset(&prev);
 			}
-			if (!handle_boundary())
+			if (!handle_boundary(&filter_stage, &header_stage))
 				goto handle_body_out;
 		}
 
@@ -897,7 +894,7 @@ static void handle_body(void)
 						strbuf_addbuf(&prev, sb);
 						break;
 					}
-				handle_filter(sb);
+				handle_filter(sb, &filter_stage, &header_stage);
 			}
 			/*
 			 * The partial chunk is saved in "prev" and will be
@@ -907,7 +904,7 @@ static void handle_body(void)
 			break;
 		}
 		default:
-			handle_filter(&line);
+			handle_filter(&line, &filter_stage, &header_stage);
 		}
 
 	} while (!strbuf_getwholeline(&line, fin, '\n'));
-- 
2.6.1-320-g86a1181
