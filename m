From: Jeff King <peff@peff.net>
Subject: Re: bug? in checkout with ambiguous refnames
Date: Tue, 11 Jan 2011 14:20:20 -0500
Message-ID: <20110111192020.GA15608@sigill.intra.peff.net>
References: <20110107104650.GA5399@pengutronix.de>
 <20110107194909.GB6175@sigill.intra.peff.net>
 <20110107195417.GC6175@sigill.intra.peff.net>
 <20110111065509.GG10094@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
	<u.kleine-koenig@pengutronix.de>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jan 11 20:20:37 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pcjlg-0000uL-GO
	for gcvg-git-2@lo.gmane.org; Tue, 11 Jan 2011 20:20:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932319Ab1AKTU1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Jan 2011 14:20:27 -0500
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:40926 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756147Ab1AKTUZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Jan 2011 14:20:25 -0500
Received: (qmail 15362 invoked by uid 111); 11 Jan 2011 19:20:23 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO sigill.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Tue, 11 Jan 2011 19:20:23 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 11 Jan 2011 14:20:20 -0500
Content-Disposition: inline
In-Reply-To: <20110111065509.GG10094@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164977>

On Tue, Jan 11, 2011 at 01:55:09AM -0500, Jeff King wrote:

> On Fri, Jan 07, 2011 at 02:54:17PM -0500, Jeff King wrote:
> 
> > +test_expect_success 'checkout reports switch to detached HEAD' '
> > +	grep "Switched to branch" stderr &&
> > +	! grep "^HEAD is now at" stderr
> 
> Junio, one minor fixup here. The test is correct, but the description
> should read "checkout reports switch to branch", not "...detached HEAD".

Hmm. One other thing to note on these ambiguity tests. Apparently we did
already have a test for this in t7201 (which should perhaps be renamed
into the t20* area with the other checkout tests), but it was passing.

The problem is that the current behavior is way more broken than just
"accidentally choose tag over branch". It actually writes the branch ref
into HEAD, but checks out the tree from the tag! The test in 7201 only
checks the former, but our new test checked the latter.

Probably we should be checking both, just to be sure (and yes, with your
patch it does the right thing):

diff --git a/t/t2019-checkout-amiguous-ref.sh b/t/t2019-checkout-amiguous-ref.sh
index e2b330b..606081b 100755
--- a/t/t2019-checkout-amiguous-ref.sh
+++ b/t/t2019-checkout-amiguous-ref.sh
@@ -22,6 +22,9 @@ test_expect_success 'checkout produces ambiguity warning' '
 '
 
 test_expect_success 'checkout chooses branch over tag' '
+	echo refs/heads/ambiguity >expect &&
+	git symbolic-ref HEAD >actual &&
+	test_cmp expect actual &&
 	echo branch >expect &&
 	test_cmp expect file
 '
@@ -41,6 +44,9 @@ test_expect_success VAGUENESS_SUCCESS 'checkout produces ambiguity warning' '
 '
 
 test_expect_success VAGUENESS_SUCCESS 'checkout chooses branch over tag' '
+	echo refs/heads/vagueness >expect &&
+	git symbolic-ref HEAD >actual &&
+	test_cmp expect actual &&
 	echo branch >expect &&
 	test_cmp expect file
 '
