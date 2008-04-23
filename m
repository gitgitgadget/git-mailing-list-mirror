From: Jeff King <peff@peff.net>
Subject: Re: Friendly refspecs
Date: Wed, 23 Apr 2008 05:21:45 -0400
Message-ID: <20080423092144.GA11368@sigill.intra.peff.net>
References: <20080416034823.GA11727@sigill.intra.peff.net> <alpine.LNX.1.00.0804161126280.19665@iabervon.org> <7vod89pnxx.fsf@gitster.siamese.dyndns.org> <20080422105658.GA11238@sigill.intra.peff.net> <7v63u9zva9.fsf@gitster.siamese.dyndns.org> <20080422200550.GB29313@sigill.intra.peff.net> <7vd4ohy5ym.fsf@gitster.siamese.dyndns.org> <20080423042433.GA3291@mithlond.arda.local> <7v1w4xuni1.fsf@gitster.siamese.dyndns.org> <20080423091606.GC11935@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Teemu Likonen <tlikonen@iki.fi>,
	Daniel Barkalow <barkalow@iabervon.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 23 11:22:35 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JobBS-00081M-RM
	for gcvg-git-2@gmane.org; Wed, 23 Apr 2008 11:22:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750924AbYDWJVr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Apr 2008 05:21:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750914AbYDWJVr
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Apr 2008 05:21:47 -0400
Received: from peff.net ([208.65.91.99]:2092 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750738AbYDWJVq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Apr 2008 05:21:46 -0400
Received: (qmail 9570 invoked by uid 111); 23 Apr 2008 09:21:44 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Wed, 23 Apr 2008 05:21:44 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 23 Apr 2008 05:21:45 -0400
Content-Disposition: inline
In-Reply-To: <20080423091606.GC11935@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80204>

On Wed, Apr 23, 2008 at 05:16:06AM -0400, Jeff King wrote:

> > Historically we did not favor one way or another for the general purpose
> > syntax.  I think Jeff's proposed heuristics to favor branch if a branch
> > tip is pushed and tag if a tag is pushed makes sense.
> 
> OK, here is a cleaned up patch with tests.

Oops, I forgot to mention: there is a broken test in t5516 that is
revealed by this change. The patch below should be applied before the
DWIM one.

-- >8 --
t5516: remove ambiguity test (1)

This test tried to push into a remote with ambiguous refs in
remotes/$x/master and remotes/$y/master. However, the remote
never actually tells us about the refs/remotes hierarchy, so
we don't even see this ambiguity.

The test happened to pass because we were simply looking for
failure, and the test fails for another reason: the dst
refspec does not exist and does not begin with refs/, making
it invalid.

Signed-off-by: Jeff King <peff@peff.net>
---
 t/t5516-fetch-push.sh |   14 +-------------
 1 files changed, 1 insertions(+), 13 deletions(-)

diff --git a/t/t5516-fetch-push.sh b/t/t5516-fetch-push.sh
index 6d7e738..f93a100 100755
--- a/t/t5516-fetch-push.sh
+++ b/t/t5516-fetch-push.sh
@@ -209,19 +209,7 @@ test_expect_success 'push with weak ambiguity (2)' '
 
 '
 
-test_expect_success 'push with ambiguity (1)' '
-
-	mk_test remotes/origin/master remotes/frotz/master &&
-	if git push testrepo master:master
-	then
-		echo "Oops, should have failed"
-		false
-	else
-		check_push_result $the_first_commit remotes/origin/master remotes/frotz/master
-	fi
-'
-
-test_expect_success 'push with ambiguity (2)' '
+test_expect_success 'push with ambiguity' '
 
 	mk_test heads/frotz tags/frotz &&
 	if git push testrepo master:frotz
-- 
1.5.5.1.69.g9c889.dirty
