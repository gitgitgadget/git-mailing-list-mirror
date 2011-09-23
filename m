From: Jeff King <peff@peff.net>
Subject: [PATCH] credential-cache: don't cache items without context
Date: Fri, 23 Sep 2011 17:53:24 -0400
Message-ID: <20110923215324.GA3013@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 23 23:53:36 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R7Dgd-0001aK-MG
	for gcvg-git-2@lo.gmane.org; Fri, 23 Sep 2011 23:53:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752561Ab1IWVx2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Sep 2011 17:53:28 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:41876
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752551Ab1IWVx1 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Sep 2011 17:53:27 -0400
Received: (qmail 21603 invoked by uid 107); 23 Sep 2011 21:58:27 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 23 Sep 2011 17:58:27 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 23 Sep 2011 17:53:24 -0400
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182005>

The credential helper should get a --unique=<whatever>
context from the callers.  It would be meaningless to cache
a username and password combination without being given any
context, since we have no idea when we should use them
again. The current code will reuse them next time we have no
context again, but that is probably not sane; there is no
guarantee that it is the same "lack of context" situation.

Git doesn't currently actually make requests of credential
helpers without a context, so this is a non-issue outside of
specialized testing. But it should do the sane thing given
any input, and it's nice to set a good example for other
helpers (which may not be tied to a specific git version,
and so arguments like "git doesn't currently do this" don't
apply to them).

Signed-off-by: Jeff King <peff@peff.net>
---
On top of jk/http-auth-keyring, naturally.

 credential-cache.c |    8 +++++---
 1 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/credential-cache.c b/credential-cache.c
index f495043..14d751e 100644
--- a/credential-cache.c
+++ b/credential-cache.c
@@ -155,9 +155,11 @@ int main(int argc, const char **argv)
 	printf("username=%s\n", c.username);
 	printf("password=%s\n", c.password);
 
-	if (do_cache(socket_path, "store", &c, timeout) < 0) {
-		spawn_daemon(socket_path);
-		do_cache(socket_path, "store", &c, timeout);
+	if (c.unique) {
+		if (do_cache(socket_path, "store", &c, timeout) < 0) {
+			spawn_daemon(socket_path);
+			do_cache(socket_path, "store", &c, timeout);
+		}
 	}
 	return 0;
 }
-- 
1.7.7.rc2.4.ga9aee2.dirty
