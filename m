From: Jeff King <peff@peff.net>
Subject: [PATCH] fix color.pager = false with "git diff"
Date: Thu, 21 Oct 2010 11:02:45 -0400
Message-ID: <20101021150244.GA18426@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Oct 21 17:02:17 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P8wek-0000oS-DQ
	for gcvg-git-2@lo.gmane.org; Thu, 21 Oct 2010 17:02:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756815Ab0JUPCG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Oct 2010 11:02:06 -0400
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:41852 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754029Ab0JUPCF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Oct 2010 11:02:05 -0400
Received: (qmail 6286 invoked by uid 111); 21 Oct 2010 15:02:02 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO sigill.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Thu, 21 Oct 2010 15:02:02 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 21 Oct 2010 11:02:45 -0400
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159512>

The color code makes a decision early on about whether to
use colors based on the config and whether we are using a
pager. For the most part, this works, because if we are
using a pager, we will start it more or less immediately.

In the case of diff, however, we delay starting the pager in
case --exit-code is being used. If this happens, then the
color code makes the wrong decision (because it doesn't
yet realize we are using a pager), and we need to correct
the decision after deciding whether to use a pager.

Signed-off-by: Jeff King <peff@peff.net>
---
Original discussion here:

  http://thread.gmane.org/gmane.comp.version-control.git/89599

I have mixed feelings on this one. It's kind of a hack. A more elegant
solution would be totally rewriting the color code to check for the
pager at first output.

In favor of this patch:

  1. It fixes a real bug.

  2. Perfect is the enemy of the good, and I don't care enough about
     this case to refactor the color code.

Against:

  1. It does nothing to fix other times when this ordering problem may
     arise (I don't think there are others, but I didn't check very
     thoroughly. And of course new ones may appear).

  2. The bug was reported over 2 years ago, and hasn't come up since,
     despite remaining unfixed.  Maybe nobody actually cares.

 builtin/diff.c |   15 +++++++++++++++
 1 files changed, 15 insertions(+), 0 deletions(-)

diff --git a/builtin/diff.c b/builtin/diff.c
index a43d326..cbe15c9 100644
--- a/builtin/diff.c
+++ b/builtin/diff.c
@@ -318,6 +318,21 @@ int cmd_diff(int argc, const char **argv, const char *prefix)
 		setup_pager();
 
 	/*
+	 * Special case: we have already examined the config for
+	 * color, but we didn't know at that point whether we were
+	 * going to start a pager. The only case that we care about is
+	 * when we turned on color, but shouldn't have (we will never
+	 * "should have but didn't" because of the pager, since
+	 * a lack of a pager implies either the tty is stdout, in
+	 * which case we do turn on color, or it is not, in which
+	 * case we don't start a pager).
+	 */
+	if (DIFF_OPT_TST(&rev.diffopt, COLOR_DIFF) &&
+	    pager_in_use() &&
+	    !pager_use_color)
+		DIFF_OPT_CLR(&rev.diffopt, COLOR_DIFF);
+
+	/*
 	 * Do we have --cached and not have a pending object, then
 	 * default to HEAD by hand.  Eek.
 	 */
-- 
1.7.3.1.235.gdd6c0
