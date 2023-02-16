Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5609C636D4
	for <git@archiver.kernel.org>; Thu, 16 Feb 2023 02:14:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229599AbjBPCO3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Feb 2023 21:14:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbjBPCO2 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Feb 2023 21:14:28 -0500
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B3CE274BA
        for <git@vger.kernel.org>; Wed, 15 Feb 2023 18:14:27 -0800 (PST)
Received: (qmail 19640 invoked by uid 109); 16 Feb 2023 02:14:26 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 16 Feb 2023 02:14:26 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 21412 invoked by uid 111); 16 Feb 2023 02:14:25 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 15 Feb 2023 21:14:25 -0500
Authentication-Results: peff.net; auth=none
Date:   Wed, 15 Feb 2023 21:14:25 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     John Cai <johncai86@gmail.com>,
        John Cai via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH v2 1/2] diff: consolidate diff algorithm option parsing
Message-ID: <Y+2RgdCDrDC1N9Y1@coredump.intra.peff.net>
References: <pull.1452.git.git.1675568781.gitgitgadget@gmail.com>
 <pull.1452.v2.git.git.1676410819.gitgitgadget@gmail.com>
 <0c5e1fc6c2651e39bcefa27ee0976c9519671969.1676410819.git.gitgitgadget@gmail.com>
 <xmqqk00j3b6r.fsf@gitster.g>
 <AAC53EE0-91F5-4A74-AB26-5F3F8B680CDE@gmail.com>
 <xmqqmt5ev6ln.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqmt5ev6ln.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 15, 2023 at 03:42:12PM -0800, Junio C Hamano wrote:

> And I think that is a reasonable way to use callback to do "more
> than just setting a bit".  Even in that case, I am not sure if it is
> a good idea to share the same callback that has conditional code
> that only is relevant to the "patience" case, though.

I have to admit I did a double-take at the string comparisons with
opt->long. I guess we can rely on it, since it is coming from the
options struct (and is not the string that the user wrote on the command
line!). But it still feels a little error-prone, just because there's no
help from the type system or the compiler.

I'd have expected it with individual callbacks like:

  int handle_patience(...)
  {
	do_patience_specific_stuff();
	do_shared_stuff(PATIENCE_DIFF);
  }

  int handle_histogram(...)
  {
	do_shared_stuff(HISTOGRAM_DIFF);
  }

and so on. That's a bit more verbose, but the call stack reflects the
flow we expect.

I can live with it either way, though.

-Peff
