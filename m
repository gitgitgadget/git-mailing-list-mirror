Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93B4FC433EF
	for <git@archiver.kernel.org>; Tue, 30 Nov 2021 21:18:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343966AbhK3VVZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 30 Nov 2021 16:21:25 -0500
Received: from cloud.peff.net ([104.130.231.41]:40538 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1344079AbhK3VVK (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Nov 2021 16:21:10 -0500
Received: (qmail 14119 invoked by uid 109); 30 Nov 2021 21:17:49 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 30 Nov 2021 21:17:49 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 30461 invoked by uid 111); 30 Nov 2021 21:17:50 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 30 Nov 2021 16:17:50 -0500
Authentication-Results: peff.net; auth=none
Date:   Tue, 30 Nov 2021 16:17:48 -0500
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Enzo Matsumiya <ematsumiya@suse.de>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Emily Shaffer <emilyshaffer@google.com>
Subject: Re: ab/run-command + em/missing-pager (was: What's cooking in
 git.git (Nov 2021, #07; Mon, 29))
Message-ID: <YaaU/OyVZI2uDLjy@coredump.intra.peff.net>
References: <xmqqzgpm2xrd.fsf@gitster.g>
 <211130.86k0gpcpy2.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <211130.86k0gpcpy2.gmgdl@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 30, 2021 at 09:54:33PM +0100, Ævar Arnfjörð Bjarmason wrote:

> > * em/missing-pager (2021-11-24) 1 commit
> > - pager: fix crash when pager program doesn't exist
> 
> As noted in [2] I'm happy to get this more isolated fix first. I'd
> missed that there was a re-submission[3] until now (since In-Reply-To
> wasn't maintained).
> 
> The code change in [3] isn't needed anymore when combined with my
> ab/run-command.
> 
> Depending on how you're planning to advance these perhaps you'd like to
> revert that as it's merged with ab/run-command, or I can re-roll
> ab/run-command on top of it if you'd like.
> 
> We could also just leave that now-redundant child_process_init() in
> pager.c, but having something that'll amount to cargo-culting to get
> around a bug in dead code doesn't seem ideal. It would be nice to have
> the API use reflect "argv" and "env" being gone.

IMHO that extra init is still doing the right thing, because it means
the struct is in the same known state in every run of setup_pager().
Fixing the argv/env thing stops the immediate bug, but there are other
potential ones. E.g., starting the command will overwrite the in/out/err
parameters; we're OK in this instance because we unconditionally
overwrite them.

So I think reusing a child_process struct without reinitializing it is
always a bit iffy, though it _usually_ works in practice. We should
model good use of the API by initializing on each use.

-Peff
