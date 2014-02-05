From: Jeff King <peff@peff.net>
Subject: [PATCH 07/13] Makefile: always create files via make-var
Date: Wed, 5 Feb 2014 12:53:16 -0500
Message-ID: <20140205175316.GG15218@sigill.intra.peff.net>
References: <20140205174823.GA15070@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 05 18:53:25 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WB6f5-00015W-1I
	for gcvg-git-2@plane.gmane.org; Wed, 05 Feb 2014 18:53:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753227AbaBERxT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Feb 2014 12:53:19 -0500
Received: from cloud.peff.net ([50.56.180.127]:45147 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752757AbaBERxS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Feb 2014 12:53:18 -0500
Received: (qmail 7796 invoked by uid 102); 5 Feb 2014 17:53:18 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 05 Feb 2014 11:53:18 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 05 Feb 2014 12:53:16 -0500
Content-Disposition: inline
In-Reply-To: <20140205174823.GA15070@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241625>

If we are trying to store an empty sentinel value for a
make-var, we would consider a missing file the same as an
empty variable. E.g., repeatedly running:

  make GIT_USER_AGENT=

will not create MAKE/USER-AGENT at all if it does not exist,
and subsequent make invocations will force a rebuild. This
is not generally a problem in practice, since most of the
files always have some boilerplate (even LDFLAGS, because it
is formed with "+=", will have a stray space in it). But
this does fix the rare case, and future-proofs us as we add
more similar variables.

Signed-off-by: Jeff King <peff@peff.net>
---
 Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index 7fecdf1..e12039f 100644
--- a/Makefile
+++ b/Makefile
@@ -1569,7 +1569,7 @@ endif
 define make-var
 MAKE/$1: FORCE
 	@VALUE='$$(subst ','\'',$3)'; \
-	if test x"$$$$VALUE" != x"`cat $$@ 2>/dev/null`"; then \
+	if ! test -e $$@ || test x"$$$$VALUE" != x"`cat $$@`"; then \
 		echo >&2 "    * new $2"; \
 		printf '%s\n' "$$$$VALUE" >$$@+ && \
 		mv $$@+ $$@; \
-- 
1.8.5.2.500.g8060133
