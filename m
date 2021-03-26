Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8858C433C1
	for <git@archiver.kernel.org>; Fri, 26 Mar 2021 08:32:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8BE3761A44
	for <git@archiver.kernel.org>; Fri, 26 Mar 2021 08:32:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229908AbhCZIbz (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 26 Mar 2021 04:31:55 -0400
Received: from cloud.peff.net ([104.130.231.41]:49644 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229753AbhCZIbq (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Mar 2021 04:31:46 -0400
Received: (qmail 29686 invoked by uid 109); 26 Mar 2021 08:31:45 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 26 Mar 2021 08:31:45 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 2231 invoked by uid 111); 26 Mar 2021 08:31:47 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 26 Mar 2021 04:31:47 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 26 Mar 2021 04:31:44 -0400
From:   Jeff King <peff@peff.net>
To:     Sean Allred <allred.sean@gmail.com>
Cc:     Lars Schneider <larsxschneider@gmail.com>, git@vger.kernel.org
Subject: Re: Bug report: 'filtering content' delayed progress message does
 not respect --quiet
Message-ID: <YF2b8LLhE0vjc7mg@coredump.intra.peff.net>
References: <CABceR4ZFVW=zeSwef7_dP+TWZ29J7BUkmMEB1CzCz=et_yYS9w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CABceR4ZFVW=zeSwef7_dP+TWZ29J7BUkmMEB1CzCz=et_yYS9w@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Mar 21, 2021 at 03:53:07PM -0500, Sean Allred wrote:

> What did you do before the bug happened? (Steps to reproduce your issue)
> 
>   Called `git clone --quiet git://path/to/private/repo`
> 
> What did you expect to happen? (Expected behavior)
> 
>   Expected git to be quiet :-)  Did not expect writes to stderr/stdout.
> 
> What happened instead? (Actual behavior)
> 
>   Received output that looked like
> 
>       Filtering content:  --% (--/--), --.-- MiB | --.-- MiB/s

+cc Lars, who added this in 52f1d62eb4 (convert: display progress for
filtered objects that have been delayed, 2017-08-20).

The message is in finish_delayed_checkout(), which gets only a "struct
checkout" to carry the state. That has a "quiet" field, but I'm not sure
it is set appropriately. E.g., builtin/checkout.c's checkout_worktree()
does not set it at all, and it is unconditionally set in unpack-trees.c's
check_updates().

We should obviously be respecting --quiet, but also checking isatty(2)
before auto-enabling. Probably we need a separate show_progress field.
For unpack-trees, I think it would get set from o->verbose_update, which
is what controls the existing "Updating files" meter. For checkout.c, it
probably comes from checkout_opts.show_progress.

-Peff
