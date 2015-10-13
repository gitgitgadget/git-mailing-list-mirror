From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 11/26] mailinfo: move filter/header stage to struct mailinfo
Date: Tue, 13 Oct 2015 16:16:32 -0700
Message-ID: <1444778207-859-12-git-send-email-gitster@pobox.com>
References: <1444778207-859-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 14 01:17:30 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zm8oy-0006OA-RD
	for gcvg-git-2@plane.gmane.org; Wed, 14 Oct 2015 01:17:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753368AbbJMXRY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Oct 2015 19:17:24 -0400
Received: from mail-pa0-f43.google.com ([209.85.220.43]:36039 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752273AbbJMXRD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Oct 2015 19:17:03 -0400
Received: by pacex6 with SMTP id ex6so34350085pac.3
        for <git@vger.kernel.org>; Tue, 13 Oct 2015 16:17:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:subject:date:message-id:in-reply-to:references;
        bh=NahBPJCEiHVOU6RdFed05osDG9h+QvaVQ3gmM2E0LPE=;
        b=SbJ3lgMFLYIOEUX128jUSKxgeBUDTF+dVUiacta9bnK/dON5Mm+e2pv2gg9iwtiwNN
         IXMS87n8/x0dD9P0kbTKMhmdThCRaOZVfpznfveyY5v2V2uu2wXqUn4beeeNI+1v+Q9x
         Ws5iJktD/1cOJYQ3WP5dTOcKbSoewL3Fs1FmCH01D4PMkaIh04ndqSNyOgW1rJwQkFVg
         CdROxaSOtTfRDjwTmed1bAi8z4YA4qOQ8CAIQRdtd4egCQnoQku4acLdoATW7a9myPZG
         8LegA3rjPzmx2QMvHW1JNp+nNwXNQDdODTSA4cwUR5AA8duUcl/qZVBFYJnQNc6O69Zl
         P4yw==
X-Received: by 10.69.17.195 with SMTP id gg3mr24916pbd.166.1444778222657;
        Tue, 13 Oct 2015 16:17:02 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:45f3:915b:d2ba:37bc])
        by smtp.gmail.com with ESMTPSA id pf7sm5854777pbc.6.2015.10.13.16.17.02
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 13 Oct 2015 16:17:02 -0700 (PDT)
X-Mailer: git-send-email 2.6.1-320-g86a1181
In-Reply-To: <1444778207-859-1-git-send-email-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279534>

Earlier we got rid of two function-scope static variables that kept
track of the states of helper functions by making them extra arguments
that are passed throughout the callchain.  Now we have a convenient
place to store and pass them around in the form of "struct mailinfo",
change them into two fields in the struct.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/mailinfo.c | 50 ++++++++++++++++++++++++++------------------------
 1 file changed, 26 insertions(+), 24 deletions(-)

diff --git a/builtin/mailinfo.c b/builtin/mailinfo.c
index a9da338..7e39769 100644
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
@@ -718,7 +722,7 @@ static int is_scissors_line(const struct strbuf *line)
 		gap * 2 < perforation);
 }
 
-static int handle_commit_msg(struct strbuf *line, int *still_looking)
+static int handle_commit_msg(struct mailinfo *mi, struct strbuf *line)
 {
 	/*
 	 * Are we still scanning and discarding in-body headers?
@@ -731,7 +735,7 @@ static int handle_commit_msg(struct strbuf *line, int *still_looking)
 		return 0;
 
 	is_empty_line = (!line->len || (line->len == 1 && line->buf[0] == '\n'));
-	if (*still_looking == 1) {
+	if (mi->header_stage == 1) {
 		/*
 		 * Haven't seen a known in-body header; discard an empty line.
 		 */
@@ -739,33 +743,33 @@ static int handle_commit_msg(struct strbuf *line, int *still_looking)
 			return 0;
 	}
 
-	if (use_inbody_headers && *still_looking) {
+	if (use_inbody_headers && mi->header_stage) {
 		int is_known_header = check_header(line, s_hdr_data, 0);
 
-		if (*still_looking == 2) {
+		if (mi->header_stage == 2) {
 			/*
 			 * an empty line after the in-body header block,
 			 * or a line obviously not an attempt to invent
 			 * an unsupported in-body header.
 			 */
 			if (is_empty_line || !is_rfc2822_header(line))
-				*still_looking = 0;
+				mi->header_stage = 0;
 			if (is_empty_line)
 				return 0;
 			/* otherwise do not discard the line, but keep going */
 		} else if (is_known_header) {
-			*still_looking = 2;
-		} else if (*still_looking != 2) {
-			*still_looking = 0;
+			mi->header_stage = 2;
+		} else if (mi->header_stage != 2) {
+			mi->header_stage = 0;
 		}
 
-		if (*still_looking)
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
@@ -777,7 +781,7 @@ static int handle_commit_msg(struct strbuf *line, int *still_looking)
 			die_errno("Could not rewind output message file");
 		if (ftruncate(fileno(cmitmsg), 0))
 			die_errno("Could not truncate output message file at scissors");
-		*still_looking = 1;
+		mi->header_stage = 1;
 
 		/*
 		 * We may have already read "secondary headers"; purge
@@ -809,13 +813,13 @@ static void handle_patch(const struct strbuf *line)
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
@@ -831,8 +835,7 @@ static int find_boundary(struct mailinfo *mi, struct strbuf *line)
 	return 0;
 }
 
-static int handle_boundary(struct mailinfo *mi, struct strbuf *line,
-			   int *filter_stage, int *header_stage)
+static int handle_boundary(struct mailinfo *mi, struct strbuf *line)
 {
 	struct strbuf newline = STRBUF_INIT;
 
@@ -854,7 +857,7 @@ again:
 					"can't recover\n");
 			exit(1);
 		}
-		handle_filter(&newline, filter_stage, header_stage);
+		handle_filter(mi, &newline);
 		strbuf_release(&newline);
 
 		/* skip to the next boundary */
@@ -882,8 +885,6 @@ again:
 static void handle_body(struct mailinfo *mi, struct strbuf *line)
 {
 	struct strbuf prev = STRBUF_INIT;
-	int filter_stage = 0;
-	int header_stage = 1;
 
 	/* Skip up to the first boundary */
 	if (*content_top) {
@@ -896,10 +897,10 @@ static void handle_body(struct mailinfo *mi, struct strbuf *line)
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
 
@@ -929,7 +930,7 @@ static void handle_body(struct mailinfo *mi, struct strbuf *line)
 						strbuf_addbuf(&prev, sb);
 						break;
 					}
-				handle_filter(sb, &filter_stage, &header_stage);
+				handle_filter(mi, sb);
 			}
 			/*
 			 * The partial chunk is saved in "prev" and will be
@@ -939,7 +940,7 @@ static void handle_body(struct mailinfo *mi, struct strbuf *line)
 			break;
 		}
 		default:
-			handle_filter(line, &filter_stage, &header_stage);
+			handle_filter(mi, line);
 		}
 
 	} while (!strbuf_getwholeline(line, mi->input, '\n'));
@@ -1050,6 +1051,7 @@ static void setup_mailinfo(struct mailinfo *mi)
 	memset(mi, 0, sizeof(*mi));
 	strbuf_init(&mi->name, 0);
 	strbuf_init(&mi->email, 0);
+	mi->header_stage = 1;
 	git_config(git_mailinfo_config, &mi);
 }
 
-- 
2.6.1-320-g86a1181
