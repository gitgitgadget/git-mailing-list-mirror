From: Jeff King <peff@peff.net>
Subject: [PATCH 02/13] Makefile: fix git-instaweb dependency on gitweb
Date: Wed, 5 Feb 2014 12:49:23 -0500
Message-ID: <20140205174923.GB15218@sigill.intra.peff.net>
References: <20140205174823.GA15070@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 05 18:49:31 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WB6bK-0006c1-TR
	for gcvg-git-2@plane.gmane.org; Wed, 05 Feb 2014 18:49:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753316AbaBERt0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Feb 2014 12:49:26 -0500
Received: from cloud.peff.net ([50.56.180.127]:45136 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753029AbaBERtZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Feb 2014 12:49:25 -0500
Received: (qmail 7547 invoked by uid 102); 5 Feb 2014 17:49:25 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 05 Feb 2014 11:49:25 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 05 Feb 2014 12:49:23 -0500
Content-Disposition: inline
In-Reply-To: <20140205174823.GA15070@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241620>

We build git-instaweb if NO_PERL is not defined, and it in
turns depends on "gitweb", which causes us to descend into
the gitweb subdir and recursively invoke make. But because
gitweb is marked as .PHONY, this forces a rebuild of
git-instaweb every time we run make.

We can drop the dependency of git-instaweb on gitweb.
However, that means we do not recurse into "gitweb" at all,
so we have to add back in the dependency to "all".

Note that the other subdirectories (like git-gui/ or perl/)
are handled directly as build commands of "all", and we
could simply do the same thing here. However, this patch
keeps "gitweb" as a target so that "make gitweb" continues
to work, in case anybody is using that.

Signed-off-by: Jeff King <peff@peff.net>
---
 Makefile | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index 3cd4a92..1f3e5d9 100644
--- a/Makefile
+++ b/Makefile
@@ -1818,8 +1818,9 @@ GIT-PERL-DEFINES: FORCE
 .PHONY: gitweb
 gitweb:
 	$(QUIET_SUBDIR0)gitweb $(QUIET_SUBDIR1) all
+all:: gitweb
 
-git-instaweb: git-instaweb.sh gitweb GIT-SCRIPT-DEFINES
+git-instaweb: git-instaweb.sh GIT-SCRIPT-DEFINES
 	$(QUIET_GEN)$(cmd_munge_script) && \
 	chmod +x $@+ && \
 	mv $@+ $@
-- 
1.8.5.2.500.g8060133
