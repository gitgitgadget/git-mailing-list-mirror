Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ED1AE2027C
	for <e@80x24.org>; Fri,  2 Jun 2017 22:26:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751163AbdFBW0n (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Jun 2017 18:26:43 -0400
Received: from cloud.peff.net ([104.130.231.41]:34149 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750971AbdFBW0m (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Jun 2017 18:26:42 -0400
Received: (qmail 7371 invoked by uid 109); 2 Jun 2017 22:26:42 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 02 Jun 2017 22:26:42 +0000
Received: (qmail 32169 invoked by uid 111); 2 Jun 2017 22:27:21 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 02 Jun 2017 18:27:21 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 02 Jun 2017 18:26:40 -0400
Date:   Fri, 2 Jun 2017 18:26:40 -0400
From:   Jeff King <peff@peff.net>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, gitster@pobox.com
Subject: Re: [WIP v2 2/2] pack-objects: support --blob-max-bytes
Message-ID: <20170602222640.u6vni5tdpjp3sayt@sigill.intra.peff.net>
References: <cover.1496361873.git.jonathantanmy@google.com>
 <cover.1496432147.git.jonathantanmy@google.com>
 <6f7934621717141ce3bb6bc05cf1d59c7900ccc5.1496432147.git.jonathantanmy@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <6f7934621717141ce3bb6bc05cf1d59c7900ccc5.1496432147.git.jonathantanmy@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jun 02, 2017 at 12:38:45PM -0700, Jonathan Tan wrote:

> +--blob-max-bytes=<n>::
> +	This option can only be used with --stdout. If specified, a blob
> +	larger than this will not be packed unless a to-be-packed tree
> +	has that blob with a filename beginning with ".git".  The size
> +	can be suffixed with "k", "m", or "g", and may be "0".
> ++
> +If specified, after printing the packfile, pack-objects will print the
> +count of excluded blobs (8 bytes) . Subsequently, for each excluded blob
> +in hash order, pack-objects will print its hash (20 bytes) and its size
> +(8 bytes). All numbers are in network byte order.
> ++
> +If pack-objects cannot efficiently determine, for an arbitrary blob,
> +that no to-be-packed tree has that blob with a filename beginning with
> +".git" (for example, if bitmaps are used to calculate the objects to be
> +packed), it will pack all blobs regardless of size.

Hmm. So this feature can't be used with bitmaps at all?  That seems like
a big downside, as we still have to walk the whole graph to come up with
the list of blobs (even if we're sending them). That's 30-40 seconds of
CPU per clone on torvalds/linux. I imagine it's much worse on
repositories big enough to need a full GVFS-style "don't send any blobs"
approach.

We have a name-hash cache extension in the bitmap file, but it doesn't
carry enough information to deduce the .git-ness of a file. I don't
think it would be too hard to add a "flags" extension, and give a single
bit to "this is a .git file".

I do also wonder if the two features would need to be separated for a
GVFS-style solution. If you're not just avoiding large blobs but trying
to get a narrow clone, you don't want the .git files from the
uninteresting parts of the tree. You want to get no blobs at all, and
then fault them in as they become relevant due to user action.

-Peff
