Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAA9BEB64D9
	for <git@archiver.kernel.org>; Tue, 27 Jun 2023 19:59:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229670AbjF0T7F (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 27 Jun 2023 15:59:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjF0T7D (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Jun 2023 15:59:03 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 082CA10FE
        for <git@vger.kernel.org>; Tue, 27 Jun 2023 12:59:01 -0700 (PDT)
Received: (qmail 15609 invoked by uid 109); 27 Jun 2023 19:59:01 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 27 Jun 2023 19:59:01 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 20746 invoked by uid 111); 27 Jun 2023 19:59:02 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 27 Jun 2023 15:59:02 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 27 Jun 2023 15:59:00 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Phillip Wood <phillip.wood123@gmail.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, vdye@github.com, me@ttaylorr.com,
        mjcheetham@outlook.com, Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH 2/2] for-each-ref: add --count-matches option
Message-ID: <20230627195900.GC1280909@coredump.intra.peff.net>
References: <pull.1548.git.1687792197.gitgitgadget@gmail.com>
 <9121e027fb9f157878a9624ce6c834b69cd38472.1687792197.git.gitgitgadget@gmail.com>
 <20230627073007.GD1226768@coredump.intra.peff.net>
 <f6fd39bc-65d4-76e3-94b4-9163194c89dd@gmail.com>
 <xmqqmt0khik5.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqmt0khik5.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 27, 2023 at 11:22:02AM -0700, Junio C Hamano wrote:

>    - populate_value() -> get_object() -> oid_object_info_extended() ->
>      grab_common_values() asks for ATOM_OBJECTTYPE that should be a
>      single xstrdup(), but oid_object_info_extended() needs to parse
>      the object, but .info.contentp ought to be NULL and we should
>      not be calling parse_object_buffer().

This is the atom that I expect to give most of the cost. We should
definitely be computing that just with a pack lookup (and chasing deltas
through the pack, though commits usually aren't deltas). But without
that atom, I think we would not even mmap the idx or pack file at all.

The ref-filter code is also pretty keen to malloc() little strings. When
we're measuring 5ms total runtimes and there's just not that much actual
work to do, those little things start to matter more.

> So it might be worth looking into where the time is going (didn't
> Peff or somebody do that a few years ago, though?) when using the
> default format and optimize or special case the codepath,[...]

Running:

 perf record -g git for-each-ref --format='%(refname) %(objecttype)' >/dev/null
 perf script report flamegraph

in linux.git shows that we spend a lot of time faulting in .idx pages.

A lot of the time is attributed to ref_array_sort(), but I think that's
a red herring. It lazy-loads the atom values, so that's where most of
the work is happening (though I would have thought it would just do the
refname atom, not all of them; but I guess it doesn't really matter
since we'll eventually need them to print anyway). Commenting out the
sort call just shows the same time spent in format_ref_array_item().

The patches you're thinking of are probably:

  https://lore.kernel.org/git/YTNpQ7Od1U%2F5i0R7@coredump.intra.peff.net/

which are mostly about micro-optimizing out those mallocs. They do still
help a little in the '%(refname)' case, but not nearly as much as
dropping '%(objecttype)' does.

(Using --format=x in theory drops out some mallocs, but I wasn't able to
measure any actual speedup).

> [...]but the
> responses I have seen from two of you makes me suspect that the new
> option is not the best general approach.

Yeah, my feeling is that with the reduced format, eliminating the
pipe/wc overhead is a pretty small improvement.

-Peff
