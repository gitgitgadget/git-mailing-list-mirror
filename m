From: Jeff King <peff@peff.net>
Subject: [PATCH 1/3] Makefile: drop dependency between git-instaweb and gitweb
Date: Fri, 29 May 2015 03:25:45 -0400
Message-ID: <20150529072545.GA9670@peff.net>
References: <20150529072119.GA5415@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 29 09:25:54 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YyEfw-0004Pc-N7
	for gcvg-git-2@plane.gmane.org; Fri, 29 May 2015 09:25:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754653AbbE2HZt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 May 2015 03:25:49 -0400
Received: from cloud.peff.net ([50.56.180.127]:37503 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752189AbbE2HZr (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 May 2015 03:25:47 -0400
Received: (qmail 8344 invoked by uid 102); 29 May 2015 07:25:47 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 29 May 2015 02:25:47 -0500
Received: (qmail 23523 invoked by uid 107); 29 May 2015 07:25:46 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 29 May 2015 03:25:46 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 29 May 2015 03:25:45 -0400
Content-Disposition: inline
In-Reply-To: <20150529072119.GA5415@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270211>

The rule for "git-instaweb" depends on "gitweb". This makes
no sense, because:

  1. git-instaweb has no build-time dependency on gitweb; it
     is a run-time dependency

  2. gitweb is a directory that we want to recursively make
     in. As a result, its recipe is marked .PHONY, which
     causes "make" to rebuild git-instaweb every time it is
     run.

Signed-off-by: Jeff King <peff@peff.net>
---
Note that this actually means we won't build "gitweb" at all with just
"make". It's possible that might break somebody's packaging script that
does:

  make &&
  cp gitweb/gitweb /some/place

I'm not incredibly concerned with that, as it was only being built as a
bizarre side effect here, and they should probably be doing "make
gitweb" (or "cd gitweb && make") if that's what they want to build.

But if we do want to build it by default, we can add it into the "all::"
rule, as we do for "templates".

 Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index 323c401..6283353 100644
--- a/Makefile
+++ b/Makefile
@@ -1784,7 +1784,7 @@ GIT-PERL-DEFINES: FORCE
 gitweb:
 	$(QUIET_SUBDIR0)gitweb $(QUIET_SUBDIR1) all
 
-git-instaweb: git-instaweb.sh gitweb GIT-SCRIPT-DEFINES
+git-instaweb: git-instaweb.sh GIT-SCRIPT-DEFINES
 	$(QUIET_GEN)$(cmd_munge_script) && \
 	chmod +x $@+ && \
 	mv $@+ $@
-- 
2.4.2.668.gc3b1ade.dirty
