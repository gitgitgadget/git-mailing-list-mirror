From: Jeff King <peff@peff.net>
Subject: [PATCH 1/2] pull: update unborn branch tip after index
Date: Thu, 20 Jun 2013 18:36:31 -0400
Message-ID: <20130620223630.GA18675@sigill.intra.peff.net>
References: <20130620223550.GA21667@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Thomas Rast <trast@inf.ethz.ch>,
	Stefan =?utf-8?B?U2Now7zDn2xlcg==?= <mail@stefanschuessler.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jun 21 00:36:42 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UpnT5-0006h8-Hs
	for gcvg-git-2@plane.gmane.org; Fri, 21 Jun 2013 00:36:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030430Ab3FTWgf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Jun 2013 18:36:35 -0400
Received: from cloud.peff.net ([50.56.180.127]:60524 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030368Ab3FTWge (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Jun 2013 18:36:34 -0400
Received: (qmail 17886 invoked by uid 102); 20 Jun 2013 22:37:34 -0000
Received: from c-98-244-76-202.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (98.244.76.202)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 20 Jun 2013 17:37:34 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 20 Jun 2013 18:36:31 -0400
Content-Disposition: inline
In-Reply-To: <20130620223550.GA21667@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228551>

When commit d09e79c taught git to pull into an unborn
branch, it first updated the unborn branch to point at the
pulled commit, and then used read-tree to update the index
and working tree. That ordering made sense, since any
failure of the latter step would be due to filesystem
errors, and one could then recover with "git reset --hard".

Later, commit 4b3ffe5 added extra safety for existing files
in the working tree by asking read-tree to bail out when it
would overwrite such a file. This error mode is much less
"your pull failed due to random errors" and more like "we
reject this pull because it would lose data". In that case,
it makes sense not to update the HEAD ref, just as a regular
rejected merge would do.

This patch reverses the order of the update-ref and
read-tree calls, so that we do not touch the HEAD ref at all if a
merge is rejected. This also means that we would not update
HEAD in case of a transient filesystem error, but those are
presumably less rare (and one can still recover by repeating
the pull, or by accessing FETCH_HEAD directly).

While we're reorganizing the code, we can drop the "exit 1"
from the end of our command chain. We exit immediately
either way, and just calling exit without an argument will
use the exit code from the last command.

Signed-off-by: Jeff King <peff@peff.net>
---
 git-pull.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/git-pull.sh b/git-pull.sh
index 638aabb..7904753 100755
--- a/git-pull.sh
+++ b/git-pull.sh
@@ -268,8 +268,8 @@ then
 
 if test -z "$orig_head"
 then
-	git update-ref -m "initial pull" HEAD $merge_head "$curr_head" &&
-	git read-tree -m -u HEAD || exit 1
+	git read-tree -m -u $merge_head &&
+	git update-ref -m "initial pull" HEAD $merge_head "$curr_head"
 	exit
 fi
 
-- 
1.8.3.rc2.14.g7eee6b3
