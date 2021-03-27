Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DCF2C433E0
	for <git@archiver.kernel.org>; Sat, 27 Mar 2021 09:45:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E3FCC61A0A
	for <git@archiver.kernel.org>; Sat, 27 Mar 2021 09:45:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231329AbhC0JmM (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 27 Mar 2021 05:42:12 -0400
Received: from cloud.peff.net ([104.130.231.41]:50622 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230424AbhC0Jlt (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 27 Mar 2021 05:41:49 -0400
Received: (qmail 13254 invoked by uid 109); 27 Mar 2021 09:41:49 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 27 Mar 2021 09:41:49 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 16120 invoked by uid 111); 27 Mar 2021 09:41:48 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 27 Mar 2021 05:41:48 -0400
Authentication-Results: peff.net; auth=none
Date:   Sat, 27 Mar 2021 05:41:47 -0400
From:   Jeff King <peff@peff.net>
To:     Stavros Ntentos <stdedos@gmail.com>
Cc:     bagasdotme@gmail.com, git@vger.kernel.org, gitster@pobox.com,
        stdedos+git@gmail.com
Subject: Re: [RFC PATCH v1 1/2] pathspec: warn: long and short forms are
 incompatible
Message-ID: <YF792/TkS3Ssw9NS@coredump.intra.peff.net>
References: <YF1w/xKbozpQn7Vf@coredump.intra.peff.net>
 <20210326161626.28648-1-133706+stdedos@users.noreply.github.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210326161626.28648-1-133706+stdedos@users.noreply.github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 26, 2021 at 06:16:26PM +0200, Stavros Ntentos wrote:

> > We avoid using variable-length arrays in our codebase. ...
> 
> Hear hear, however, I wanted to avoid the "small mess"
> that allocate/free would cause (one or more of ++sloc, labels, if-nesting); ...
> 
> > But two, they are limited in size and the failure mode is not graceful. ...
> ... however, my main issue is that - I don't know what's a sane allocation size.

I don't think a VLA gets you out of knowing the allocation size. Either
way, you are using strlen(entry).

But I do think avoiding allocating altogether is better (as I showed in
my previous response).

> > ... The "4096" is scary here ...
> While scary, it is "a safe" upper high.
> The first time the string ends up in pathspec.c for processing it's here:
> 	entry = argv[i];
> which comes from here
> 	parse_pathspec(pathspec, magic_mask, flags, prefix, parsed_file.v);
> 
> and I don't know what's the maximum size of `parsed_file.v[0]`

There is no reasonable maximum size you can assume. Using 4096 is most
definitely not a safe upper bound.

However, as I said, I don't think it is doing anything useful in the
first place. You have sized the destination buffers as large as the
original string, so they must be large enough to hold any subset of the
original. Dropping them would be equally correct, but less distracting
to a reader.

> > Is this "%4096[^)]" actually valid? I don't think scanf understands
> > regular expressions.
> 
> I was suprised too - but it's not regex.
> 
> see: https://www.cplusplus.com/reference/cstdio/scanf/#parameters - 4th/3rd row from the end

Thanks, this is a corner of scanf I haven't looked at (mostly because
again, we generally avoid scanf in our code base entirely).

> I think it will help you see what I am trying to achieve if you read at the warning message / testcase
> https://lore.kernel.org/git/20210326024005.26962-2-stdedos+git@gmail.com/#iZ30t:t6132-pathspec-exclude.sh
> 
> And, to clean up the testcase:
> 	git log --oneline --format=%s -- ':!(glob)**/file'
> 
> I guess it should be now obvious what am I targetting:
> 
> If someone naively mixes short and long pathspec magics (`!`, and `(glob)`),
> short form takes precedence and ignores long magic / assumes long magic as part of path.
> 
> (If it's not obvious, all the more reason to include such warning)

I understand the overall goal. I am not sure why slashes in the flags
section are a reliable indicator that this mixing is not happening and
we should not show the warning.

It also feels like any checks like this should be relying on the
existing pathspec-magic parser a bit more. I don't know the pathspec
code that well, but surely at some point it has a notion of which parts
are magic flags (e.g., after parse_element_magic in init_pathspec_item).

-Peff
