From: Bo Yang <struggleyb.nku@gmail.com>
Subject: [PATCH 5/7] Emit a whole line once a time.
Date: Sat, 15 May 2010 04:02:09 -0700
Message-ID: <1273921331-32702-6-git-send-email-struggleyb.nku@gmail.com>
References: <1273921331-32702-1-git-send-email-struggleyb.nku@gmail.com>
 <1273921331-32702-2-git-send-email-struggleyb.nku@gmail.com>
 <1273921331-32702-3-git-send-email-struggleyb.nku@gmail.com>
 <1273921331-32702-4-git-send-email-struggleyb.nku@gmail.com>
 <1273921331-32702-5-git-send-email-struggleyb.nku@gmail.com>
Cc: gitster@pobox.com, trast@student.ethz.ch
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 15 13:02:50 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ODF8q-0007wy-4O
	for gcvg-git-2@lo.gmane.org; Sat, 15 May 2010 13:02:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754891Ab0EOLC1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 May 2010 07:02:27 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:44331 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754826Ab0EOLCX (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 May 2010 07:02:23 -0400
Received: by mail-pv0-f174.google.com with SMTP id 1so973496pvh.19
        for <git@vger.kernel.org>; Sat, 15 May 2010 04:02:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=SqwYVFv9gC/QLaj0Dt71HOF27Af7nWqofatzQkG8CIY=;
        b=mEl5xBiJl0ymjtsu5UsSzU7jVx1EpmsUz8XJjHufEUaUcsAMc5dri712BCDIoM5ym9
         BxmS7KbQQzXpjUjFyVBhBkPWbdi/gxFS8uS8hvqe/P4vkqQMeMq+3gStic0ahBsDeaJw
         r6qcnrvityRvKcDD2XtjzUizs4cB4qEb6TpPI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=Z0eDG5WR41QktzvKl2HfMzLJD4nlIyXYwRXiJslAE+x3Zvi3/F4PwxBmQCiwDapmoQ
         m2soxee7BTMzZ5n6+yTJMVgJmw6jhUbw54Zps7lI60zC0PoIu8CUwtuXwKLuaTY48M/w
         8HnjrB2slh3+bjP5MrgOlf9KALG4WNEZgfByQ=
Received: by 10.114.189.6 with SMTP id m6mr2157233waf.57.1273921342992;
        Sat, 15 May 2010 04:02:22 -0700 (PDT)
Received: from localhost.localdomain ([222.30.37.37])
        by mx.google.com with ESMTPS id d16sm28703988wam.12.2010.05.15.04.02.20
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 15 May 2010 04:02:22 -0700 (PDT)
X-Mailer: git-send-email 1.6.0.4
In-Reply-To: <1273921331-32702-5-git-send-email-struggleyb.nku@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147143>

Use a strbuf to compose the whole line, and then
call emit_line to output it once. This make output_prefix
callback works well.

Signed-off-by: Bo Yang <struggleyb.nku@gmail.com>
---
 diff.c |   34 +++++++++++++++++++++++++++++-----
 1 files changed, 29 insertions(+), 5 deletions(-)

diff --git a/diff.c b/diff.c
index 4a10d16..ed97115 100644
--- a/diff.c
+++ b/diff.c
@@ -367,6 +367,18 @@ static void emit_hunk_header(struct emit_callback *ecbdata,
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
@@ -381,17 +393,29 @@ static void emit_hunk_header(struct emit_callback *ecbdata,
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
1.7.1.94.gc3269
