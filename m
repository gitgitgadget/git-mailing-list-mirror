Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A5DD62021E
	for <e@80x24.org>; Tue, 15 Nov 2016 17:40:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754039AbcKORkc (ORCPT <rfc822;e@80x24.org>);
        Tue, 15 Nov 2016 12:40:32 -0500
Received: from cloud.peff.net ([104.130.231.41]:43491 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752263AbcKORkb (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Nov 2016 12:40:31 -0500
Received: (qmail 28040 invoked by uid 109); 15 Nov 2016 17:40:31 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 15 Nov 2016 17:40:31 +0000
Received: (qmail 12267 invoked by uid 111); 15 Nov 2016 17:41:01 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 15 Nov 2016 12:41:01 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 15 Nov 2016 12:40:29 -0500
Date:   Tue, 15 Nov 2016 12:40:29 -0500
From:   Jeff King <peff@peff.net>
To:     Matt McCutchen <matt@mattmccutchen.net>
Cc:     git <git@vger.kernel.org>
Subject: Re: Protecting old temporary objects being reused from concurrent
 "git gc"?
Message-ID: <20161115174028.zvohfcw4jse3jrmm@sigill.intra.peff.net>
References: <1479219194.2406.73.camel@mattmccutchen.net>
 <20161115170634.ichqrqbhmpv2dsiw@sigill.intra.peff.net>
 <1479231184.2406.88.camel@mattmccutchen.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1479231184.2406.88.camel@mattmccutchen.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 15, 2016 at 12:33:04PM -0500, Matt McCutchen wrote:

> On Tue, 2016-11-15 at 12:06 -0500, Jeff King wrote:
> >  - when an object write is optimized out because we already have the
> >    object, git will update the mtime on the file (loose object or
> >    packfile) to freshen it
> 
> FWIW, I am not seeing this happen when I do "git read-tree --prefix"
> followed by "git write-tree" using the current master (3ab2281).  See
> the attached test script.

The optimization I'm thinking about is the one from write_sha1_file(),
which learned to freshen in 33d4221c7 (write_sha1_file: freshen existing
objects, 2014-10-15).

I suspect the issue is that read-tree populates the cache-tree index
extension, and then write-tree omits the object write before it even
gets to write_sha1_file(). The solution is that it should probably be
calling one of the freshen() functions (possibly just replacing
has_sha1_file() with check_and_freshen(), but I haven't looked).

I'd definitely welcome patches in this area.

> OK.  I'll write a patch to add a summary of this information to the
> git-gc man page.

Sounds like a good idea. Thanks.

-Peff
