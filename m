Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AAEC820286
	for <e@80x24.org>; Fri,  8 Sep 2017 03:47:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753645AbdIHDrn (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Sep 2017 23:47:43 -0400
Received: from cloud.peff.net ([104.130.231.41]:60398 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1752375AbdIHDrm (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Sep 2017 23:47:42 -0400
Received: (qmail 9039 invoked by uid 109); 8 Sep 2017 03:47:42 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 08 Sep 2017 03:47:42 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 5585 invoked by uid 111); 8 Sep 2017 03:48:15 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Thu, 07 Sep 2017 23:48:15 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 07 Sep 2017 23:47:40 -0400
Date:   Thu, 7 Sep 2017 23:47:40 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Stefan Beller <sbeller@google.com>,
        =?utf-8?B?UGF3ZcWC?= Marczewski <pwmarcz@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Strange behavior of git rev-list
Message-ID: <20170908034739.4op3w4f2ma5s65ku@sigill.intra.peff.net>
References: <CACNsYJ-UeEONZ+mDgg6x5Bi+D3VmS=5eGCYq1gEPHVsMEJGojA@mail.gmail.com>
 <20170907094718.b6kuzp2uhvkmwcso@sigill.intra.peff.net>
 <CACNsYJ8rRSf5gNtnPS05CnYCYGmoBymbgH7UumuOuBz1jp6RBA@mail.gmail.com>
 <20170907101126.u574pr7l5odff6zo@sigill.intra.peff.net>
 <CAGZ79kaubRDXnetj+EXawnr50LMo4tGObz+-Bd-=KerndLfSaA@mail.gmail.com>
 <20170908031705.5zqs7jhamzgda47t@sigill.intra.peff.net>
 <xmqqwp59zwqv.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqwp59zwqv.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 08, 2017 at 12:37:28PM +0900, Junio C Hamano wrote:

> > I'm still moderately against storing generation numbers inside the
> > objects. They're redundant with the existing parent pointers, which
> > means it's an opportunity for the two sets of data to disagree. And as
> > we've seen, once errors are cemented in history it's very hard to fix
> > them, because you break any history built on top.
> >
> > I'm much more in favor of building a local cache of generation numbers
> > (either on the fly or during repacks, where we can piggy-back on the
> > existing pack .idx for indexing).
> 
> I guess our mails crossed.  Yes, objects that are needlessly broken
> only because they botch computation of derivable values are real
> problem, as we need to accomodate them forever because histories can
> and will be built on top of them.
> 
> On the other hand, seeing that the world did not stop even with some
> projects have trees with entries whose mode are written with 0-padding
> on the left in the ancient part of their histories, it might not be
> such a big deal.  I dunno.

True, but in counter-point:

  1. Tree problems generally only affect operations on that tree itself.
     Parent (or generation number) problems hit us any time we walk
     across that part of history, which may be much more frequent.

  2. There's an open question of what to do with existing commits
     without generation numbers.

     Per (1), "git tag --contains" is _always_ going to want to know the
     generation number of v1.0. Some problems are "local" to their block
     of history and as the project history marches forward, the bugs are
     there but you are less likely to make queries that hit them. But
     considering old tags for reachability will happen forever (and is
     the _most_ important use of generation numbers, because it lets us
     throw out that old history immediately).

     So if we assume we can't rewrite those objects, then we end up with
     some kind of local cache anyway.

  3. I think we should be moving more in the direction of keeping
     repo-local caches for optimizations. Reachability bitmaps have been
     a big performance win. I think we should be doing the same with our
     properties of commits. Not just generation numbers, but making it
     cheap to access the graph structure without zlib-inflating whole
     commit objects (i.e., packv4 or something like the "metapacks" I
     proposed a few years ago).

-Peff
