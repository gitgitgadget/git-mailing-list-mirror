Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 123F2C433B4
	for <git@archiver.kernel.org>; Fri,  9 Apr 2021 21:29:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D60D260233
	for <git@archiver.kernel.org>; Fri,  9 Apr 2021 21:29:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234718AbhDIV3r (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 9 Apr 2021 17:29:47 -0400
Received: from cloud.peff.net ([104.130.231.41]:47168 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234574AbhDIV3q (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Apr 2021 17:29:46 -0400
Received: (qmail 2794 invoked by uid 109); 9 Apr 2021 21:29:32 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 09 Apr 2021 21:29:32 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 17042 invoked by uid 111); 9 Apr 2021 21:29:32 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 09 Apr 2021 17:29:32 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 9 Apr 2021 17:29:31 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Taylor Blau <me@ttaylorr.com>, Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH 3/6] object.c: make type_from_string() return "enum
 object_type"
Message-ID: <YHDHO/EXaSptqkaE@coredump.intra.peff.net>
References: <cover-0.3-0000000000-20210409T080534Z-avarab@gmail.com>
 <cover-0.6-0000000000-20210409T082935Z-avarab@gmail.com>
 <patch-3.6-7fd86f6699-20210409T082935Z-avarab@gmail.com>
 <YHCZh5nLNVEHCWV2@coredump.intra.peff.net>
 <87fszzgs86.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87fszzgs86.fsf@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Apr 09, 2021 at 09:42:17PM +0200, Ævar Arnfjörð Bjarmason wrote:

> > I think what the patch is doing is good, but this rationale misses the
> > main point of that discussion, I think. I doubt that the value of
> > OBJ_BAD would ever change. But the point was that we could grow a new
> > "failure" value at "-2", and we would want to catch here (I do consider
> > it relatively unlikely, but that IMHO is the reason to keep the negative
> > check).
> >
> > I think for the same reason that "return OBJ_BAD" instead of "return -1"
> > would be just fine (it is not "just so happens" that OBJ_BAD is
> > negative; that was deliberate to allow exactly this convention). But I
> > am also OK with leaving the "return -1" calls.
> 
> I'm beginning to think in response to this and the comment on 5/6 that
> it might be cleaner to split up the object_type enum, as demonstrated
> for a config.[ch] feature in [1].
> 
> Converting back and forth between them is a bit nasty, and having
> multiple interchangable OBJ_* constants with identical values just to
> satisfy them being in different enums, but it would allow having the
> compiler explicitly help check that callers cover all possible cases of
> values they could get.
> 
> Most callers just get OBJ_{COMMIT,TREE,BLOB,TAG} some more get that plus
> OBJ_{BAD,NONE}, almost nobody gets OBJ_{OFS,REF}_DELTA, and AFAICT just
> the peel code cares about OBJ_ANY. We then have an OBJ_MAX nobody's ever
> used for anything (I've got some unsubmitted patch somewhere to remove
> it).
> 
> What do you think about that sort of approach? I haven't convinced
> myself that it's a good idea, so far I just thought bridging the gap of
> things that return "enum" actually having that as part of their
> signature for human legibility, even if C itself doesn't care about the
> difference, and we currently can't get much/any of the benefits of the
> compiler catching non-exhaustive "case" statements (unless every
> callsite is to include OBJ_OFS etc.).

I suspect you'll end up with a lot of awkward spots. I do agree that
_most_ callers only care about getting one of the actual 4 object types,
or an error. But those values are tied to the delta ones internally
(when we see a delta type, and then later decide to promote it to the
"real" type). And of course those are all used to read and write the
on-disk bits, too.

So while there might be some way of doing this cleaner, it hasn't
historically been a place we've seen a lot of problems (at least not
that I recall). So it seems like a pretty deep rabbit hole that is not
likely to give a lot of benefit.

-Peff
