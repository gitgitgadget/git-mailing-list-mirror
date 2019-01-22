Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 95A951F453
	for <e@80x24.org>; Tue, 22 Jan 2019 07:12:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727040AbfAVHMx (ORCPT <rfc822;e@80x24.org>);
        Tue, 22 Jan 2019 02:12:53 -0500
Received: from cloud.peff.net ([104.130.231.41]:43524 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726423AbfAVHMx (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Jan 2019 02:12:53 -0500
Received: (qmail 5965 invoked by uid 109); 22 Jan 2019 07:12:53 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 22 Jan 2019 07:12:53 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 3388 invoked by uid 111); 22 Jan 2019 07:12:56 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 22 Jan 2019 02:12:56 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 22 Jan 2019 02:12:51 -0500
Date:   Tue, 22 Jan 2019 02:12:51 -0500
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Barret Rhoden <brho@google.com>, git@vger.kernel.org,
        David Kastrup <dak@gnu.org>, Jeff Smith <whydoubt@gmail.com>,
        =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
        Stefan Beller <stefanbeller@gmail.com>
Subject: Re: [PATCH v2 1/3] Move init_skiplist() outside of fsck
Message-ID: <20190122071251.GB28555@sigill.intra.peff.net>
References: <20190107213013.231514-1-brho@google.com>
 <20190117202919.157326-1-brho@google.com>
 <20190117202919.157326-2-brho@google.com>
 <87k1j247ui.fsf@evledraar.gmail.com>
 <xmqqzhrxlvfj.fsf@gitster-ct.c.googlers.com>
 <nycvar.QRO.7.76.6.1901182155020.41@tvgsbejvaqbjf.bet>
 <20190118213018.GA28808@sigill.intra.peff.net>
 <87h8e54n6y.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87h8e54n6y.fsf@evledraar.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jan 18, 2019 at 11:26:29PM +0100, Ævar Arnfjörð Bjarmason wrote:

> I stand corrected, I thought these still needed to be updated to parse
> anything that wasn't 40 chars, since I hadn't seen anything about these
> formats in the hash transition document.
> 
> So fair enough, let's change that while we're at it, but this seems like
> something that needs to be planned for in more detail / documented in
> the hash transition doc.
> 
> I.e. many (e.g. me) maintain some system-wide skiplist for strict fsck
> cloning of legacy repos. So I can see there being some need for a
> SHA1<->SHA256 map in this case, but since these files might stretch
> across repo boundaries and not be checked into the repo itself this is a
> new use-case that needs thinking about.

My assumption had been that changing your local repository would be a
(local) flag day, and you'd update any ancillary files like skiplists,
mailmap.blob, etc at the same time. I'm not opposed to making those
features more clever, though.

> But now that I think about it this sort of thing would be a good
> use-case for just fixing these various historical fsck issues while
> we're at it when possible, e.g. "missing space before email" (probably
> not all could be unambiguously fixed). So instead of sha256<->sha1
> fn(sha256)<->fn(sha1)[1]?

That is a very tempting thing to do, but I think it comes with its own
complications. We do not want to do fn(sha1), I don't think; the reason
we care about sha1 at all is that those hashes are already set in stone.

There could be a "clean up the data as we convert to sha256" operation,
but:

  - it needs to be set in stone from day 1, I'd think. The last thing we
    want is to modify it after conversions are in the wild

  - I think we need to be bi-directional. So it must be a mapping that
    can be undone to retrieve the original bytes, so we can compute
    their "real" sha1.

At which point, I think it might be simpler to just make git more
permissive with respect to those minor data errors (and in fact, we are
already pretty permissive for the most part in non-fsck operations).

-Peff
