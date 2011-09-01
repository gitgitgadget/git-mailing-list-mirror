From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] test-lib: save test counts across invocations
Date: Thu, 1 Sep 2011 12:38:46 -0400
Message-ID: <20110901163846.GD15018@sigill.intra.peff.net>
References: <8fe5381a6b69079b8c20452fd4d99a128764dd52.1314882443.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Thu Sep 01 18:38:58 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QzAI5-0005xI-RM
	for gcvg-git-2@lo.gmane.org; Thu, 01 Sep 2011 18:38:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757476Ab1IAQiw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Sep 2011 12:38:52 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:59659
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757353Ab1IAQiv (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Sep 2011 12:38:51 -0400
Received: (qmail 20678 invoked by uid 107); 1 Sep 2011 16:39:35 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 01 Sep 2011 12:39:35 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 01 Sep 2011 12:38:46 -0400
Content-Disposition: inline
In-Reply-To: <8fe5381a6b69079b8c20452fd4d99a128764dd52.1314882443.git.trast@student.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180540>

On Thu, Sep 01, 2011 at 03:08:45PM +0200, Thomas Rast wrote:

> Save the number of tests run ($test_count) in a file under
> test-counts/.  Then when sourcing test-lib.sh the next time, compare
> the timestamps.  If the counts file is older than the test, discard.
> Otherwise use the count that we saved and give prove the test plan
> ("1..N") up front.

Hmm. What happens when we're wrong? Does our eye-candy just print
something non-sensical like "13/12", or does prove actually care that we
run the right number of tests?

> Sparked by a discussion on G+.  I think this is the "simple" approach.
> The "cute" approach would be to let test-lib.sh define test_* as
> test-counting dummies once, source the test script itself (avoiding
> the sourcing loop with test-lib) to count what it does, then do the
> real work.

I don't think the "cute" approach will ever be accurate. Deciding
whether to run later tests sometimes depends on the results of earlier
tests, in at least two cases:

  1. Some tests find out which capabilities the system has, and set
     prerequisites. You need to actually run those tests, not make them
     counting dummies.

  2. Some tests create state that we then iterate on. For example, I
     think the mailinfo tests do something like:

        test_expect_success 'split' '
                git mailsplit -o patches mbox
        '
        for i in patches/*; do
          test_expect_success "check patch $i" '
                  git mailinfo $i >output
                  ...
          '
        done

      You'd get an inaccurate count if you didn't actually run the
      mailsplit command.

Anyway, this whole thing is a cute idea, and I do love eye candy, but I
wonder if it's worth the complexity. All this is telling us is how far
into each of the scripts it is. But we have literally hundreds of test
scripts, all with varying numbers of tests of varying speeds, and you're
probably running 16 or more at one time. So it doesn't tell you what you
really want to know, which is: how soon will the test suite probably be
done running.

-Peff
