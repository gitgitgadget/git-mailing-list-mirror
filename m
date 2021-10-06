Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC1E6C433EF
	for <git@archiver.kernel.org>; Wed,  6 Oct 2021 16:15:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9DAC761130
	for <git@archiver.kernel.org>; Wed,  6 Oct 2021 16:15:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238124AbhJFQRY (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 6 Oct 2021 12:17:24 -0400
Received: from cloud.peff.net ([104.130.231.41]:34142 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230101AbhJFQRY (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Oct 2021 12:17:24 -0400
Received: (qmail 26277 invoked by uid 109); 6 Oct 2021 16:15:31 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 06 Oct 2021 16:15:31 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 28695 invoked by uid 111); 6 Oct 2021 16:15:31 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 06 Oct 2021 12:15:31 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 6 Oct 2021 12:15:30 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 2/5] cat-file: mention --unordered along with
 --batch-all-objects
Message-ID: <YV3LonbeIS8DrMsN@coredump.intra.peff.net>
References: <YVy1sx8Xb1xMLFQT@coredump.intra.peff.net>
 <YVy2DNd+XemykKE0@coredump.intra.peff.net>
 <877derjia9.fsf@evledraar.gmail.com>
 <YVzGeE1T/Kp8DDZD@coredump.intra.peff.net>
 <87tuhuikhf.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87tuhuikhf.fsf@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 06, 2021 at 11:02:59AM +0200, Ævar Arnfjörð Bjarmason wrote:

> I thought that --batch-all-objects and --batch were mutually exclusive,
> but they're obviously not.

Right. In fact, the former is useless without the latter (or
--batch-check).

> In my defense I think the help/code is very confusing. I hacked up some
> WIP changes to change it from:

That's fair, but...

> Looking at the history it seems you added --batch-all-objects around the
> same time as the OPT_CMDMODE() was used in the command, so we should
> probably have something like this to start with:
> 
> -- >8 --
> Subject: [PATCH] cat-file: make --batch-all-objects a CMDMODE
> 
> The usage of OPT_CMDMODE() in "cat-file"[1] was added in parallel with
> the development of[3] the --batch-all-objects option[4], so we've
> since grown[5] checks that it can't be combined with other command
> modes, when it should just be made a top-level command-mode
> instead. It doesn't combine with --filters, --textconv etc.

This is not right. --batch-all-objects does not provide a mode exclusive
with "-t", etc, by itself. It is --batch or --batch-check that does so.
Those in theory should be OPT_CMDMODE, but I don't think they can be,
because they also take an argument. So we'd need some OPT_CMDMODE_ARG()
or something, but then it needs _two_ value fields. So I think it would
require major surgery to parse-options.

Using --batch-all-objects without --batch or --batch-check would be an
error, and we do flag it as such.

So you are not wrong that using --batch-all-objects with -t is nonsense,
and we do indeed error on it currently. But it is not because the two
are themselves exclusive, but because of the chaining of the two rules.


The groupings you showed in your larger output mostly make sense, but...

>     Run <rev>:<blobs|tree> via conversion or filter
>         --textconv            for blob objects, run textconv on object's content
>         --filters             for blob objects, run filters on object's content
>         --path <blob>         use a specific path for --textconv/--filters
>     
>     Emit objects in batch via requests on STDIN, or --batch-all-objects
>         --batch-all-objects   Emit all objects in the repository, instead of taking requests on STDIN
>         --buffer              buffer --batch output
>         --batch[=<format>]    show info and content of objects fed from the standard input
>         --batch-check[=<format>]
> [...]

These groups aren't mutually exclusive. You can use --textconv in batch
mode. Which further muddies the CMDMODE waters; --batch is a mode that
overrides "-t", but _not_ "--textconv", where it is a modifier.

-Peff
