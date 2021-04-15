Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B732C433ED
	for <git@archiver.kernel.org>; Thu, 15 Apr 2021 09:03:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 29DBC61073
	for <git@archiver.kernel.org>; Thu, 15 Apr 2021 09:03:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231725AbhDOJDd (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 15 Apr 2021 05:03:33 -0400
Received: from cloud.peff.net ([104.130.231.41]:53114 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231488AbhDOJDc (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Apr 2021 05:03:32 -0400
Received: (qmail 9672 invoked by uid 109); 15 Apr 2021 09:03:08 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 15 Apr 2021 09:03:08 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 14300 invoked by uid 111); 15 Apr 2021 09:03:09 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 15 Apr 2021 05:03:09 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 15 Apr 2021 05:03:08 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>,
        rafaeloliveira.cs@gmail.com, git@vger.kernel.org,
        szeder.dev@gmail.com
Subject: Re: [PATCH 2/2] repack: avoid loosening promisor pack objects in
 partial clones
Message-ID: <YHgBTPGTmDUBMGA9@coredump.intra.peff.net>
References: <20210414191403.4387-3-rafaeloliveira.cs@gmail.com>
 <20210415010454.4077355-1-jonathantanmy@google.com>
 <xmqqo8egurx5.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqo8egurx5.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 14, 2021 at 08:51:02PM -0700, Junio C Hamano wrote:

> Jonathan Tan <jonathantanmy@google.com> writes:
> 
> >> When `-A` and `-d` are used together, besides packing all objects (-A)
> >> and removing redundant packs (-d), it also unpack all unreachable
> >> objects and deletes them by calling `git pruned-packed`.
> >
> > I still think of these objects as not unreachable, even though I know
> > that pack-objects calls them that (the argument is called
> > --unpack-unreachable). So I would say "it also loosens all objects that
> > were previously packed but did not go into the new pack", but perhaps
> > this is OK too.
> 
> Hmph, that is puzzling.  I understand that the operation about
> 
>  (1) finding all the objects that are still reachable and send them
>      into a newly created pack, and
> 
>  (2) among the objects that were previously in the packs, eject
>      those that weren't made into the new pack with the previous
>      point.
> 
> Where did I get it wrong?  If all the reachable ones are dealt with
> with the first point, what is leftover is not reachable, no?

Right. I think your understanding is correct, and the commit message is
a bit confused. Normally after we eject loose objects, they'd stay there
(a follow-up git-gc may run git-prune and delete them, though if they
were recent enough not to just drop completely during the repack, then
git-prune would likewise leave them be). Talking about prune-packed here
is misleading, because it usually has nothing to do with these objects.

What makes the partial-clone situation under discussion interesting is
that the objects _are_ reachable. They are excluded from the new pack
because we put them in a separate promisor pack. But we erroneously turn
them loose, rather than realizing that they were excluded for a
different reason.

So the fundamental bug is that we turn them loose at all. What makes the
bug trickier to see is that when we run prune-packed afterwards, we then
clean up the evidence of the bug (so it looks more like a performance
problem than a correctness one).

-Peff
