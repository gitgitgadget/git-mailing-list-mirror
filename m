Return-Path: <SRS0=NBeB=5G=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C49CC4332B
	for <git@archiver.kernel.org>; Sat, 21 Mar 2020 05:04:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBE8A20753
	for <git@archiver.kernel.org>; Sat, 21 Mar 2020 05:04:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727158AbgCUFE5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 21 Mar 2020 01:04:57 -0400
Received: from cloud.peff.net ([104.130.231.41]:45966 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725440AbgCUFE4 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 21 Mar 2020 01:04:56 -0400
Received: (qmail 8104 invoked by uid 109); 21 Mar 2020 05:04:56 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sat, 21 Mar 2020 05:04:56 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 14864 invoked by uid 111); 21 Mar 2020 05:14:39 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 21 Mar 2020 01:14:39 -0400
Authentication-Results: peff.net; auth=none
Date:   Sat, 21 Mar 2020 01:04:55 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        dstolee@microsoft.com
Subject: Re: [PATCH 0/1] commit-graph: avoid unnecessary tag deference when
 merging
Message-ID: <20200321050455.GB1438317@coredump.intra.peff.net>
References: <cover.1584762087.git.me@ttaylorr.com>
 <xmqqo8sq9uhb.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqo8sq9uhb.fsf@gitster.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 20, 2020 at 09:56:16PM -0700, Junio C Hamano wrote:

> Taylor Blau <me@ttaylorr.com> writes:
> 
> > This patch avoids an unnecessary tag dereference in
> > 'merge_commit_graph()', which can improve the running time of a
> > commit-graph write by around ~7.4% on average.
> 
> That I suspect depends heavily on what portion of your total
> committishes consist of tags, no (in an absurdly extreme case, if
> there is no tag in the repository, there won't be any improvement)?
> 
> What tag-vs-commit ratio is the above "average" number based on?

I think the point is that in this code path we've already identified the
candidates as commits (because they were in an existing commit-graph
file), so treating the items as a committishes in the first place is
unnecessary. If an object isn't itself a commit, we should be dropping
it from the proposed output (possibly we ought to give a warning in such
a case, too, as it indicates the previous writer did something wrong).

-Peff
