From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 05/26] mailinfo: get rid of function-local static states
Date: Tue, 13 Oct 2015 16:16:26 -0700
Message-ID: <1444778207-859-6-git-send-email-gitster@pobox.com>
References: <1444778207-859-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 14 01:18:15 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zm8ph-00079E-I5
	for gcvg-git-2@plane.gmane.org; Wed, 14 Oct 2015 01:18:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753336AbbJMXRQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Oct 2015 19:17:16 -0400
Received: from mail-pa0-f42.google.com ([209.85.220.42]:35949 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752121AbbJMXQ4 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Oct 2015 19:16:56 -0400
Received: by pacex6 with SMTP id ex6so34347931pac.3
        for <git@vger.kernel.org>; Tue, 13 Oct 2015 16:16:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:subject:date:message-id:in-reply-to:references;
        bh=OuwoemQqH3hcdf69c/7JycpskUWz+6ufi5rdFb7HS98=;
        b=KuHDjVkepVQFIaAUZXZ328M9pHtn6ze8wOtYFJ/IsRIaL+4vQnzP/yo9G3i/cK4AVY
         v2JFbiQfVnRK+lmLcAsQae5QIb73dTumxFTOht4FS+mbsTINsUBaVErnvegvXYcxY6Jv
         o85+Seyx2vO07GeMvKvHEfm3nh+DcdsMhcYVS1jLav4VMrbyTp1NURxYHPxLwC5vjpFw
         FWD1Mg85Di3E9lS8zDg1V5M8I2WQpglnBa4sy0xcyvuB83DNMfgtrjV0kvdZB+yGTwbh
         tYnvM5Ds1GuH7KZnLHfZ8GiukfvViNWfdAmekGXkvoYdatyMg4hG1r9UAHbn8ss5xMXz
         EVkA==
X-Received: by 10.66.157.3 with SMTP id wi3mr17798pab.17.1444778216130;
        Tue, 13 Oct 2015 16:16:56 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:45f3:915b:d2ba:37bc])
        by smtp.gmail.com with ESMTPSA id k10sm5815264pbq.78.2015.10.13.16.16.55
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 13 Oct 2015 16:16:55 -0700 (PDT)
X-Mailer: git-send-email 2.6.1-320-g86a1181
In-Reply-To: <1444778207-859-1-git-send-email-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279550>

Two helper functions use "static int" in their scope to keep track
of the state while repeatedly getting called once for each input
line.  Move these state variables their ultimate caller and pass
down pointers to them, as a small step in preparation for making
this entire callchain more reentrant.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/mailinfo.c | 48 +++++++++++++++++++++++-------------------------
 1 file changed, 23 insertions(+), 25 deletions(-)

diff --git a/builtin/mailinfo.c b/builtin/mailinfo.c
index 175c6ae..5a74811 100644
--- a/builtin/mailinfo.c
+++ b/builtin/mailinfo.c
@@ -713,21 +713,20 @@ static int is_scissors_line(const struct strbuf *line)
 		gap * 2 < perforation);
 }
 
-static int handle_commit_msg(struct strbuf *line)
+static int handle_commit_msg(struct strbuf *line, int *still_looking)
 {
 	/*
 	 * Are we still scanning and discarding in-body headers?
 	 * It is initially set to 1, set to 2 when we do see a
 	 * valid in-body header.
 	 */
-	static int still_looking = 1;
 	int is_empty_line;
 
 	if (!cmitmsg)
 		return 0;
 
 	is_empty_line = (!line->len || (line->len == 1 && line->buf[0] == '\n'));
-	if (still_looking == 1) {
+	if (*still_looking == 1) {
 		/*
 		 * Haven't seen a known in-body header; discard an empty line.
 		 */
@@ -735,33 +734,33 @@ static int handle_commit_msg(struct strbuf *line)
 			return 0;
 	}
 
-	if (use_inbody_headers && still_looking) {
+	if (use_inbody_headers && *still_looking) {
 		int is_known_header = check_header(line, s_hdr_data, 0);
 
-		if (still_looking == 2) {
+		if (*still_looking == 2) {
 			/*
 			 * an empty line after the in-body header block,
 			 * or a line obviously not an attempt to invent
 			 * an unsupported in-body header.
 			 */
 			if (is_empty_line || !is_rfc2822_header(line))
-				still_looking = 0;
+				*still_looking = 0;
 			if (is_empty_line)
 				return 0;
 			/* otherwise do not discard the line, but keep going */
 		} else if (is_known_header) {
-			still_looking = 2;
-		} else if (still_looking != 2) {
-			still_looking = 0;
+			*still_looking = 2;
+		} else if (*still_looking != 2) {
+			*still_looking = 0;
 		}
 
-		if (still_looking)
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
@@ -773,7 +772,7 @@ static int handle_commit_msg(struct strbuf *line)
 			die_errno("Could not rewind output message file");
 		if (ftruncate(fileno(cmitmsg), 0))
 			die_errno("Could not truncate output message file at scissors");
-		still_looking = 1;
+		*still_looking = 1;
 
 		/*
 		 * We may have already read "secondary headers"; purge
@@ -805,16 +804,13 @@ static void handle_patch(const struct strbuf *line)
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
@@ -830,7 +826,7 @@ static int find_boundary(void)
 	return 0;
 }
 
-static int handle_boundary(void)
+static int handle_boundary(int *filter_stage, int *header_stage)
 {
 	struct strbuf newline = STRBUF_INIT;
 
@@ -852,7 +848,7 @@ again:
 					"can't recover\n");
 			exit(1);
 		}
-		handle_filter(&newline);
+		handle_filter(&newline, filter_stage, header_stage);
 		strbuf_release(&newline);
 
 		/* skip to the next boundary */
@@ -880,6 +876,8 @@ again:
 static void handle_body(void)
 {
 	struct strbuf prev = STRBUF_INIT;
+	int filter_stage = 0;
+	int header_stage = 1;
 
 	/* Skip up to the first boundary */
 	if (*content_top) {
@@ -892,10 +890,10 @@ static void handle_body(void)
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
 
@@ -925,7 +923,7 @@ static void handle_body(void)
 						strbuf_addbuf(&prev, sb);
 						break;
 					}
-				handle_filter(sb);
+				handle_filter(sb, &filter_stage, &header_stage);
 			}
 			/*
 			 * The partial chunk is saved in "prev" and will be
@@ -935,7 +933,7 @@ static void handle_body(void)
 			break;
 		}
 		default:
-			handle_filter(&line);
+			handle_filter(&line, &filter_stage, &header_stage);
 		}
 
 	} while (!strbuf_getwholeline(&line, fin, '\n'));
-- 
2.6.1-320-g86a1181
