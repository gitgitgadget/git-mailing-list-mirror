Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45002C433EF
	for <git@archiver.kernel.org>; Mon, 18 Jul 2022 15:05:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235065AbiGRPFL (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 18 Jul 2022 11:05:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235041AbiGRPFK (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Jul 2022 11:05:10 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E781252A2
        for <git@vger.kernel.org>; Mon, 18 Jul 2022 08:05:09 -0700 (PDT)
Received: (qmail 32234 invoked by uid 109); 18 Jul 2022 15:05:08 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 18 Jul 2022 15:05:08 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 10035 invoked by uid 111); 18 Jul 2022 15:05:08 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 18 Jul 2022 11:05:08 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 18 Jul 2022 11:05:08 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 5/6] bisect.c: partially fix bisect_rev_setup() memory
 leak
Message-ID: <YtV2pImT7MBFrqWD@coredump.intra.peff.net>
References: <cover-0.6-00000000000-20220713T130511Z-avarab@gmail.com>
 <patch-5.6-83897fd108a-20220713T130511Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <patch-5.6-83897fd108a-20220713T130511Z-avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jul 13, 2022 at 03:10:34PM +0200, Ævar Arnfjörð Bjarmason wrote:

> Partially fix the memory leak noted in in 8a534b61241 (bisect: use
> argv_array API, 2011-09-13), which added the "XXX" comment seen in the
> context. We can partially fix it by having the bisect_rev_setup()
> function take a "struct strvec", rather than constructing it.
> 
> As the comment notes we need to keep the construct "rev_argv" around
> while the "struct rev_info" is around, which as seen in the newly
> added "strvec_clear()" calls here we do after "release_revisions()".

This seems like not too bad a solution on its face. The caller is
responsible for keeping rev_argv around as long as rev is valid.

This would be simpler if setup_revisions() made its own copy of the argv
strings and dropped them via release_revisions(). That has a small cost,
but I suspect it doesn't matter much in practice.

I thought that would be too much of a pain to add, but it kind of looks
like you went there anyway in the next patch. I'll comment further
there.

> This "partially" fixes the memory leak because we're leaking the "--"
> added to the "rev_argv" here still, which will be addressed in a
> subsequent commit.

This part confused me, because the "--" is in the strvec which gets
cleared. I'd guess that the revisions code just overwrites it with NULL,
and we lose access to it. But it should become clear in the next commit.

> -	setup_revisions(rev_argv.nr, rev_argv.v, revs, NULL);
> +	setup_revisions(rev_argv->nr, rev_argv->v, revs, NULL);
>  	/* XXX leak rev_argv, as "revs" may still be pointing to it */

I wouldn't really call this a "leak" anymore; the caller now owns it.
Maybe nit-picking, since this comment goes away later.

-Peff
