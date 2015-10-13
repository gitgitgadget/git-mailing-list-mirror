From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 03/26] mailinfo: fold decode_header_bq() into decode_header()
Date: Tue, 13 Oct 2015 16:16:24 -0700
Message-ID: <1444778207-859-4-git-send-email-gitster@pobox.com>
References: <1444778207-859-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 14 01:17:22 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zm8oo-0006FA-MZ
	for gcvg-git-2@plane.gmane.org; Wed, 14 Oct 2015 01:17:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753307AbbJMXRM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Oct 2015 19:17:12 -0400
Received: from mail-pa0-f43.google.com ([209.85.220.43]:33157 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751733AbbJMXQx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Oct 2015 19:16:53 -0400
Received: by pabrc13 with SMTP id rc13so34523869pab.0
        for <git@vger.kernel.org>; Tue, 13 Oct 2015 16:16:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:subject:date:message-id:in-reply-to:references;
        bh=bSu+F9WQke5PhA+bFbiOh6hmDYp0Fz30IBhua7coJ40=;
        b=L0PCbBP4kkYXyLxUgQCJn2zfeHQgV7Bowe/ZtPpYcYY04ocrcmi03dNiA0Bo5LdmSh
         C3+JvqV+drLu5ovFsEXYXhyHJV++KL4gQrYEGvOZITIxe0G7PZCXBXnVYgKNT0xhOqty
         /U9YKghBelq8iRiGEtcaXX3Gpj0EovoHyXz0PTWbagSOsrKAv969OU6OCYeTMQ9VQ7QI
         Fu7qtC6ieGdk2PCMAEQ3ifFCNTePKvcbfuQzchLYd44yI0TU/sfOpnHKd/hBu5X2/zSF
         dZxgwyUfmzzZAaFrPSA5GwUf8YD4+86ZzKtY7zE5Lsgx9tJebBs8DUAxlEmx3rIbRrs1
         ccxw==
X-Received: by 10.66.101.39 with SMTP id fd7mr22575pab.3.1444778213452;
        Tue, 13 Oct 2015 16:16:53 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:45f3:915b:d2ba:37bc])
        by smtp.gmail.com with ESMTPSA id nu5sm5822432pbb.65.2015.10.13.16.16.52
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 13 Oct 2015 16:16:52 -0700 (PDT)
X-Mailer: git-send-email 2.6.1-320-g86a1181
In-Reply-To: <1444778207-859-1-git-send-email-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279532>

In olden days we might have wanted to behave differently in
decode_header() if the header line was encoded with RFC2047, but we
apparently do not do so, hence this helper function can go, together
with its return value.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/mailinfo.c | 23 +++++++----------------
 1 file changed, 7 insertions(+), 16 deletions(-)

diff --git a/builtin/mailinfo.c b/builtin/mailinfo.c
index 2742d0d..3b015a5 100644
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
2.6.1-320-g86a1181
