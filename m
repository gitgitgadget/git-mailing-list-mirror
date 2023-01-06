Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05D17C3DA7A
	for <git@archiver.kernel.org>; Fri,  6 Jan 2023 09:09:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231561AbjAFJJp (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 6 Jan 2023 04:09:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229532AbjAFJJn (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Jan 2023 04:09:43 -0500
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD6081C436
        for <git@vger.kernel.org>; Fri,  6 Jan 2023 01:09:42 -0800 (PST)
Received: (qmail 12873 invoked by uid 109); 6 Jan 2023 09:09:42 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 06 Jan 2023 09:09:42 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 12706 invoked by uid 111); 6 Jan 2023 09:09:46 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 06 Jan 2023 04:09:46 -0500
Authentication-Results: peff.net; auth=none
Date:   Fri, 6 Jan 2023 04:09:41 -0500
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc:     Marco Nenciarini <marco.nenciarini@enterprisedb.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: BUG: git grep behave oddly with alternatives
Message-ID: <Y7flVcALZQgz0VPl@coredump.intra.peff.net>
References: <f82ae28a-fb56-8d1f-96c8-550b61439d3a@enterprisedb.com>
 <634f47a8-b370-81cb-00e7-d93ffc7534a8@web.de>
 <1f61b660-b2d0-ba93-3182-05a9ab97b00e@enterprisedb.com>
 <343a891e-d737-0ace-26a9-3839d3bd5583@web.de>
 <Y7Uu35HwUx2EVfAg@coredump.intra.peff.net>
 <e5165840-331c-e9b6-b45f-62abab860d79@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e5165840-331c-e9b6-b45f-62abab860d79@web.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 04, 2023 at 05:36:21PM +0100, René Scharfe wrote:

> > I didn't test, but just from looking at the patch I'd expect this to
> > affect other parts of Git besides git-grep. E.g., "git log --grep".
> > Which raises two questions:
> >
> >  - would a more generalized name be better? USE_REG_ENHANCED or
> >    something? That might be _too_ general, but see below.
> >
> >  - should this cover other cases? Grepping for "regcomp", would people
> >    want this to behave consistently for "git config --get-regexp", or
> >    diff funcnames, and so on?
> >
> > If so, then I could envision a USE_REG_ENHANCED which just wraps the
> > system regcomp and adds the REG_ENHANCED flag when REG_EXTENDED is not
> > set?
> 
> Good point.  I don't know what people want, though.  re_format(7) on
> macOS/BSD and regex(7) on Linux call basic REs "obsolete" and extended
> REs "modern", so they seem to push people away from the old kind,
> enhanced or not.

Oh, good point. I was just grepping for regcomp(), but of course any
case which is already passing REG_EXTENDED would not be affected anyway.
And most places are already using that. E.g., the config code always
does so, and it looks like pickaxe "-G" does so.

For diffs, we have diff.*.xfuncname, which uses EREs. We do still
support regular "funcname" for backwards compatibility, but we only
document the extended version. Ironically, that option was introduced
because BREs did not portably support things like alternation, even with
the "enhanced" syntax. ;) See 45d9414fa5 (diff.*.xfuncname which uses
"extended" regex's for hunk header selection, 2008-09-18).

So I think we are embracing the "everyone should use EREs" mentality
already. The only spots I see that use BREs are:

  - grep.c, which handles "git grep" and "git log --grep"

  - line-range.c, presumably for "-L" function matching

  - deprecated non-ERE funcname patterns

Your patch is handling the first, which is by the far most important. I
would be OK leaving the others as-is, but I also wouldn't mind a patch
that works at the regcomp() level to make things automatically
consistent.

-Peff
