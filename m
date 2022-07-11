Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F3A2C43334
	for <git@archiver.kernel.org>; Mon, 11 Jul 2022 10:11:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234627AbiGKKLy (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 11 Jul 2022 06:11:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234624AbiGKKKn (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Jul 2022 06:10:43 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74BF9DFCD
        for <git@vger.kernel.org>; Mon, 11 Jul 2022 02:33:22 -0700 (PDT)
Received: (qmail 6870 invoked by uid 109); 11 Jul 2022 09:33:21 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 11 Jul 2022 09:33:21 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 17066 invoked by uid 111); 11 Jul 2022 09:33:21 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 11 Jul 2022 05:33:21 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 11 Jul 2022 05:33:21 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH 6/7] xdiff: remove xdl_malloc() wrapper, use malloc(),
 not xmalloc()
Message-ID: <YsvuYX7xekLGIdVt@coredump.intra.peff.net>
References: <b34dcb93-df73-f5de-3c7c-7ab6c3250afe@gmail.com>
 <cover-0.7-00000000000-20220708T140354Z-avarab@gmail.com>
 <patch-6.7-33d93f121a9-20220708T140354Z-avarab@gmail.com>
 <YsiHGliw2dYmGcDY@coredump.intra.peff.net>
 <220708.864jzr9sq4.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <220708.864jzr9sq4.gmgdl@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jul 08, 2022 at 11:47:58PM +0200, Ævar Arnfjörð Bjarmason wrote:

> But we also have a few other uses of malloc() in the codebase. I wonder
> if the right thing here isn't to just use malloc(), but to have
> git-compat-util.h override malloc() (similar to how we we override
> e.g. exit() now...), which would also catch those.

I suspect that introduces new complexities, as some calls really may
want an actual no-frills malloc. I'm thinking stuff in compat/, for
example, where extra actions taken by xmalloc() could cause weird
looping or races. This was probably a lot more likely when we closed
packs via xmalloc (e.g., via git_mmap()'s malloc() call) but I think the
general principle still holds. E.g., gitsetenv() calling getenv() is a
potential questionable area.

It does look like the call in submodule--helper.c is just wrong, though,
and should be changed. You could probably detect these with the
preprocessor, but again, you run into complexities with the cases that
_should_ be vanilla malloc. Given how little of a problem this has been
historically, I'm mostly content to notice these in review and
occasionally grep for fixes.

I suppose a coccinelle rule could help, because it makes it easy to
suppress false positives (like all of compat/), which the preprocessor
doesn't.

-Peff
