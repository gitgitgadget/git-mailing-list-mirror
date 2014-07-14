From: Jeff King <peff@peff.net>
Subject: [PATCH/RFH 0/3] stable priority-queue
Date: Mon, 14 Jul 2014 01:40:22 -0400
Message-ID: <20140714054021.GA4422@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 14 07:40:33 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X6Z02-00053c-UL
	for gcvg-git-2@plane.gmane.org; Mon, 14 Jul 2014 07:40:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752274AbaGNFkZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Jul 2014 01:40:25 -0400
Received: from cloud.peff.net ([50.56.180.127]:33410 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750844AbaGNFkY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Jul 2014 01:40:24 -0400
Received: (qmail 31566 invoked by uid 102); 14 Jul 2014 05:40:24 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 14 Jul 2014 00:40:24 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 14 Jul 2014 01:40:22 -0400
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253470>

As Junio and I discussed earlier in [1], this series makes the
prio_queue struct stable with respect to object insertion (which in turn
means we can use it to replace commit_list in more places).

I think everything here is correct, but the second commit fails the
final test in t5539. I think the test is just flaky (hence the RFH and
cc to Duy).

That test creates some unrelated commits in two separate repositories,
and then fetches from one to the other. Since the commit creation
happens in a subshell, the first commit in each ends up with the same
test_tick value. When fetch-pack looks at the two root commits
"unrelated1" and "new-too", the exact sequence of ACKs is different
depending on which one it pulls out of the queue first.

With the current code, it happens to be "unrelated1" (though this is not
at all guaranteed by the prio_queue data structure, it is deterministic
for this particular sequence of input). We see the ready-ACK, and the
test succeeds.

With the stable queue, we reliably get "new-too" out (since it is our
local tip, it is added to the queue before we even talk to the remote).
We never see a ready-ACK, and the test fails due to the grep on the
TRACE_PACKET output at the end (the fetch itself succeeds as expected).

I'm really not quite clear on what's supposed to be going on in the
test. I can make it pass with:

diff --git a/t/t5539-fetch-http-shallow.sh b/t/t5539-fetch-http-shallow.sh
index 94553e1..b461188 100755
--- a/t/t5539-fetch-http-shallow.sh
+++ b/t/t5539-fetch-http-shallow.sh
@@ -54,6 +54,7 @@ EOF
 test_expect_success 'no shallow lines after receiving ACK ready' '
 	(
 		cd shallow &&
+		test_tick &&
 		for i in $(test_seq 15)
 		do
 			git checkout --orphan unrelated$i &&

which just bumps the timestamp for the unrelated* commits (so that they
are always more recent than "new-too" and get picked first). I'm not
sure if that is too hacky, or if there's a more robust way to set up the
test.

Anyway, here are the patches.

  [1/3]: prio-queue: factor out compare and swap operations
  [2/3]: prio-queue: make output stable with respect to insertion
  [3/3]: paint_down_to_common: use prio_queue

-Peff

[1] http://thread.gmane.org/gmane.comp.version-control.git/252472/focus=252475
