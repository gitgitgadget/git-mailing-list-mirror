Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 881BAC46467
	for <git@archiver.kernel.org>; Wed, 11 Jan 2023 18:56:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235905AbjAKS4h (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Jan 2023 13:56:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238450AbjAKS4b (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Jan 2023 13:56:31 -0500
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6A318F
        for <git@vger.kernel.org>; Wed, 11 Jan 2023 10:56:30 -0800 (PST)
Received: (qmail 30451 invoked by uid 109); 11 Jan 2023 18:56:30 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 11 Jan 2023 18:56:30 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 7896 invoked by uid 111); 11 Jan 2023 18:56:31 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 11 Jan 2023 13:56:31 -0500
Authentication-Results: peff.net; auth=none
Date:   Wed, 11 Jan 2023 13:56:29 -0500
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc:     Marco Nenciarini <marco.nenciarini@enterprisedb.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: BUG: git grep behave oddly with alternatives
Message-ID: <Y78GXZvyrOrXhe7n@coredump.intra.peff.net>
References: <f82ae28a-fb56-8d1f-96c8-550b61439d3a@enterprisedb.com>
 <634f47a8-b370-81cb-00e7-d93ffc7534a8@web.de>
 <1f61b660-b2d0-ba93-3182-05a9ab97b00e@enterprisedb.com>
 <343a891e-d737-0ace-26a9-3839d3bd5583@web.de>
 <Y7Uu35HwUx2EVfAg@coredump.intra.peff.net>
 <e5165840-331c-e9b6-b45f-62abab860d79@web.de>
 <Y7flVcALZQgz0VPl@coredump.intra.peff.net>
 <26a0d4ca-3d97-ace4-1a1f-92b1ee6715a6@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <26a0d4ca-3d97-ace4-1a1f-92b1ee6715a6@web.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Jan 08, 2023 at 01:42:04AM +0100, René Scharfe wrote:

> REG_ENHANCED on macOS affects REG_EXTENDED as well.  It unlocks e.g.
> non-greedy repetitions and inline comments.  Sounds nice, but also
> potentially surprising.  I was unable to find a current version of
> the re_format(7) manpage online, unfortunately.

I'm not quite sure what you mean here by "non-greedy repetitions".
Something like:

  # prefer "foo bar" to "foo bar bar"; only matters for colorizing or
  # --only-matching
  git grep -E 'foo.*?bar'

? If so, then yeah, that changes the meaning of a bare "?" and people
might be surprised by it.

> Apple's latest version of Git sets NO_REGEX and thus uses
> compat/regex, if I read their source correctly:
> 
> https://github.com/apple-oss-distributions/Git/blob/Git-128/src/git/Makefile#L1302
> 
> The easiest and most consistent option would be to do the same.  But
> we can't do that, because it would break multibyte support, which was
> fixed by 1819ad327b (grep: fix multibyte regex handling under macOS,
> 2022-08-26), which started to use the system regex functions again.

Looks like that NO_REGEX line was dropped by 1819ad327b. So I don't
think Apple added it themselves; their version is just based on an older
version of Git (looks like 2.24.3).

> Which begs the question: Isn't that a problem for the platforms that
> still have to use NO_REGEX?  Shouldn't we fix compat/regex?

I'm not sure. I always assumed our fallback was similar-ish to what was
in glibc and was thus pretty featureful, but that may not be true (it
actually comes from gawk). It looks like we just didn't pull over the
multi-byte parts in a997bf423d (compat/regex: get the gawk regex engine
to compile within git, 2010-08-17).

> Anyway, here's an attempt at a more general, but still targeted fix
> for macOS:
> 
> --- >8 ---
> Subject: [PATCH] use enhanced basic regular expressions on macOS

This seems pretty sensible, regardless of whether we improve multi-byte
support for compat/regex.

-Peff
