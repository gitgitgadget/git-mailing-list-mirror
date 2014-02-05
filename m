From: Jeff King <peff@peff.net>
Subject: [PATCH 04/13] Makefile: use tempfile/mv strategy for GIT-*
Date: Wed, 5 Feb 2014 12:50:30 -0500
Message-ID: <20140205175030.GD15218@sigill.intra.peff.net>
References: <20140205174823.GA15070@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 05 18:50:37 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WB6cP-0007SL-Dx
	for gcvg-git-2@plane.gmane.org; Wed, 05 Feb 2014 18:50:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753229AbaBERud (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Feb 2014 12:50:33 -0500
Received: from cloud.peff.net ([50.56.180.127]:45141 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753029AbaBERuc (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Feb 2014 12:50:32 -0500
Received: (qmail 7620 invoked by uid 102); 5 Feb 2014 17:50:32 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 05 Feb 2014 11:50:32 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 05 Feb 2014 12:50:30 -0500
Content-Disposition: inline
In-Reply-To: <20140205174823.GA15070@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241622>

We create GIT-CFLAGS and related files by echoing into a
shell redirection. It's possible for an error to cause the
file to end up empty or truncated. In theory, this could
cause us to later make an incorrect comparison of the file
contents to a Makefile variable, and avoid rebuilding some
dependencies.

In practice, this is very unlikely to happen, as the
followup run would have to have changed the variable to
match the truncation exactly. However, it is good hygiene to
use our usual tempfile + mv trick to make sure that the file
is created atomically.

Signed-off-by: Jeff King <peff@peff.net>
---
 Makefile | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index 50bf252..b06d5ec 100644
--- a/Makefile
+++ b/Makefile
@@ -1571,7 +1571,8 @@ GIT-$1: FORCE
 	@VALUE='$$(subst ','\'',$3)'; \
 	if test x"$$$$VALUE" != x"`cat $$@ 2>/dev/null`"; then \
 		echo >&2 "    * new $2"; \
-		echo "$$$$VALUE" >$$@; \
+		echo "$$$$VALUE" >$$@+ && \
+		mv $$@+ $$@; \
 	fi
 endef
 
-- 
1.8.5.2.500.g8060133
