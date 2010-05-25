From: Bo Yang <struggleyb.nku@gmail.com>
Subject: Re: [PATCH 4/6 rebase-version] Emit a whole line once a time.
Date: Tue, 25 May 2010 18:44:20 +0800
Message-ID: <1274784260-13991-1-git-send-email-struggleyb.nku@gmail.com>
Cc: gitster@pobox.com, trast@student.ethz.ch, peff@peff.net,
	Bo Yang <struggleyb.nku@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 25 12:45:32 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OGrdb-0003tz-80
	for gcvg-git-2@lo.gmane.org; Tue, 25 May 2010 12:45:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753460Ab0EYKob (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 May 2010 06:44:31 -0400
Received: from mail-pz0-f176.google.com ([209.85.222.176]:47560 "EHLO
	mail-pz0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750773Ab0EYKoa (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 May 2010 06:44:30 -0400
Received: by pzk6 with SMTP id 6so1972169pzk.1
        for <git@vger.kernel.org>; Tue, 25 May 2010 03:44:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=JTN1M3QWJU+9Fo1NtBOB57eu1sAD4JuHbkjGF7J+KXk=;
        b=iyZx1Tm05XhZohvmM66ZzsDFG0C0RqKPUQmhBO/6uFPVJOQqnFTlbwwORJbyzNPXAv
         q3XJEg4i23DhSn0laXb4ejP2slvk/33QRisH0KeV/iOZOkJLD0+yDXqtDw7RgpUZNSgZ
         r7QdxSaMvZiDYyOhWz4Rl9mxz9JDfr/274oyk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=x6163kIux863PqsRMskyexWkb7sT/TVAQZ2ddv+TfPcGJF0/xrteV3h9MXVezeYdx0
         xxCCfO5oDAklyqt96zAa6K6vRp1O88sBbK3sGdFU288+1qLYZ9k2NAvgWgr43IOU3SBu
         LYLTFJp7hQOm2FZzP5inF6VzkYAhQMtcZAK/U=
Received: by 10.115.28.14 with SMTP id f14mr6012880waj.58.1274784269530;
        Tue, 25 May 2010 03:44:29 -0700 (PDT)
Received: from localhost.localdomain ([58.68.143.99])
        by mx.google.com with ESMTPS id n29sm46736756wae.4.2010.05.25.03.44.26
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 25 May 2010 03:44:28 -0700 (PDT)
X-Mailer: git-send-email 1.6.0.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147707>

Since the graph prefix will be printed when calling
emit_line, so the functions should be used to emit a
complete line out once a time. No one should call
emit_line to just output some strings instead of a
complete line.
Use a strbuf to compose the whole line, and then
call emit_line to output it once.

Signed-off-by: Bo Yang <struggleyb.nku@gmail.com>
---
 diff.c |   34 +++++++++++++++++++++++++++++-----
 1 files changed, 29 insertions(+), 5 deletions(-)

diff --git a/diff.c b/diff.c
index b99a56c..067260b 100644
--- a/diff.c
+++ b/diff.c
@@ -370,6 +370,18 @@ static void emit_hunk_header(struct emit_callback *ecbdata,
 	const char *reset = diff_get_color(ecbdata->color_diff, DIFF_RESET);
 	static const char atat[2] = { '@', '@' };
 	const char *cp, *ep;
+	struct strbuf msgbuf = STRBUF_INIT;
+	int org_len = len;
+
+	/*
+	 * trailing \r\n
+	 */
+	int i = 1;
+	for (; i < 3; i++) {
+		if (line[len - i] == '\r' || line[len - i] == '\n') {
+			len --;
+		}
+	}
 
 	/*
 	 * As a hunk header must begin with "@@ -<old>, +<new> @@",
@@ -384,17 +396,29 @@ static void emit_hunk_header(struct emit_callback *ecbdata,
 	ep += 2; /* skip over @@ */
 
 	/* The hunk header in fraginfo color */
-	emit_line(ecbdata->opt, frag, reset, line, ep - line);
+	strbuf_add(&msgbuf, frag, strlen(frag));
+	strbuf_add(&msgbuf, line, ep - line);
+	strbuf_add(&msgbuf, reset, strlen(reset));
 
 	/* blank before the func header */
 	for (cp = ep; ep - line < len; ep++)
 		if (*ep != ' ' && *ep != '\t')
 			break;
-	if (ep != cp)
-		emit_line(ecbdata->opt, plain, reset, cp, ep - cp);
+	if (ep != cp) {
+		strbuf_add(&msgbuf, plain, strlen(plain));
+		strbuf_add(&msgbuf, cp, ep - cp);
+		strbuf_add(&msgbuf, reset, strlen(reset));
+	}
+
+	if (ep < line + len) {
+		strbuf_add(&msgbuf, func, strlen(func));
+		strbuf_add(&msgbuf, ep, line + len - ep);
+		strbuf_add(&msgbuf, reset, strlen(reset));
+	}
 
-	if (ep < line + len)
-		emit_line(ecbdata->opt, func, reset, ep, line + len - ep);
+	strbuf_add(&msgbuf, line + len, org_len - len);
+	emit_line(ecbdata->opt, "", "", msgbuf.buf, msgbuf.len);
+	strbuf_release(&msgbuf);
 }
 
 static struct diff_tempfile *claim_diff_tempfile(void) {
-- 
1.6.0.4
