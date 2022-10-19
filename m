Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4332C4332F
	for <git@archiver.kernel.org>; Wed, 19 Oct 2022 18:57:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230075AbiJSS5D (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 19 Oct 2022 14:57:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229767AbiJSS5C (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Oct 2022 14:57:02 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B70EC13ECC7
        for <git@vger.kernel.org>; Wed, 19 Oct 2022 11:57:01 -0700 (PDT)
Received: (qmail 3360 invoked by uid 109); 19 Oct 2022 18:57:01 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 19 Oct 2022 18:57:01 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 7888 invoked by uid 111); 19 Oct 2022 18:57:01 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 19 Oct 2022 14:57:01 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 19 Oct 2022 14:57:00 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Subject: Re: [PATCH v2 00/10] run-command API: add run_command_{l,sv}_opt()
Message-ID: <Y1BIfEN5ds2kKjjk@coredump.intra.peff.net>
References: <cover-00.10-00000000000-20221014T153426Z-avarab@gmail.com>
 <cover-v2-00.10-00000000000-20221017T170316Z-avarab@gmail.com>
 <xmqq4jw1wl6z.fsf@gitster.g>
 <221018.86a65ti70m.gmgdl@evledraar.gmail.com>
 <Y08P0G1Be+5hCVML@coredump.intra.peff.net>
 <xmqq7d0vu8cw.fsf@gitster.g>
 <Y1AujKKPUJFepph5@coredump.intra.peff.net>
 <xmqq7d0vsngp.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqq7d0vsngp.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 19, 2022 at 11:00:22AM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> >> True. run_command() needs the RUN_* flags twiddling, too, so it is
> >> not a point against _l_opt() variant.
> >
> > Did you mean run_command_v() here? If so, then yes, it requires the
> > flags. But if we are going to drop it in favor of just run_command(),
> > then those flags go away (and moving to the _l() variant is a step in
> > the opposite direction).
> 
> Ah, but we'd still need to prepare individual bits in the child
> structure (e.g. RUN_GIT_CMD vs .git_cmd) anyway.  Even though we may
> not have to work with the flags, somehow we need to set it up.  So
> it is not all that strong argument against the _l_opt().

Right, to the callers it is no different; they must use the flags or the
struct fields. What I meant is that we do not need to support _both_.
I.e., the big mapping in run_command_v_opt_cd_env_tr2() goes away.

> The above assessment is primarily because I do not have too much
> against RUN_GIT_CMD and friends, compared to setting the individual
> members in the child_process struct.  Setting individual members in
> the struct is more direct and it may be an improvement use
> run_command() directly over using _v_opt() and _l_opt() variants.

Yeah. I do not find RUN_GIT_CMD all that bad myself; I was mainly
pointing out that we do not need to support both of them (and of the
two, the struct fields are by far the more flexible, so that's what we
should keep).

That said, I am not too sad to have both. I would not have bothered to
do the work to remove the _v() versions with flags. But since René
already did so...

-Peff
