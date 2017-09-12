Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,PLING_QUERY,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BFFBE1FADE
	for <e@80x24.org>; Tue, 12 Sep 2017 17:38:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751480AbdILRiV (ORCPT <rfc822;e@80x24.org>);
        Tue, 12 Sep 2017 13:38:21 -0400
Received: from cloud.peff.net ([104.130.231.41]:35894 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751441AbdILRiU (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Sep 2017 13:38:20 -0400
Received: (qmail 29596 invoked by uid 109); 12 Sep 2017 17:38:20 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 12 Sep 2017 17:38:20 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 6901 invoked by uid 111); 12 Sep 2017 17:38:55 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Tue, 12 Sep 2017 13:38:55 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 12 Sep 2017 13:38:18 -0400
Date:   Tue, 12 Sep 2017 13:38:18 -0400
From:   Jeff King <peff@peff.net>
To:     Lars Schneider <larsxschneider@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
Subject: Re: SHA1 collision in production repo?! (probably not)
Message-ID: <20170912173818.a22a54pvbv7yhjyt@sigill.intra.peff.net>
References: <4D74C1D4-9EA7-4A17-AFC5-0B54B4A6DD0E@gmail.com>
 <xmqqh929z6wl.fsf@gitster.mtv.corp.google.com>
 <20170331174515.j2ruifuigskyvucc@sigill.intra.peff.net>
 <512E7480-E923-4EBF-BA9D-1FEEB99B8BA6@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <512E7480-E923-4EBF-BA9D-1FEEB99B8BA6@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 12, 2017 at 06:18:32PM +0200, Lars Schneider wrote:

> we are seeing this now in Git 2.14.1:
> 
> ...
> error: inflate: data stream error (unknown compression method)
> error: unable to unpack 7b513f98a66ef9488e516e7abbc246438597c6d5 header
> error: inflate: data stream error (unknown compression method)
> error: unable to unpack 7b513f98a66ef9488e516e7abbc246438597c6d5 header
> fatal: loose object 7b513f98a66ef9488e516e7abbc246438597c6d5 (stored in .git/objects/7b/513f98a66ef9488e516e7abbc246438597c6d5) is corrupt
> fatal: The remote end hung up unexpectedly
> 
> I guess this means your fix [1] works properly :-)

Oh, good. :)

> At some point I will try to explore a retry mechanism for these cases.

I don't think we can generally retry loose-object failures. We use
copies from packs first, and then loose. So a corrupt loose can fallback
to another pack or to loose, but not the other way around (because we
would never look at the loose if we had a good copy elsewhere).

Though in your particular case, if I recall, you're receiving the object
over the network and the corrupted copy is in the way. So right now the
recovery process is:

  1. Notice the commit message.

  2. Run git-fsck to notice that we don't really[1] need the object.

  3. Run `rm .git/objects/7b/513f...`

  4. Re-run the fetch.

But in theory we should be able to say "oh, we don't _really_ have that,
the collision test isn't necessary" and then overwrite it. I actually
thought that's what would happen now (has_sha1_file() would return an
error), but I guess for what we need, it just does a stat() and calls it
a day, not realizing we ought to be overwriting.

-Peff

[1] git-fsck will actually complain if reflogs point to the object, and
    we can always expire those in a corrupted repo. So possibly what you
    want to know is whether it's reachable from actual refs. Of course
    this whole check is optional. If the object's corrupted, it's
    corrupted. But I get nervous calling `rm` on something that _could_
    be precious (say it's just a single-bit error that could be
    recovered). But if you have a known-good copy incoming, that's less
    of an issue.
