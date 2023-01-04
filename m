Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CF91C46467
	for <git@archiver.kernel.org>; Wed,  4 Jan 2023 07:33:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231201AbjADHdf (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 4 Jan 2023 02:33:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229773AbjADHde (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Jan 2023 02:33:34 -0500
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DE2AEE03
        for <git@vger.kernel.org>; Tue,  3 Jan 2023 23:33:32 -0800 (PST)
Received: (qmail 17890 invoked by uid 109); 4 Jan 2023 07:33:31 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 04 Jan 2023 07:33:31 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 22558 invoked by uid 111); 4 Jan 2023 07:33:35 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 04 Jan 2023 02:33:35 -0500
Authentication-Results: peff.net; auth=none
Date:   Wed, 4 Jan 2023 02:33:31 -0500
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH 3/5] environ: GIT_FLUSH should be made a usual Boolean
Message-ID: <Y7Ury+2n77XBzNl+@coredump.intra.peff.net>
References: <xmqq8rmkpsit.fsf@gitster.g>
 <20220915160659.126441-1-gitster@pobox.com>
 <20220915160659.126441-4-gitster@pobox.com>
 <c58476c9-f7d1-bea4-17eb-c5346790df2e@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c58476c9-f7d1-bea4-17eb-c5346790df2e@web.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jan 03, 2023 at 06:18:32PM +0100, René Scharfe wrote:

>                        before                  with this patch
> ---------------------- ----------------------- -----------------------
> (unset)                if stdin is not a file  if stdin is not a file
> GIT_FLUSH=             no                      no
> GIT_FLUSH=0            no                      no
> GIT_FLUSH=1	       yes                     yes
> GIT_FLUSH=false        no                      no
> GIT_FLUSH=true         no                      yes
> GIT_FLUSH=bogus        no                      if stdin is not a file
> GIT_FLUSH=10000000000  yes                     if stdin is not a file

These last two are unlike most of our other boolean variables, where we
complain about bad values:

  $ GIT_TEST_ASSUME_DIFFERENT_OWNER=bogus git rev-parse
  fatal: bad boolean config value 'bogus' for 'GIT_TEST_ASSUME_DIFFERENT_OWNER'

  $ GIT_LITERAL_PATHSPECS=10000000000 git rev-list HEAD -- foo
  fatal: bad boolean config value '10000000000' for 'GIT_LITERAL_PATHSPECS'

> This implementation ignores invalid values, and doesn't even report
> them, as before.  If we want to do that then we need to stop parsing
> the variable lazily, in order to report errors before the first
> output is written -- in maybe_flush_or_die() it's too late.

Why is it too late then? If we're going to do a hard die() anyway (as
above), whether it happens after a bit of output or not doesn't seem
like that big a deal. And if we never flush and look at the variable,
and the user "gets away" with a bogus value, nothing is harmed. That's
how existing variables work (e.g., try removing the pathspec from the
rev-list invocation above).

If that behavior is OK, then we could just use git_env_bool() here
(though the patch size isn't much different; as you noted, most of the
change comes from flipping the variable).

-Peff
