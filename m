Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8B555203E1
	for <e@80x24.org>; Wed, 27 Jul 2016 18:32:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757365AbcG0ScI (ORCPT <rfc822;e@80x24.org>);
	Wed, 27 Jul 2016 14:32:08 -0400
Received: from cloud.peff.net ([50.56.180.127]:50003 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753597AbcG0ScH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Jul 2016 14:32:07 -0400
Received: (qmail 1858 invoked by uid 102); 27 Jul 2016 18:32:06 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 27 Jul 2016 14:32:06 -0400
Received: (qmail 19246 invoked by uid 107); 27 Jul 2016 18:32:31 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 27 Jul 2016 14:32:31 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 27 Jul 2016 14:32:03 -0400
Date:	Wed, 27 Jul 2016 14:32:03 -0400
From:	Jeff King <peff@peff.net>
To:	Phil Pennock <phil@pennock-tech.com>
Cc:	git@vger.kernel.org,
	Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH] pretty format string support for reflog times
Message-ID: <20160727183203.GE32219@sigill.intra.peff.net>
References: <20160727081414.GA21451@breadbox>
 <20160727175622.GA9961@sigill.intra.peff.net>
 <20160727181334.GA24224@tower.spodhuis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20160727181334.GA24224@tower.spodhuis.org>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Wed, Jul 27, 2016 at 06:13:34PM +0000, Phil Pennock wrote:

> > Our usual error-return is "0 is success", "-1 is error".
> 
> The idea was "boolean function" and adding more negations elsewhere just
> made things ugly.  I can change if you really want, as consistency wins,
> but I'll be holding my nose as the invoker flow becomes:
> 
>     if (! function_call(out_params)) {
>       use(out_params);
>     }
> 
> which is counter-intuitive (but then, I do much less C these days and
> have been corrupted).  So I'll hold off for now, until told otherwise.

Yeah, I agree the "!" test for "did it work" is counter-intuitive if you're
coming from other languages, but it's pretty normal for C code bases
(especially ours).

> > > +refhead1_short=$(git rev-parse --short --verify HEAD@{0}) &&
> > > +refhead2_short=$(git rev-parse --short --verify HEAD@{1}) &&
> > 
> > We try to push as much as possible into a test_expect_success block,
> > since it handles things like unexpected output to stderr. I guess you
> > put these outside because they are used in multiple tests. You don't
> > have to do that, because tests can affect the greater environment. But
> > if you do keep something outside of a test, you _don't_ want to use
> > &&-chaining, as it means that the lines below it (i.e., the next test!)
> > would simply not be run at all.
> 
> This however was matching existing style for `head1` and `head2` a
> little above.  I was somewhat surprised.

Ah. Yeah, those are wrong and bad. We should fix that.

> > > +test_expect_success 'can access the reflog' '
> > > +	git reflog -n 2 >actual &&
> > > +	cat >expected <<EOF &&
> > > +$refhead1_short HEAD@{0}: commit (amend): shorter
> > > +$refhead2_short HEAD@{1}: commit (amend): short
> > > +EOF
> > > +	test_cmp expected actual
> > > +'
> > 
> > I'm not sure what this is testing. Just that we have reflogs turned on
> > at all? I think we can skip this, as it's implicit in the
> > reflog-formatting test below.
> 
> Disagree: I could see no existing tests for reflog content matching an
> expected layout (but could have missed one; I see some _using_ reflog).

I think because t4205 is mostly about testing user-formats. t1410 and
t1411 are where I'd expect to see tests of normal output for "git
reflog".

> If adding a test for minutiae of how tuning options adjust the output,
> and something changes which breaks the output more widely, the person
> investigating can spend a lot of time investigating a red herring,
> looking to see what they broke in the `--pretty` handling.
> 
> First test the basics, then test the specifics, so that if the basics
> break too then the developer is naturally led to the correct thing to
> investigate instead of their only clue being that specifics broke.

Oh, I agree. I just think the basics are tested elsewhere, and this new
test is redundant and out-of-place. The numeric progression of the test
scripts is supposed to follow this basic-first ordering, though it's
often hard in practice (e.g., I think some "git log --format" stuff has
crept into the t14xx series, just because it's so darned convenient to
use).

> > You can use "<<-" to ask the shell to strip leading tabs from the
> > here-doc. And then you can indent the contents to match the rest of the
> > test.
> 
> You can, but it's fragile if tabs become spaces and it isn't consistent
> with the existing tests above.

Yeah, looking at the other "&&-" cases you mentioned, I see the whole
script does not use "<<-". That is against our "usual" style, though
there are many inconsistent sins in the history of the scripts. IMHO is
worth modernizing the whole thing.

I don't buy the tabs-become-spaces argument. We use tabs for indentation
in Git, and that's extremely unlikely to change. If your patch gets
munged in transit or by your editor, then the maintainer is going to
complain when applying your patch.

> > (I did a few more tweaks to the format to hopefully make it easier to
> > read). It would probably be a more interesting test if the two reflogs
> > actually had different timestamps, though.
> 
> Is there a way to force that, through the normalizations?

The magic function you are looking for is "test_tick()", which advances
GIT_COMMITTER_DATE, etc. It's called automatically from test_commit(),
so seeing two commits with identical timestamps is an indication that
an earlier test did a manual commit without a matching tick (probably
because it did not care about the timestamps itself).

It's OK to just make your own new commits, like:

  test_commit reflog-test-one &&
  test_commit reflog-test-two &&
  ... check the output of log -g -2 ...

and test those, and then you aren't as dependent on what happened before
(though of course if you are hard-coding the dates, somebody inserting a
new tick in between will screw you up; we tend to add new tests at the
end of scripts for reasons like that).

> > Also, come to think of it, that "%gr" test is going to break in about
> > year. :-/
> 
> Oh crap, I saw the normalization and thought everything was being set to
> specifics, but of course the relative is against now.  Good catch,
> thanks.  How about:
> 
>     | sed "s/[1-9][0-9]* years/N years/"
> 
> and then test against "N years" in expected?

I can't think of any reason that would fail, unless somebody travels
back in time to run the tests in 2005 (or their system clock is screwed
up).

-Peff
