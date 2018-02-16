Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 92A041F404
	for <e@80x24.org>; Fri, 16 Feb 2018 21:54:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750849AbeBPVyr (ORCPT <rfc822;e@80x24.org>);
        Fri, 16 Feb 2018 16:54:47 -0500
Received: from cloud.peff.net ([104.130.231.41]:55650 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1750792AbeBPVyq (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Feb 2018 16:54:46 -0500
Received: (qmail 25514 invoked by uid 109); 16 Feb 2018 21:54:46 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 16 Feb 2018 21:54:46 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 22604 invoked by uid 111); 16 Feb 2018 21:55:30 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 16 Feb 2018 16:55:30 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 16 Feb 2018 16:54:43 -0500
Date:   Fri, 16 Feb 2018 16:54:43 -0500
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?0J7Qu9GPINCi0LXQu9C10LbQvdCw0Y8=?= 
        <olyatelezhnaya@gmail.com>
Cc:     git <git@vger.kernel.org>
Subject: Re: [PATCH v3 16/23] ref-filter: make cat_file_info independent
Message-ID: <20180216215442.GA22270@sigill.intra.peff.net>
References: <01020161890f4236-47989eb4-c19f-4282-9084-9d4f90c2ebeb-000000@eu-west-1.amazonses.com>
 <01020161890f4376-0d1c5615-ae9c-4320-bc2d-fd3bda19bce0-000000@eu-west-1.amazonses.com>
 <20180215055334.GN18780@sigill.intra.peff.net>
 <CAL21BmmFaDstAT3Jm6AWh95mfWLJqN1MQF+pBTa3erX5w9MWRQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL21BmmFaDstAT3Jm6AWh95mfWLJqN1MQF+pBTa3erX5w9MWRQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 15, 2018 at 01:33:25PM +0300, Оля Тележная wrote:

> 2018-02-15 8:53 GMT+03:00 Jeff King <peff@peff.net>:
> > On Mon, Feb 12, 2018 at 08:08:54AM +0000, Olga Telezhnaya wrote:
> >
> >> Remove connection between expand_data variable
> >> in cat-file and in ref-filter.
> >> It will help further to get rid of using expand_data in cat-file.
> >
> > I have to admit I'm confused at this point about what is_cat_file is
> > for, or even why we need cat_file_data. Shouldn't these items be handled
> > by their matching ref-filter atoms at this point?
> 
> We discussed that earlier outside of mailing list, and I even tried to
> implement that idea and spent a couple of days to prove that it's not
> possible.
> The problem is that the list of atoms is made dynamically, and we
> can't store pointers to any values in each atom. That's why we need
> separate cat_file_info variable that is outside of main atom list.
> We also need is_cat_file because we still have some part of logic that
> is different for cat-file and for all other commands, and sometimes we
> need to know that information.

OK, right, I forgot about the pointers thing. This is definitely the
sort of design decision that should go into the commit message.

I went over our off-list discussion again to refresh my memory. Let me
try to summarize a bit (for myself, or for other readerss). Naively, one
would hope that you could do something like:

  1. While parsing the %(objectsize) atom, add a pointer like:

       the_object_info->sizep = &atom.size;

  2. Later when fulfilling the request for a specific object, if
     the_object_info is not empty, then call sha1_object_info() with it
     to hold the results.

  3. Read the value out of atom.size when assembling the formatted
     string.

But that has two problems:

  a. During parsing, we're resizing the atom array, so the &atom.size
     pointer is subject to change.  This is the issue you mentioned
     above. I think we could solve it by taking a pass over the atoms
     after parsing and filling in the pointers then. But...

  b. Another problem is that the same atom may appear multiple times. So
     parsing "%(objectsize) %(objectsize)", we can't point
     the_object_info at _both_ of them. We need our call to
     sha1_object_info() to store the result in a single location, and
     then as we format each atom they can both use that (which works
     even if they might format it differently, say if you had
     "%(deltabase) %(deltabase:abbrev)".

So we do need some kind of global storage to hold these results. This is
sort of the same problem we have with parsing the objects at all. There
we get by without a global because all of the logic is crammed into
populate_value(). In theory we could do the same thing here, but there
are just a lot of different items we might be asking for. So instead of
"need_tagged", you'd have a multitude of need_objectsize_disk,
need_deltabase, etc, which gets unwieldy. We may as well fill in a
"struct object_info".

So OK, I agree that something like "struct expand_data" is needed.

But what seems non-ideal to me is the way that ref-filter depends on it
in this cat-file-specific way. If it needs those values it should be
calling sha1_object_info(). And if it doesn't, then it can skip the
call. It shouldn't need to know about cat-file at all.

And likewise cat-file should not know about expand_data. And I think
that's true by the end of the series, though the steps in the middle
left me a little confused.

-Peff
