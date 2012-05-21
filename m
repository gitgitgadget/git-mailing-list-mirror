From: Jeff King <peff@peff.net>
Subject: [PATCHv2 14/15] ident: trim whitespace from default name/email
Date: Mon, 21 May 2012 19:10:29 -0400
Message-ID: <20120521231029.GN10981@sigill.intra.peff.net>
References: <20120521230917.GA474@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Angus Hammond <angusgh@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue May 22 01:10:51 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SWbkW-00008T-RR
	for gcvg-git-2@plane.gmane.org; Tue, 22 May 2012 01:10:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757810Ab2EUXKh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 May 2012 19:10:37 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:51244
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757679Ab2EUXKc (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 May 2012 19:10:32 -0400
Received: (qmail 7976 invoked by uid 107); 21 May 2012 23:10:57 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 21 May 2012 19:10:57 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 21 May 2012 19:10:29 -0400
Content-Disposition: inline
In-Reply-To: <20120521230917.GA474@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198156>

Usually these values get fed to fmt_ident, which will trim
any cruft anyway, but there are a few code paths which use
them directly. Let's clean them up for the benefit of those
callers. Furthermore, fmt_ident will look at the pre-trimmed
value and decide whether to invoke ERROR_ON_NO_NAME; this
check can be fooled by a name consisting only of spaces.

Note that we only bother to clean up when we are pulling the
information from gecos or from system files. Any other value
comes from a config file, where we will have cleaned up
accidental whitespace already.

Signed-off-by: Jeff King <peff@peff.net>
---
 ident.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/ident.c b/ident.c
index cefb829..e279039 100644
--- a/ident.c
+++ b/ident.c
@@ -95,8 +95,10 @@ static void copy_email(const struct passwd *pw, struct strbuf *email)
 
 const char *ident_default_name(void)
 {
-	if (!git_default_name.len)
+	if (!git_default_name.len) {
 		copy_gecos(xgetpwuid_self(), &git_default_name);
+		strbuf_trim(&git_default_name);
+	}
 	return git_default_name.buf;
 }
 
@@ -110,6 +112,7 @@ const char *ident_default_email(void)
 			user_ident_explicitly_given |= IDENT_MAIL_GIVEN;
 		} else
 			copy_email(xgetpwuid_self(), &git_default_email);
+		strbuf_trim(&git_default_email);
 	}
 	return git_default_email.buf;
 }
-- 
1.7.10.1.19.g711d603
