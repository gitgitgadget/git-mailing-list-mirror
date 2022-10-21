Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60D10C433FE
	for <git@archiver.kernel.org>; Fri, 21 Oct 2022 20:14:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229987AbiJUUOA (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 Oct 2022 16:14:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230190AbiJUUN6 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Oct 2022 16:13:58 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C62D2A0410
        for <git@vger.kernel.org>; Fri, 21 Oct 2022 13:13:52 -0700 (PDT)
Received: (qmail 14070 invoked by uid 109); 21 Oct 2022 20:13:51 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 21 Oct 2022 20:13:51 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 15377 invoked by uid 111); 21 Oct 2022 20:13:50 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 21 Oct 2022 16:13:50 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 21 Oct 2022 16:13:48 -0400
From:   Jeff King <peff@peff.net>
To:     Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH 1/3] git_parse_unsigned: reject negative values
Message-ID: <Y1L9fF6yd9EIIp9e@coredump.intra.peff.net>
References: <pull.1389.git.1666359915.gitgitgadget@gmail.com>
 <9c8440e5e82777311c6217cb4a9ddcd5cb8ce689.1666359915.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <9c8440e5e82777311c6217cb4a9ddcd5cb8ce689.1666359915.git.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 21, 2022 at 01:45:12PM +0000, Phillip Wood via GitGitGadget wrote:

> git_parse_unsigned() relies on strtoumax() which unfortunately parses
> negative values as large positive integers. Fix this by rejecting any
> string that contains '-' as we do in strtoul_ui(). I've chosen to treat
> negative numbers as invalid input and set errno to EINVAL rather than
> ERANGE one the basis that they are never acceptable if we're looking for
> a unsigned integer.

Certainly this seems like the right thing to do for a function parsing
an unsigned value. It would be nice if we could demonstrate the visible
effect with a test, though (and of course catch any later regressions).

Sadly "git config" doesn't let you ask to parse an unsigned type. But we
can find things in the core.* region that are parsed by default (and not
likely to change, as they represent file/memory sizes). Like:

  git -c core.bigFileThreshold=-1 rev-parse

which quietly passes before your patch, but fails after.

It does make me wonder if anybody uses a negative value like this in the
wild for "no limit", as it does what you might imagine currently (I get
2^64-1).

-Peff
