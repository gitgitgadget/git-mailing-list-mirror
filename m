Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9042E1F45A
	for <e@80x24.org>; Mon, 12 Aug 2019 16:08:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726496AbfHLQIg (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Aug 2019 12:08:36 -0400
Received: from cloud.peff.net ([104.130.231.41]:40786 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725843AbfHLQIg (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Aug 2019 12:08:36 -0400
Received: (qmail 26071 invoked by uid 109); 12 Aug 2019 16:08:36 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 12 Aug 2019 16:08:36 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 23845 invoked by uid 111); 12 Aug 2019 16:11:29 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 12 Aug 2019 12:11:29 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 12 Aug 2019 12:08:35 -0400
From:   Jeff King <peff@peff.net>
To:     Jacob Vosmaer <jacob@gitlab.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: Feature-request: git-bundle --quiet
Message-ID: <20190812160834.GA25388@sigill.intra.peff.net>
References: <robbat2-20190806T191156-796782357Z@orbis-terrarum.net>
 <20190808104212.GA14189@sigill.intra.peff.net>
 <CADMWQoP3tH7-e+3FCYkB7b7nf8v-HBQ1toDoje8G_hvD_LaDZw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CADMWQoP3tH7-e+3FCYkB7b7nf8v-HBQ1toDoje8G_hvD_LaDZw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 12, 2019 at 12:15:19PM +0200, Jacob Vosmaer wrote:

> This is a tangent, but relevant: how do we feel about the fact that
> 'git bundle create' does not perform CRC32 checks when copying data
> out of an existing packfile?
> 
> See https://github.com/git/git/blob/v2.22.0/builtin/pack-objects.c#L2614-L2622 .
> 
> I understand the rationale of "skip CRC32 when serving a fetch",
> although I have no clue how much we gain from skipping it. But "pack
> to stdout means fetch" isn't quite accurate, as it includes bundles.

I don't recall it being discussed in the past. I think you could argue
either way:

  - a bundle is just another form of object transfer, like a fetch, and
    so we don't need to be careful about bitrot. The receiver would
    notice it when it indexes the pack (as opposed to an on-disk repack,
    where we'll immediately delete the old copy, and really want to make
    sure we haven't just lost data).

  - because a bundle isn't interactive like a regular fetch, any bit
    errors may not be seen until much later when somebody reads the. At
    that point it may not be possible to go back to the original repo
    (in the extreme case of using a bundle as a backup, it may have been
    deleted entirely!).

Depending on the cost of those checks (and I really doubt they are all
_that_ expensive), it might make sense for bundles to err on the
conservative side and do them. And if they are expensive, it should
perhaps be made an option for people who know they are planning to store
the bundle for a long time without reading it[1].

I agree that linking "skip CRC32" to "pack to stdout" is a bit hacky. It
should be easy to add a new --check-crc32 option which defaults to
"!pack_to_stdout" if not specified.

-Peff

[1] Of course bitrot in the original packfile is just one place this can
    go wrong. Depending how paranoid you want to be, it might be worth
    reading back the result before considering it a valid backup. That
    would catch some software bugs, as well as any bit corruption on the
    writing side. Doing a full index-pack is the most robust way there,
    but it's quite expensive. Just checking the SHA1 of the packfile
    itself would give pretty good protection against write errors,
    though you'd definitely want to couple it with CRC32 checks on the
    source (since Git would otherwise include the bad bits in its SHA1
    checksum).
