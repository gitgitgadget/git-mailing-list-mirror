Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 294271F87F
	for <e@80x24.org>; Mon, 19 Nov 2018 18:44:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726750AbeKTFJa (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Nov 2018 00:09:30 -0500
Received: from cloud.peff.net ([104.130.231.41]:44750 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726594AbeKTFJ2 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Nov 2018 00:09:28 -0500
Received: (qmail 19265 invoked by uid 109); 19 Nov 2018 18:44:40 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 19 Nov 2018 18:44:40 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 20589 invoked by uid 111); 19 Nov 2018 18:44:03 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Mon, 19 Nov 2018 13:44:03 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 19 Nov 2018 13:44:39 -0500
Date:   Mon, 19 Nov 2018 13:44:39 -0500
From:   Jeff King <peff@peff.net>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Stefan Beller <sbeller@google.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Ben Peart <benpeart@microsoft.com>
Subject: Re: Git Test Coverage Report (v2.20.0-rc0)
Message-ID: <20181119184438.GA21528@sigill.intra.peff.net>
References: <9e293b1b-1845-1772-409b-031c0bf4d17b@gmail.com>
 <6f532502-d4b6-17f6-0ec7-01079077ac90@gmail.com>
 <20181119162137.GA10621@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181119162137.GA10621@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 19, 2018 at 11:21:38AM -0500, Jeff King wrote:

> > +       if (use_delta_islands) {
> > +               const char *p;
> > +               unsigned depth = 0;
> > +               struct object_entry *ent;
> > +
> > +               for (p = strchr(name, '/'); p; p = strchr(p + 1, '/'))
> > +                       depth++;
> > +
> > +               ent = packlist_find(&to_pack, obj->oid.hash, NULL);
> > +               if (ent && depth > ent->tree_depth)
> > +                       ent->tree_depth = depth;
> > +       }
> >  }
> > 
> > And that 'ent->tree_depth = depth;' line is replaced with the
> > oe_set_tree_depth() call in the report.
> > 
> > Since depth is never incremented, we are not covering this block. Is it
> > possible to test?
> 
> Looks like t5320 only has single-level trees. We probably just need to
> add a deeper tree. A more interesting case is when an object really is
> found at multiple depths, but constructing a case that cared about that
> would be quite complicated.
> 
> That said, there is much bigger problem with this code, which is that
> 108f530385 (pack-objects: move tree_depth into 'struct packing_data',
> 2018-08-16) is totally broken. It works on the trivial repository in the
> test, but try this (especially under valgrind or ASan) on a real
> repository:
> 
>   git repack -adi
> 
> which will crash immediately.  It doesn't correctly maintain the
> invariant that if tree_depth is not NULL, it is the same size as
> the main object array.
> 
> I'll see if I can come up with a fix.

Just a quick update to prevent anyone else looking at it: I have a fix
for this (and another related issue with that commit).

There's an edge case in that depth computation that I think is
unhandled, as well. I _think_ it doesn't trigger very often, but I'm
running some experiments to verify it. That's S-L-O-W, so I probably
won't have results until tomorrow.

-Peff
