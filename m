Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E16DDC4332F
	for <git@archiver.kernel.org>; Sat, 17 Dec 2022 13:32:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230325AbiLQNcb (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 17 Dec 2022 08:32:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbiLQNca (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 17 Dec 2022 08:32:30 -0500
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 640BCD9B
        for <git@vger.kernel.org>; Sat, 17 Dec 2022 05:32:29 -0800 (PST)
Received: (qmail 2031 invoked by uid 109); 17 Dec 2022 13:32:28 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 17 Dec 2022 13:32:28 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 22877 invoked by uid 111); 17 Dec 2022 13:32:28 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 17 Dec 2022 08:32:28 -0500
Authentication-Results: peff.net; auth=none
Date:   Sat, 17 Dec 2022 08:32:28 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Rose via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Seija Kijin <doremylover123@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH] git: remove unneeded casts
Message-ID: <Y53E7PNu05VTdvXG@coredump.intra.peff.net>
References: <pull.1396.git.git.1671032126602.gitgitgadget@gmail.com>
 <Y5o9NNVx7dFLhIMd@coredump.intra.peff.net>
 <xmqqh6xxv946.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqh6xxv946.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Dec 15, 2022 at 08:49:45AM +0900, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > I'll stop here for now. It's a fair bit of leg-work digging
> > these up (though again, I do think there's value in
> > understanding why the cast was there, even if we know it
> > isn't _currently_ doing anything).
> 
> I agree with the value of understanding why each of these casts has
> become unnecessary, and thanks for demonstrating how a rerolled
> version should justify its changes with its findings behind each of
> the unnecessary casts.

I almost didn't write my earlier email, because I was worried that I was
creating work where it didn't need to exist (and all of the cases I
looked at seemed like good changes). But the cases that Phillip found
are a good reminder of the value of being careful here.

> What do you recommend the next round should look like?  Multi patch
> series, each of which removes one cast with its proposed log message
> explains how it has become unneeded?  A single patch with a gigantic
> proposed log message that lists the findings for each and all casts
> that are removed?  Somewhere in between, perhaps split along the
> file boundary, or grouped by the event that made them unneeded
> (e.g. "cmd_main() used to take non-const but when we made it to take
> const, all of these casts we remove in this patch became unneeded")?

When I've done fixes across the code base like this in the past, I'd
usually try to group them into patches by root cause. So perhaps:

  - this used to be "char **argv" because of main(), but either because
    of becoming a builtin or cmd_main() it is now const

  - this used to require casting from non-const to const to free()

  - etc, with one-offs for cases that don't fit in any group

The keeps a single patch's explanation from being too overwhelming, and
avoids repeating yourself when the same logic applies to multiple cases.

That said, I am happy with any solution that explains why we are sure
each case is OK to do. :)

-Peff
