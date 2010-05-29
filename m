From: Bo Yang <struggleyb.nku@gmail.com>
Subject: Re: [PATCH v4 4/6] Emit a whole line in one go
Date: Sat, 29 May 2010 23:32:05 +0800
Message-ID: <1275147126-16784-1-git-send-email-struggleyb.nku@gmail.com>
Cc: gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 29 17:32:56 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OIO1u-0002yw-CC
	for gcvg-git-2@lo.gmane.org; Sat, 29 May 2010 17:32:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757306Ab0E2PcR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 29 May 2010 11:32:17 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:50731 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753717Ab0E2PcQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 29 May 2010 11:32:16 -0400
Received: by pwj2 with SMTP id 2so174602pwj.19
        for <git@vger.kernel.org>; Sat, 29 May 2010 08:32:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=XdynsnCVA7Xx8f+idMLCm62msKfmNnz70dtGWL81MFI=;
        b=JXR6EyXhBfpu+97FmXUHXK9vvoz1tJ8P3jLa2quNWXWp1M4JFaqabrl2URVV+ev3tk
         C6bnYK85gMSwWxVMaFeydAs/jYSm7AvXrsa+/qL+9IsaLHdlLKfRk6u56VR7ba7jahBF
         tw+g9tnJE+ClqILdjRsL8kvPemNw1qbvkDtQg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=BnLqNXa3r+tPUTd8rmyBC/0EthF1bdFFF/fT4XcelZk59fcRlwLYdDip7Lab1Fl0t/
         4+3adGyHoEsXxT82INK87V0oHetfZZQppU0pz9KrK31f/Xf2/GU6iukEhOMs482qsw7Y
         CW92xkDi1MTcFWbvoCqG/umWJjqMLAQn8ezn0=
Received: by 10.115.132.31 with SMTP id j31mr1557663wan.114.1275147135332;
        Sat, 29 May 2010 08:32:15 -0700 (PDT)
Received: from localhost.localdomain ([60.27.219.198])
        by mx.google.com with ESMTPS id d16sm30384823wam.0.2010.05.29.08.32.12
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 29 May 2010 08:32:14 -0700 (PDT)
X-Mailer: git-send-email 1.7.0.2.273.gc2413.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147970>

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
index 7f2538d..8b738f0 100644
--- a/diff.c
+++ b/diff.c
@@ -370,6 +370,9 @@ static void emit_hunk_header(struct emit_callback *ecbdata,
 	const char *reset = diff_get_color(ecbdata->color_diff, DIFF_RESET);
 	static const char atat[2] = { '@', '@' };
 	const char *cp, *ep;
+	struct strbuf msgbuf = STRBUF_INIT;
+	int org_len = len;
+	int i = 1;
 
 	/*
 	 * As a hunk header must begin with "@@ -<old>, +<new> @@",
@@ -384,17 +387,38 @@ static void emit_hunk_header(struct emit_callback *ecbdata,
 	ep += 2; /* skip over @@ */
 
 	/* The hunk header in fraginfo color */
-	emit_line(ecbdata->opt, frag, reset, line, ep - line);
+	strbuf_add(&msgbuf, frag, strlen(frag));
+	strbuf_add(&msgbuf, line, ep - line);
+	strbuf_add(&msgbuf, reset, strlen(reset));
+
+	/*
+	 * trailing \r\n
+	 */
+	for (; i < 3; i++) {
+		if (line[len - i] == '\r' || line[len - i] == '\n') {
+			len --;
+		}
+	}
 
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
1.7.0.2.273.gc2413.dirty
