Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D37E0C433F5
	for <git@archiver.kernel.org>; Fri,  1 Oct 2021 06:17:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B725861A54
	for <git@archiver.kernel.org>; Fri,  1 Oct 2021 06:17:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352101AbhJAGTT (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 1 Oct 2021 02:19:19 -0400
Received: from cloud.peff.net ([104.130.231.41]:58884 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1351989AbhJAGTO (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Oct 2021 02:19:14 -0400
Received: (qmail 26179 invoked by uid 109); 1 Oct 2021 06:17:31 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 01 Oct 2021 06:17:31 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 8224 invoked by uid 111); 1 Oct 2021 06:17:30 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 01 Oct 2021 02:17:30 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 1 Oct 2021 02:17:30 -0400
From:   Jeff King <peff@peff.net>
To:     Jiang Xin <worldhello.net@gmail.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Han Xin <chiyutianyi@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Git List <git@vger.kernel.org>,
        Han Xin <hanxin.hx@alibaba-inc.com>
Subject: Re: [PATCH v2] receive-pack: not receive pack file with large object
Message-ID: <YVan+n1surlXfiEw@coredump.intra.peff.net>
References: <20210930121058.5771-1-chiyutianyi@gmail.com>
 <20210930132004.16075-1-chiyutianyi@gmail.com>
 <87pmsqtb2p.fsf@evledraar.gmail.com>
 <CANYiYbHNBcDaoF+QE_+62EXUZD_caaJDFmt7v1_BddQfpdVcvg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CANYiYbHNBcDaoF+QE_+62EXUZD_caaJDFmt7v1_BddQfpdVcvg@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 01, 2021 at 10:30:24AM +0800, Jiang Xin wrote:

> > Maybe an unfair knee-jerk reaction: I think we should really be pushing
> > this sort of thing into pre-receive hooks and/or the proc-receive hook,
> > i.e. see 15d3af5e22e (receive-pack: add new proc-receive hook,
> > 2020-08-27).
> 
> Last week, one user complained that he cannot push to his repo in our
> server, and later Han Xin discovered the user was trying to push a
> very big blob object over 10GB. For this case, the "pre-receive" hook
> had no change to execute because "git-receive-pack" died early because
> of OOM.  The function "unpack_non_delta_entry()" in
> "builtin/unpack-objects.c" will try to allocate memory for the whole
> 10GB blob but no lucky.
> 
> Han Xin is preparing another patch to resolve the OOM issue found in
> "unpack_non_delta_entry()". But we think it is reasonable to prevent
> such a big blob in a pack to git-receive-pack, because it will be
> slower to check objects from pack and loose objects in the quarantine
> using pre-receive hook.

I think index-pack handles this case correctly, at least for base
objects. In unpack_entry_data(), it will stream anything bigger than
big_file_threshold. Probably unpack-objects needs to learn the same
trick.

In general, the code in index-pack has gotten a _lot_ more attention
over the years than unpack-objects. I'd trust its security a lot more,
and it has extra performance enhancements (like multithreading and
streaming). At GitHub, we always run index-pack on incoming packs, and
never unpack-objects. I'm tempted to say we should stop using
unpack-objects entirely for incoming packs, and then either:

  - just keep packs for incoming objects. It's not really any worse of a
    state than loose objects, and it all eventually gets rolled up by gc
    anyway. (The exception is that thin packs may duplicate base objects
    until that rollup).

  - teach index-pack an "--unpack" option. I actually wrote some patches
    for this a while back. It's not very much code, but there were some
    rough edges and I never came back to them. I'm happy to share if
    anybody's interested.

Though I would note that for deltas, even index-pack will not stream the
contents. You generally shouldn't have very large deltas, as clients
will also avoid computing them (because that also involves putting the
whole object in memory). But the notion of "large" is not necessarily
the same between client and server. And of course somebody can
maliciously make a giant delta.

-Peff
