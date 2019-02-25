Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D23D020248
	for <e@80x24.org>; Mon, 25 Feb 2019 22:08:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727856AbfBYWIp (ORCPT <rfc822;e@80x24.org>);
        Mon, 25 Feb 2019 17:08:45 -0500
Received: from cloud.peff.net ([104.130.231.41]:57410 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726971AbfBYWIp (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Feb 2019 17:08:45 -0500
Received: (qmail 16876 invoked by uid 109); 25 Feb 2019 22:08:45 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 25 Feb 2019 22:08:45 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 21880 invoked by uid 111); 25 Feb 2019 22:08:57 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Mon, 25 Feb 2019 17:08:57 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 25 Feb 2019 17:08:41 -0500
Date:   Mon, 25 Feb 2019 17:08:41 -0500
From:   Jeff King <peff@peff.net>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v2 5/5] remote-curl: use post_rpc() for protocol v2 also
Message-ID: <20190225220841.GA3248@sigill.intra.peff.net>
References: <cover.1550170980.git.jonathantanmy@google.com>
 <cover.1550780213.git.jonathantanmy@google.com>
 <b0ff17d324d46822da9db898d187dcc5fb0467ca.1550780213.git.jonathantanmy@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <b0ff17d324d46822da9db898d187dcc5fb0467ca.1550780213.git.jonathantanmy@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 21, 2019 at 12:24:41PM -0800, Jonathan Tan wrote:

> When transmitting and receiving POSTs for protocol v0 and v1,
> remote-curl uses post_rpc() (and associated functions), but when doing
> the same for protocol v2, it uses a separate set of functions
> (proxy_rpc() and others). Besides duplication of code, this has caused
> at least one bug: the auth retry mechanism that was implemented in v0/v1
> was not implemented in v2.
> 
> To fix this issue and avoid it in the future, make remote-curl also use
> post_rpc() when handling protocol v2. Because line lengths are written
> to the HTTP request in protocol v2 (unlike in protocol v0/v1), this
> necessitates changes in post_rpc() and some of the functions it uses;
> perform these changes too.

This patch seems to cause noop fetches from GitHub to report "the remote
end hung up unexpectedly" at the end of the fetch (I have
protocol.version=2 set in the examples below):

  [parent is good]
  $ git checkout 0cdb2a12ad0300b5d0cb5bb6e8999034ae4b9bef^
  $ make
  $ bin-wrappers/git fetch https://github.com/git/git
  From https://github.com/git/git
   * branch                  HEAD       -> FETCH_HEAD

  [this patch is bad]
  $ git checkout 0cdb2a12ad0300b5d0cb5bb6e8999034ae4b9bef
  $ make
  $ bin-wrappers/git fetch https://github.com/git/git
  From https://github.com/git/git
   * branch                  HEAD       -> FETCH_HEAD
  fatal: the remote end hung up unexpectedly

I haven't dug, so it's possible that GitHub's server-side is doing
something slightly odd or wrong. But given the nature of the patch, I'd
suspect we just aren't noticing EOF correctly.

-Peff
