Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CEC9C200B9
	for <e@80x24.org>; Tue,  8 May 2018 17:25:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755575AbeEHRZU (ORCPT <rfc822;e@80x24.org>);
        Tue, 8 May 2018 13:25:20 -0400
Received: from cloud.peff.net ([104.130.231.41]:60652 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1755571AbeEHRZT (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 May 2018 13:25:19 -0400
Received: (qmail 12731 invoked by uid 109); 8 May 2018 17:25:19 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 08 May 2018 17:25:19 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 7022 invoked by uid 111); 8 May 2018 17:25:23 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 08 May 2018 13:25:23 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 08 May 2018 13:25:17 -0400
Date:   Tue, 8 May 2018 13:25:17 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        gitster@pobox.com
Subject: Re: [PATCH 2/2] builtin/grep.c: teach '-o', '--only-matching' to
 'git-grep'
Message-ID: <20180508172517.GA934@sigill.intra.peff.net>
References: <cover.1525492696.git.me@ttaylorr.com>
 <c8b527c5de3b0e5422d2c1afb91d454d1e46fff4.1525492696.git.me@ttaylorr.com>
 <87fu36y4u0.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87fu36y4u0.fsf@evledraar.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, May 05, 2018 at 08:49:43AM +0200, Ævar Arnfjörð Bjarmason wrote:

> > +test_expect_success 'grep --only-matching --heading' '
> > +	git grep --only-matching --heading --line-number --column mmap file >actual &&
> > +	test_cmp expected actual
> > +'
> > +
> >  cat >expected <<EOF
> >  <BOLD;GREEN>hello.c<RESET>
> >  4:int main(int argc, const <BLACK;BYELLOW>char<RESET> **argv)
> 
> We should test this a lot more, I think a good way to do that would be
> to extend this series by first importing GNU grep's -o tests, see
> http://git.savannah.gnu.org/cgit/grep.git/tree/tests/foad1 they are
> license-compatible. Then change the grep_test() function to call git
> grep instead.

I'm trying to figure out what GNU grep's tests are actually checking
that we don't have. I see:

 - they check that "-i" returns the actual found string in its original
   case. This seems like a subset of finding a non-trivial regex. I.e.,
   "foo.*" should find "foobar". We probably should have a test like
   that.

 - they test multiple hits on the same line, which seems like an
   important and easy-to-screw-up case; we do that, too.

 - they test everything other thing with and without "-i" because those
   are apparently separate code paths in GNU grep, but I don't think
   that applies to us.

 - they test each case with "-b", but we don't have that (we do test
   with "--column", which is good)

 - they test with "-n", which we do here (we don't test without, but
   that seems like an unlikely bug, knowing how it is implemented)

 - they test with -H, but that is already the default for git-grep

 - they test with context (-C3) for us. It looks like GNU grep omits
   context lines with "-o", but we show a bunch of blank lines. This is
   I guess a bug (though it seems kind of an odd combination to specify
   in the first place)

So I think it probably makes sense to just pick through the list I just
wrote and write our own tests than to try to import GNU grep's specific
tests (and there's a ton of other unrelated tests in that file that may
or may not even run with git-grep).

> It should also be tested with the various grep.patternType options to
> make sure it works with basic, extended, perl, fixed etc.

Hmm, this code is all external to the actual matching. So unless one of
those is totally screwing up the regmatch_t return, I'm not sure that's
accomplishing much (and if one of them is, it's totally broken for
coloring, "-c", and maybe other features).

We've usually taken a pretty white-box approach to our testing, covering
things that seem likely to go wrong given the general problem space and
our implementation. But maybe I'm missing something in particular that
you think might be tricky.

-Peff
