Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A9F261F4F8
	for <e@80x24.org>; Wed,  5 Oct 2016 15:47:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752481AbcJEPrT (ORCPT <rfc822;e@80x24.org>);
        Wed, 5 Oct 2016 11:47:19 -0400
Received: from cloud.peff.net ([104.130.231.41]:52794 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751645AbcJEPrT (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Oct 2016 11:47:19 -0400
Received: (qmail 28155 invoked by uid 109); 5 Oct 2016 15:47:17 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 05 Oct 2016 15:47:17 +0000
Received: (qmail 17895 invoked by uid 111); 5 Oct 2016 15:47:35 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 05 Oct 2016 11:47:35 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 05 Oct 2016 11:47:15 -0400
Date:   Wed, 5 Oct 2016 11:47:15 -0400
From:   Jeff King <peff@peff.net>
To:     Stefan Beller <sbeller@google.com>
Cc:     gitster@pobox.com, git@vger.kernel.org, hvoigt@hvoigt.net,
        torvalds@linux-foundation.org
Subject: Re: [PATCHv3 1/2] push: change submodule default to check when
 submodules exist
Message-ID: <20161005154715.qmmcwpkt2yudbc2d@sigill.intra.peff.net>
References: <CAGZ79kbt+SZoogKTV_-rVfOOFzf6xrhWytrBo2H3r6NQw34WTw@mail.gmail.com>
 <20161004210359.15266-1-sbeller@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20161004210359.15266-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 04, 2016 at 02:03:58PM -0700, Stefan Beller wrote:

> thanks for the suggestions, both git_path(..) as well as checking the config,
> this seems quite readable to me:
> 
>  builtin/push.c | 14 +++++++++++++-
>  1 file changed, 13 insertions(+), 1 deletion(-)

Yeah, this seems like a good compromise to me.

I did have one other thought, but I don't think it's worth pursuing now.
We care about finding gitlinks in objects we're pushing; is there any
process which is already looking at those objects? Genreally, the
"pack-objects" doing the push has to. Not to actually push the objects,
which often are sent blindly off disk, but to determine the set of
reachable objects in the first place. So in theory we could prepare the
list of objects to pack, and as a side effect it could say "and here are
gitlinks referenced by those objects". But that doesn't work if bitmaps
are in effect, because then we don't access the objects directly at all.
I think you could solve that by extending the bitmap format to include a
bit for gitlinks that are reachable (but not necessarily included in the
pack).

So I don't think that's worth thinking too much about now, but it might
be an interesting optimization down the road.

-Peff
