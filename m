Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C92DC43331
	for <git@archiver.kernel.org>; Tue, 12 Jan 2021 11:35:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 30EAA22CBE
	for <git@archiver.kernel.org>; Tue, 12 Jan 2021 11:35:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729396AbhALLfU (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 Jan 2021 06:35:20 -0500
Received: from cloud.peff.net ([104.130.231.41]:53254 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728953AbhALLfT (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Jan 2021 06:35:19 -0500
Received: (qmail 8939 invoked by uid 109); 12 Jan 2021 11:34:38 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 12 Jan 2021 11:34:38 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 12512 invoked by uid 111); 12 Jan 2021 11:34:41 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 12 Jan 2021 06:34:41 -0500
Authentication-Results: peff.net; auth=none
Date:   Tue, 12 Jan 2021 06:34:38 -0500
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 00/11] [RFH] Introduce support for GETTEXT_POISON=rot13
Message-ID: <X/2JTsoUj3nAQcMi@coredump.intra.peff.net>
References: <pull.836.git.1610441262.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <pull.836.git.1610441262.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jan 12, 2021 at 08:47:31AM +0000, Johannes Schindelin via GitGitGadget wrote:

> Ævar suggested recently
> [https://lore.kernel.org/git/xmqqim836v6m.fsf@gitster.c.googlers.com/T/#m6fdc43d4f1eb3f20f841096c59e985b69c84875e]
> that this whole GETTEXT_POISON business is totally useless.
> 
> I do not believe that it is useless. To back up my belief with something
> tangible, I implemented a GETTEXT_POISON=rot13 mode and ran the test suite
> to see whether we erroneously expect translated messages where they aren't,
> and related problems.
> 
> And the experiment delivered. It is just a demonstration (I only addressed a
> handful of the test suite failures, 124 test scripts still need to be
> inspected to find out why they fail), of course. Yet I think that finding
> e.g. the missing translations of sha1dc-cb and parse-options show that it
> would be very useful to complete this patch series and then use the rot13
> mode in our CI jobs (instead of the current GETTEXT_POISON=true mode, which
> really is less useful).

I'm not entirely convinced by this. The original point of the poison
code was not to find opportunities to translate strings, but to make
sure we did not accidentally translate a string that some script was
relying on. And I don't see any fixes for the latter here (and as Ævar
suggested in the linked thread, the fact that we're not combing through
existing code looking for translations makes such an error a lot less
likely).

Which isn't to say repurposing it in the other direction might not be
worthwhile. But I suspect a lot of the test failures are just false
positives. Until now it was always reasonable to conservatively use
test_i18ngrep for cases which could reasonably translated, even if they
were not yet.

Likewise, I'm not sure that one can reliably rot13 an output for
test_i18ncmp. It could contain mixed translated and untranslated bits
from different messages.

So I dunno. You did find two spots where translations could be used.
But if nobody actually saw them to care that they got translated, were
they important? I may be a bit biased as somebody who would not use the
translations in the first place, of course.

-Peff
