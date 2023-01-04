Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C254C4332F
	for <git@archiver.kernel.org>; Wed,  4 Jan 2023 07:46:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233720AbjADHqs (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 4 Jan 2023 02:46:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233750AbjADHqn (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Jan 2023 02:46:43 -0500
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 176F819C07
        for <git@vger.kernel.org>; Tue,  3 Jan 2023 23:46:40 -0800 (PST)
Received: (qmail 17925 invoked by uid 109); 4 Jan 2023 07:46:40 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 04 Jan 2023 07:46:40 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 22648 invoked by uid 111); 4 Jan 2023 07:46:44 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 04 Jan 2023 02:46:44 -0500
Authentication-Results: peff.net; auth=none
Date:   Wed, 4 Jan 2023 02:46:39 -0500
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc:     Marco Nenciarini <marco.nenciarini@enterprisedb.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: BUG: git grep behave oddly with alternatives
Message-ID: <Y7Uu35HwUx2EVfAg@coredump.intra.peff.net>
References: <f82ae28a-fb56-8d1f-96c8-550b61439d3a@enterprisedb.com>
 <634f47a8-b370-81cb-00e7-d93ffc7534a8@web.de>
 <1f61b660-b2d0-ba93-3182-05a9ab97b00e@enterprisedb.com>
 <343a891e-d737-0ace-26a9-3839d3bd5583@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <343a891e-d737-0ace-26a9-3839d3bd5583@web.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jan 03, 2023 at 09:52:27PM +0100, René Scharfe wrote:

> diff --git a/Makefile b/Makefile
> index db447d0738..15e7edc9d2 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -289,6 +289,10 @@ include shared.mak
>  # Define NO_REGEX if your C library lacks regex support with REG_STARTEND
>  # feature.
>  #
> +# Define GIT_GREP_USES_REG_ENHANCED if your C library provides the flag
> +# REG_ENHANCED to enable enhanced basic regular expressions and you'd
> +# like to use it in git grep.

I didn't test, but just from looking at the patch I'd expect this to
affect other parts of Git besides git-grep. E.g., "git log --grep".
Which raises two questions:

 - would a more generalized name be better? USE_REG_ENHANCED or
   something? That might be _too_ general, but see below.

 - should this cover other cases? Grepping for "regcomp", would people
   want this to behave consistently for "git config --get-regexp", or
   diff funcnames, and so on?

If so, then I could envision a USE_REG_ENHANCED which just wraps the
system regcomp and adds the REG_ENHANCED flag when REG_EXTENDED is not
set?

-Peff
