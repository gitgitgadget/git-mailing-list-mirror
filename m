Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B1DFC433EF
	for <git@archiver.kernel.org>; Fri,  8 Jul 2022 19:35:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239725AbiGHTf5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 8 Jul 2022 15:35:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238121AbiGHTf5 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Jul 2022 15:35:57 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A07E57245
        for <git@vger.kernel.org>; Fri,  8 Jul 2022 12:35:56 -0700 (PDT)
Received: (qmail 9613 invoked by uid 109); 8 Jul 2022 19:35:55 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 08 Jul 2022 19:35:55 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 14153 invoked by uid 111); 8 Jul 2022 19:35:55 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 08 Jul 2022 15:35:55 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 8 Jul 2022 15:35:54 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH 6/7] xdiff: remove xdl_malloc() wrapper, use malloc(),
 not xmalloc()
Message-ID: <YsiHGliw2dYmGcDY@coredump.intra.peff.net>
References: <b34dcb93-df73-f5de-3c7c-7ab6c3250afe@gmail.com>
 <cover-0.7-00000000000-20220708T140354Z-avarab@gmail.com>
 <patch-6.7-33d93f121a9-20220708T140354Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <patch-6.7-33d93f121a9-20220708T140354Z-avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jul 08, 2022 at 04:20:18PM +0200, Ævar Arnfjörð Bjarmason wrote:

> As noted in 36c83197249 (xdiff: use xmalloc/xrealloc, 2019-04-11) the
> reason we have xdl_malloc() in the first place was to make the xdiff
> code safer, it was not handling some allocation failures correctly at
> the time.
> 
> But as noted in that commit doing this was intended as a stopgap, as
> various code in xdiff/* did not correctly handle allocation failures,
> and would have segfaulted if malloc() returned NULL.
> 
> But since then and after preceding commits we can be confident that
> malloc() failures are handled correctly. All of these users of
> xdl_malloc() are checking their return values, and we're returning
> -1 (or similar ) to the top-level in case of failures.

This is also losing the other parts mentioned in 36c83197249:
respecting GIT_ALLOC_LIMIT and any memory reclamation strategies.

I think you'd want an xmalloc_gently() instead of a raw malloc().

For the same reason, I suspect it's better to leave this with a layer of
preprocessor indirection. Even if we chose to use malloc() here, libgit2
might not, and having the macro makes it easier to share the code.

-Peff
