From: Adam Spiers <git@adamspiers.org>
Subject: Re: [PATCH] Make test output coloring more intuitive
Date: Tue, 18 Sep 2012 22:21:22 +0100
Message-ID: <20120918212122.GA2567@atlantic.linksys.moosehall>
References: <1347882637-21766-1-git-send-email-git@adamspiers.org>
 <20120917201119.GB24888@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git list <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Sep 18 23:21:36 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TE5Ed-00073f-DQ
	for gcvg-git-2@plane.gmane.org; Tue, 18 Sep 2012 23:21:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932105Ab2IRVV1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Sep 2012 17:21:27 -0400
Received: from coral.adamspiers.org ([85.119.82.20]:43956 "EHLO
	coral.adamspiers.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932104Ab2IRVVZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Sep 2012 17:21:25 -0400
Received: from localhost (f.8.b.2.1.5.e.f.f.f.4.f.0.4.2.0.0.0.0.0.b.1.4.6.0.b.8.0.1.0.0.2.ip6.arpa [IPv6:2001:8b0:641b:0:240:f4ff:fe51:2b8f])
	by coral.adamspiers.org (Postfix) with ESMTPSA id 7D8452E5DB;
	Tue, 18 Sep 2012 22:21:23 +0100 (BST)
Mail-Followup-To: Jeff King <peff@peff.net>, git list <git@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20120917201119.GB24888@sigill.intra.peff.net>
X-OS: GNU/Linux
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205876>

On Mon, Sep 17, 2012 at 04:11:19PM -0400, Jeff King wrote:
> On Mon, Sep 17, 2012 at 12:50:37PM +0100, Adam Spiers wrote:
> 
> > The end result of these changes is that:
> > 
> >   - red is _only_ used for things which have gone unexpectedly wrong:
> >     test failures, unexpected test passes, and failures with the
> >     framework,
> > 
> >   - yellow is _only_ used for known breakages, and
> > 
> >   - green is _only_ used for things which have gone to plan and
> >     require no further work to be done.
> 
> Sounds reasonable, and I think the new output looks nice. I notice that
> skipped tests are still in green. I wonder if they should be in yellow,
> too. They may or may not be a problem, but you are failing to run some
> portion of the test suite.

Fair point, I'll reroll the series and change skipped tests to yellow
(non-bold, to distinguish from known breakages which are bold yellow).

> > diff --git a/t/t0000-basic.sh b/t/t0000-basic.sh
> > index ae6a3f0..4e111b4 100755
> > --- a/t/t0000-basic.sh
> > +++ b/t/t0000-basic.sh
> > @@ -81,9 +81,10 @@ test_expect_success 'pretend we have fixed a known breakage (run in sub test-lib
> >  	./passing-todo.sh >out 2>err &&
> >  	! test -s err &&
> >  	sed -e 's/^> //' >expect <<-\\EOF &&
> > -	> ok 1 - pretend we have fixed a known breakage # TODO known breakage
> > -	> # fixed 1 known breakage(s)
> > -	> # passed all 1 test(s)
> > +	> ok 1 - pretend we have fixed a known breakage # TODO known breakage vanished
> > +	> # fixed 1 known breakage(s); please update test(s)
> > +	> # still have 1 known breakage(s)
> > +	> # passed all remaining 0 test(s)
> >  	> 1..1
> >  	EOF
> >  	test_cmp expect out)
> 
> This hunk is surprising after reading the commit message. It looks like
> you are also breaking down expect_fail tests by fixed and not fixed.

Correct.

> I think that is probably an OK thing to do (although it might make more
> sense in a separate patch), but are your numbers right?

They are right (at least as I intended), but I agree it's a bit
confusing.

> It looks from that count as if there are 2 tests expecting failure
> (one fixed and one still broken).

It's actually one test which is both fixed *and* in some sense broken.
The confusion arises from the ambiguity of the word "broken", which
could mean either "failed as expected" or "expected to fail but
didn't".  Previously it was just the former, but my patch changed it
to encompass both cases.  The motivation behind this was to avoid the

    # passed all $count test(s)

summary message which is overly comforting when one or more tests were
expected to fail but didn't.  However perhaps it's cleaner to keep the
counter buckets separated.  I'll try to come up with a better
solution.
