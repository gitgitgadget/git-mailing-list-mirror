Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D77F2209AA
	for <e@80x24.org>; Mon, 26 Sep 2016 11:57:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030293AbcIZL50 (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Sep 2016 07:57:26 -0400
Received: from cloud.peff.net ([104.130.231.41]:47998 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934585AbcIZL5Y (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Sep 2016 07:57:24 -0400
Received: (qmail 18453 invoked by uid 109); 26 Sep 2016 11:57:23 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 26 Sep 2016 11:57:23 +0000
Received: (qmail 4267 invoked by uid 111); 26 Sep 2016 11:57:37 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 26 Sep 2016 07:57:37 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 26 Sep 2016 07:57:20 -0400
Date:   Mon, 26 Sep 2016 07:57:20 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Git Mailing List <git@vger.kernel.org>
Subject: [PATCH 0/10] helping people resolve ambiguous sha1s
Message-ID: <20160926115720.p2yb22lcq37gboon@sigill.intra.peff.net>
References: <CA+55aFy0_pwtFOYS1Tmnxipw9ZkRNCQHmoYyegO00pjMiZQfbg@mail.gmail.com>
 <xmqq37knwcf4.fsf@gitster.mtv.corp.google.com>
 <20160926043442.3pz7ccawdcsn2kzb@sigill.intra.peff.net>
 <CAPc5daV1YJaEqH5eZCej3nkg8htHVDWQu0V0uoC4gVmPYpDL9Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAPc5daV1YJaEqH5eZCej3nkg8htHVDWQu0V0uoC4gVmPYpDL9Q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Sep 25, 2016 at 09:45:18PM -0700, Junio C Hamano wrote:

> On Sun, Sep 25, 2016 at 9:34 PM, Jeff King <peff@peff.net> wrote:
> >
> > An easier (but less automatic) tool would be to improve our error
> > message for the ambiguous case, and actually report details of the
> > candidates. I'm working up a patch now.
> 
> That sounds like a fun little lunch-break project. Thanks.

That's what I thought, but it turned out to be quite involved. :)

I started by trying to teach get_short_sha1() to remember all of the
candidates it sees, but it turns out to be surprisingly complicated. I
did have something working, but I scrapped it in favor of just looking
at the object database again. It's the error code path, so it's OK to be
slower (especially if it keeps the non-error code path much simpler).

But then being the diligent programmer that I am, I added a tests.
And that failed because of an unrelated bug. Fixing that revealed
another bug. And so on.

The good news is that I think I've finally cleared up all of the
long-standing bugs where git will print the same error message twice.
Those have been annoying me for yours (and apparently others[1]).

Patches 2-4 and 9 are all bugfixes. Patch 10 is the interesting part.
The rest are just cleanups and refactoring.

  [01/10]: get_sha1: detect buggy calls with multiple disambiguators
  [02/10]: get_sha1: avoid repeating ourselves via ONLY_TO_DIE
  [03/10]: get_sha1: propagate flags to child functions
  [04/10]: get_short_sha1: peel tags when looking for treeish
  [05/10]: get_short_sha1: refactor init of disambiguation code
  [06/10]: get_short_sha1: NUL-terminate hex prefix
  [07/10]: get_short_sha1: mark ambiguity error for translation
  [08/10]: sha1_array: let callbacks interrupt iteration
  [09/10]: for_each_abbrev: drop duplicate objects
  [10/10]: get_short_sha1: list ambiguous objects on error

Of course this is all totally orthogonal to Linus's original question. I
hope it will make things more pleasant when somebody does end up having
to look up a too-short sha1, but it's probably still a good idea to
bump the default.

-Peff

[1] http://public-inbox.org/git/504B91B7.1000406@avtalion.name/
