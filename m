Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1E82C61DB3
	for <git@archiver.kernel.org>; Thu, 12 Jan 2023 22:07:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239706AbjALWHP (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 Jan 2023 17:07:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239906AbjALWGZ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Jan 2023 17:06:25 -0500
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 252D476AD7
        for <git@vger.kernel.org>; Thu, 12 Jan 2023 13:54:55 -0800 (PST)
Received: (qmail 8387 invoked by uid 109); 12 Jan 2023 21:54:55 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 12 Jan 2023 21:54:55 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 19695 invoked by uid 111); 12 Jan 2023 21:54:56 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 12 Jan 2023 16:54:56 -0500
Authentication-Results: peff.net; auth=none
Date:   Thu, 12 Jan 2023 16:54:54 -0500
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc:     Marco Nenciarini <marco.nenciarini@enterprisedb.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: BUG: git grep behave oddly with alternatives
Message-ID: <Y8CBrtmL45tA/N8z@coredump.intra.peff.net>
References: <f82ae28a-fb56-8d1f-96c8-550b61439d3a@enterprisedb.com>
 <634f47a8-b370-81cb-00e7-d93ffc7534a8@web.de>
 <1f61b660-b2d0-ba93-3182-05a9ab97b00e@enterprisedb.com>
 <343a891e-d737-0ace-26a9-3839d3bd5583@web.de>
 <Y7Uu35HwUx2EVfAg@coredump.intra.peff.net>
 <e5165840-331c-e9b6-b45f-62abab860d79@web.de>
 <Y7flVcALZQgz0VPl@coredump.intra.peff.net>
 <26a0d4ca-3d97-ace4-1a1f-92b1ee6715a6@web.de>
 <Y78GXZvyrOrXhe7n@coredump.intra.peff.net>
 <4165031d-e7f1-0477-2245-6a8e312de522@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4165031d-e7f1-0477-2245-6a8e312de522@web.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jan 12, 2023 at 06:13:13PM +0100, René Scharfe wrote:

> > I'm not quite sure what you mean here by "non-greedy repetitions".
> > Something like:
> >
> >   # prefer "foo bar" to "foo bar bar"; only matters for colorizing or
> >   # --only-matching
> >   git grep -E 'foo.*?bar'
> >
> > ? If so, then yeah, that changes the meaning of a bare "?" and people
> > might be surprised by it.
> 
> Right.  To be fair, question mark is a special character and you'd
> probably need to quote it anyway if you want to match a literal
> question mark.  Otherwise I get:
> 
>    $ git grep -E 'foo.*?bar'
>    fatal: command line, 'foo.*?bar': repetition-operator operand invalid

This is on macOS, I assume? With glibc it seems to be quietly ignored:

  $ git grep -E -o 'foo.*?ba' .clang-format
  .clang-format:foo, bar, ba

So it is not treated literally (as it would be without -E). But nor does
it make the match non-greedy (otherwise it would have output "foo, ba",
as "git grep -P" does).

So it does seem like all bets are off for what people can and should
expect here. Which isn't to say we should make things worse. I mostly
wondered if REG_ENHANCED might take us closer to what glibc was doing by
default, but it doesn't seem like it.

-Peff
