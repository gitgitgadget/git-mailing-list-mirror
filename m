From: Jeff King <peff@peff.net>
Subject: [PATCH] rebase: ignore failures from "gc --auto"
Date: Wed, 13 Jan 2016 13:47:18 -0500
Message-ID: <20160113184718.GA5647@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 13 19:47:32 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aJQSA-00046D-Gj
	for gcvg-git-2@plane.gmane.org; Wed, 13 Jan 2016 19:47:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753946AbcAMSrV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Jan 2016 13:47:21 -0500
Received: from cloud.peff.net ([50.56.180.127]:53127 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753545AbcAMSrV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jan 2016 13:47:21 -0500
Received: (qmail 8506 invoked by uid 102); 13 Jan 2016 18:47:20 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 13 Jan 2016 13:47:20 -0500
Received: (qmail 30924 invoked by uid 107); 13 Jan 2016 18:47:39 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 13 Jan 2016 13:47:39 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 13 Jan 2016 13:47:18 -0500
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283965>

After rebasing, we call "gc --auto" to clean up if we
created a lot of loose objects. However, we do so inside an
&&-chain. If "gc --auto" fails (e.g., because a previous
background gc blocked us by leaving "gc.log" in place),
then:

  1. We will fail to clean up the state directory, leaving
     the user stuck in the rebase forever (even "git am
     --abort" doesn't work, because it calls "gc --auto"!).

  2. In some cases, we may return a bogus exit code from
     rebase, indicating failure when everything except the
     auto-gc succeeded.

We can fix this by ignoring the exit code of "gc --auto".

Signed-off-by: Jeff King <peff@peff.net>
---
This bit me just now. The real blocker was "you have too many loose
objects, run 'git prune'" left in the gc.log file.

It looks like this is the only "gc --auto" we call from a shell script,
and all of the C callers already ignore the exit code. So no other spots
need a similar fix.

 git-rebase.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/git-rebase.sh b/git-rebase.sh
index af7ba5f..cf60c43 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -176,7 +176,7 @@ You can run "git stash pop" or "git stash drop" at any time.
 
 finish_rebase () {
 	apply_autostash &&
-	git gc --auto &&
+	{ git gc --auto || true; } &&
 	rm -rf "$state_dir"
 }
 
-- 
2.7.0.242.gdeece69
