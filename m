From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 33/34] mailinfo: remove calls to exit() and die() deep in the callchain
Date: Mon, 19 Oct 2015 00:28:50 -0700
Message-ID: <1445239731-10677-34-git-send-email-gitster@pobox.com>
References: <1444855557-2127-1-git-send-email-gitster@pobox.com>
 <1445239731-10677-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 19 09:29:56 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zo4tH-00032X-9E
	for gcvg-git-2@plane.gmane.org; Mon, 19 Oct 2015 09:29:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751838AbbJSH3p (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Oct 2015 03:29:45 -0400
Received: from mail-pa0-f44.google.com ([209.85.220.44]:33198 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753117AbbJSH3e (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Oct 2015 03:29:34 -0400
Received: by pabrc13 with SMTP id rc13so183006856pab.0
        for <git@vger.kernel.org>; Mon, 19 Oct 2015 00:29:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:subject:date:message-id:in-reply-to:references;
        bh=ndXEqte4bUfT5m3baqc2J6LtNOgZ3Kq5clWcUMabg4k=;
        b=S7hbYoNCH76g70Zk4qbS+NTy98RxgsZDkgCtkdVITwQeLhU6+RctwWXc6pE+rqh+rN
         yCRK0u0k4XLO1M15kLMFlMvw/u4cuGVltG4puPgvRlaojm73L3ZFln0vZVWN28KwqMoE
         OZvIr/td7/FmgAP308U8W5HiqMMPQfCqm799p2sA3kHsYfnRn73lWuJweDVtqr1zDuiM
         l7HC0yvLsec2w5eTlb6Gn/VzheepzDwE4D+K2qB1gV3sgiV9SuzOok/2nfBiPZYs8gUU
         6DSs21sMm2x4KwX7fvVmklTM3yVQ9rF042vLvlZWuXlSFhD2Bc6795NC+sAYJR7q9dgL
         Gc2g==
X-Received: by 10.66.221.104 with SMTP id qd8mr33895808pac.155.1445239773908;
        Mon, 19 Oct 2015 00:29:33 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:f5db:ee54:4f5:9373])
        by smtp.gmail.com with ESMTPSA id gv1sm34490876pbc.38.2015.10.19.00.29.33
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 19 Oct 2015 00:29:33 -0700 (PDT)
X-Mailer: git-send-email 2.6.2-388-g10c4a0e
In-Reply-To: <1445239731-10677-1-git-send-email-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279849>

The top-level mailinfo() would instead punt when the code in the
deeper part of the callchain detects an unrecoverable error in the
input.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 mailinfo.c | 30 ++++++++++++++++++++++--------
 mailinfo.h |  1 +
 2 files changed, 23 insertions(+), 8 deletions(-)

diff --git a/mailinfo.c b/mailinfo.c
index 4fbf38f..9d009fa 100644
--- a/mailinfo.c
+++ b/mailinfo.c
@@ -163,8 +163,10 @@ static void handle_content_type(struct mailinfo *mi, struct strbuf *line)
 	if (slurp_attr(line->buf, "boundary=", boundary)) {
 		strbuf_insert(boundary, 0, "--", 2);
 		if (++mi->content_top >= &mi->content[MAX_BOUNDARIES]) {
-			fprintf(stderr, "Too many boundaries to handle\n");
-			exit(1);
+			error("Too many boundaries to handle");
+			mi->input_error = -1;
+			mi->content_top = &mi->content[MAX_BOUNDARIES] - 1;
+			return;
 		}
 		*(mi->content_top) = boundary;
 		boundary = NULL;
@@ -355,9 +357,11 @@ static int convert_to_utf8(struct mailinfo *mi,
 	if (same_encoding(mi->metainfo_charset, charset))
 		return 0;
 	out = reencode_string(line->buf, mi->metainfo_charset, charset);
-	if (!out)
+	if (!out) {
+		mi->input_error = -1;
 		return error("cannot convert from %s to %s",
 			     charset, mi->metainfo_charset);
+	}
 	strbuf_attach(line, out, strlen(out), strlen(out));
 	return 0;
 }
@@ -367,6 +371,7 @@ static void decode_header(struct mailinfo *mi, struct strbuf *it)
 	char *in, *ep, *cp;
 	struct strbuf outbuf = STRBUF_INIT, *dec;
 	struct strbuf charset_q = STRBUF_INIT, piecebuf = STRBUF_INIT;
+	int found_error = 1; /* pessimism */
 
 	in = it->buf;
 	while (in - it->buf <= it->len && (ep = strstr(in, "=?")) != NULL) {
@@ -436,10 +441,14 @@ static void decode_header(struct mailinfo *mi, struct strbuf *it)
 	strbuf_addstr(&outbuf, in);
 	strbuf_reset(it);
 	strbuf_addbuf(it, &outbuf);
+	found_error = 0;
 release_return:
 	strbuf_release(&outbuf);
 	strbuf_release(&charset_q);
 	strbuf_release(&piecebuf);
+
+	if (found_error)
+		mi->input_error = -1;
 }
 
 static int check_header(struct mailinfo *mi,
@@ -640,7 +649,7 @@ static int handle_commit_msg(struct mailinfo *mi, struct strbuf *line)
 
 	/* normalize the log message to UTF-8. */
 	if (convert_to_utf8(mi, line, mi->charset.buf))
-		exit(128);
+		return 0; /* mi->input_error already set */
 
 	if (mi->use_scissors && is_scissors_line(line)) {
 		int i;
@@ -783,12 +792,15 @@ again:
 		   will fail first.  But just in case..
 		 */
 		if (--mi->content_top < mi->content) {
-			fprintf(stderr, "Detected mismatched boundaries, "
-					"can't recover\n");
-			exit(1);
+			error("Detected mismatched boundaries, can't recover");
+			mi->input_error = -1;
+			mi->content_top = mi->content;
+			return 0;
 		}
 		handle_filter(mi, &newline);
 		strbuf_release(&newline);
+		if (mi->input_error)
+			return 0;
 
 		/* skip to the next boundary */
 		if (!find_boundary(mi, line))
@@ -873,6 +885,8 @@ static void handle_body(struct mailinfo *mi, struct strbuf *line)
 			handle_filter(mi, line);
 		}
 
+		if (mi->input_error)
+			break;
 	} while (!strbuf_getwholeline(line, mi->input, '\n'));
 
 handle_body_out:
@@ -966,7 +980,7 @@ int mailinfo(struct mailinfo *mi, const char *msg, const char *patch)
 
 	handle_info(mi);
 
-	return 0;
+	return mi->input_error;
 }
 
 static int git_mailinfo_config(const char *var, const char *value, void *mi_)
diff --git a/mailinfo.h b/mailinfo.h
index 27841be..5bf257d 100644
--- a/mailinfo.h
+++ b/mailinfo.h
@@ -31,6 +31,7 @@ struct mailinfo {
 	struct strbuf **s_hdr_data;
 
 	struct strbuf log_message;
+	int input_error;
 };
 
 extern void setup_mailinfo(struct mailinfo *);
-- 
2.6.2-383-g144b2e6
