From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 04/31] mailinfo: fold decode_header_bq() into decode_header()
Date: Wed, 14 Oct 2015 13:45:30 -0700
Message-ID: <1444855557-2127-5-git-send-email-gitster@pobox.com>
References: <1444778207-859-1-git-send-email-gitster@pobox.com>
 <1444855557-2127-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 14 22:48:25 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZmSyF-0003N6-Au
	for gcvg-git-2@plane.gmane.org; Wed, 14 Oct 2015 22:48:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932785AbbJNUq0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Oct 2015 16:46:26 -0400
Received: from mail-pa0-f41.google.com ([209.85.220.41]:34733 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932297AbbJNUqE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Oct 2015 16:46:04 -0400
Received: by payp3 with SMTP id p3so16203549pay.1
        for <git@vger.kernel.org>; Wed, 14 Oct 2015 13:46:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:subject:date:message-id:in-reply-to:references;
        bh=Zoo8uKdSZ6ETooxUDh6fE4JWdEGJnCLy+o2Kft/42kc=;
        b=bDhWNSZY24l3oDxVwG9DpHTs396KjXKQU4Fk45AadfJ+S/iDYTxi6K66BO+Mxe465g
         FDUIyOg42PFpMrvSMtu1eXmYK3tuvOJM6DBkxWk43rhBtVAT38hrHy6oAzMvlOte8Nu6
         NVJVfq5SFUNyoMnGeO9dd3YAkYEsU9zbbWYpri9lTaFo5NrdfE9o3fdugyXMKJaW31db
         lQdPQDWEE8cfwzfim46bZrsbijSvXF/un7Ildb0RGP49vlABXRyqb53EEekC1oMvS6W8
         7GdbmIarjKzyHYgHGY3VYCyFCerhcyFPgEusX0BI7MH5FKO9kFUM6rBkC323qyC07cWc
         C9WA==
X-Received: by 10.66.139.201 with SMTP id ra9mr5641136pab.153.1444855564040;
        Wed, 14 Oct 2015 13:46:04 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:7964:41eb:7b4:cd77])
        by smtp.gmail.com with ESMTPSA id ey17sm11337334pac.26.2015.10.14.13.46.03
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 14 Oct 2015 13:46:03 -0700 (PDT)
X-Mailer: git-send-email 2.6.1-320-g86a1181
In-Reply-To: <1444855557-2127-1-git-send-email-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279620>

In olden days we might have wanted to behave differently in
decode_header() if the header line was encoded with RFC2047, but we
apparently do not do so, hence this helper function can go, together
with its return value.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/mailinfo.c | 23 +++++++----------------
 1 file changed, 7 insertions(+), 16 deletions(-)

diff --git a/builtin/mailinfo.c b/builtin/mailinfo.c
index 412a23b..73be47c 100644
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
