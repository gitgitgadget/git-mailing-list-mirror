From: Jeff King <peff@peff.net>
Subject: [PATCH] rebase-interactive: silence warning when no commits
 rewritten
Date: Sun, 18 Apr 2010 08:01:45 -0400
Message-ID: <20100418120145.GA14872@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Thomas Rast <trast@student.ethz.ch>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Apr 18 14:02:44 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O3TCz-0004B4-Bj
	for gcvg-git-2@lo.gmane.org; Sun, 18 Apr 2010 14:02:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757179Ab0DRMCW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Apr 2010 08:02:22 -0400
Received: from peff.net ([208.65.91.99]:39881 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756934Ab0DRMCV (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Apr 2010 08:02:21 -0400
Received: (qmail 1403 invoked by uid 107); 18 Apr 2010 12:02:23 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Sun, 18 Apr 2010 08:02:23 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sun, 18 Apr 2010 08:01:45 -0400
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145219>

If you do a "rebase -i" and don't change any commits,
nothing is rewritten, and we have no REWRITTEN_LIST. The
shell prints out an ugly message:

  $ GIT_EDITOR=true git rebase -i HEAD^
  /path/to/git-rebase--interactive: 1: cannot open
    /path/to/repo/.git/rebase-merge/rewritten-list: No such file
  Successfully rebased and updated refs/heads/master.

We can fix it by not running "notes copy" at all if nothing
was rewritten.

Signed-off-by: Jeff King <peff@peff.net>
---
We already use the same test just below when deciding whether to run the
post-rewrite hook.

 git-rebase--interactive.sh |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index b817c4a..436b7f5 100755
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -562,12 +562,13 @@ do_next () {
 		;;
 	esac && {
 		test ! -f "$DOTEST"/verbose ||
 			git diff-tree --stat $(cat "$DOTEST"/head)..HEAD
 	} &&
 	{
+		test -s "$REWRITTEN_LIST" &&
 		git notes copy --for-rewrite=rebase < "$REWRITTEN_LIST" ||
 		true # we don't care if this copying failed
 	} &&
 	if test -x "$GIT_DIR"/hooks/post-rewrite &&
 		test -s "$REWRITTEN_LIST"; then
 		"$GIT_DIR"/hooks/post-rewrite rebase < "$REWRITTEN_LIST"
-- 
1.7.1.rc1.279.gae4efc.dirty
