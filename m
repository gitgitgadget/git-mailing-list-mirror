Return-Path: <SRS0=ToNR=6F=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65511C2BA19
	for <git@archiver.kernel.org>; Tue, 21 Apr 2020 07:01:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3D942206F4
	for <git@archiver.kernel.org>; Tue, 21 Apr 2020 07:01:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726018AbgDUHBg (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Apr 2020 03:01:36 -0400
Received: from cloud.peff.net ([104.130.231.41]:34194 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725926AbgDUHBg (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Apr 2020 03:01:36 -0400
Received: (qmail 19638 invoked by uid 109); 21 Apr 2020 07:01:35 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 21 Apr 2020 07:01:35 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 8912 invoked by uid 111); 21 Apr 2020 07:12:38 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 21 Apr 2020 03:12:38 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 21 Apr 2020 03:01:35 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        dstolee@microsoft.com, mhagger@alum.mit.edu
Subject: Re: [PATCH 0/3] commit-graph: write non-split graphs as read-only
Message-ID: <20200421070135.GA2906244@coredump.intra.peff.net>
References: <cover.1587422630.git.me@ttaylorr.com>
 <xmqq5zdtrbby.fsf@gitster.c.googlers.com>
 <20200420233907.GA97996@syl.local>
 <xmqqlfmpprhq.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqlfmpprhq.fsf@gitster.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 20, 2020 at 06:17:05PM -0700, Junio C Hamano wrote:

> Taylor Blau <me@ttaylorr.com> writes:
> 
> >   * do want to respect core.sharedRepository, in which case the
> >     current behavior of always setting split-graph permissions to '0444'
> >     is wrong, or
> 
> Yes, I would say "always 0444" is wrong.

I'm not sure. That's what we do for loose objects, packs, etc. The mode
we feed to git_mkstemp_mode(), etc, is not the true mode we expect to
end up with. We know that it will be modified by the umask, and then
perhaps by adjust_shared_perm().

If you are arguing that there are only two interesting modes: 0444 and
0666, and those could be represented by a read-only/read-write enum, I'd
agree with that. But the rest of the code already spells those as 0444
and 0666, and I don't see that as a big problem (in fact, there's a bit
of an advantage because the same constants work at both high and low
levels of the call stack, so you don't have to decide where to put the
translation).

> >   * we do not want to respect core.sharedRepository, in which case these
> >     patches are doing what we want by setting all commit-graph files to
> >     have read-only permissions.
> >
> > My hunch is that we do not want to abide by core.sharedRepository here
> > for the same reason that, say, loose objects are read-only. What do you
> > think?
> 
> I thought that adjusting perm for sharedRepository is orthogonal to
> the read-only vs read-write.  If a file ought to be writable by the
> owner, we would make it group writable in a group shared repository.
> If a file is readable by the owner, we make sure it is readable by
> group in such a repository (and we do not want to flip write bit
> on).  That happens by calling path.c::calc_shared_perm().

Right. I think adjust_shared_perm() should already be doing what we
want, and we should continue to call it. But it should not be
responsible for this "read-only versus read-write" decision. That
happens much earlier, and it adjusts as appropriate.

-Peff
