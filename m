Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB50DEB64DD
	for <git@archiver.kernel.org>; Mon,  3 Jul 2023 05:19:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229820AbjGCFTw (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 3 Jul 2023 01:19:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229949AbjGCFTt (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Jul 2023 01:19:49 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46A8CA7
        for <git@vger.kernel.org>; Sun,  2 Jul 2023 22:19:47 -0700 (PDT)
Received: (qmail 5292 invoked by uid 109); 3 Jul 2023 05:19:48 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 03 Jul 2023 05:19:48 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 2020 invoked by uid 111); 3 Jul 2023 05:19:50 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 03 Jul 2023 01:19:50 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 3 Jul 2023 01:19:46 -0400
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, Chris Torek <chris.torek@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Junio C Hamano <gitster@pobox.com>,
        Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH v4 04/16] ref-filter: add `ref_filter_clear()`
Message-ID: <20230703051946.GD3502534@coredump.intra.peff.net>
References: <cover.1683581621.git.me@ttaylorr.com>
 <cover.1687270849.git.me@ttaylorr.com>
 <777e71004d68dc9bb9c4cad2b896acff2c615cbf.1687270849.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <777e71004d68dc9bb9c4cad2b896acff2c615cbf.1687270849.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 20, 2023 at 10:21:16AM -0400, Taylor Blau wrote:

> From: Jeff King <peff@peff.net>
> 
> We did not bother to clean up at all in `git branch` or `git tag`, and
> `git for-each-ref` only cleans up a couple of members.
> 
> Add and call `ref_filter_clear()` when cleaning up a `struct
> ref_filter`. Running this patch (without any test changes) indicates a
> couple of now leak-free tests. This was found by running:
> 
>     $ make SANITIZE=leak
>     $ make -C t GIT_TEST_PASSING_SANITIZE_LEAK=check GIT_TEST_OPTS=--immediate
> 
> (Note that the `reachable_from` and `unreachable_from` lists should be
> cleaned as they are used. So this is just covering any case where we
> might bail before running the reachability check.)

And this is the one that benefits from the earlier future-proofing. :)

(In case anyone is wondering why I am reviewing my own commits, it's
because Taylor and I worked on this topic together off-list, but he
wrote the commit messages after I dumped a bunch of cleanups on him).

> +void ref_filter_init(struct ref_filter *filter)
> +{
> +	struct ref_filter blank = REF_FILTER_INIT;
> +	memcpy(filter, &blank, sizeof(blank));
> +}

I was a little surprised by adding init() here, but we need it at the
end of clear(). So this is an OK place for it (the other option would be
in the earlier INIT patch, but it would be unused until now).

-Peff
