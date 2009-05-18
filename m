From: Jeff King <peff@peff.net>
Subject: [PATCH] for-each-ref: fix segfault in copy_email
Date: Mon, 18 May 2009 13:58:11 -0400
Message-ID: <20090518175811.GB14509@sigill.intra.peff.net>
References: <20090518151440.GA10536@andros.its.yale.edu> <4A118696.80902@drmicha.warpmail.net> <alpine.LFD.2.01.0905181015080.3301@localhost.localdomain> <20090518174547.GA14509@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	dloewenherz@gmail.com, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon May 18 19:58:25 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M676U-0007Me-5E
	for gcvg-git-2@gmane.org; Mon, 18 May 2009 19:58:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751450AbZERR6N (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 May 2009 13:58:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751218AbZERR6M
	(ORCPT <rfc822;git-outgoing>); Mon, 18 May 2009 13:58:12 -0400
Received: from peff.net ([208.65.91.99]:49556 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751160AbZERR6L (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 May 2009 13:58:11 -0400
Received: (qmail 18584 invoked by uid 107); 18 May 2009 17:58:15 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Mon, 18 May 2009 13:58:15 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 18 May 2009 13:58:11 -0400
Content-Disposition: inline
In-Reply-To: <20090518174547.GA14509@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119461>

You can trigger a segfault in git.git by doing:

  git for-each-ref --format='%(taggeremail)' refs/tags/v0.99

The v0.99 tag is special in that it contains no "tagger"
header.

The bug is obvious in copy_email, which carefully checks to
make sure the result of a strchr is non-NULL, but only after
already having used it to perform other work. The fix is to
move the check up.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin-for-each-ref.c |    7 +++++--
 1 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/builtin-for-each-ref.c b/builtin-for-each-ref.c
index 91e8f95..d091e04 100644
--- a/builtin-for-each-ref.c
+++ b/builtin-for-each-ref.c
@@ -339,8 +339,11 @@ static const char *copy_name(const char *buf)
 static const char *copy_email(const char *buf)
 {
 	const char *email = strchr(buf, '<');
-	const char *eoemail = strchr(email, '>');
-	if (!email || !eoemail)
+	const char *eoemail;
+	if (!email)
+		return "";
+	eoemail = strchr(email, '>');
+	if (!eoemail)
 		return "";
 	return xmemdupz(email, eoemail + 1 - email);
 }
-- 
1.6.3.1.137.g9019.dirty
