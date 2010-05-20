From: Bo Yang <struggleyb.nku@gmail.com>
Subject: [PATCH 4/6 v2] Emit a whole line once a time.
Date: Thu, 20 May 2010 03:25:36 -0700
Message-ID: <1274351138-11813-5-git-send-email-struggleyb.nku@gmail.com>
References: <1274351138-11813-1-git-send-email-struggleyb.nku@gmail.com>
 <1274351138-11813-2-git-send-email-struggleyb.nku@gmail.com>
 <1274351138-11813-3-git-send-email-struggleyb.nku@gmail.com>
 <1274351138-11813-4-git-send-email-struggleyb.nku@gmail.com>
Cc: gitster@pobox.com, trast@student.ethz.ch
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 20 12:26:13 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OF2xA-0006qW-Fd
	for gcvg-git-2@lo.gmane.org; Thu, 20 May 2010 12:26:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754408Ab0ETKZ7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 May 2010 06:25:59 -0400
Received: from mail-px0-f174.google.com ([209.85.212.174]:58573 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754169Ab0ETKZ4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 May 2010 06:25:56 -0400
Received: by mail-px0-f174.google.com with SMTP id 18so1244760pxi.19
        for <git@vger.kernel.org>; Thu, 20 May 2010 03:25:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=mNT1fWsn54DB8c23b0re9pfgn/NI8XU0UzmIAodAwcs=;
        b=fJJh9jJkHI2N1sri7hwJW1o5wyfcxmegymuCSQn07NUyUlrlSOloZYS0D3b65JBtCw
         zh2qkGWkX8eKCwWyKnzvNw7pA6ht9CV62zKWJujz+mY6CVPrjfr+2QshjvwQGvdq0W/O
         knrecDqslV8WPD3Jj6AIl/1CQw7sjMtu1pEm8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=kAIRfLLZbuWN9h73KiN6/qica6bu7sWju7Xn6d8LJAAJjd2Wdg+0iYunXntBzrU9Pn
         rWHl4DeIjUQ1lyuWk+suKhuyrPyOAinbd8Eg6XmHzQJ32QbzKIIEjQcOspkG9MBCo5lF
         +obEoxrYqUltaWw0QnS3WrXubwsdkcoyXWFx8=
Received: by 10.114.32.31 with SMTP id f31mr831357waf.195.1274351156525;
        Thu, 20 May 2010 03:25:56 -0700 (PDT)
Received: from localhost.localdomain ([222.30.37.37])
        by mx.google.com with ESMTPS id n32sm76160636wae.22.2010.05.20.03.25.54
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 20 May 2010 03:25:55 -0700 (PDT)
X-Mailer: git-send-email 1.6.0.4
In-Reply-To: <1274351138-11813-4-git-send-email-struggleyb.nku@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147376>

Use a strbuf to compose the whole line, and then
call emit_line to output it once. This make output_prefix
callback works well.

Signed-off-by: Bo Yang <struggleyb.nku@gmail.com>
---
 diff.c |   34 +++++++++++++++++++++++++++++-----
 1 files changed, 29 insertions(+), 5 deletions(-)

diff --git a/diff.c b/diff.c
index 5d1b7b5..69c15a6 100644
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
