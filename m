From: Jeff King <peff@peff.net>
Subject: [PATCH 1/2] prompt: clean up strbuf usage
Date: Fri, 3 Feb 2012 17:14:11 -0500
Message-ID: <20120203221411.GA8065@sigill.intra.peff.net>
References: <20120203213654.GD1890@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Feanil Patel <feanil@gmail.com>, git@vger.kernel.org
To: Neal Groothuis <ngroot@lo-cal.org>
X-From: git-owner@vger.kernel.org Fri Feb 03 23:14:39 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RtROt-000779-FS
	for gcvg-git-2@plane.gmane.org; Fri, 03 Feb 2012 23:14:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757809Ab2BCWOO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Feb 2012 17:14:14 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:56056
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753117Ab2BCWON (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Feb 2012 17:14:13 -0500
Received: (qmail 2878 invoked by uid 107); 3 Feb 2012 22:21:19 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 03 Feb 2012 17:21:19 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 03 Feb 2012 17:14:11 -0500
Content-Disposition: inline
In-Reply-To: <20120203213654.GD1890@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189815>

The do_askpass function inherited a few bad habits from the
original git_getpass. One, there's no need to strbuf_reset a
buffer which was just initialized. And two, it's a good
habit to use strbuf_detach to claim ownership of a buffer's
string (even though in this case the owning buffer goes out
of scope, so it's effectively the same thing).

Signed-off-by: Jeff King <peff@peff.net>
---
Neither is a big deal, but just some style cleanups while I was in the
area.

 prompt.c |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/prompt.c b/prompt.c
index 72ab9de..64f817b 100644
--- a/prompt.c
+++ b/prompt.c
@@ -21,7 +21,6 @@ static char *do_askpass(const char *cmd, const char *prompt)
 	if (start_command(&pass))
 		exit(1);
 
-	strbuf_reset(&buffer);
 	if (strbuf_read(&buffer, pass.out, 20) < 0)
 		die("failed to get '%s' from %s\n", prompt, cmd);
 
@@ -32,7 +31,7 @@ static char *do_askpass(const char *cmd, const char *prompt)
 
 	strbuf_setlen(&buffer, strcspn(buffer.buf, "\r\n"));
 
-	return buffer.buf;
+	return strbuf_detach(&buffer, NULL);
 }
 
 char *git_prompt(const char *prompt, int flags)
-- 
1.7.9.rc1.28.gf4be5
