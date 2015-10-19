From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 16/34] mailinfo: move add_message_id and message_id to struct mailinfo
Date: Mon, 19 Oct 2015 00:28:33 -0700
Message-ID: <1445239731-10677-17-git-send-email-gitster@pobox.com>
References: <1444855557-2127-1-git-send-email-gitster@pobox.com>
 <1445239731-10677-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 19 09:29:27 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zo4so-0002f8-LD
	for gcvg-git-2@plane.gmane.org; Mon, 19 Oct 2015 09:29:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752877AbbJSH3R (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Oct 2015 03:29:17 -0400
Received: from mail-pa0-f48.google.com ([209.85.220.48]:32792 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752827AbbJSH3O (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Oct 2015 03:29:14 -0400
Received: by pabrc13 with SMTP id rc13so182997625pab.0
        for <git@vger.kernel.org>; Mon, 19 Oct 2015 00:29:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:subject:date:message-id:in-reply-to:references;
        bh=ZLUn/cc69SacRNZcixS2rXwcIfQWmXUpnt8fI7Z/wdU=;
        b=0Lppixxfb6BmIk76Smx+Gj44EqxY2ImD1ES82LXxscQFOFF7I1R1mkSyRtvmLxCJkd
         m9Z4xztCyrBaTH0kQmmxGTszBtf4YddEiDukhbUcYf59zk6RWfvcBQg1CV0K+1giBJWn
         mBCVWGXPWnAdpSQWiYMpd8BlKA9udj6qnrLru3KaTUV3qIJoKkKkeScpSfFOtm3WzCDn
         e89+MFyk7L+M7+BiPfVo04gzyQr9Lz9aXVkZr0LYUdy0iRfOnzzmtx/RA4EFBJ6GVUU0
         +aReOj6dUvPaaJ7b8TwxEA84jGnGLcSepQIbG2bKf6gK7Ia2lIBNMlLKFs5zRkp2XfWE
         TM4w==
X-Received: by 10.67.30.74 with SMTP id kc10mr32359829pad.147.1445239753256;
        Mon, 19 Oct 2015 00:29:13 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:f5db:ee54:4f5:9373])
        by smtp.gmail.com with ESMTPSA id yg2sm34443541pbb.79.2015.10.19.00.29.12
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 19 Oct 2015 00:29:12 -0700 (PDT)
X-Mailer: git-send-email 2.6.2-388-g10c4a0e
In-Reply-To: <1445239731-10677-1-git-send-email-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279840>

This requires us to pass the structure into check_header() codepath.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/mailinfo.c | 31 +++++++++++++++++--------------
 1 file changed, 17 insertions(+), 14 deletions(-)

diff --git a/builtin/mailinfo.c b/builtin/mailinfo.c
index 8bd76c6..c0522f2 100644
--- a/builtin/mailinfo.c
+++ b/builtin/mailinfo.c
@@ -19,12 +19,13 @@ struct mailinfo {
 	struct strbuf email;
 	int keep_subject;
 	int keep_non_patch_brackets_in_subject;
+	int add_message_id;
 
+	char *message_id;
 	int patch_lines;
 	int filter_stage; /* still reading log or are we copying patch? */
 	int header_stage; /* still checking in-body headers? */
 };
-static char *message_id;
 
 static enum  {
 	TE_DONTCARE, TE_QP, TE_BASE64
@@ -34,7 +35,6 @@ static struct strbuf charset = STRBUF_INIT;
 
 static struct strbuf **p_hdr_data, **s_hdr_data;
 static int use_scissors;
-static int add_message_id;
 static int use_inbody_headers = 1;
 
 #define MAX_HDR_PARSED 10
@@ -209,10 +209,10 @@ static void handle_content_type(struct strbuf *line)
 	}
 }
 
-static void handle_message_id(const struct strbuf *line)
+static void handle_message_id(struct mailinfo *mi, const struct strbuf *line)
 {
-	if (add_message_id)
-		message_id = strdup(line->buf);
+	if (mi->add_message_id)
+		mi->message_id = strdup(line->buf);
 }
 
 static void handle_content_transfer_encoding(const struct strbuf *line)
@@ -321,11 +321,13 @@ static int is_format_patch_separator(const char *line, int len)
 	return !memcmp(SAMPLE + (cp - line), cp, strlen(SAMPLE) - (cp - line));
 }
 
-static int check_header(const struct strbuf *line,
-				struct strbuf *hdr_data[], int overwrite)
+static int check_header(struct mailinfo *mi,
+			const struct strbuf *line,
+			struct strbuf *hdr_data[], int overwrite)
 {
 	int i, ret = 0, len;
 	struct strbuf sb = STRBUF_INIT;
+
 	/* search for the interesting parts */
 	for (i = 0; header[i]; i++) {
 		int len = strlen(header[i]);
@@ -363,7 +365,7 @@ static int check_header(const struct strbuf *line,
 		len = strlen("Message-Id: ");
 		strbuf_add(&sb, line->buf + len, line->len - len);
 		decode_header(&sb);
-		handle_message_id(&sb);
+		handle_message_id(mi, &sb);
 		ret = 1;
 		goto check_header_out;
 	}
@@ -733,7 +735,7 @@ static int handle_commit_msg(struct mailinfo *mi, struct strbuf *line)
 	}
 
 	if (use_inbody_headers && mi->header_stage) {
-		mi->header_stage = check_header(line, s_hdr_data, 0);
+		mi->header_stage = check_header(mi, line, s_hdr_data, 0);
 		if (mi->header_stage)
 			return 0;
 	} else
@@ -767,8 +769,8 @@ static int handle_commit_msg(struct mailinfo *mi, struct strbuf *line)
 	}
 
 	if (patchbreak(line)) {
-		if (message_id)
-			fprintf(cmitmsg, "Message-Id: %s\n", message_id);
+		if (mi->message_id)
+			fprintf(cmitmsg, "Message-Id: %s\n", mi->message_id);
 		fclose(cmitmsg);
 		cmitmsg = NULL;
 		return 1;
@@ -843,7 +845,7 @@ again:
 
 	/* slurp in this section's info */
 	while (read_one_header_line(line, mi->input))
-		check_header(line, p_hdr_data, 0);
+		check_header(mi, line, p_hdr_data, 0);
 
 	strbuf_release(&newline);
 	/* replenish line */
@@ -997,7 +999,7 @@ static int mailinfo(struct mailinfo *mi, const char *msg, const char *patch)
 
 	/* process the email header */
 	while (read_one_header_line(&line, mi->input))
-		check_header(&line, p_hdr_data, 1);
+		check_header(mi, &line, p_hdr_data, 1);
 
 	handle_body(mi, &line);
 	fclose(patchfile);
@@ -1032,6 +1034,7 @@ static void clear_mailinfo(struct mailinfo *mi)
 {
 	strbuf_release(&mi->name);
 	strbuf_release(&mi->email);
+	free(mi->message_id);
 }
 
 static const char mailinfo_usage[] =
@@ -1057,7 +1060,7 @@ int cmd_mailinfo(int argc, const char **argv, const char *prefix)
 		else if (!strcmp(argv[1], "-b"))
 			mi.keep_non_patch_brackets_in_subject = 1;
 		else if (!strcmp(argv[1], "-m") || !strcmp(argv[1], "--message-id"))
-			add_message_id = 1;
+			mi.add_message_id = 1;
 		else if (!strcmp(argv[1], "-u"))
 			metainfo_charset = def_charset;
 		else if (!strcmp(argv[1], "-n"))
-- 
2.6.2-383-g144b2e6
