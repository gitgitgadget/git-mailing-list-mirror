Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 596E31F406
	for <e@80x24.org>; Wed, 17 Jan 2018 21:43:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753368AbeAQVn5 (ORCPT <rfc822;e@80x24.org>);
        Wed, 17 Jan 2018 16:43:57 -0500
Received: from cloud.peff.net ([104.130.231.41]:47040 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1752578AbeAQVn4 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Jan 2018 16:43:56 -0500
Received: (qmail 19600 invoked by uid 109); 17 Jan 2018 21:43:56 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 17 Jan 2018 21:43:56 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 5805 invoked by uid 111); 17 Jan 2018 21:44:31 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 17 Jan 2018 16:44:31 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 17 Jan 2018 16:43:54 -0500
Date:   Wed, 17 Jan 2018 16:43:54 -0500
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?0J7Qu9GPINCi0LXQu9C10LbQvdCw0Y8=?= 
        <olyatelezhnaya@gmail.com>
Cc:     git <git@vger.kernel.org>
Subject: Re: [PATCH v2 03/18] ref-filter: make valid_atom as function
 parameter
Message-ID: <20180117214354.GA13128@sigill.intra.peff.net>
References: <01020160df6dc499-0e6d11ec-1dcd-4a71-997b-ea231f33fae4-000000@eu-west-1.amazonses.com>
 <01020160df6dc529-fae54bd6-e595-44fa-9f9a-c44cb3a5a1a8-000000@eu-west-1.amazonses.com>
 <20180115214208.GD4778@sigill.intra.peff.net>
 <CAL21Bm=+uPrKECcCq2_rfJRuCpsOjZ41NfiyY3d1UA0b8YKj1w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL21Bm=+uPrKECcCq2_rfJRuCpsOjZ41NfiyY3d1UA0b8YKj1w@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jan 16, 2018 at 09:55:22AM +0300, Оля Тележная wrote:

> > IOW, the progression I'd expect in a series like this is:
> >
> >   1. Teach ref-filter.c to support everything that cat-file can do.
> >
> >   2. Convert cat-file to use ref-filter.c.
> 
> I agree, I even made this and it's working fine:
> https://github.com/git/git/pull/450/commits/1b74f1047f07434dccb207534d1ad45a143e3f2b
> But I decided not to add that to patch because I expand the
> functionality of several commands (not only cat-file and
> for-each-ref), and I need to support all new functionality in a proper
> way, make these error messages, test everything and - the hardest one
> - support many new commands for cat-file. As I understand, it is not
> possible unless we finally move to ref-filter and print results also
> there. Oh, and I also need to rewrite docs in that case. And I decided
> to apply this in another patch. But, please, say your opinion, maybe
> we could do that here in some way.

Yeah, I agree that it will cause changes to other users of ref-filter,
and you'd need to deal with documentation and tests there. But I think
we're going to have to do those things eventually (since supporting
those extra fields everywhere is part of the point of the project). And
by doing them now, I think it can make the transition for cat-file a lot
simpler, because we never have to puzzle over this intermediate state
where only some of the atoms are valid for cat-file.

I also agree that moving cat-file's printing over to ref-filter.c is
going to introduce a lot of corner cases (like the behavior when
somebody does "cat-file --batch-check=%(refname)" with a bare sha1). But
I think a progression of patches handling those cases would be pretty
easy to follow. E.g., I'd expect to see a patch that teaches
ref-filter[1] how to handle callers that don't have a ref, but just a
bare object name. And it would be easier to evaluate that on its own,
because we know that's an end state we're going to have to handle, and
not some funny state created as part of the transition.

-Peff

[1] And here's where we might start to think about calling it something
    besides ref-filter, if we don't necessarily have a ref. :)
