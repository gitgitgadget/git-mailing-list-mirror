Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 748C1C433FE
	for <git@archiver.kernel.org>; Thu, 17 Nov 2022 21:58:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241105AbiKQV6v (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Nov 2022 16:58:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241078AbiKQV6N (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Nov 2022 16:58:13 -0500
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05E567EBE9
        for <git@vger.kernel.org>; Thu, 17 Nov 2022 13:57:28 -0800 (PST)
Received: (qmail 28488 invoked by uid 109); 17 Nov 2022 21:57:28 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 17 Nov 2022 21:57:28 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 18232 invoked by uid 111); 17 Nov 2022 21:57:27 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 17 Nov 2022 16:57:27 -0500
Authentication-Results: peff.net; auth=none
Date:   Thu, 17 Nov 2022 16:57:26 -0500
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Glen Choo via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>,
        Glen Choo <chooglen@google.com>
Subject: Re: [PATCH] object-file: use real paths when adding alternates
Message-ID: <Y3auRnJqHq3pMKAe@coredump.intra.peff.net>
References: <pull.1382.git.git.1668706274099.gitgitgadget@gmail.com>
 <Y3aBzbzub7flQyca@coredump.intra.peff.net>
 <221117.86h6yxgy7b.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <221117.86h6yxgy7b.gmgdl@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Nov 17, 2022 at 08:41:44PM +0100, Ævar Arnfjörð Bjarmason wrote:

> This probably isn't worth it, but I wondered if this wouldn't be easier
> if we pulled that memory management into the caller, it's not
> performance sensitive (or maybe, how many alternatives do people have
> :)), but an advantage of this is that we avoid the free()/malloc() if we
> only get partway through, i.e. return early and keep looping.

I agree with your "probably". This isn't worth it to save a malloc in a
very non-hot code path. If the two bits of code were otherwise equal
(say, reset-ing a buffer used directly in a loop) I might say "why
not?". But crossing a function boundary to me introduces way too many
questions in somebody reading the code (like "is pathbuf supposed to
have something in it?") to make it worth doing here.

But even if we did want to do it, see below.

> In terms of general code smell & how we manage the "return" here, as
> adding "RESULT_MUST_BE_USED" to this shows we never use the "0" or "-1"
> (or any other...) return value.
> 
> That's been the case since this was added in c2f493a4ae1 (Transitively
> read alternatives, 2006-05-07), so we can probably just make this a
> "void" and ditch the returns if we're finding ourselves juggling these
> return values...

Yeah, we could ditch the return values. In a sense they are at least
documenting how link_alt_odb_entry() sees the world, but if nobody looks
at them, I'd be OK dropping them to make it clear that we don't intend
to ever act on them.

That said, both of these are orthogonal to what Glen's patches are
doing. If you want to submit a series later to deal with them, OK, but
let's try not to hijack the conversation for patches that are fixing a
real bug.

-Peff
