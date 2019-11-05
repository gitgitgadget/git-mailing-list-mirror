Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 65EF41F454
	for <e@80x24.org>; Tue,  5 Nov 2019 08:00:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388049AbfKEIAL (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Nov 2019 03:00:11 -0500
Received: from cloud.peff.net ([104.130.231.41]:39040 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S2387982AbfKEIAL (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Nov 2019 03:00:11 -0500
Received: (qmail 8809 invoked by uid 109); 5 Nov 2019 08:00:11 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 05 Nov 2019 08:00:11 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 9988 invoked by uid 111); 5 Nov 2019 08:03:28 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 05 Nov 2019 03:03:28 -0500
Authentication-Results: peff.net; auth=none
Date:   Tue, 5 Nov 2019 03:00:10 -0500
From:   Jeff King <peff@peff.net>
To:     Danh Doan <congdanhqx@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v2 3/3] sequencer: reencode to utf-8 before arrange
 rebase's todo list
Message-ID: <20191105080010.GA7415@sigill.intra.peff.net>
References: <20191031092618.29073-1-congdanhqx@gmail.com>
 <cover.1572596278.git.congdanhqx@gmail.com>
 <b7927b27235422ac53595cfaa63b4f1cbe009013.1572596278.git.congdanhqx@gmail.com>
 <20191101165921.GD26219@sigill.intra.peff.net>
 <20191102010215.GB17624@danh.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191102010215.GB17624@danh.dev>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Nov 02, 2019 at 08:02:15AM +0700, Danh Doan wrote:

> Anyway, if we're going to working with a single encoding internally,
> can we take other extreme approach: reencode the commit message to
> utf-8 before writing the commit object? (Is there any codepoint in
> other encoding that can't be reencoded to utf-8?)

That's normally what we do. The only cases we're covering here are when
somebody has explicitly asked that the commit object be stored in
another encoding. Presumably they'd also be using a matching
i18n.logOutputEncoding in that case, in which case logmsg_reencode()
would be a noop. I think the only reasons to do that are:

  1. You're stuck on some legacy encoding for your terminal. But in that
     case, I think you'd still be better off storing utf-8 and
     translating on the fly, since whatever encoding you do store is
     baked into your objects for all time (so accept some slowness now,
     but eventually move to utf-8).

  2. Your preferred language is bigger in utf-8 than in some specific
     encoding, and you'd rather save some bytes. I'm not sure how big a
     deal this is, given that commit messages don't tend to be that big
     in the first place (compared to trees and blobs). And the zlib
     deflation on the result might help remove some of the redundancy,
     too.

So I'd actually expect very few people to be using this feature at all
these days (which is part of why I would not be all that broken up if we
just fix the test and move on, if nobody is reporting real-world
problems).

> Since git-log and friends are doing 2 steps conversion for commit
> message for now (reencode to utf-8 first, then reencode again to
> get_log_output_encoding()). With this new approach, first step is
> likely a noop (but must be kept for backward compatible).

Interesting. Traditionally we did a single step conversion to the output
format, and it looks like most output formats still do that (i.e.,
everything in pretty_print_commit() except FMT_USERFORMAT, which is what
powers "--pretty=format:%s", etc).

The two-part user-format thing goes back to 7e77df39bf (pretty: two
phase conversion for non utf-8 commits, 2013-04-19). It does seem like
it would be cheaper to convert the format string into the output
encoding (it would need to be an ascii superset, but that's already the
case, since we expect to parse "author", etc out of the re-encoded
commit object). But again, I have trouble caring too much about the
performance of this case, as I consider it to be mostly legacy at this
point. But I also don't write in (say) Japanese, so maybe I'm being too
narrow-minded about whether people really want to avoid utf-8.

-Peff
