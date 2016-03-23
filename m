From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] git-send-pack: Fix --all option when used with directory
Date: Wed, 23 Mar 2016 17:30:34 -0400
Message-ID: <20160323213034.GB19920@sigill.intra.peff.net>
References: <1458750262-25765-1-git-send-email-stanislav@assembla.com>
 <20160323212213.GA19920@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Dave Borowitz <dborowitz@google.com>, git@vger.kernel.org
To: Stanislav Kolotinskiy <stanislav@assembla.com>
X-From: git-owner@vger.kernel.org Wed Mar 23 22:30:47 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aiqMV-0005ke-0S
	for gcvg-git-2@plane.gmane.org; Wed, 23 Mar 2016 22:30:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751350AbcCWVai (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Mar 2016 17:30:38 -0400
Received: from cloud.peff.net ([50.56.180.127]:36999 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750984AbcCWVah (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Mar 2016 17:30:37 -0400
Received: (qmail 2791 invoked by uid 102); 23 Mar 2016 21:30:37 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 23 Mar 2016 17:30:37 -0400
Received: (qmail 3639 invoked by uid 107); 23 Mar 2016 21:30:57 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 23 Mar 2016 17:30:57 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 23 Mar 2016 17:30:34 -0400
Content-Disposition: inline
In-Reply-To: <20160323212213.GA19920@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289686>

On Wed, Mar 23, 2016 at 05:22:13PM -0400, Jeff King wrote:

> > diff --git a/t/t9904-send-pack-all.sh b/t/t9904-send-pack-all.sh
> 
> The tests are roughly grouped by functionality. send-pack tests are in
> the t540x range, and this should probably go there. Though I also
> suspect it could easily be added to the end of an existing test script,
> which is preferable.
> 
> > +test_expect_success setup '
> 
> This setup seems a bit more complicated than it needs to be. It's nice
> to keep tests as simple as possible, so a reader can understand exactly
> what is being tested.
> 
> Here are a few things I think we can simplify:
> [...]

So I think we could replace your t9904 with something like this:

diff --git a/t/t5400-send-pack.sh b/t/t5400-send-pack.sh
index 04cea97..305ca7a 100755
--- a/t/t5400-send-pack.sh
+++ b/t/t5400-send-pack.sh
@@ -128,6 +128,18 @@ test_expect_success 'denyNonFastforwards trumps --force' '
 	test "$victim_orig" = "$victim_head"
 '
 
+test_expect_success 'send-pack --all sends all branches' '
+	# make sure we have at least 2 branches with different
+	# values, just to be thorough
+	git branch other-branch HEAD^ &&
+
+	git init --bare all.git &&
+	git send-pack --all all.git &&
+	git for-each-ref refs/heads >expect &&
+	git -C all.git for-each-ref refs/heads >actual &&
+	test_cmp expect actual
+'
+
 test_expect_success 'push --all excludes remote-tracking hierarchy' '
 	mkdir parent &&
 	(
