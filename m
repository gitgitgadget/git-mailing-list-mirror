From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 19/34] mailinfo: move check for metainfo_charset to convert_to_utf8()
Date: Mon, 19 Oct 2015 00:28:36 -0700
Message-ID: <1445239731-10677-20-git-send-email-gitster@pobox.com>
References: <1444855557-2127-1-git-send-email-gitster@pobox.com>
 <1445239731-10677-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 19 09:29:33 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zo4su-0002o3-Gn
	for gcvg-git-2@plane.gmane.org; Mon, 19 Oct 2015 09:29:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752992AbbJSH3Z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Oct 2015 03:29:25 -0400
Received: from mail-pa0-f49.google.com ([209.85.220.49]:34845 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750904AbbJSH3R (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Oct 2015 03:29:17 -0400
Received: by pasz6 with SMTP id z6so22263683pas.2
        for <git@vger.kernel.org>; Mon, 19 Oct 2015 00:29:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:subject:date:message-id:in-reply-to:references;
        bh=tPmgNK2a6CdBG13kKZOESh5uIjVMX9c52mBQgxSPb2w=;
        b=cnWbBSPnfPzHqp/dG7dkI/0mp0KaM91kPO015H0pZl/acIs8xucMRSIdHkkB7JtQwa
         CzsqEQyyjDZX9PA9a80AlWHt0PTC1A43A2m6AcH7z7O8ASnkSuEx8MFHtmXorqQlZdmm
         x43/4PyvQRkI3renoQAZP2uoHZmOHgASYVh5yyr+WzNVkdA5T7LnbS9rLKQ+HxhLi7zA
         My2zW1ZwfKFPUcbYc+XC/l+7wF3XLSZmc04yTws/TFBVHmxiQSRcpAwRqMKbDnArR6cb
         BJuxphs/DLwVXkKhoE9CTcN2hserSekeGMVyHsYF0LtmR4Vcje3e0vqksLq3k/qjr/Se
         qxjw==
X-Received: by 10.66.102.74 with SMTP id fm10mr5689132pab.113.1445239756928;
        Mon, 19 Oct 2015 00:29:16 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:f5db:ee54:4f5:9373])
        by smtp.gmail.com with ESMTPSA id ha1sm12839783pbc.54.2015.10.19.00.29.16
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 19 Oct 2015 00:29:16 -0700 (PDT)
X-Mailer: git-send-email 2.6.2-388-g10c4a0e
In-Reply-To: <1445239731-10677-1-git-send-email-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279842>

All callers of this function refrains from calling it when
mi->metainfo_charset is NULL; move the check to the callee,
as it already has a few conditions at its beginning to turn
it into a no-op.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/mailinfo.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/builtin/mailinfo.c b/builtin/mailinfo.c
index 26fd9b1..737d0fc 100644
--- a/builtin/mailinfo.c
+++ b/builtin/mailinfo.c
@@ -524,7 +524,7 @@ static void convert_to_utf8(struct mailinfo *mi,
 {
 	char *out;
 
-	if (!charset || !*charset)
+	if (!mi->metainfo_charset || !charset || !*charset)
 		return;
 
 	if (same_encoding(mi->metainfo_charset, charset))
@@ -599,8 +599,7 @@ static void decode_header(struct mailinfo *mi, struct strbuf *it)
 			dec = decode_q_segment(&piecebuf, 1);
 			break;
 		}
-		if (mi->metainfo_charset)
-			convert_to_utf8(mi, dec, charset_q.buf);
+		convert_to_utf8(mi, dec, charset_q.buf);
 
 		strbuf_addbuf(&outbuf, dec);
 		strbuf_release(dec);
@@ -745,8 +744,7 @@ static int handle_commit_msg(struct mailinfo *mi, struct strbuf *line)
 		mi->header_stage = 0;
 
 	/* normalize the log message to UTF-8. */
-	if (mi->metainfo_charset)
-		convert_to_utf8(mi, line, charset.buf);
+	convert_to_utf8(mi, line, charset.buf);
 
 	if (mi->use_scissors && is_scissors_line(line)) {
 		int i;
-- 
2.6.2-383-g144b2e6
