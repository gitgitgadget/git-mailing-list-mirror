From: Jeff King <peff@peff.net>
Subject: Re: bug? in checkout with ambiguous refnames
Date: Tue, 11 Jan 2011 13:02:08 -0500
Message-ID: <20110111180208.GC1833@sigill.intra.peff.net>
References: <20110107104650.GA5399@pengutronix.de>
 <20110107194909.GB6175@sigill.intra.peff.net>
 <20110107195417.GC6175@sigill.intra.peff.net>
 <7vsjx449bv.fsf@alter.siamese.dyndns.org>
 <7vipy0483h.fsf@alter.siamese.dyndns.org>
 <20110111065207.GF10094@sigill.intra.peff.net>
 <7vvd1v4bmt.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
	<u.kleine-koenig@pengutronix.de>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jan 11 19:02:19 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PciXy-0005jp-R3
	for gcvg-git-2@lo.gmane.org; Tue, 11 Jan 2011 19:02:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756232Ab1AKSCO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Jan 2011 13:02:14 -0500
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:57049 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751596Ab1AKSCM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Jan 2011 13:02:12 -0500
Received: (qmail 14565 invoked by uid 111); 11 Jan 2011 18:02:10 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO sigill.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Tue, 11 Jan 2011 18:02:10 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 11 Jan 2011 13:02:08 -0500
Content-Disposition: inline
In-Reply-To: <7vvd1v4bmt.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164964>

On Tue, Jan 11, 2011 at 09:02:18AM -0800, Junio C Hamano wrote:

> > Also, one other question while we are on the subject. I think we all
> > agree that "git checkout $foo" should prefer $foo as a branch. But what
> > about "git checkout -b $branch $start_point"?
> 
> That has always been defined as a synonym for
> 
> 	git branch $branch $start_point && git checkout $branch
> 
> so $start_point is just a random extended SHA-1 expression.

That's what I would have expected, but I wanted to write a test to make
sure it was the case.

But it's not. Even taking away the die, my second test here fails (built
on top of the three previous commits under discussion):

diff --git a/t/t2019-checkout-amiguous-ref.sh b/t/t2019-checkout-amiguous-ref.sh
index e2b330b..7a6b30b 100755
--- a/t/t2019-checkout-amiguous-ref.sh
+++ b/t/t2019-checkout-amiguous-ref.sh
@@ -50,4 +50,13 @@ test_expect_success VAGUENESS_SUCCESS 'checkout reports switch to detached HEAD'
 	! grep "^HEAD is now at" stderr
 '
 
+test_expect_success 'new branch from ambiguous start_point works' '
+	git checkout -b newbranch ambiguity
+'
+
+test_expect_success 'checkout chooses tag over branch for start_point' '
+	echo tag >expect &&
+	test_cmp expect file
+'
+
 test_done

For bonus fun, doing this:

  git branch newbranch ambiguity
  git checkout newbranch

_does_ prefer the branch. So it is checkout feeding create_branch() the
modified sha1. I'll see if I can dig further.

-Peff
