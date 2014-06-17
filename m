From: Jeff King <peff@peff.net>
Subject: [PATCH 2/5] t7510: use consistent &&-chains in loop
Date: Mon, 16 Jun 2014 20:03:43 -0400
Message-ID: <20140617000343.GB17110@sigill.intra.peff.net>
References: <20140616235917.GA19499@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>,
	Michael J Gruber <git@drmicha.warpmail.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 17 02:03:49 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WwgsO-0006Hr-R6
	for gcvg-git-2@plane.gmane.org; Tue, 17 Jun 2014 02:03:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751886AbaFQADo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Jun 2014 20:03:44 -0400
Received: from cloud.peff.net ([50.56.180.127]:45638 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751517AbaFQADo (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Jun 2014 20:03:44 -0400
Received: (qmail 27025 invoked by uid 102); 17 Jun 2014 00:03:44 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 16 Jun 2014 19:03:44 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 16 Jun 2014 20:03:43 -0400
Content-Disposition: inline
In-Reply-To: <20140616235917.GA19499@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251833>

From: Michael J Gruber <git@drmicha.warpmail.net>

We check multiple commits in a loop. Because we want to
break out of the loop if any single iteration fails, we use
a subshell/exit like:

  (
	for i in $stuff
	do
		do-something $i || exit 1
	done
  )

However, we are inconsistent in our loop body. Some commands
get their own "|| exit 1", and others try to chain to the
next command with "&&", like:

  X &&
  Y || exit 1
  Z || exit 1

This is a little hard to read and follow, because X and Y
are treated differently for no good reason. But much worse,
the second loop follows a similar pattern and gets it wrong.
"Y" is expected to fail, so we use "&& exit 1", giving us:

  X &&
  Y && exit 1
  Z || exit 1

That gets the test for X wrong (we do not exit unless both X
fails and Y unexpectedly succeeds, but we would want to exit
if _either_ is wrong). We can write this clearly and
correctly by consistently using "&&", followed by a single
"|| exit 1", and negating Y with "!" (as we would in a
normal &&-chain). Like:

  X &&
  ! Y &&
  Z || exit 1

Signed-off-by: Jeff King <peff@peff.net>
---
I listed Michael as the author here, because this is the patch that I
expected to come in his next re-roll, based on our discussion. I'm
including it here because I'm about to touch the same area (and Michael,
you'd probably want to rebase on top of this series anyway. Assuming I
haven't screwed it up :) ).

 t/t7510-signed-commit.sh | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/t/t7510-signed-commit.sh b/t/t7510-signed-commit.sh
index 37c3778..cdffcbd 100755
--- a/t/t7510-signed-commit.sh
+++ b/t/t7510-signed-commit.sh
@@ -50,18 +50,18 @@ test_expect_success GPG 'show signatures' '
 		for commit in initial second merge fourth-signed fifth-signed sixth-signed seventh-signed
 		do
 			git show --pretty=short --show-signature $commit >actual &&
-			grep "Good signature from" actual || exit 1
-			! grep "BAD signature from" actual || exit 1
-			echo $commit OK
+			grep "Good signature from" actual &&
+			! grep "BAD signature from" actual &&
+			echo $commit OK || exit 1
 		done
 	) &&
 	(
 		for commit in merge^2 fourth-unsigned sixth-unsigned seventh-unsigned
 		do
 			git show --pretty=short --show-signature $commit >actual &&
-			grep "Good signature from" actual && exit 1
-			! grep "BAD signature from" actual || exit 1
-			echo $commit OK
+			! grep "Good signature from" actual &&
+			! grep "BAD signature from" actual &&
+			echo $commit OK || exit 1
 		done
 	)
 '
-- 
2.0.0.566.gfe3e6b2
