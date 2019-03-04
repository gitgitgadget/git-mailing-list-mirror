Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0640820248
	for <e@80x24.org>; Mon,  4 Mar 2019 21:17:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726096AbfCDVRw (ORCPT <rfc822;e@80x24.org>);
        Mon, 4 Mar 2019 16:17:52 -0500
Received: from cloud.peff.net ([104.130.231.41]:38390 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726038AbfCDVRv (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Mar 2019 16:17:51 -0500
Received: (qmail 29294 invoked by uid 109); 4 Mar 2019 21:17:51 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 04 Mar 2019 21:17:51 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 26085 invoked by uid 111); 4 Mar 2019 21:18:08 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Mon, 04 Mar 2019 16:18:08 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 04 Mar 2019 16:17:49 -0500
Date:   Mon, 4 Mar 2019 16:17:49 -0500
From:   Jeff King <peff@peff.net>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     matvore@google.com, git@vger.kernel.org
Subject: Re: [PATCH] rev-list: allow cached objects in existence check
Message-ID: <20190304211749.GA3020@sigill.intra.peff.net>
References: <20190304174053.GA27497@sigill.intra.peff.net>
 <20190304191932.105204-1-jonathantanmy@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190304191932.105204-1-jonathantanmy@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 04, 2019 at 11:19:32AM -0800, Jonathan Tan wrote:

> >   - some callers of has_sha1_file() might care about durability between
> >     processes. Because it's baked in, the empty tree is safe for that
> >     (whatever follow-on process runs, it will also be baked in there).
> >     But that's not necessarily true for other "cached" objects. I'm not
> >     really that worried about it because we use it sparingly (the only
> >     call to pretend_sha1_file() is in git-blame, and if it ever did ask
> >     "do we have this object", I actually think the right answer would be
> >     "yes").
> > 
> >     But if this is a concern, we could perhaps have two levels of flags:
> >     SKIP_CACHED and SKIP_INTERNAL.
> 
> Or teach git-blame to have its own pretend mechanism, and remove the
> pretend mechanism from sha1-file.c.

I think that would be ideal, but I'm not sure if it's feasible due to
the layering of the various modules. IOW, the blame code isn't just
pretending a fake object file for _itself_, it needs to then call into
the diff code, which must be able to then find that content in order to
produce a diff.

But maybe it is not so bad. Our diff_filespec struct does represent
working-tree files (as it must, since we diff them!). So it may be
possible to feed it to the diff code at the right spot.

I haven't looked closely enough to say for sure whether it's feasible or
not. But it does imply to me that we should go with this regression fix
in the near-term and think about building bigger changes separately on
master.

> The last time I deeply thought of this was during the partial clone
> implementation, so I am probably not completely up-to-date, but it seems
> to me that ideally, for reading, we would remove SKIP_CACHED completely
> (and always consult the cache), and also remove completely the ability
> to pretend (blame will have to do it by itself); and for writing, we
> would write the empty tree whenever we do now (for backwards
> compatibility with old versions of Git that read what we write). Both
> the approach in this patch and making has_object_file() respect cached
> objects are steps in that direction, so I'm OK with both.

Yeah, I think our world-views are in accord. :)

-Peff
