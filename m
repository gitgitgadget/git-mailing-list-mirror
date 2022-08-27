Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF004C0502A
	for <git@archiver.kernel.org>; Sat, 27 Aug 2022 12:58:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232686AbiH0M6q (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 27 Aug 2022 08:58:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231222AbiH0M6p (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 27 Aug 2022 08:58:45 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5921C33E3E
        for <git@vger.kernel.org>; Sat, 27 Aug 2022 05:58:43 -0700 (PDT)
Received: (qmail 21955 invoked by uid 109); 27 Aug 2022 12:58:42 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 27 Aug 2022 12:58:42 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 19902 invoked by uid 111); 27 Aug 2022 12:58:42 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 27 Aug 2022 08:58:42 -0400
Authentication-Results: peff.net; auth=none
Date:   Sat, 27 Aug 2022 08:58:41 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH] ci: update 'static-analysis' to Ubuntu 22.04
Message-ID: <YwoVAYTk0EKsAiut@coredump.intra.peff.net>
References: <pull.1334.git.1661275691795.gitgitgadget@gmail.com>
 <xmqqwnax438x.fsf@gitster.g>
 <7364f631-e05b-0db8-aaa4-9f0101b6db56@github.com>
 <xmqqfshl3pbp.fsf@gitster.g>
 <220825.86ilmg4mil.gmgdl@evledraar.gmail.com>
 <Ywh6v8oo3nRl/O5h@coredump.intra.peff.net>
 <xmqqczcnymtd.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqqczcnymtd.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Aug 26, 2022 at 09:46:54AM -0700, Junio C Hamano wrote:

> > Yeah, my general skepticism and disappointment above notwithstanding,
> > this seems like the best path forward from here. I tried a few other
> > tricks (like --macro-file and --iso-file), but if its parser chokes, I
> > don't think there's much we can do about it. Even if we wrote a patch to
> > coccinelle itself (and I have no interest in doing that myself), it
> > would take a while to become available.
> 
> If it is just a single unused.cocci, I would actually think removing
> it would be a much better path forward.  UNUSED() that renames to
> help folks without checking compilers would help noticing bad code
> much earlier than unused.cocci many contributors are not running
> themselves anyway.

I doubt that it is just unused.cocci. If I understand correctly, the new
syntax is choking coccinelle's parser, so it is missing segments of the
code from its analysis.

That shows up as a false positive for unused.cocci, because its patch is
something like "find me spots that have X followed by Y, with no Z in
between (and then delete X and Y)". And the breakage is that it doesn't
notice Z, so it thinks it has found such a spot.

But other rules are of the form "find me X (and turn it into Y)". If the
tool fails to parse code that contains X, then we'll get a false
negative: it won't generate output when it should. But we don't notice
any of those, because there are no true positives in the code base right
now. But it would presumably fail to find some of them if there were.
And more importantly, it makes the tool just as useless as false
positives.

If it were a matter of choosing one static analysis over another (unused
parameters versus coccinelle), we might have something tricky to decide.
But Ævar's non-parenthesized suggestion is a practical workaround. I
don't like it as much as what I posted originally, but it's only a
little less ergonomic, and lets us keep using coccinelle (which, despite
the headaches I've had tangling with it over the years, has produced
useful outcomes).

-Peff
