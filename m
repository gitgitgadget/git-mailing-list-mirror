Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DE6E420248
	for <e@80x24.org>; Wed,  3 Apr 2019 12:32:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726151AbfDCMce (ORCPT <rfc822;e@80x24.org>);
        Wed, 3 Apr 2019 08:32:34 -0400
Received: from eggs.gnu.org ([209.51.188.92]:35765 "EHLO eggs.gnu.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726074AbfDCMce (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Apr 2019 08:32:34 -0400
Received: from fencepost.gnu.org ([2001:470:142:3::e]:52990)
        by eggs.gnu.org with esmtp (Exim 4.71)
        (envelope-from <dak@gnu.org>)
        id 1hBf4A-0001MX-7P; Wed, 03 Apr 2019 08:32:30 -0400
Received: from x2f3b1a1.dyn.telefonica.de ([2.243.177.161]:49784 helo=lola)
        by fencepost.gnu.org with esmtpsa (TLS1.2:RSA_AES_256_CBC_SHA1:256)
        (Exim 4.82)
        (envelope-from <dak@gnu.org>)
        id 1hBf42-0000yf-7R; Wed, 03 Apr 2019 08:32:24 -0400
From:   David Kastrup <dak@gnu.org>
To:     Jeff King <peff@peff.net>
Cc:     Duy Nguyen <pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH] blame.c: don't drop origin blobs as eagerly
References: <20190402115625.21427-1-dak@gnu.org>
        <xmqqv9zvsfay.fsf@gitster-ct.c.googlers.com>
        <CACsJy8AbkmJ69ucCfGMdXHGvfko89SxH=DKjra6Ltwf7wpy-Og@mail.gmail.com>
        <20190403113604.GA2941@sigill.intra.peff.net>
        <CACsJy8BCGHqjO5fKG7TO5X239z_7Gzdo80jF0rx939X501yVnA@mail.gmail.com>
        <20190403121919.GA6818@sigill.intra.peff.net>
Date:   Wed, 03 Apr 2019 14:32:19 +0200
In-Reply-To: <20190403121919.GA6818@sigill.intra.peff.net> (Jeff King's
        message of "Wed, 3 Apr 2019 08:19:19 -0400")
Message-ID: <878swr5kx8.fsf@fencepost.gnu.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Wed, Apr 03, 2019 at 07:06:02PM +0700, Duy Nguyen wrote:
>
>> On Wed, Apr 3, 2019 at 6:36 PM Jeff King <peff@peff.net> wrote:
>> > I suspect we could do even better by storing and reusing not just the
>> > original blob between diffs, but the intermediate diff state (i.e., the
>> > hashes produced by xdl_prepare(), which should be usable between
>> > multiple diffs). That's quite a bit more complex, though, and I imagine
>> > would require some surgery to xdiff.
>> 
>> Amazing. xdl_prepare_ctx and xdl_hash_record (called inside
>> xdl_prepare_ctx) account for 36% according to 'perf report'. Please
>> tell me you just did not get this on your first guess.
>
> Sorry, it was a guess. ;)
>
> But an educated one, based on previous experiments with speeding up "log
> -p". Remember XDL_FAST_HASH, which produced speedups there (but
> unfortunately had some pathological slowdowns, because it produced too
> many collisions). I've also played around with using other hashes like
> murmur or siphash, but was never able to get anything remarkably faster
> than what we have now.
>
>> I tracked and dumped all the hashes that are sent to xdl_prepare() and
>> it looks like the amount of duplicates is quite high. There are only
>> about 1000 one-time hashes out of 7000 (didn't really draw a histogram
>> to examine closer). So yeah this looks really promising, assuming
>> somebody is going to do something about it.
>
> I don't think counting the unique hash outputs tells you much about what
> can be sped up. After all, two related blobs are likely to overlap quite
> a bit in their hashes (i.e., all of their non-unique lines). The trick
> is finding in each blob those ones that _are_ unique. :)
>
> But if we spend 36% of our time in hashing the blobs, then that implies
> that we could gain back 18% by caching and reusing the work from a
> previous diff (as David notes, a simple keep-the-last-parent cache only
> yields 100% cache hits in a linear history, but it's probably good
> enough for our purposes).

Of course, if you really want to get tricky, you'll not even compare
stuff that is expanded from the same delta-chain location.  Basically,
there are a number of separate layers that are doing rather similar work
with rather similar data, but intermingling the layers' work is not
going to be good for maintainability.  Caching at the various layers can
keep their separation while still reducing some of the redundancy costs.

-- 
David Kastrup
