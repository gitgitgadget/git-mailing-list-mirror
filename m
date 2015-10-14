From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 18/31] mailinfo: move charset to struct mailinfo
Date: Wed, 14 Oct 2015 13:45:44 -0700
Message-ID: <1444855557-2127-19-git-send-email-gitster@pobox.com>
References: <1444778207-859-1-git-send-email-gitster@pobox.com>
 <1444855557-2127-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 14 22:48:58 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZmSyn-0003xF-Lj
	for gcvg-git-2@plane.gmane.org; Wed, 14 Oct 2015 22:48:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932557AbbJNUsw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Oct 2015 16:48:52 -0400
Received: from mail-pa0-f48.google.com ([209.85.220.48]:33964 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932514AbbJNUqW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Oct 2015 16:46:22 -0400
Received: by payp3 with SMTP id p3so16209936pay.1
        for <git@vger.kernel.org>; Wed, 14 Oct 2015 13:46:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:subject:date:message-id:in-reply-to:references;
        bh=Zb1E575EQcVqpk/7r8flQamWLcF6+kxU7N8AfxirXsY=;
        b=0hANeGQk/PnQt98VzMlzTwq2j/Y+pbZmT/wmLuvETbPfpDPMrr+z3jNE3dNPBbFKCc
         UsIjCe0S0dbpLGWRheGPs3FfBD5HMvESgdUA4vGmlOMqaFAImUj+gS4Q7CbiKdWQTDVJ
         RExhSyl+cmXVaPs2mVgOxXolWZNC2zbTrRjA2AcSISEi54up6YwI/sXa4pgglB0pacoh
         IQX7b5/vO9PWitJEv/AZsaKbGdbhSLwHk8eaGwe0Gn2rNfwcngT0V9J9WpniiJnY7z0g
         5lgOItJ7dTgjkHC+yaoYKxXfMjG9InxEZAWkCo6NV3hGwaoLNvOk8QpYnhu6KFY5l+KH
         eNJg==
X-Received: by 10.68.57.238 with SMTP id l14mr5703320pbq.150.1444855581837;
        Wed, 14 Oct 2015 13:46:21 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:7964:41eb:7b4:cd77])
        by smtp.gmail.com with ESMTPSA id jt1sm1400221pbc.83.2015.10.14.13.46.21
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 14 Oct 2015 13:46:21 -0700 (PDT)
X-Mailer: git-send-email 2.6.1-320-g86a1181
In-Reply-To: <1444855557-2127-1-git-send-email-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279626>

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/mailinfo.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/builtin/mailinfo.c b/builtin/mailinfo.c
index 140b31ee..41f659d 100644
--- a/builtin/mailinfo.c
+++ b/builtin/mailinfo.c
@@ -22,6 +22,7 @@ struct mailinfo {
 	int use_inbody_headers; /* defaults to 1 */
 	const char *metainfo_charset;
 
+	struct strbuf charset;
 	char *message_id;
 	enum  {
 		TE_DONTCARE, TE_QP, TE_BASE64
@@ -31,9 +32,6 @@ struct mailinfo {
 	int header_stage; /* still checking in-body headers? */
 };
 
-
-static struct strbuf charset = STRBUF_INIT;
-
 static struct strbuf **p_hdr_data, **s_hdr_data;
 
 #define MAX_HDR_PARSED 10
@@ -186,7 +184,7 @@ static struct strbuf *content[MAX_BOUNDARIES];
 
 static struct strbuf **content_top = content;
 
-static void handle_content_type(struct strbuf *line)
+static void handle_content_type(struct mailinfo *mi, struct strbuf *line)
 {
 	struct strbuf *boundary = xmalloc(sizeof(struct strbuf));
 	strbuf_init(boundary, line->len);
@@ -200,7 +198,7 @@ static void handle_content_type(struct strbuf *line)
 		*content_top = boundary;
 		boundary = NULL;
 	}
-	slurp_attr(line->buf, "charset=", &charset);
+	slurp_attr(line->buf, "charset=", &mi->charset);
 
 	if (boundary) {
 		strbuf_release(boundary);
@@ -349,7 +347,7 @@ static int check_header(struct mailinfo *mi,
 		strbuf_add(&sb, line->buf + len, line->len - len);
 		decode_header(mi, &sb);
 		strbuf_insert(&sb, 0, "Content-Type: ", len);
-		handle_content_type(&sb);
+		handle_content_type(mi, &sb);
 		ret = 1;
 		goto check_header_out;
 	}
@@ -745,7 +743,7 @@ static int handle_commit_msg(struct mailinfo *mi, struct strbuf *line)
 		mi->header_stage = 0;
 
 	/* normalize the log message to UTF-8. */
-	convert_to_utf8(mi, line, charset.buf);
+	convert_to_utf8(mi, line, mi->charset.buf);
 
 	if (mi->use_scissors && is_scissors_line(line)) {
 		int i;
@@ -840,7 +838,7 @@ again:
 
 	/* set some defaults */
 	mi->transfer_encoding = TE_DONTCARE;
-	strbuf_reset(&charset);
+	strbuf_reset(&mi->charset);
 
 	/* slurp in this section's info */
 	while (read_one_header_line(line, mi->input))
@@ -1027,6 +1025,7 @@ static void setup_mailinfo(struct mailinfo *mi)
 	memset(mi, 0, sizeof(*mi));
 	strbuf_init(&mi->name, 0);
 	strbuf_init(&mi->email, 0);
+	strbuf_init(&mi->charset, 0);
 	mi->header_stage = 1;
 	mi->use_inbody_headers = 1;
 	git_config(git_mailinfo_config, &mi);
-- 
2.6.1-320-g86a1181
