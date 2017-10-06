Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 60A591FA21
	for <e@80x24.org>; Fri,  6 Oct 2017 04:30:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750897AbdJFEaL (ORCPT <rfc822;e@80x24.org>);
        Fri, 6 Oct 2017 00:30:11 -0400
Received: from cloud.peff.net ([104.130.231.41]:34722 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1750781AbdJFEaK (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Oct 2017 00:30:10 -0400
Received: (qmail 6699 invoked by uid 109); 6 Oct 2017 04:30:10 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 06 Oct 2017 04:30:10 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 2545 invoked by uid 111); 6 Oct 2017 04:30:10 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Fri, 06 Oct 2017 00:30:10 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 06 Oct 2017 00:30:08 -0400
Date:   Fri, 6 Oct 2017 00:30:08 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Jonathan Tan <jonathantanmy@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] sha1_loose_object_info: handle errors from
 unpack_sha1_rest
Message-ID: <20171006043008.2s6pg4aurwledf3s@sigill.intra.peff.net>
References: <20171005055952.t5ef7hyolyevoj3d@sigill.intra.peff.net>
 <xmqqr2ugykl2.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqr2ugykl2.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 06, 2017 at 01:19:21PM +0900, Junio C Hamano wrote:

> > But note that the leak in (2) is actually older than that.
> > The original unpack_sha1_file() directly returned the result
> > of unpack_sha1_rest() to its caller, when it should have
> > been closing the zlib stream itself on error.
> >
> > Signed-off-by: Jeff King <peff@peff.net>
> > ---
> 
> Obviously correct.  (2) is as old as Git itself; it eventually
> blames down to e83c5163 ("Initial revision of "git", the information
> manager from hell", 2005-04-07), where read-cache.c::unpack_sha1_file()
> liberally returns NULL without cleaning up the zstream.

Thanks, I as too lazy to dig down further, but I'm always interested to
see the roots of these things (especially "bug in the original" versus
"introduced by a careless refactor").

I have a feeling that the world would be a better place if
unpack_sha1_rest() just always promised to close the zstream, since no
callers seem to want to look at it in the error case. But I wanted to go
for the minimal fix first.

-Peff
