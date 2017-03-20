Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 351AD20958
	for <e@80x24.org>; Mon, 20 Mar 2017 18:30:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756257AbdCTSam (ORCPT <rfc822;e@80x24.org>);
        Mon, 20 Mar 2017 14:30:42 -0400
Received: from cloud.peff.net ([104.130.231.41]:47919 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756221AbdCTSak (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Mar 2017 14:30:40 -0400
Received: (qmail 14913 invoked by uid 109); 20 Mar 2017 18:30:27 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 20 Mar 2017 18:30:27 +0000
Received: (qmail 4438 invoked by uid 111); 20 Mar 2017 18:30:40 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 20 Mar 2017 14:30:40 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 20 Mar 2017 14:30:23 -0400
Date:   Mon, 20 Mar 2017 14:30:23 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Michael Haggerty <mhagger@alum.mit.edu>,
        Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        David Turner <novalis@novalis.org>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 00/20] Separate `ref_cache` into a separate module
Message-ID: <20170320183022.mlv2y5g6pn2i7znq@sigill.intra.peff.net>
References: <cover.1490026594.git.mhagger@alum.mit.edu>
 <CACBZZX7Kqo=w-c2LOH9a4xf6WpnhE5tsvNHa1O2-4dvYTKZxEA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACBZZX7Kqo=w-c2LOH9a4xf6WpnhE5tsvNHa1O2-4dvYTKZxEA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 20, 2017 at 07:24:12PM +0100, Ævar Arnfjörð Bjarmason wrote:

> On Mon, Mar 20, 2017 at 5:33 PM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
> 
> > I've completed a draft of an epic 48-patch series implementing all of
> > the above points on my GitHub fork [1] as branch
> > `wip/mmap-packed-refs`. It dramatically speeds up performance and
> > reduces memory usage for some tasks in repositories with very many
> > packed references.
> 
> Just curious, what sort of performance numbers on mainly what sort of
> operations? I'd expect the fixed cost of e.g. `git log -1 >/dev/null`
> to go down, which can take as long as a second on some repos with a
> huge amount of refs, but anything else?

Anything that reads refs (and that includes anything that touches an
object, because it looks at refs/replace) loads the entire packed-refs
file into memory. So I'd expect you're paying that "1 second" cost on a
lot of commands.

Even commands that traverse the entire ref namespace should improve, as
we'd spend a lot less time allocating and copying data into the
in-memory refs cache. Not to mention that the memory usage is reduced,
though that probably only really matters for pathological cases.

-Peff
