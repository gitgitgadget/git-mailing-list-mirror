Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D39CC2042F
	for <e@80x24.org>; Thu, 17 Nov 2016 01:04:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933324AbcKQBEy (ORCPT <rfc822;e@80x24.org>);
        Wed, 16 Nov 2016 20:04:54 -0500
Received: from cloud.peff.net ([104.130.231.41]:44200 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933202AbcKQBEx (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Nov 2016 20:04:53 -0500
Received: (qmail 8928 invoked by uid 109); 17 Nov 2016 01:04:53 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 17 Nov 2016 01:04:53 +0000
Received: (qmail 23322 invoked by uid 111); 17 Nov 2016 01:05:24 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (10.42.43.3)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 16 Nov 2016 20:05:24 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 16 Nov 2016 17:04:50 -0800
Date:   Wed, 16 Nov 2016 17:04:50 -0800
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Matt McCutchen <matt@mattmccutchen.net>, git <git@vger.kernel.org>
Subject: Re: Protecting old temporary objects being reused from concurrent
 "git gc"?
Message-ID: <20161117010449.6k3cwo3njvrid4jy@sigill.intra.peff.net>
References: <1479219194.2406.73.camel@mattmccutchen.net>
 <20161115170634.ichqrqbhmpv2dsiw@sigill.intra.peff.net>
 <1479231184.2406.88.camel@mattmccutchen.net>
 <20161115174028.zvohfcw4jse3jrmm@sigill.intra.peff.net>
 <xmqq1sybqmjt.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq1sybqmjt.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 16, 2016 at 10:58:30AM -0800, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > I suspect the issue is that read-tree populates the cache-tree index
> > extension, and then write-tree omits the object write before it even
> > gets to write_sha1_file().
> 
> Wait a minute.  The entries in the index and trees in the cache-tree
> are root of "still in use" traversal for the purpose of pruning,
> which makes the "something like this" patch unnecessary for the real
> index file.
> 
> And for temporary index files that is kept for 6 months, touching
> tree objects that cache-tree references is irrelevant---the blobs
> recorded in the "list of objects" part of the index will go stale,
> which is a lot more problematic.

I think the case that is helped here is somebody who runs "git
write-tree" and expects that the timestamp on those trees is fresh. So
even more a briefly used index, like:

  export GIT_INDEX_FILE=/tmp/foo
  git read-tree ...
  git write-tree
  rm -f $GIT_INDEX_FILE

we'd expect that a "git gc" which runs immediately after would see those
trees as recent and avoid pruning them (and transitively, any blobs that
are reachable from the trees). But I don't think that write-tree
actually freshens them (it sees "oh, we already have these; there is
nothing to write").

I could actually see an argument that the read-tree operation should
freshen the blobs themselves (because we know those blobs are now in
active use, and probably shouldn't be pruned), but I am not sure I agree
there. If only because it is weird that an operation which is otherwise
read-only with respect to the repository would modify the object
database.

-Peff
