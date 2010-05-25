From: Bo Yang <struggleyb.nku@gmail.com>
Subject: [PATCH 4/6 rebase-version] Emit a whole line once a time.
Date: Tue, 25 May 2010 17:02:32 +0800
Message-ID: <1274778154-29976-5-git-send-email-struggleyb.nku@gmail.com>
References: <1274778154-29976-1-git-send-email-struggleyb.nku@gmail.com>
 <1274778154-29976-2-git-send-email-struggleyb.nku@gmail.com>
 <1274778154-29976-3-git-send-email-struggleyb.nku@gmail.com>
 <1274778154-29976-4-git-send-email-struggleyb.nku@gmail.com>
Cc: gitster@pobox.com, trast@student.ethz.ch, peff@peff.net
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 25 11:03:16 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OGq2e-0006UN-6S
	for gcvg-git-2@lo.gmane.org; Tue, 25 May 2010 11:03:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932219Ab0EYJDI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 May 2010 05:03:08 -0400
Received: from mail-px0-f174.google.com ([209.85.212.174]:52593 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756505Ab0EYJDC (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 May 2010 05:03:02 -0400
Received: by mail-px0-f174.google.com with SMTP id 18so1861182pxi.19
        for <git@vger.kernel.org>; Tue, 25 May 2010 02:03:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=twsVvs9X48ZHBWDaXCO0opyqeZiBVW3QSOdJqOKV8dY=;
        b=PRne4ehXQj03zPCu2Dtud9u+YaBrr9speCO0FYgiHfqduIwzYA+iuYqJI9isKp9VgX
         AfyKJrkJ9TT5aI3RceX5X9nxljU3Gcfqk4XHHFsiEyObUWCURCTvZUCHpcHcY5P1nFKd
         kD4HtlAX0xQeWq+fCzjm9qXvUX/R7i/c6aQB4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=efrKD1qLZ3FJzOX0h28Wtd0nOP9CTfRf6lLi18anx4gZEiUXGojg9iTg9V0/AkkmYj
         C5ofBnMsiCtfQGtWeFb0MWb5lAkLSzrxcAl5XGhR1HOl1LBrrmAaaDoK+wOoDUYkHtWo
         nP85H8VAR1Rk50jSv+YjZZ0FPd8zjORGS1Sko=
Received: by 10.114.215.12 with SMTP id n12mr5963270wag.68.1274778182347;
        Tue, 25 May 2010 02:03:02 -0700 (PDT)
Received: from localhost.localdomain ([58.68.143.99])
        by mx.google.com with ESMTPS id d16sm46058650wam.0.2010.05.25.02.02.59
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 25 May 2010 02:03:01 -0700 (PDT)
X-Mailer: git-send-email 1.6.0.4
In-Reply-To: <1274778154-29976-4-git-send-email-struggleyb.nku@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147692>

Use a strbuf to compose the whole line, and then
call emit_line to output it once. This make output_prefix
callback works well.

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
