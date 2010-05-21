From: Bo Yang <struggleyb.nku@gmail.com>
Subject: [PATCH 4/6 v3] Emit a whole line once a time.
Date: Thu, 20 May 2010 18:52:42 -0700
Message-ID: <1274406764-32278-5-git-send-email-struggleyb.nku@gmail.com>
References: <1274406764-32278-1-git-send-email-struggleyb.nku@gmail.com>
 <1274406764-32278-2-git-send-email-struggleyb.nku@gmail.com>
 <1274406764-32278-3-git-send-email-struggleyb.nku@gmail.com>
 <1274406764-32278-4-git-send-email-struggleyb.nku@gmail.com>
Cc: gitster@pobox.com, trast@student.ethz.ch, peff@peff.net
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 21 03:53:16 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OFHQI-0004JK-SV
	for gcvg-git-2@lo.gmane.org; Fri, 21 May 2010 03:53:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756161Ab0EUBxF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 May 2010 21:53:05 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:33687 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753163Ab0EUBxB (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 May 2010 21:53:01 -0400
Received: by mail-pw0-f46.google.com with SMTP id 5so209656pwi.19
        for <git@vger.kernel.org>; Thu, 20 May 2010 18:53:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=GIhqF8xDo3rJK0zZaYorUS4d2Ij1+FKkICUZGqpHApg=;
        b=ZL82IOnzfZHAXyeQFM6eUmsK4fL/mrwy+dEcMitjB0oqaTv05vVxxeob68dnIy4ou8
         Xc9ry4IPfyma75cX6kvCuanRG7Pmn7An4hJw65LT2gc30FwTXRMozkhPtY6j3p9R2NCC
         CJaWb8cwGgHmbuuBZiUQRcQuegY4wFLfn3MmA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=Gc3SLLzhupnP+XpajZNW5udEKXm4smhfNSDqdoir1LeJdaTpoQd4CM6SJfFGm76+u/
         VINjQNLArML+5uvN0JyCVqRjIgzaSdPzaLhr76KV30mxx94sC65lpfdFOlzvJdn1ur1C
         TfAk2GmuK/F4NHvascK5Yx8jF1UI1DTMJBq/I=
Received: by 10.141.139.21 with SMTP id r21mr688006rvn.2.1274406780766;
        Thu, 20 May 2010 18:53:00 -0700 (PDT)
Received: from localhost.localdomain ([222.30.37.37])
        by mx.google.com with ESMTPS id o38sm442378rvp.12.2010.05.20.18.52.58
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 20 May 2010 18:53:00 -0700 (PDT)
X-Mailer: git-send-email 1.6.0.4
In-Reply-To: <1274406764-32278-4-git-send-email-struggleyb.nku@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147424>

Use a strbuf to compose the whole line, and then
call emit_line to output it once. This make output_prefix
callback works well.

Signed-off-by: Bo Yang <struggleyb.nku@gmail.com>
---
 diff.c |   34 +++++++++++++++++++++++++++++-----
 1 files changed, 29 insertions(+), 5 deletions(-)

diff --git a/diff.c b/diff.c
index b935e1a..ea737e9 100644
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
