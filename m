From: Bo Yang <struggleyb.nku@gmail.com>
Subject: [PATCH v4 4/6] Emit a whole line once a time
Date: Wed, 26 May 2010 15:23:55 +0800
Message-ID: <1274858637-13243-2-git-send-email-struggleyb.nku@gmail.com>
References: <1274858637-13243-1-git-send-email-struggleyb.nku@gmail.com>
Cc: gitster@pobox.com, trast@student.ethz.ch
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 26 09:24:33 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OHAye-0002yW-Kq
	for gcvg-git-2@lo.gmane.org; Wed, 26 May 2010 09:24:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753345Ab0EZHY3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 May 2010 03:24:29 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:35361 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753269Ab0EZHY2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 May 2010 03:24:28 -0400
Received: by pvg3 with SMTP id 3so962438pvg.19
        for <git@vger.kernel.org>; Wed, 26 May 2010 00:24:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=DbzSboQltg45iNoi2xeIr/p1wXSgM/Z8hf1pYIRYc8I=;
        b=IRvrhlii+WnlmSFnPLs6XxZzWJcsFdJC3FiO0OSu953MB5J01pN9dwC2M6+ROA/+fD
         w/ob3njvh/VRRUvMmInmzFartKvGLiuyHMDY5SYyVEuHWipgQpAvxzof/WyJuWmKoBsw
         hjOaxXFvWmNUSMvOQgxYYrGMW+OuXaHvWRV8g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=nUArA4BcWrk56wRUNeJb3yz7GPZ/0B4iIqxP2MlNkyQznqhzSdVcPd20qlVm1H2C1u
         GjXyRWPizAauaOEXeiQCqAD/R2TDD6U4TyWPXfuaWcfZqYC/gw9TsatDnQ1xfWRYZCqU
         mMXi8cbU4/6AlArrq2aJIjYZM93m/zpmhRqAg=
Received: by 10.114.188.4 with SMTP id l4mr7254263waf.19.1274858667406;
        Wed, 26 May 2010 00:24:27 -0700 (PDT)
Received: from localhost.localdomain ([58.68.143.99])
        by mx.google.com with ESMTPS id 33sm54800802wad.8.2010.05.26.00.24.24
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 26 May 2010 00:24:26 -0700 (PDT)
X-Mailer: git-send-email 1.6.0.4
In-Reply-To: <1274858637-13243-1-git-send-email-struggleyb.nku@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147776>

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
index 7f2538d..bffaedc 100644
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
