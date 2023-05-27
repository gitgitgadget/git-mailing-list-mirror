Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20A18C77B73
	for <git@archiver.kernel.org>; Sat, 27 May 2023 17:19:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230412AbjE0RTo (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 27 May 2023 13:19:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229796AbjE0RTn (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 27 May 2023 13:19:43 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E12FBC
        for <git@vger.kernel.org>; Sat, 27 May 2023 10:19:41 -0700 (PDT)
Received: (qmail 1957 invoked by uid 109); 27 May 2023 17:19:39 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 27 May 2023 17:19:39 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 32459 invoked by uid 111); 27 May 2023 17:19:36 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 27 May 2023 13:19:36 -0400
Authentication-Results: peff.net; auth=none
Date:   Sat, 27 May 2023 13:19:36 -0400
From:   Jeff King <peff@peff.net>
To:     Teng Long <dyroneteng@gmail.com>
Cc:     avarab@gmail.com, git@vger.kernel.org, gitster@pobox.com,
        sunshine@sunshineco.com, tenglong.tl@alibaba-inc.com
Subject: Re: [PATCH v10 4/6] notes.c: introduce
 '[--[no-]separator|--separator=<paragraph-break>]' option
Message-ID: <20230527171936.GA1460206@coredump.intra.peff.net>
References: <20230519005447.GA2955320@coredump.intra.peff.net>
 <20230527071721.24285-1-tenglong.tl@alibaba-inc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230527071721.24285-1-tenglong.tl@alibaba-inc.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, May 27, 2023 at 03:17:21PM +0800, Teng Long wrote:

> > [1] To reproduce, I did:
> > 
> >       git checkout 3993a53a13
> >       make SANITIZE=address,undefined CC=clang
> >       cd t && ./t3301-notes.sh -v -i
> > 
> >     I'm using clang-14 on a Debian machine.
> 
> Do you always do the 'make' with 'SANITIZE=address,undefined', should I
> follow that approach, may I ask you to give some advices about it?

No, not usually. I usually run it when I am working on a patch that does
something tricky with memory handling, and I want extra confidence that
I haven't screwed anything up. :)

We do run CI jobs for both ASan and UBSan, as of 1c0962c0c4 (ci: add
address and undefined sanitizer tasks, 2022-10-20). But they run with
gcc, which doesn't seem to catch this particular case.

IMHO it might be worth switching to clang for those jobs. My vague
recollection was that I've seen it catch more things, but now we have a
concrete example. I think it might also run faster (for some reason
doing both sanitizers at once is slower for gcc, but faster for clang).

-Peff
