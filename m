Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8041AC636CC
	for <git@archiver.kernel.org>; Sat,  4 Feb 2023 11:17:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233338AbjBDLR0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 4 Feb 2023 06:17:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232000AbjBDLRY (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 4 Feb 2023 06:17:24 -0500
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1690F30B0A
        for <git@vger.kernel.org>; Sat,  4 Feb 2023 03:17:22 -0800 (PST)
Received: (qmail 3494 invoked by uid 109); 4 Feb 2023 11:17:22 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 04 Feb 2023 11:17:22 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 18097 invoked by uid 111); 4 Feb 2023 11:17:22 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 04 Feb 2023 06:17:22 -0500
Authentication-Results: peff.net; auth=none
Date:   Sat, 4 Feb 2023 06:17:21 -0500
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     demerphq <demerphq@gmail.com>,
        "D. Ben Knoble" <ben.knoble@gmail.com>, git@vger.kernel.org
Subject: Re: grep: fix multibyte regex handling under macOS
 (1819ad327b7a1f19540a819813b70a0e8a7f798f)
Message-ID: <Y94+wVcV8OAFOIuK@coredump.intra.peff.net>
References: <CALnO6CAZtwfGY4SYeOuKqdP9+e_0EYNf4F703DRQB7UUfd_bUg@mail.gmail.com>
 <CANgJU+X_e0owKC3uWPaA_gVP54syF1+MJ-cTn+fjPrNS5LDsMA@mail.gmail.com>
 <Y9rv29c0dYUAYx8B@coredump.intra.peff.net>
 <CANgJU+XNLqf0E2+YC8yxtRPVh=mevc3P0eeye2_nx=ULB2iVWw@mail.gmail.com>
 <Y9098dyaTtiNk506@coredump.intra.peff.net>
 <230203.86357mbe8x.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <230203.86357mbe8x.gmgdl@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Feb 03, 2023 at 10:56:53PM +0100, Ævar Arnfjörð Bjarmason wrote:

> > I don't have a strong opinion either way. The main concern I'd have is
> > handling dependencies. I like pcre a lot, but I'm not sure that I would
> > want building Git to require pcre on every platform. If there's an
> > engine we can ship as a vendored dependency that builds everywhere, that
> > helps.
> 
> We can just make that fallback engine be PCRE. I submitted patches a
> while ago to include a minimal version of it in compat/pcre, as we seem
> to have some allergy to external dependencies:
> https://lore.kernel.org/git/20170511175115.648-1-avarab@gmail.com/
> 
> It's ~80k lines instead of compat/regex's ~15k, but it's actually
> maintained, and would be much easier to upgrade.

I'm OK with that if we really think that libpcre will build without
problems on every platform that Git does. I don't know if we have any
data there. Obviously libpcre builds lots of places, but will we have
problems on obscure platforms like NonStop? Part of me wants to not
care, but if the value here is saying "the regex engine is always going
to be X", then there is not much point in saying "the regex engine is
usually X, but you can't rely on it because sometimes it's not".

"Usually" is enough for helping users quality of life (if we help 99% of
users, that is good). It isn't enough for making assumptions in the code
(like using constructs in userdiff regexes that would break horribly on
the other 1% of platforms).

-Peff
