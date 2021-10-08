Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 995B6C433F5
	for <git@archiver.kernel.org>; Fri,  8 Oct 2021 21:44:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 74CD360F6F
	for <git@archiver.kernel.org>; Fri,  8 Oct 2021 21:44:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243468AbhJHVqK (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 8 Oct 2021 17:46:10 -0400
Received: from cloud.peff.net ([104.130.231.41]:36178 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230384AbhJHVqJ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Oct 2021 17:46:09 -0400
Received: (qmail 6397 invoked by uid 109); 8 Oct 2021 21:44:13 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 08 Oct 2021 21:44:13 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 19271 invoked by uid 111); 8 Oct 2021 21:44:12 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 08 Oct 2021 17:44:12 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 8 Oct 2021 17:44:12 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 2/5] cat-file: mention --unordered along with
 --batch-all-objects
Message-ID: <YWC7rF4mpU9W6CbI@coredump.intra.peff.net>
References: <YVy1sx8Xb1xMLFQT@coredump.intra.peff.net>
 <YVy2DNd+XemykKE0@coredump.intra.peff.net>
 <877derjia9.fsf@evledraar.gmail.com>
 <YVzGeE1T/Kp8DDZD@coredump.intra.peff.net>
 <87tuhuikhf.fsf@evledraar.gmail.com>
 <YV3LonbeIS8DrMsN@coredump.intra.peff.net>
 <87k0ipgmbb.fsf@evledraar.gmail.com>
 <YV+tXVWVuy/rZn/l@coredump.intra.peff.net>
 <87lf34ey5a.fsf@evledraar.gmail.com>
 <xmqqo87zjlwt.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqo87zjlwt.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 08, 2021 at 01:34:26PM -0700, Junio C Hamano wrote:

> >> So I don't think OPT_CMDMODE could ever present this complete set of
> >> rules, because they are not all mutually exclusive with each other. But
> >> I think calling "--batch-all-objects" a mode is just muddying the waters
> >> even further.
> >
> > I think we've got some different understanding of what a CMDMODE
> > means. --batch-all-objects should be a cmdmode, but --batch, --buffer
> > etc. can't be. Similarly it's not a bug that --filters and --textconv
> > are cmdmodes, but you think that's bad.
> 
> Among options[] elements, "batch" and "batch-check" take &batch, and
> they are obviously mutually exclusive.  "batch-all-objects" can flip
> the batch.all_objects flag to affect operations that use &batch
> (namely, these two), so it is more like a modifier and can never be
> a cmdmode.
> 
> Is "git cat-file -t tag --batch" a valid way to invoke the command?
> Are there options (like "-t" in the above example) that are marked
> with OPT_CMDMODE that can be used with "--batch" or "--batch-check"?
> 
> If the answer is "no", then "--batch" and "--batch-check" could also
> be command modes, but I suspect OPT_CMDMODE() does not have enough
> flexibility to say "use the &opt to record which command mode is
> requested, and by the way, there is this extra pointer &batch to
> stuff necessary information in and use this callback to fill it", so
> even if "--batch" and "--batch-check" are incompatible with existing
> command modes, it needs a bit or preparatory work to make them.

Yes, it would definitely need that extension. But it's also weirder than
that. --textconv is an OPT_CMDMODE(), because it is mutually exclusive
with "-t", etc. But it is not exclusive with "--batch". So there is not
a single set of mutually exclusive cmdmodes. There are three sets:

  1. single-object options like "-t", "-p", etc

  2. --textconv and --filters, which can take a single object or batch
     input

  3. batch options like --batch-check --batch

(1) is mutually exclusive with (2) and (3), but the latter two are not
exclusive with each other.

The current code uses OPT_CMDMODE() for (1) and (2), and then manually
enforces the exclusion between (1) and (3). But IMHO it is (2) that is
the odd-man out, in that it can be its own mode or a modifier, and it
probably should not be OPT_CMDMODE() (but from the end-user perspective,
that is OK, though it may influence how we document or group things).

I do not think talking about --batch-all-objects makes sense here. As
you said above (and I said already several times), it is a modifier for
--batch/--batch-check. Making it into a CMDMODE does not break anything
(currently), but:

  - it does not really help; it only makes sense with batch options, and
    we already must manually catch those interacting with single-object
    options (because making them OPT_CMDMODE does not work for the
    reasons above).

  - if we _were_ to make the batch options CMDMODEs, then it would be
    doing the wrong thing (though I don't foresee that happening because
    of those same reasons)

  - if we allowed "--textconv --batch --batch-all-objects", then it
    would likewise do the wrong thing (by conflicting with --textconv's
    CMDMODE). We disallow that now, but it is a potentially well-formed
    request (show all objects, textconv-ing blobs). It's not useful
    enough for anybody to have cared, but I think it shows why the
    semantic distinction of treating --batch-all-objects as a
    batch-option and not itself a mode is important.

-Peff
