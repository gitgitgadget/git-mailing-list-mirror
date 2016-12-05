Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ADB3E1FF40
	for <e@80x24.org>; Mon,  5 Dec 2016 07:37:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750951AbcLEHhR (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Dec 2016 02:37:17 -0500
Received: from cloud.peff.net ([104.130.231.41]:51602 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751086AbcLEHhQ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Dec 2016 02:37:16 -0500
Received: (qmail 1524 invoked by uid 109); 5 Dec 2016 07:36:20 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 05 Dec 2016 07:36:20 +0000
Received: (qmail 2422 invoked by uid 111); 5 Dec 2016 07:36:58 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 05 Dec 2016 02:36:58 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 05 Dec 2016 02:36:19 -0500
Date:   Mon, 5 Dec 2016 02:36:19 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Mike Hommey <mh@glandium.org>, git@vger.kernel.org
Subject: Re: Should reset_revision_walk clear more flags?
Message-ID: <20161205073619.6h6rm2z4av3mie2y@sigill.intra.peff.net>
References: <20161204230958.h3ilhueqqptv253u@glandium.org>
 <20161205054013.taosbwjamxiwzocn@sigill.intra.peff.net>
 <xmqqmvga6dmb.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqmvga6dmb.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Dec 04, 2016 at 11:26:04PM -0800, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > Which I think would include both of the flags you mentioned, along with
> > others like SYMMETRIC_LEFT, PATCHSAME, etc. Probably really everything
> > mentioned in revision.h, which should be summed up as ALL_REV_FLAGS.
> > Some callsites already seem to feed that to clear_commit_marks().
> >
> > I doubt you can go too wrong by clearing more flags. 
> 
> This and ...
> 
> > It's possible that
> > some caller is relying on a flag _not_ being cleared between two
> > traversals, but in that case it should probably be using
> > clear_commit_marks() or clear_object_flags() explicitly to make it clear
> > what it expects to be saved.
> 
> ... this are contradictory, no?

I don't think so. If you are calling reset_revision_walk(), then I'm not
sure you have any right to expect that particular flags are left intact.
You _should_ be using an option that lets you specify the full set of
flags, rather than making an implicit assumption about which flags are
left.

In other words, I'd much rather see:

  clear_object_flags(ALL_REV_FLAGS & (~TMP_MARK));

than:

  /* This leaves TMP_MARK intact! */
  reset_revision_walk();

if you need to leave TMP_MARK intact.

Which isn't to say every caller does it correctly already. My claim
above is only "should", not "does". :)

But given that many of them _do_ use the more specific flag-clearing
functions, I think most of the calls to reset_revision_walk() are
blanket "I'm done now, clean up after me" calls.

> A caller may use two sets of its own flags in addition to letting
> the traversal machinery use the basic ones, and it may want to keep
> one of its own two sets while clearing the other set.  It would
> clear_commit_marks() to clear the latter.  And then it would let
> that the next traversal to reset_revision_walk() clear the basic
> ones.
> 
> So if you make reset_revision_walk() clear "more flags", that would
> break such a caller that is using clear_commit_marks() to make it
> clear what its expectations are, no?

I'd argue that it should not be calling reset_revision_walk() at all if
it wants anything saved. It should mask out the flags it wants, as
above. But I do realize that reasoning is circular: it's OK for
reset_revision_walk() to reset everything because that's what it does,
or at least should do from its name. :)

-Peff
