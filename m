Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 87B2920705
	for <e@80x24.org>; Thu,  7 Jul 2016 20:52:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752700AbcGGUwh (ORCPT <rfc822;e@80x24.org>);
	Thu, 7 Jul 2016 16:52:37 -0400
Received: from cloud.peff.net ([50.56.180.127]:41658 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751416AbcGGUwf (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Jul 2016 16:52:35 -0400
Received: (qmail 6838 invoked by uid 102); 7 Jul 2016 20:52:26 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 07 Jul 2016 16:52:26 -0400
Received: (qmail 7733 invoked by uid 107); 7 Jul 2016 20:52:44 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 07 Jul 2016 16:52:44 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 07 Jul 2016 16:52:23 -0400
Date:	Thu, 7 Jul 2016 16:52:23 -0400
From:	Jeff King <peff@peff.net>
To:	Kirill Smelkov <kirr@nexedi.com>
Cc:	Junio C Hamano <gitster@pobox.com>,
	=?utf-8?Q?J=C3=A9rome?= Perrin <jerome@nexedi.com>,
	Isabelle Vallet <isabelle.vallet@nexedi.com>,
	Kazuhiko Shiozaki <kazuhiko@nexedi.com>,
	Julien Muchembled <jm@nexedi.com>, git@vger.kernel.org,
	Vicent Marti <tanoku@gmail.com>
Subject: Re: [PATCH] pack-objects: Use reachability bitmap index when
 generating non-stdout pack too
Message-ID: <20160707205223.GA11753@sigill.intra.peff.net>
References: <20160707190917.20011-1-kirr@nexedi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20160707190917.20011-1-kirr@nexedi.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Thu, Jul 07, 2016 at 10:09:17PM +0300, Kirill Smelkov wrote:

> Starting from 6b8fda2d (pack-objects: use bitmaps when packing objects)
> if a repository has bitmap index, pack-objects can nicely speedup
> "Counting objects" graph traversal phase. That however was done only for
> case when resultant pack is sent to stdout, not written into a file.
> 
> We can teach pack-objects to use bitmap index for initial object
> counting phase when generating resultant pack file too:

I'm not sure this is a good idea in general. When bitmaps are in use, we
cannot fill out the details in the object-packing list as thoroughly. In
particular:

  - we will not compute the same write order (which is based on
    traversal order), leading to packs that have less efficient cache
    characteristics

  - we don't learn about the filename of trees and blobs, which is going
    to make the delta step much less efficient. This might be mitigated
    by turning on the bitmap name-hash cache; I don't recall how much
    detail pack-objects needs on the name (i.e., the full name versus
    just the hash).

There may be other subtle things, too. The general idea of tying the
bitmap use to pack_to_stdout is that you _do_ want to use it for
serving fetches and pushes, but for a full on-disk repack via gc, it's
more important to generate a good pack.

Your use case:

> git-backup extracts many packs on repositories restoration. That was my
> initial motivation for the patch.

Seems to be somewhere in between. I'm not sure I understand how you're
invoking pack-objects here, but I wonder if you should be using
"pack-objects --stdout" yourself.

But even if it is the right thing for your use case to be using bitmaps
to generate an on-disk bitmap, I think we should be making sure it
_doesn't_ trigger when doing a normal repack.

-Peff
