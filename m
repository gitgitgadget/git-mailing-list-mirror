Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B397DC4338F
	for <git@archiver.kernel.org>; Wed, 25 Aug 2021 00:44:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8AB3B610F8
	for <git@archiver.kernel.org>; Wed, 25 Aug 2021 00:44:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236337AbhHYApZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 Aug 2021 20:45:25 -0400
Received: from cloud.peff.net ([104.130.231.41]:58358 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231552AbhHYApY (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Aug 2021 20:45:24 -0400
Received: (qmail 21127 invoked by uid 109); 25 Aug 2021 00:44:40 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 25 Aug 2021 00:44:40 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 3990 invoked by uid 111); 25 Aug 2021 00:44:39 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 24 Aug 2021 20:44:39 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 24 Aug 2021 20:44:39 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Taylor Blau <me@ttaylorr.com>, Jacob Vosmaer <jacob@gitlab.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 1/1] upload-pack: buffer ref advertisement writes
Message-ID: <YSWSd5fMbSD5duOU@coredump.intra.peff.net>
References: <20210824140259.89332-1-jacob@gitlab.com>
 <YSVfq9lZGdSRCcP9@nand.local>
 <xmqqczq2mseb.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqczq2mseb.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 24, 2021 at 02:42:20PM -0700, Junio C Hamano wrote:

> > None of this looks wrong to me, but it might be nice to teach the
> > packet writer a buffered mode that would handle this for us. It would be
> > especially nice to bolt the final flush onto packet_flush(), since it is
> > otherwise easy to forget to do.
> 
> FWIW, the packet-line part of the system was from the beginning
> written with an eye to allow buffering until _flush() comes; we may
> have added some buggy conversation path that deadlocks if we make
> the non-flush packets fully buffered, so there may need some fixes,
> but I do not expect the fallout would be too hard to diagnose.
> 
> It may be worth trying that avenue first before piling on the user
> level buffering like this patch does.

Yeah, I had the same thought. It also feels like this is a problem
already solved by stdio. I.e., a lot of the packet_* functions can
handle descriptors or strbufs. Why not "FILE *" handles?

It would probably involve using the original descriptor _and_ the
filehandle in some cases (e.g., ref advertisement over the handle, and
then muxing pack-objects output straight to the descriptor). But that's
OK as long we are sensible about flushing at the right moments.

It may not be much less complex than just implementing buffering in the
packet_* interfaces, though. The tricky part is likely to be the
interface (not itself, but avoiding repetition between all the
fd/strbuf/buffered variants).

-Peff
