From: Jeff King <peff@peff.net>
Subject: [PATCH 05/13] Makefile: prefer printf to echo for GIT-*
Date: Wed, 5 Feb 2014 12:50:54 -0500
Message-ID: <20140205175054.GE15218@sigill.intra.peff.net>
References: <20140205174823.GA15070@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 05 18:51:04 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WB6cm-0007m8-6A
	for gcvg-git-2@plane.gmane.org; Wed, 05 Feb 2014 18:51:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753288AbaBERu4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Feb 2014 12:50:56 -0500
Received: from cloud.peff.net ([50.56.180.127]:45143 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753029AbaBERu4 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Feb 2014 12:50:56 -0500
Received: (qmail 7636 invoked by uid 102); 5 Feb 2014 17:50:56 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 05 Feb 2014 11:50:55 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 05 Feb 2014 12:50:54 -0500
Content-Disposition: inline
In-Reply-To: <20140205174823.GA15070@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241623>

When we write Makefile variables to a sentinel file, we use
"echo" to do so. Since we are writing arbitrary data which
may contain backslash escapes (particularly with file paths
on Windows), echo may or may not expand those escapes,
depending on which shell is in use.

During the next run of "make", we check the sentinel file to
see if it is different than the Makefile variable. If
escapes were expanded, then we will erroneously think it
changed and trigger a rebuild. You can see this easily by
running:

  make prefix='foo\bar'

multiple times; it will re-build some files repeatedly.

Signed-off-by: Jeff King <peff@peff.net>
---
 Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index b06d5ec..60dc53b 100644
--- a/Makefile
+++ b/Makefile
@@ -1571,7 +1571,7 @@ GIT-$1: FORCE
 	@VALUE='$$(subst ','\'',$3)'; \
 	if test x"$$$$VALUE" != x"`cat $$@ 2>/dev/null`"; then \
 		echo >&2 "    * new $2"; \
-		echo "$$$$VALUE" >$$@+ && \
+		printf '%s\n' "$$$$VALUE" >$$@+ && \
 		mv $$@+ $$@; \
 	fi
 endef
-- 
1.8.5.2.500.g8060133
