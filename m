Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8243C2042F
	for <e@80x24.org>; Wed, 16 Nov 2016 17:18:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933203AbcKPRSA (ORCPT <rfc822;e@80x24.org>);
        Wed, 16 Nov 2016 12:18:00 -0500
Received: from cloud.peff.net ([104.130.231.41]:44004 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933013AbcKPRR7 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Nov 2016 12:17:59 -0500
Received: (qmail 15178 invoked by uid 109); 16 Nov 2016 17:17:59 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 16 Nov 2016 17:17:59 +0000
Received: (qmail 16794 invoked by uid 111); 16 Nov 2016 08:08:28 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (10.0.43.3)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 16 Nov 2016 03:08:28 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 16 Nov 2016 03:07:54 -0500
Date:   Wed, 16 Nov 2016 03:07:54 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Matt McCutchen <matt@mattmccutchen.net>, git <git@vger.kernel.org>
Subject: Re: Protecting old temporary objects being reused from concurrent
 "git gc"?
Message-ID: <20161116080753.gkn6v7vhdbifpubn@sigill.intra.peff.net>
References: <1479219194.2406.73.camel@mattmccutchen.net>
 <20161115170634.ichqrqbhmpv2dsiw@sigill.intra.peff.net>
 <1479231184.2406.88.camel@mattmccutchen.net>
 <20161115174028.zvohfcw4jse3jrmm@sigill.intra.peff.net>
 <xmqqk2c4tsv4.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqk2c4tsv4.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 15, 2016 at 12:01:35PM -0800, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > I suspect the issue is that read-tree populates the cache-tree index
> > extension, and then write-tree omits the object write before it even
> > gets to write_sha1_file(). The solution is that it should probably be
> > calling one of the freshen() functions (possibly just replacing
> > has_sha1_file() with check_and_freshen(), but I haven't looked).
> 
> I think the final writing always happens via write_sha1_file(), but
> an earlier cache-tree update that says "if we have a tree object
> already, then use it, otherwise even though we know the object name
> for this subtree, do not record it in the cache-tree" codepath may
> decide to record the subtree's sha1 without refreshing the referent.
> 
> A fix may look like this.

Yeah, that's along the lines I was expecting, though I'm not familiar
enough with cache-tree to say whether it's sufficient. I notice there is
a return very early on in update_one() when has_sha1_file() matches, and
it seems like that would trigger in some interesting cases, too.

-Peff
