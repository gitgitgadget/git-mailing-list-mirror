From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 15/26] mailinfo: move metainfo_charset to struct mailinfo
Date: Tue, 13 Oct 2015 16:16:36 -0700
Message-ID: <1444778207-859-16-git-send-email-gitster@pobox.com>
References: <1444778207-859-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 14 01:17:47 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zm8pC-0006XH-RL
	for gcvg-git-2@plane.gmane.org; Wed, 14 Oct 2015 01:17:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753379AbbJMXRd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Oct 2015 19:17:33 -0400
Received: from mail-pa0-f45.google.com ([209.85.220.45]:34816 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752583AbbJMXRH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Oct 2015 19:17:07 -0400
Received: by padcn9 with SMTP id cn9so3397760pad.2
        for <git@vger.kernel.org>; Tue, 13 Oct 2015 16:17:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:subject:date:message-id:in-reply-to:references;
        bh=/FQYHgB2/5jOF27lmlEZvmHaOUvdO1R/U1oMVnXtwbc=;
        b=AMvCAhKtGXHGwPeevJ993LuhRv3Zk+eZr11FA5lftauJ1Eo8TPh/XxPQCF0I7QbbJ6
         MconU8YaUM4X2+FHVY+9W7h+ese98X4SaovsJDjtcfrWwtcfYdiWjrkrtnqn/L/DPMbR
         VZ7TlwxDa/U9DP/VH67QwpQSbDjgfrzPYK7BervqlomA+08BfPscfnJdQ2CTVbRwXell
         6oth0zYVj9j0shPRNgdeqikzDxg3AOTM5rKBspsu687QWiqHYUbL4McpNxEEe5/Wekdp
         u8B82fZuevGi+abZQ6j0s1W/g8IckqU5xcbhvfo8Y+pZHWLi1tPwZG1J+kYRenThHYRn
         n/jw==
X-Received: by 10.67.1.73 with SMTP id be9mr11830pad.35.1444778226961;
        Tue, 13 Oct 2015 16:17:06 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:45f3:915b:d2ba:37bc])
        by smtp.gmail.com with ESMTPSA id qd5sm5820962pbc.73.2015.10.13.16.17.06
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 13 Oct 2015 16:17:06 -0700 (PDT)
X-Mailer: git-send-email 2.6.1-320-g86a1181
In-Reply-To: <1444778207-859-1-git-send-email-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279540>

This requires us to pass the struct down to decode_header() and
convert_to_utf8() callchain.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/mailinfo.c | 40 +++++++++++++++++++---------------------
 1 file changed, 19 insertions(+), 21 deletions(-)

diff --git a/builtin/mailinfo.c b/builtin/mailinfo.c
index 5302c03..7e01efa 100644
--- a/builtin/mailinfo.c
+++ b/builtin/mailinfo.c
@@ -9,8 +9,6 @@
 
 static FILE *cmitmsg, *patchfile;
 
-static const char *metainfo_charset;
-
 struct mailinfo {
 	FILE *input;
 	FILE *output;
@@ -22,6 +20,7 @@ struct mailinfo {
 	int add_message_id;
 	int use_scissors;
 	int use_inbody_headers; /* defaults to 1 */
+	const char *metainfo_charset;
 
 	char *message_id;
 	int patch_lines;
@@ -293,7 +292,7 @@ static void cleanup_space(struct strbuf *sb)
 	}
 }
 
-static void decode_header(struct strbuf *line);
+static void decode_header(struct mailinfo *mi, struct strbuf *line);
 static const char *header[MAX_HDR_PARSED] = {
 	"From","Subject","Date",
 };
@@ -336,7 +335,7 @@ static int check_header(struct mailinfo *mi,
 			 * normalize the meta information to utf8.
 			 */
 			strbuf_add(&sb, line->buf + len + 2, line->len - len - 2);
-			decode_header(&sb);
+			decode_header(mi, &sb);
 			handle_header(&hdr_data[i], &sb);
 			ret = 1;
 			goto check_header_out;
@@ -347,7 +346,7 @@ static int check_header(struct mailinfo *mi,
 	if (cmp_header(line, "Content-Type")) {
 		len = strlen("Content-Type: ");
 		strbuf_add(&sb, line->buf + len, line->len - len);
-		decode_header(&sb);
+		decode_header(mi, &sb);
 		strbuf_insert(&sb, 0, "Content-Type: ", len);
 		handle_content_type(&sb);
 		ret = 1;
@@ -356,7 +355,7 @@ static int check_header(struct mailinfo *mi,
 	if (cmp_header(line, "Content-Transfer-Encoding")) {
 		len = strlen("Content-Transfer-Encoding: ");
 		strbuf_add(&sb, line->buf + len, line->len - len);
-		decode_header(&sb);
+		decode_header(mi, &sb);
 		handle_content_transfer_encoding(&sb);
 		ret = 1;
 		goto check_header_out;
@@ -364,7 +363,7 @@ static int check_header(struct mailinfo *mi,
 	if (cmp_header(line, "Message-Id")) {
 		len = strlen("Message-Id: ");
 		strbuf_add(&sb, line->buf + len, line->len - len);
-		decode_header(&sb);
+		decode_header(mi, &sb);
 		handle_message_id(mi, &sb);
 		ret = 1;
 		goto check_header_out;
@@ -520,23 +519,24 @@ static struct strbuf *decode_b_segment(const struct strbuf *b_seg)
 	return out;
 }
 
-static void convert_to_utf8(struct strbuf *line, const char *charset)
+static void convert_to_utf8(struct mailinfo *mi,
+			    struct strbuf *line, const char *charset)
 {
 	char *out;
 
-	if (!charset || !*charset)
+	if (!mi->metainfo_charset || !charset || !*charset)
 		return;
 
-	if (same_encoding(metainfo_charset, charset))
+	if (same_encoding(mi->metainfo_charset, charset))
 		return;
-	out = reencode_string(line->buf, metainfo_charset, charset);
+	out = reencode_string(line->buf, mi->metainfo_charset, charset);
 	if (!out)
 		die("cannot convert from %s to %s",
-		    charset, metainfo_charset);
+		    charset, mi->metainfo_charset);
 	strbuf_attach(line, out, strlen(out), strlen(out));
 }
 
-static void decode_header(struct strbuf *it)
+static void decode_header(struct mailinfo *mi, struct strbuf *it)
 {
 	char *in, *ep, *cp;
 	struct strbuf outbuf = STRBUF_INIT, *dec;
@@ -599,8 +599,7 @@ static void decode_header(struct strbuf *it)
 			dec = decode_q_segment(&piecebuf, 1);
 			break;
 		}
-		if (metainfo_charset)
-			convert_to_utf8(dec, charset_q.buf);
+		convert_to_utf8(mi, dec, charset_q.buf);
 
 		strbuf_addbuf(&outbuf, dec);
 		strbuf_release(dec);
@@ -774,8 +773,7 @@ static int handle_commit_msg(struct mailinfo *mi, struct strbuf *line)
 		mi->header_stage = 0;
 
 	/* normalize the log message to UTF-8. */
-	if (metainfo_charset)
-		convert_to_utf8(line, charset.buf);
+	convert_to_utf8(mi, line, charset.buf);
 
 	if (mi->use_scissors && is_scissors_line(line)) {
 		int i;
@@ -1074,7 +1072,7 @@ int cmd_mailinfo(int argc, const char **argv, const char *prefix)
 	setup_mailinfo(&mi);
 
 	def_charset = get_commit_output_encoding();
-	metainfo_charset = def_charset;
+	mi.metainfo_charset = def_charset;
 
 	while (1 < argc && argv[1][0] == '-') {
 		if (!strcmp(argv[1], "-k"))
@@ -1084,11 +1082,11 @@ int cmd_mailinfo(int argc, const char **argv, const char *prefix)
 		else if (!strcmp(argv[1], "-m") || !strcmp(argv[1], "--message-id"))
 			mi.add_message_id = 1;
 		else if (!strcmp(argv[1], "-u"))
-			metainfo_charset = def_charset;
+			mi.metainfo_charset = def_charset;
 		else if (!strcmp(argv[1], "-n"))
-			metainfo_charset = NULL;
+			mi.metainfo_charset = NULL;
 		else if (starts_with(argv[1], "--encoding="))
-			metainfo_charset = argv[1] + 11;
+			mi.metainfo_charset = argv[1] + 11;
 		else if (!strcmp(argv[1], "--scissors"))
 			mi.use_scissors = 1;
 		else if (!strcmp(argv[1], "--no-scissors"))
-- 
2.6.1-320-g86a1181
