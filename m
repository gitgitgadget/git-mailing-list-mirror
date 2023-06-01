Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB017C7EE23
	for <git@archiver.kernel.org>; Thu,  1 Jun 2023 18:20:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231193AbjFASUd (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 1 Jun 2023 14:20:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230419AbjFASUb (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Jun 2023 14:20:31 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F3A4123
        for <git@vger.kernel.org>; Thu,  1 Jun 2023 11:20:21 -0700 (PDT)
Received: (qmail 6683 invoked by uid 109); 1 Jun 2023 18:20:21 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 01 Jun 2023 18:20:21 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 25651 invoked by uid 111); 1 Jun 2023 18:20:20 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 01 Jun 2023 14:20:20 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 1 Jun 2023 14:20:20 -0400
From:   Jeff King <peff@peff.net>
To:     Kristoffer Haugsbakk <code@khaugsbakk.name>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Denton Liu <liu.denton@gmail.com>
Subject: Re: [RFC PATCH 1/3] range-diff: treat notes like `log`
Message-ID: <20230601182020.GC4165405@coredump.intra.peff.net>
References: <cover.1685441207.git.code@khaugsbakk.name>
 <8cc8eddfced1b64156008f7f923c430981d472af.1685441207.git.code@khaugsbakk.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8cc8eddfced1b64156008f7f923c430981d472af.1685441207.git.code@khaugsbakk.name>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, May 30, 2023 at 12:41:29PM +0200, Kristoffer Haugsbakk wrote:

> Currently, `range-diff` shows the default notes if no notes-related
> arguments are given. This is also how `log` behaves. But unlike
> `range-diff`, `log` does *not* show the default notes if
> `--notes=<custom>` are given. In other words, this:
> 
>     git log --notes=custom
> 
> is equivalent to this:
> 
>     git log --no-notes --notes=custom
> 
> While:
> 
>     git range-diff --notes=custom
> 
> acts like this:
> 
>     git log --notes --notes-custom
> 
> This can’t be how the user expects `range-diff` to behave given that the
> man page for `range diff` under `--[no-]notes[=<ref>]` says:
> 
> > This flag is passed to the git log program (see git-log(1)) that
> > generates the patches.

Yeah, I certainly agree that the behavior of range-diff is surprising,
and that this is a bug.

I'd have expected the solution here would be for range-diff to stop
passing "--notes", and let "log" decide whether to show notes (based on
specific --notes=foo it gets from other_arg).

But...

> This behavior also affects `format-patch` since it uses `range-diff` for
> the cover letter. Unlike `log`, though, `format-patch` is not supposed
> to show the default notes if no notes-related arguments are given.[1]
> But this promise is broken when the range-diff happens to have something
> to say about the changes to the default notes, since that will be shown
> in the cover letter.
> 
> Remedy this by co-opting the `--standard-notes` option which has been
> deprecated since ab18b2c0df[2] and which is currently only documented in
> `pretty-options`.

I'm not clear on whether you're actually fixing two separate bugs here,
or if they need to be intertwined.

It seems like passing --standard-notes means that format-patch's
range-diff will still show the standard notes by default. Maybe I'm
misunderstanding the problem, though.

-Peff
