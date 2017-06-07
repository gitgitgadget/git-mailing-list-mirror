Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E025C1FAE5
	for <e@80x24.org>; Wed,  7 Jun 2017 09:50:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751469AbdFGJpq (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Jun 2017 05:45:46 -0400
Received: from cloud.peff.net ([104.130.231.41]:35802 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751478AbdFGJon (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Jun 2017 05:44:43 -0400
Received: (qmail 14531 invoked by uid 109); 7 Jun 2017 09:44:42 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 07 Jun 2017 09:44:42 +0000
Received: (qmail 32299 invoked by uid 111); 7 Jun 2017 09:44:42 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 07 Jun 2017 05:44:42 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 07 Jun 2017 05:44:41 -0400
Date:   Wed, 7 Jun 2017 05:44:40 -0400
From:   Jeff King <peff@peff.net>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org,
        gitster@pobox.com
Subject: Re: [WIP v2 2/2] pack-objects: support --blob-max-bytes
Message-ID: <20170607094440.vg5ogy4bp5kg53s3@sigill.intra.peff.net>
References: <cover.1496361873.git.jonathantanmy@google.com>
 <cover.1496432147.git.jonathantanmy@google.com>
 <6f7934621717141ce3bb6bc05cf1d59c7900ccc5.1496432147.git.jonathantanmy@google.com>
 <20170602222640.u6vni5tdpjp3sayt@sigill.intra.peff.net>
 <20170602232508.GA21733@aiede.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170602232508.GA21733@aiede.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jun 02, 2017 at 04:25:08PM -0700, Jonathan Nieder wrote:

> > We have a name-hash cache extension in the bitmap file, but it doesn't
> > carry enough information to deduce the .git-ness of a file. I don't
> > think it would be too hard to add a "flags" extension, and give a single
> > bit to "this is a .git file".
> 
> A nicer approach IMHO is to include an extra bitmap, like the existing
> object-type bitmaps (see the dump_bitmap calls in
> bitmap_writer_finish).  This would would represent the set of all
> .git* blobs in the pack.

Yeah, it could be stored as a bitmap, which would be slightly smaller
(since it would be mostly 0's). I think either way it would need an
extension flag in the header to signal its presence.

Older versions of Git are OK with having flags they don't understand. I
know JGit used to complain about seeing a bitmap with unknown flags, but
I'm not sure if that is still the case.

> >                      If you're not just avoiding large blobs but trying
> > to get a narrow clone, you don't want the .git files from the
> > uninteresting parts of the tree.
> 
> This is something I've wondered about, too.  Part of the story is that
> we haven't started omitting trees, so there is already O(number of
> trees) objects being sent and some additional small blobs for .git*
> specials doesn't make it much worse.  Sending all .git* blobs keeps
> things simple since the server doesn't have to infer which .git* blobs
> are relevant to this client.
> 
> Longer term, we will likely want to allow clients to request omission
> of some trees, too.  Omitting the corresponding .git* files becomes
> more straightforward at that point.
> 
> Does that make sense?

Yeah, I agree we'd want to avoid the trees, too, in that case.

-Peff
