Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4900C433EF
	for <git@archiver.kernel.org>; Mon,  4 Oct 2021 12:07:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B6378610FB
	for <git@archiver.kernel.org>; Mon,  4 Oct 2021 12:07:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233160AbhJDMJG (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 4 Oct 2021 08:09:06 -0400
Received: from cloud.peff.net ([104.130.231.41]:60340 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232875AbhJDMJG (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Oct 2021 08:09:06 -0400
Received: (qmail 9060 invoked by uid 109); 4 Oct 2021 12:07:16 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 04 Oct 2021 12:07:16 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 13830 invoked by uid 111); 4 Oct 2021 12:07:16 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 04 Oct 2021 08:07:16 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 4 Oct 2021 08:07:16 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] object-name: make ambiguous object output
 translatable
Message-ID: <YVrudGOcUxblsfPY@coredump.intra.peff.net>
References: <cover-0.2-00000000000-20211004T013611Z-avarab@gmail.com>
 <patch-2.2-b6136380c28-20211004T013611Z-avarab@gmail.com>
 <YVqu0aEBMy3mnYoE@coredump.intra.peff.net>
 <87o885nq4z.fsf@evledraar.gmail.com>
 <YVrJj0Ltuc1Tcm7t@coredump.intra.peff.net>
 <877detni03.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <877detni03.fsf@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 04, 2021 at 01:16:24PM +0200, Ævar Arnfjörð Bjarmason wrote:

> An unstated motivation of mine here is that I've got a series that
> changes the advise() function itself so that it automatically adds the
> "and run xyz to disable this message".
> 
> Now some don't emit it, some don't even have associated configuration or
> documentation. It's a mess.
> 
> I originally hacked this up because this is the one in-tree user of
> advise() that constructs output incrementally. So for that improvement
> to advise() it either needs to be changed to not do so (this patch), or
> I'd need an advise_no_template() or advise_hint_line() or whatever as a
> workaround.

OK, that makes sense. In general, I think it's much easier if those
motivations _aren't_ unstated. Both for the benefit of reviewers, but
also folks reading commit messages later who wonder "hey, it looks like
we didn't need this hunk, and it is causing a hassle, so why can't I
just revert it".

But...

> I didn't mean to be too subterfuge-y about it. It's just hard to find a
> balance between a single long series & a few shorter ones, and when to
> distract reviewers with "this design choice is also because of XYZ
> tangentally related end-goal".

...yeah, if you have patches that say "do X, because later maybe we'll
do Y", then it is often hard to evaluate them if Y is not in the same
series.  And _especially_ so if there is some other Z happening in the
current series with X, because even talking about X is muddling things.

So in an ideal world, you'd not do X at all (in this case, touch the
advise() lines), and leave Y (rolling up a buf to hand to a single
advise() line) as a preparatory patch in a series that does Z (your
change to advise() to print the extra stuff).

Things don't always break down that way, but I think they do here.
Nothing you want to do here is semantically related to the later change
to advise() you want to make. There are textual dependencies, which
means you'll want to wait for one series to graduate before the other,
but that's already the case if you stuff the preparatory patch in this
series.

-Peff
