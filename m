Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EC44B1F404
	for <e@80x24.org>; Fri, 19 Jan 2018 17:23:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932166AbeASRX4 (ORCPT <rfc822;e@80x24.org>);
        Fri, 19 Jan 2018 12:23:56 -0500
Received: from cloud.peff.net ([104.130.231.41]:49606 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1755932AbeASRXz (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Jan 2018 12:23:55 -0500
Received: (qmail 12928 invoked by uid 109); 19 Jan 2018 17:23:55 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 19 Jan 2018 17:23:55 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 21840 invoked by uid 111); 19 Jan 2018 17:24:31 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 19 Jan 2018 12:24:31 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 19 Jan 2018 12:23:53 -0500
Date:   Fri, 19 Jan 2018 12:23:53 -0500
From:   Jeff King <peff@peff.net>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     =?utf-8?B?0J7Qu9GPINCi0LXQu9C10LbQvdCw0Y8=?= 
        <olyatelezhnaya@gmail.com>, git <git@vger.kernel.org>
Subject: Re: [PATCH v2 03/18] ref-filter: make valid_atom as function
 parameter
Message-ID: <20180119172353.GA5752@sigill.intra.peff.net>
References: <01020160df6dc499-0e6d11ec-1dcd-4a71-997b-ea231f33fae4-000000@eu-west-1.amazonses.com>
 <01020160df6dc529-fae54bd6-e595-44fa-9f9a-c44cb3a5a1a8-000000@eu-west-1.amazonses.com>
 <20180115214208.GD4778@sigill.intra.peff.net>
 <CAL21Bm=+uPrKECcCq2_rfJRuCpsOjZ41NfiyY3d1UA0b8YKj1w@mail.gmail.com>
 <20180117214354.GA13128@sigill.intra.peff.net>
 <CAP8UFD0PtOqX5c4ovRbYDWejQ55iUwtnPv-zGXS2GFAajhXqtA@mail.gmail.com>
 <CAL21BmnKd0qamJWJbrAzg_ZX1GkhCTPO_5zOiFNMBeF-xjDTiQ@mail.gmail.com>
 <CAP8UFD1dcwEA9z+oQKFV=aFoKn73mtP4qkLGovW2XTu6N=N4dA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAP8UFD1dcwEA9z+oQKFV=aFoKn73mtP4qkLGovW2XTu6N=N4dA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jan 19, 2018 at 06:14:56PM +0100, Christian Couder wrote:

> > Let's discuss, what behavior we are waiting for
> > when atom seems useless for the command. Die or ignore?
> 
> We could alternatively just emit a warning, but it looks like there
> are a lot of die() calls already in ref-filter.c, so I would suggest
> die().

I actually think it makes sense to just expand nonsense into the empty
string, for two reasons:

  1. That's what ref-filter already does for the existing cases. For
     example, try:

       git for-each-ref --format='%(objecttype) %(authordate)'

     and you will see that the annotated tags just get a blank author
     field.

  2. I think we may end up with a case where we feed multiple objects
     via --batch-check, and the format is only nonsense for _some_ of
     them. E.g., I envision a world where you can do:

       git cat-file --batch-check='%(objecttype) %(refname)' <<-\EOF
       master
       12345abcde12345abcde12345abcde12345abcde
       EOF

     and get output like:

       commit refs/heads/master
       commit

     (i.e., if we would remember the refname discovered during the name
     resolution, we could still report it). It would be annoying if the
     second line caused us to die().

> > And, which
> > atoms are useless (as I understand, "rest" and "deltabase" from
> > cat-file are useless for all ref-filter users, so the question is
> > about - am I right in it, and about ref-filter atoms for cat-file).
> 
> For now and I think until the migration process is finished, you could
> just die() in case of any atom not already supported by the command.

I'm OK with dying in the interim if it's easier, though I suspect it is
not much extra work to just expand to the empty string in such cases. If
that's where we want to end up eventually, it may be worth going
straight there.

I also think %(deltabase) does make sense for anything that points to an
object. I suspect it's not all that _useful_ for for-each-ref, but that
doesn't mean we can't return the sensible thing if somebody asks for it.

I agree that %(rest) probably doesn't make any sense for a caller which
isn't parsing input.

-Peff
