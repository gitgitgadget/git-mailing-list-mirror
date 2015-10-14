From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 14/31] mailinfo: move add_message_id and message_id to struct mailinfo
Date: Wed, 14 Oct 2015 13:45:40 -0700
Message-ID: <1444855557-2127-15-git-send-email-gitster@pobox.com>
References: <1444778207-859-1-git-send-email-gitster@pobox.com>
 <1444855557-2127-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 14 22:47:22 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZmSxF-0002Kx-PZ
	for gcvg-git-2@plane.gmane.org; Wed, 14 Oct 2015 22:47:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932912AbbJNUqi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Oct 2015 16:46:38 -0400
Received: from mail-pa0-f52.google.com ([209.85.220.52]:36546 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932424AbbJNUqR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Oct 2015 16:46:17 -0400
Received: by pabws5 with SMTP id ws5so148724pab.3
        for <git@vger.kernel.org>; Wed, 14 Oct 2015 13:46:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:subject:date:message-id:in-reply-to:references;
        bh=MW2ExirhPaUTim67u97lE0i0UU4nDsQkRi045nNa3XA=;
        b=Gf2qcwvQbsV0LCImODY5olKYvbLFbW1uYhZ6aJC0kd5fKyaC8rNl1v7qEkR5bNhLkX
         0wVovBOcJVIvZdzHwacbdYGDwetrJQ8W9oz/3Zd/aitwEkvJsmPxBNSQKkP9Fs8QjBdK
         /EgnqgN7Yt+qeIul4RjkhNUe2eEe+YDK25isgplFqh2zpCGHfQqQypPHgWGtcCGSx0bI
         Ruv0YCJ3Cm0CeUYI8t0p280K7tOf1PfRd6hyB9sYv47mucNpNKzyesPLTmfoDuO8c9yi
         T7zFPM1HLuI7CxsHxq3EvIuPw4qiZ+27XvZNUii10HR5lq6W7wzDNbhMmpXeHKN1Vhga
         501w==
X-Received: by 10.66.216.1 with SMTP id om1mr5719914pac.51.1444855576820;
        Wed, 14 Oct 2015 13:46:16 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:7964:41eb:7b4:cd77])
        by smtp.gmail.com with ESMTPSA id pc8sm11289603pbc.27.2015.10.14.13.46.16
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 14 Oct 2015 13:46:16 -0700 (PDT)
X-Mailer: git-send-email 2.6.1-320-g86a1181
In-Reply-To: <1444855557-2127-1-git-send-email-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279606>

This requires us to pass the structure into check_header() codepath.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/mailinfo.c | 30 ++++++++++++++++--------------
 1 file changed, 16 insertions(+), 14 deletions(-)

diff --git a/builtin/mailinfo.c b/builtin/mailinfo.c
index f451ba4..6703453 100644
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
@@ -1050,7 +1052,7 @@ int cmd_mailinfo(int argc, const char **argv, const char *prefix)
 		else if (!strcmp(argv[1], "-b"))
 			mi.keep_non_patch_brackets_in_subject = 1;
 		else if (!strcmp(argv[1], "-m") || !strcmp(argv[1], "--message-id"))
-			add_message_id = 1;
+			mi.add_message_id = 1;
 		else if (!strcmp(argv[1], "-u"))
 			metainfo_charset = def_charset;
 		else if (!strcmp(argv[1], "-n"))
-- 
2.6.1-320-g86a1181
