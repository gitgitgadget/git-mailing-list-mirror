From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 18/34] mailinfo: move metainfo_charset to struct mailinfo
Date: Mon, 19 Oct 2015 00:28:35 -0700
Message-ID: <1445239731-10677-19-git-send-email-gitster@pobox.com>
References: <1444855557-2127-1-git-send-email-gitster@pobox.com>
 <1445239731-10677-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 19 09:30:29 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zo4to-0003OY-1l
	for gcvg-git-2@plane.gmane.org; Mon, 19 Oct 2015 09:30:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752012AbbJSHaU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Oct 2015 03:30:20 -0400
Received: from mail-pa0-f54.google.com ([209.85.220.54]:36358 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752668AbbJSH3Q (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Oct 2015 03:29:16 -0400
Received: by pacfv9 with SMTP id fv9so86973507pac.3
        for <git@vger.kernel.org>; Mon, 19 Oct 2015 00:29:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:subject:date:message-id:in-reply-to:references;
        bh=zL9wSEOlOpwoXtxXOeyQnWJ3UsYq+gwIq7sla5r5yQc=;
        b=cKeRcyRHg1QpiNFYf4mYCE2nc/H/RtgV32smF/ZalcNuGs9pb1MLFcfZmWdBBorwH8
         /xoCflCkh2WLZLZVlTBwE6qzJXAYOZb/5SpOOqe+dLDWTxblbE1zpf5jrBv4wV8OZqob
         vPtcK8s1J9y03Nb1lDJuiw75NLolc4ojPle+mfnrUQSjTrgsXEQa+BJWUo+qCO4lGk23
         dffNMgKi39wJrmE7Jkt1hlUtShHDd3a6ZIh52lNwXRreAEio1Q+HVbQyARZSKfz0L4F+
         7g7XXsnjYoY/W3iv/Wv9EuhwxRgvoh9a/a/HDIwgcnrDfRZSMgEx/j0jVD4BjoTG+xGv
         J2Iw==
X-Received: by 10.66.190.41 with SMTP id gn9mr32988078pac.0.1445239755746;
        Mon, 19 Oct 2015 00:29:15 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:f5db:ee54:4f5:9373])
        by smtp.gmail.com with ESMTPSA id xd10sm34845220pab.25.2015.10.19.00.29.15
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 19 Oct 2015 00:29:15 -0700 (PDT)
X-Mailer: git-send-email 2.6.2-388-g10c4a0e
In-Reply-To: <1445239731-10677-1-git-send-email-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279858>

This requires us to pass the struct down to decode_header() and
convert_to_utf8() callchain.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/mailinfo.c | 40 ++++++++++++++++++++--------------------
 1 file changed, 20 insertions(+), 20 deletions(-)

diff --git a/builtin/mailinfo.c b/builtin/mailinfo.c
index 2c8f249..26fd9b1 100644
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
 
 	if (!charset || !*charset)
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
@@ -599,8 +599,8 @@ static void decode_header(struct strbuf *it)
 			dec = decode_q_segment(&piecebuf, 1);
 			break;
 		}
-		if (metainfo_charset)
-			convert_to_utf8(dec, charset_q.buf);
+		if (mi->metainfo_charset)
+			convert_to_utf8(mi, dec, charset_q.buf);
 
 		strbuf_addbuf(&outbuf, dec);
 		strbuf_release(dec);
@@ -745,8 +745,8 @@ static int handle_commit_msg(struct mailinfo *mi, struct strbuf *line)
 		mi->header_stage = 0;
 
 	/* normalize the log message to UTF-8. */
-	if (metainfo_charset)
-		convert_to_utf8(line, charset.buf);
+	if (mi->metainfo_charset)
+		convert_to_utf8(mi, line, charset.buf);
 
 	if (mi->use_scissors && is_scissors_line(line)) {
 		int i;
@@ -1055,7 +1055,7 @@ int cmd_mailinfo(int argc, const char **argv, const char *prefix)
 	setup_mailinfo(&mi);
 
 	def_charset = get_commit_output_encoding();
-	metainfo_charset = def_charset;
+	mi.metainfo_charset = def_charset;
 
 	while (1 < argc && argv[1][0] == '-') {
 		if (!strcmp(argv[1], "-k"))
@@ -1065,11 +1065,11 @@ int cmd_mailinfo(int argc, const char **argv, const char *prefix)
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
2.6.2-383-g144b2e6
