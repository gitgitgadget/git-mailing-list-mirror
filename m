From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 02/34] mailinfo: fold decode_header_bq() into decode_header()
Date: Mon, 19 Oct 2015 00:28:19 -0700
Message-ID: <1445239731-10677-3-git-send-email-gitster@pobox.com>
References: <1444855557-2127-1-git-send-email-gitster@pobox.com>
 <1445239731-10677-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 19 09:31:05 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zo4uI-0003ig-T6
	for gcvg-git-2@plane.gmane.org; Mon, 19 Oct 2015 09:30:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752691AbbJSHay (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Oct 2015 03:30:54 -0400
Received: from mail-pa0-f44.google.com ([209.85.220.44]:35956 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751636AbbJSH24 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Oct 2015 03:28:56 -0400
Received: by pacfv9 with SMTP id fv9so86964399pac.3
        for <git@vger.kernel.org>; Mon, 19 Oct 2015 00:28:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:subject:date:message-id:in-reply-to:references;
        bh=Kq+MCBF/9Zj0d3zDbSqb68ITn6cjDl5mNHd/0AcKTHQ=;
        b=vn/hewG749UJ9b22/9Sge9q3RmY5kPVeKfbvCSZCsfLGp6oyBpFoHB/6cJnt+e3Ls5
         X3ydqI5chdoNPgHzafv/rxpEGBabF7U3Cke/W8BZrqVmgxPloagWYPyxs4n2zucd94gl
         5tIq5zD6emzAoFdpOUf/KSayoFp+PHFDZ7ZWxmx846qY4eq+cgOlX+yghwfsfWRkuTKS
         uGOEO9TBkbbCGt7R8tGaZTGIL6ruDpfHVqJAC1AWXTDrayemv54Db5oWi9Bm9XRN0zo5
         Fuby5lbqYa+i5aawbH5CtxVnqtXHxwTW+KYjoa4CHXvdLtr95F8Mh6ekpPlPg94FbJeE
         lUzA==
X-Received: by 10.68.168.2 with SMTP id zs2mr33412375pbb.154.1445239736496;
        Mon, 19 Oct 2015 00:28:56 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:f5db:ee54:4f5:9373])
        by smtp.gmail.com with ESMTPSA id a17sm34469827pbu.55.2015.10.19.00.28.55
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 19 Oct 2015 00:28:55 -0700 (PDT)
X-Mailer: git-send-email 2.6.2-388-g10c4a0e
In-Reply-To: <1445239731-10677-1-git-send-email-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279866>

In olden days we might have wanted to behave differently in
decode_header() if the header line was encoded with RFC2047, but we
apparently do not do so, hence this helper function can go, together
with its return value.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/mailinfo.c | 23 +++++++----------------
 1 file changed, 7 insertions(+), 16 deletions(-)

diff --git a/builtin/mailinfo.c b/builtin/mailinfo.c
index 5a4ed75..addc0e0 100644
--- a/builtin/mailinfo.c
+++ b/builtin/mailinfo.c
@@ -525,19 +525,17 @@ static void convert_to_utf8(struct strbuf *line, const char *charset)
 	strbuf_attach(line, out, strlen(out), strlen(out));
 }
 
-static int decode_header_bq(struct strbuf *it)
+static void decode_header(struct strbuf *it)
 {
 	char *in, *ep, *cp;
 	struct strbuf outbuf = STRBUF_INIT, *dec;
 	struct strbuf charset_q = STRBUF_INIT, piecebuf = STRBUF_INIT;
-	int rfc2047 = 0;
 
 	in = it->buf;
 	while (in - it->buf <= it->len && (ep = strstr(in, "=?")) != NULL) {
 		int encoding;
 		strbuf_reset(&charset_q);
 		strbuf_reset(&piecebuf);
-		rfc2047 = 1;
 
 		if (in != ep) {
 			/*
@@ -567,22 +565,22 @@ static int decode_header_bq(struct strbuf *it)
 		ep += 2;
 
 		if (ep - it->buf >= it->len || !(cp = strchr(ep, '?')))
-			goto decode_header_bq_out;
+			goto release_return;
 
 		if (cp + 3 - it->buf > it->len)
-			goto decode_header_bq_out;
+			goto release_return;
 		strbuf_add(&charset_q, ep, cp - ep);
 
 		encoding = cp[1];
 		if (!encoding || cp[2] != '?')
-			goto decode_header_bq_out;
+			goto release_return;
 		ep = strstr(cp + 3, "?=");
 		if (!ep)
-			goto decode_header_bq_out;
+			goto release_return;
 		strbuf_add(&piecebuf, cp + 3, ep - cp - 3);
 		switch (tolower(encoding)) {
 		default:
-			goto decode_header_bq_out;
+			goto release_return;
 		case 'b':
 			dec = decode_b_segment(&piecebuf);
 			break;
@@ -601,17 +599,10 @@ static int decode_header_bq(struct strbuf *it)
 	strbuf_addstr(&outbuf, in);
 	strbuf_reset(it);
 	strbuf_addbuf(it, &outbuf);
-decode_header_bq_out:
+release_return:
 	strbuf_release(&outbuf);
 	strbuf_release(&charset_q);
 	strbuf_release(&piecebuf);
-	return rfc2047;
-}
-
-static void decode_header(struct strbuf *it)
-{
-	if (decode_header_bq(it))
-		return;
 }
 
 static void decode_transfer_encoding(struct strbuf *line)
-- 
2.6.2-383-g144b2e6
