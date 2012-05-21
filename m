From: Jeff King <peff@peff.net>
Subject: [PATCHv2 06/15] ident: trim trailing newline from /etc/mailname
Date: Mon, 21 May 2012 19:10:02 -0400
Message-ID: <20120521231002.GF10981@sigill.intra.peff.net>
References: <20120521230917.GA474@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Angus Hammond <angusgh@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue May 22 01:10:15 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SWbjy-0007Tj-Bg
	for gcvg-git-2@plane.gmane.org; Tue, 22 May 2012 01:10:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754495Ab2EUXKG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 May 2012 19:10:06 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:51215
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754182Ab2EUXKF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 May 2012 19:10:05 -0400
Received: (qmail 7787 invoked by uid 107); 21 May 2012 23:10:30 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 21 May 2012 19:10:30 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 21 May 2012 19:10:02 -0400
Content-Disposition: inline
In-Reply-To: <20120521230917.GA474@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198151>

We use fgets to read the /etc/mailname file, which means we
will typically end up with an extra newline in our
git_default_email. Most of the time this doesn't matter, as
fmt_ident will skip it as cruft, but there is one code path
that accesses it directly (in http-push.c:lock_remote).

Signed-off-by: Jeff King <peff@peff.net>
---
 ident.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/ident.c b/ident.c
index af92b2c..acb3a08 100644
--- a/ident.c
+++ b/ident.c
@@ -74,6 +74,10 @@ static int add_mailname_host(char *buf, size_t len)
 	}
 	/* success! */
 	fclose(mailname);
+
+	len = strlen(buf);
+	if (len && buf[len-1] == '\n')
+		buf[len-1] = '\0';
 	return 0;
 }
 
-- 
1.7.10.1.19.g711d603
