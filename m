Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3877C433EF
	for <git@archiver.kernel.org>; Mon, 18 Jul 2022 15:11:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235201AbiGRPLl (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 18 Jul 2022 11:11:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235185AbiGRPLk (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Jul 2022 11:11:40 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B80E25E86
        for <git@vger.kernel.org>; Mon, 18 Jul 2022 08:11:39 -0700 (PDT)
Received: (qmail 32246 invoked by uid 109); 18 Jul 2022 15:11:38 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 18 Jul 2022 15:11:38 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 10083 invoked by uid 111); 18 Jul 2022 15:11:38 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 18 Jul 2022 11:11:38 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 18 Jul 2022 11:11:38 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 6/6] revisions API: don't leak memory on argv elements
 that need free()-ing
Message-ID: <YtV4KmrTBkmcx6m3@coredump.intra.peff.net>
References: <cover-0.6-00000000000-20220713T130511Z-avarab@gmail.com>
 <patch-6.6-4a581a4a6ce-20220713T130511Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <patch-6.6-4a581a4a6ce-20220713T130511Z-avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jul 13, 2022 at 03:10:35PM +0200, Ævar Arnfjörð Bjarmason wrote:

> There's several potential ways to fix those sort of leaks, we could
> add a "nodup" mode to "struct strvec", which would work for the cases
> where we push constant strings to it. But that wouldn't work as soon
> as we used strvec_pushf(), or otherwise needed to duplicate or create
> a string for that "struct strvec".

Right, I think this falls down when you have mixed const/non-const
entries. You have to know which is which for strvec_clear().

> Let's instead make it the responsibility of the revisions API. If it's
> going to clobber elements of argv it can also free() them, which it
> will now do if instructed to do so via "free_removed_argv_elements".

OK, I think this is a reasonable and minimal fix for the "--" problem on
its own.

But if you went just a little further and made the option "rev should
own its own argv", then I think you can simplify life for callers even
more. They could construct a strvec themselves and then hand it off to
the rev_info, to be cleaned up when release_revisions() is called (and
of course freeing the "--" when we overwrite it in the interim, as you
do here).

Then all of the bisect callers from the previous patch could avoid
having to deal with the strvec at all. They'd call bisect_rev_setup(),
which would internally attach the memory to rev_info.

>  bisect.c                    | 6 ++++--
>  builtin/submodule--helper.c | 5 ++++-
>  remote.c                    | 5 ++++-
>  revision.c                  | 2 ++
>  revision.h                  | 3 ++-
>  t/t2020-checkout-detach.sh  | 1 +
>  6 files changed, 17 insertions(+), 5 deletions(-)

The patch itself works as advertised, I think.

-Peff
