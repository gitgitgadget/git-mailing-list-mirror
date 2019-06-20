Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 17B8D1F462
	for <e@80x24.org>; Thu, 20 Jun 2019 10:35:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731253AbfFTKfd (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Jun 2019 06:35:33 -0400
Received: from cloud.peff.net ([104.130.231.41]:45718 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726081AbfFTKfd (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Jun 2019 06:35:33 -0400
Received: (qmail 18517 invoked by uid 109); 20 Jun 2019 10:35:32 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 20 Jun 2019 10:35:32 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 14773 invoked by uid 111); 20 Jun 2019 10:36:21 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 20 Jun 2019 06:36:21 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 20 Jun 2019 06:35:31 -0400
Date:   Thu, 20 Jun 2019 06:35:31 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        git-packagers@googlegroups.com
Subject: Re: Can we just get rid of kwset & obstack in favor of
 optimistically using PCRE v2 JIT?
Message-ID: <20190620103530.GA15700@sigill.intra.peff.net>
References: <pull.265.git.gitgitgadget@gmail.com>
 <c1527a71672056859a4613f2318bcbfce31e8b50.1560426581.git.gitgitgadget@gmail.com>
 <87v9x793qi.fsf@evledraar.gmail.com>
 <87tvcr92m2.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87tvcr92m2.fsf@evledraar.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jun 15, 2019 at 01:19:33AM +0200, Ævar Arnfjörð Bjarmason wrote:

> ...small correction, we currently hard-rely on kwset() for any pattern
> containing a \0 for "git-grep" (these can only by supplied via the -f
> <pattern-from-file> option), this means that any pattern containing a \0
> is implicitly fixed, unless kwset() doesn't like it (-i and non-ASCII),
> what a mess.
> 
> Since we hard depend on REG_STARTEND since 2f8952250a ("regex: add
> regexec_buf() that can work on a non NUL-terminated string", 2016-09-21)
> we should just fix that while we're at it. It's a backwards-incompatible
> change, but I doubt anyone is relying on our undocumented behavior of
> implicitly considering grep patterns with \0 in them always fixed.

That's only for NULs in the haystack, though. I don't think there's a
way to have a NUL in the pattern with regcomp(), since it takes a
NUL-terminated string.

I do agree with you that treating it like a fixed string is somewhat
insane. We're probably better off to die.

In general, your plan to get rid of kwset sounds like a good path. It
would be a slight regression for somebody who is truly feeding a
fixed-string pattern with a NUL in it, on a system without pcre. Right
now that works (via kwset), and if we would start feeding fixed strings
to regcomp() then obviously that won't work. I guess we could go back to
using memmem as a fallback, which is what it looks like we used before
9eceddeec6 (Use kwset in grep, 2011-08-21).

Seems like a code path that would get exercised approximately never,
though.

-Peff
