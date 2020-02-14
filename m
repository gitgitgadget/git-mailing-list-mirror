Return-Path: <SRS0=nsHh=4C=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9243C35242
	for <git@archiver.kernel.org>; Fri, 14 Feb 2020 20:51:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83E99222C2
	for <git@archiver.kernel.org>; Fri, 14 Feb 2020 20:51:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388860AbgBNUvw (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 Feb 2020 15:51:52 -0500
Received: from cloud.peff.net ([104.130.231.41]:43864 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S2387970AbgBNUvw (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Feb 2020 15:51:52 -0500
Received: (qmail 23591 invoked by uid 109); 14 Feb 2020 20:51:52 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 14 Feb 2020 20:51:52 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 24386 invoked by uid 111); 14 Feb 2020 21:00:49 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 14 Feb 2020 16:00:49 -0500
Authentication-Results: peff.net; auth=none
Date:   Fri, 14 Feb 2020 15:51:51 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v2 04/15] pack-bitmap: refuse to do a bitmap traversal
 with pathspecs
Message-ID: <20200214205151.GB1210277@coredump.intra.peff.net>
References: <20200214182147.GA654525@coredump.intra.peff.net>
 <20200214182216.GD150965@coredump.intra.peff.net>
 <xmqqeeuxng8x.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqeeuxng8x.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Feb 14, 2020 at 11:03:26AM -0800, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > It would also prepare us for a day where this case _is_ handled, but
> > that's pretty unlikely. E.g., we could use bitmaps to generate the set
> > of commits, and then diff each commit to see if it matches the pathspec.
> 
> Would the gs/commit-graph-path-filter topic possibly help in this regard?
> I was wondering how it would fit within the framework this series sets
> up to teach object-filtering and reachability-bitmap codepaths to
> work well together.

I think it would make the scheme I described faster, because that diff
becomes faster. So the commit traversal itself becomes proportionally
more expensive. And if we could speed that up with bitmaps, that's some
improvement. OTOH, my later timings in patch 9 showed that commit graphs
already make that part pretty fast. And they do so without a bunch of
weird restrictions and hassles. So I suspect it's not really worth the
effort to implement this half-way bitmaps approach (for a special case
that it's not even clear anybody cares about).

But if somebody _does_ do so, I don't think we'd need to do anything too
special to integrate with commit-graph-path-filter. The nice thing about
that approach is that the pathspec pruning will just magically return
the same answer, but faster.

-Peff
