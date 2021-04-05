Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90D82C433B4
	for <git@archiver.kernel.org>; Mon,  5 Apr 2021 22:17:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5635B613DA
	for <git@archiver.kernel.org>; Mon,  5 Apr 2021 22:17:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241421AbhDEWRY (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 5 Apr 2021 18:17:24 -0400
Received: from cloud.peff.net ([104.130.231.41]:42074 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241313AbhDEWRX (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Apr 2021 18:17:23 -0400
Received: (qmail 3093 invoked by uid 109); 5 Apr 2021 22:17:16 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 05 Apr 2021 22:17:16 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 22116 invoked by uid 111); 5 Apr 2021 22:17:16 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 05 Apr 2021 18:17:16 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 5 Apr 2021 18:17:15 -0400
From:   Jeff King <peff@peff.net>
To:     ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Hariom Verma <hariom18599@gmail.com>,
        ZheNing Hu <adlternative@gmail.com>
Subject: Re: [PATCH] [GSOC] ref-filter: use single strbuf for all output
Message-ID: <YGuMaxoYgRkUR1sa@coredump.intra.peff.net>
References: <pull.927.git.1617631280402.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <pull.927.git.1617631280402.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 05, 2021 at 02:01:19PM +0000, ZheNing Hu via GitGitGadget wrote:

> When we use `git for-each-ref`, every ref will call
> `show_ref_array_item()` and allocate its own final strbuf
> and error strbuf. Instead, we can provide two single strbuf:
> final_buf and error_buf that get reused for each output.
> 
> When run it 100 times:
> 
> $ git for-each-ref
> 
> on git.git :
> 
> 3.19s user
> 3.88s system
> 35% cpu
> 20.199 total
> 
> to:
> 
> 2.89s user
> 4.00s system
> 34% cpu
> 19.741 total

That's a bigger performance improvement than I'd expect from this. I'm
having trouble reproducing it here (I get the same time before and
after). I also notice that you don't seem to be CPU bound, and we spend
most of our time on system CPU (so program startup stuff, not the loop
you're optimizing).

I think a more interesting test is timing a single invocation with a
large number of refs. If you are planning to do a lot of work on the
formatting code, it might be worth adding such a test into t/perf (both
to show off results, but also to catch any regressions after we make
things faster).

>     This patch learned Jeff King's optimization measures in git
>     cat-file(79ed0a5): using a single strbuf for all objects output Instead
>     of allocating a large number of small strbuf for every object.

I do think this is a good direction (for all the reasons laid out in
79ed0a5), though it wasn't actually the part I was most worried about
for ref-filter performance. The bigger issue in ref-filter is that each
individual atom will generally have its own allocated string, and then
we'll format all of the atoms into the final strbuf output. In most
cases we could avoid those intermediate copies entirely.

I do think this would be a useful optimization to have in addition,
though. As for the patch itself, I looked over the review that Eric
gave, and he already said everything I would have. :)

-Peff
