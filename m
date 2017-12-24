Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 568CA1F424
	for <e@80x24.org>; Sun, 24 Dec 2017 14:22:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752157AbdLXOWu (ORCPT <rfc822;e@80x24.org>);
        Sun, 24 Dec 2017 09:22:50 -0500
Received: from cloud.peff.net ([104.130.231.41]:46464 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751042AbdLXOWt (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 24 Dec 2017 09:22:49 -0500
Received: (qmail 10966 invoked by uid 109); 24 Dec 2017 14:22:48 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sun, 24 Dec 2017 14:22:48 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 3472 invoked by uid 111); 24 Dec 2017 14:23:15 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with ESMTPA; Sun, 24 Dec 2017 09:23:15 -0500
Authentication-Results: peff.net; auth=pass (cram-md5) smtp.auth=relayok
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 24 Dec 2017 09:22:46 -0500
Date:   Sun, 24 Dec 2017 09:22:46 -0500
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
        Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>,
        Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH] revision: introduce prepare_revision_walk_extended()
Message-ID: <20171224142246.GA23648@sigill.intra.peff.net>
References: <6ace4f8f-824b-2825-ef18-1fccebb9fb5c@web.de>
 <20171218151043.GA9449@sigill.intra.peff.net>
 <39581cd0-0bfd-c8d1-642b-1245cf425ab4@web.de>
 <20171219114906.GB24558@sigill.intra.peff.net>
 <xmqq7etiworw.fsf@gitster.mtv.corp.google.com>
 <20171220130811.GD17569@sigill.intra.peff.net>
 <c8980a2c-24e2-a877-fa66-31206123ce49@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c8980a2c-24e2-a877-fa66-31206123ce49@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Dec 21, 2017 at 07:41:44PM +0100, René Scharfe wrote:

> Am 20.12.2017 um 14:08 schrieb Jeff King:
> > On Tue, Dec 19, 2017 at 10:33:55AM -0800, Junio C Hamano wrote:
> > 
> >> Should we take the patch posted as-is and move forward?
> > 
> > I suppose so.  I don't really have anything against the patch. My main
> > complaint was just that I don't think it's actually cleaning up the
> > gross parts of the interface. It's just substituting one gross thing (a
> > funny struct flag) for another (a special version of the prepare
> > function that takes a funny out-parameter).
> 
> If this is a fair description (and I have to admit that it is) then I
> don't understand why you aren't against the patch.  Let's drop it.

Heh, I almost wrote more on this. My thinking was two-fold:

  - while I think the fundamental gross-ness is still there after your
    patch, it does smooth some of the rough edges. So it's a slight
    improvement over the status quo.

  - I read an article a while back (which unfortunately I can't find
    now) about the idea of "default to yes" in open source. I.e., the
    idea that if somebody bothered to cook up a patch and there is no
    good reason to reject it, you should take it.

    Certainly there are cases where that can go too far: obvious ones
    like bad ideas where it is not really "default" anymore, but also
    subtle ones where the changes are code churn whose fallouts will
    be dealt with by others. But this patch is a good example. I'm not
    convinced it makes things better, but I don't think it makes things
    worse. If you, who looked a lot closer at the problem than I did,
    still think it's a good idea after our discussion, it's probably
    worth applying.

So my comments weren't really "this is a bad idea" as much as "is there
a better idea". We didn't come up with one after some discussion, and
I'm willing to let it go there for now.

But if you want to keep thinking on it, I'm game. ;)

> Can we do better?  How about something this?  It reverts bundle to
> duplicate the object_array, but creates just a commit_list in the other
> two cases.  As a side-effect this allows clearing flags for all entries
> with a single traversal.

I think this is basically the "copy it before-hand" thing from earlier
in the thread. Switching to just keeping commits seems like a nice
change. It's an easy (if minor) optimization, and it makes clear exactly
which part of the data we need to keep around.

The single-traversal thing I suspect doesn't matter much in practice. In
both cases if we would visit commit X twice, we'd immediately see on the
second visit that it has already been cleared and not do anymore work.

  Side note: Another question is whether it would simply be faster to
  clear the flags for _all_ objects that we've touched in the current
  process (we have clear_object_flags() for this already). Then we know
  that we touch each one once, and we as a bonus we don't even have to
  keep the previous tips. The downsides are:

    - if another traversal in the process looked at many objects, but
      our current traversal looked at few, then we would examine more
      objects than we need to (albeit with lower cost per object)

    - it's possible there's another traversal in the same process whose
      flags we would want to have saved. I suspect such a setup is
      broken already, though, unless there's a guarantee that the two
      traversals don't overlap.

So anyway, I think this is a reasonable approach, unless we're really
worried about the extra O(# of pending) allocation.

-Peff
