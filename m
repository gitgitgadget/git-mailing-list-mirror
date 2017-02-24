Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 783AC2022D
	for <e@80x24.org>; Fri, 24 Feb 2017 00:12:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752603AbdBXAML (ORCPT <rfc822;e@80x24.org>);
        Thu, 23 Feb 2017 19:12:11 -0500
Received: from cloud.peff.net ([104.130.231.41]:33057 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752781AbdBXAMH (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Feb 2017 19:12:07 -0500
Received: (qmail 30249 invoked by uid 109); 24 Feb 2017 00:05:25 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 24 Feb 2017 00:05:25 +0000
Received: (qmail 17879 invoked by uid 111); 24 Feb 2017 00:05:29 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 23 Feb 2017 19:05:29 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 23 Feb 2017 19:05:23 -0500
Date:   Thu, 23 Feb 2017 19:05:23 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org,
        peartben@gmail.com, benpeart@microsoft.com
Subject: Re: [BUG] allowtipsha1inwant serves unreachable blobs if you know
 its hash
Message-ID: <20170224000522.6ctrglphidmbsei7@sigill.intra.peff.net>
References: <20170223230358.30050-1-jonathantanmy@google.com>
 <xmqqtw7k5uxj.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqtw7k5uxj.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 23, 2017 at 03:50:00PM -0800, Junio C Hamano wrote:

> Jonathan Tan <jonathantanmy@google.com> writes:
> 
> > Adding "--objects" works, and all existing tests pass, except for the
> > potential performance issue and the side effect that even fetching a
> > reachable blob no longer works. This is due to a possible bug where a
> > call like "git rev-list --objects $tree ^master" (where $tree is the
> > tree object corresponding to master) prints out objects ...
> 
> The "reachable from this, excluding what is reachable from that"
> notation was originally designed to work only on commits, and I
> wouldn't be surprised if "$tree ^master" did not work as you expect
> in the current implementation.
> 
> I agree that ideally it shouldn't show anything, but I suspect that
> it would make it very expensive if done naively---we'd end up having
> to call mark_tree_uninteresting() for all uninteresting commits, not
> just for the commits at the edge of the DAG as we do right now.

Yes, it's super-expensive to do naively (like 40+ seconds of CPU on
torvalds/linux). Bitmaps should generally make it tolerable, though
there are corner cases (e.g., if a ref tip has to walk a bit to get to a
bitmap; we try to put bitmaps near the ref tips, but when you have
50,000 tags it's hard to do).

We've explored similar things at GitHub for doing reachability checks on
all 40-hex lookups (because right now I can point you to
.../git/git/commit/1234abcd and you see that object, even if it's only
in _my_ fork and not reachable from git/git).

-Peff
