Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 56E2D1F597
	for <e@80x24.org>; Fri, 20 Jul 2018 17:56:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388223AbeGTSpZ (ORCPT <rfc822;e@80x24.org>);
        Fri, 20 Jul 2018 14:45:25 -0400
Received: from cloud.peff.net ([104.130.231.41]:54324 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S2387950AbeGTSpZ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Jul 2018 14:45:25 -0400
Received: (qmail 30234 invoked by uid 109); 20 Jul 2018 17:56:04 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 20 Jul 2018 17:56:04 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 30244 invoked by uid 111); 20 Jul 2018 17:56:09 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 20 Jul 2018 13:56:09 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 20 Jul 2018 13:56:03 -0400
Date:   Fri, 20 Jul 2018 13:56:03 -0400
From:   Jeff King <peff@peff.net>
To:     "Theodore Y. Ts'o" <tytso@mit.edu>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH 1/2] introduce "banned function" list
Message-ID: <20180720175602.GC22486@sigill.intra.peff.net>
References: <20180719203259.GA7869@sigill.intra.peff.net>
 <20180719203901.GA8079@sigill.intra.peff.net>
 <xmqqmuumdetr.fsf@gitster-ct.c.googlers.com>
 <20180720010808.GC2179@sigill.intra.peff.net>
 <20180720132241.GN30706@thunk.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180720132241.GN30706@thunk.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jul 20, 2018 at 09:22:41AM -0400, Theodore Y. Ts'o wrote:

> On Thu, Jul 19, 2018 at 09:08:08PM -0400, Jeff King wrote:
> > Ditto for sprintf, where you should _always_ be using at least xsnprintf
> > (or some better tool, depending on the situation).  And for strncpy,
> > strlcpy (or again, some better tool) is strictly an improvement.
> 
> Nitpick: this may be true for git, but it's not strictly true in all
> cases.  I actually have a (non-git) case where strncpy *is* the right
> tool.  And this is one where I'm copying a NUL-terminated string into
> a fixed-length charater array (in the ext4 superblock) which is *not*
> NUL-terminated.  In that case, strncpy works(); but strlcpy() does not
> do what I want.

Thanks for an interesting (and exotic) counter-point. For strcpy(), you
always have to run strlen() anyway to know you're not going to overflow,
so you might as well memcpy() at that point. But if you really are OK
with truncation, then using strncpy() lets you copy while walking over
the string only once, which is more efficient.  On the other hand,
strncpy() fills out NULs to the end of the destination array, so you are
paying an extra cost for small strings.

> So I used strncpy() advisedly, and I ignore people running Coccinelle
> scripts and blindly sending patches to "fix" ext4.

Even after hearing your counter-point, I think I'm still OK with the
ban. Because as you've noticed, even if the call is fine, it carries an
ongoing maintenance cost. Every time you (or somebody else) audits, you
have to skip over that known-good call. And you have to deal with
well-meaning patches. So to me there's value in eliminating it even if
it's an acceptable tool.

We don't have any remaining calls to strncpy() in Git, so this lets us
punt on deciding if the ban is worth changing what's there. We can wait
for somebody to decide they _really_ need strncpy, and we can discuss it
then with a concrete case.

> But perhaps that's also a solution for git?  You don't have to
> necessarily put them on a banned list; you could instead have some
> handy, pre-set scripts that scan the entire code base looking for
> "bad" functions with cleanups automatically suggested.  This could be
> run at patch review time, and/or periodically (especially before a
> release).

We do this already with coccinelle for some transformations. But I think
there's real value in linting that's always run, and is cheap. Catching
these things early means we don't have to spend time on them in review,
or dealing with follow-up patches.

-Peff
