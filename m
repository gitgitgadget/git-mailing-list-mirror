Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 609961F461
	for <e@80x24.org>; Mon,  2 Sep 2019 15:54:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726180AbfIBPym (ORCPT <rfc822;e@80x24.org>);
        Mon, 2 Sep 2019 11:54:42 -0400
Received: from cloud.peff.net ([104.130.231.41]:36712 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725815AbfIBPym (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Sep 2019 11:54:42 -0400
Received: (qmail 26147 invoked by uid 109); 2 Sep 2019 15:54:41 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 02 Sep 2019 15:54:41 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 24932 invoked by uid 111); 2 Sep 2019 15:56:18 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 02 Sep 2019 11:56:18 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 2 Sep 2019 11:54:40 -0400
From:   Jeff King <peff@peff.net>
To:     Reino Wijnsma <rwijnsma@xs4all.nl>
Cc:     git@vger.kernel.org
Subject: Re: Retrieve version-string on shallow clone
Message-ID: <20190902155440.GE18593@sigill.intra.peff.net>
References: <26d7f32e-2df5-ce39-cd20-8cd82dc8587c@xs4all.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <26d7f32e-2df5-ce39-cd20-8cd82dc8587c@xs4all.nl>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Sep 01, 2019 at 01:07:44PM +0200, Reino Wijnsma wrote:

> git clone https://github.com/mstorsjo/fdk-aac.git
> [...]
> 
> git describe --tags
> v2.0.0-185-gcc5c85d
> 
> git clone --depth 1 https://github.com/mstorsjo/fdk-aac.git
> 
> git describe --tags
> fatal: No names found, cannot describe anything.
> 
> The tags get lost while doing a shallow clone.

Right. As noted elsewhere in the thread, this is the expected behavior
of Git. But what you want is perfectly reasonable; there's just not a
good way to do it yet.

> I'd figure one of these options would be to clone everything from tag
> v2.0.0 onward, but if so how would I do that?

I don't think there's a good way to do this. But I also think it's not
quite what you want, as you'd end up transferring a lot of extra data
(and deeper shallow fetches load the server more, as we can't use
reachability bitmaps, and we have to do extra on-the-fly delta
compression).

> As another option I was thinking; maybe it's possible to do git
> describe --tags on the remote repo?

This seems like it's more directly what you want, and doesn't have a lot
of downsides. There's no way to trigger this within Git's protocols. If
it's an ssh server you control, you can of course run git-describe
yourself on the server. For a hosting site like GitHub, you'd need
support from the host's non-Git API. I don't _think_ anything like that
exists right now in GitHub's API, though.

-Peff
