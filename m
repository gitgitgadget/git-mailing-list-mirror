Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B136C07E95
	for <git@archiver.kernel.org>; Tue, 20 Jul 2021 07:11:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 51ACF610CC
	for <git@archiver.kernel.org>; Tue, 20 Jul 2021 07:11:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229845AbhGTGbH (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Jul 2021 02:31:07 -0400
Received: from cloud.peff.net ([104.130.231.41]:54298 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233617AbhGTGa4 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Jul 2021 02:30:56 -0400
Received: (qmail 2221 invoked by uid 109); 20 Jul 2021 07:11:35 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 20 Jul 2021 07:11:35 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 19709 invoked by uid 111); 20 Jul 2021 07:11:36 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 20 Jul 2021 03:11:36 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 20 Jul 2021 03:11:34 -0400
From:   Jeff King <peff@peff.net>
To:     Patrick Steinhardt <ps@pks.im>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH] t0000: fix test if run with TEST_OUTPUT_DIRECTORY
Message-ID: <YPZ3JmWKLrUldK4R@coredump.intra.peff.net>
References: <60f5d923848d3_145c71208cc@natae.notmuch>
 <44006e7b0bdda50dc51153cc2efb6ae954d4eecb.1626762728.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <44006e7b0bdda50dc51153cc2efb6ae954d4eecb.1626762728.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jul 20, 2021 at 08:32:26AM +0200, Patrick Steinhardt wrote:

> Fix the issue by adding a new TEST_OUTPUT_DIRECTORY_OVERRIDE variable.
> If set, then we'll always override the TEST_OUTPUT_DIRECTORY with its
> value after sourcing GIT-BUILD-OPTIONS.

Thanks, I like this approach much better than removing
TEST_OUTPUT_DIRECTORY entirely (and I confirmed that it fixes the
problem).

I do wish we had a more generic way of overriding stuff in
GIT-BUILD-OPTIONS, rather than introducing manual _OVERRIDE variables
for each. But there's not an easy solution here (see the earlier thread
for some discussion), so this seems like a good immediate step to take.

One small note on the commit message:

> While this works as expected in the general case, it falls apart when
> the developer has TEST_OUTPUT_DIRECTORY explicitly defined either via
> the environment or via config.mak.

The mention of the environment confused me for a moment, since:

  TEST_OUTPUT_DIRECTORY=/tmp/foo ./t0000-basic.sh

is already OK. But you probably meant that:

  TEST_OUTPUT_DIRECTORY=/tmp/foo make test

would fail, since "make" would pick up the variable and then write it
into GIT-BUILD-OPTIONS (just as it would if you put it in config.mak, or
on the command-line of make).

I don't think it's sufficiently confusing to rewrite the commit message,
but just something I noted while reading it.

> --- a/t/test-lib.sh
> +++ b/t/test-lib.sh
> @@ -57,6 +57,15 @@ fi
>  . "$GIT_BUILD_DIR"/GIT-BUILD-OPTIONS
>  export PERL_PATH SHELL_PATH
>  
> +# In t0000, we need to override test directories of nested testcases. In case
> +# the developer has TEST_OUTPUT_DIRECTORY part of his build options, then we'd
> +# reset this value to instead contain what the developer has specified. We thus
> +# have this knob to allow overriding the directory.
> +if test -n "${TEST_OUTPUT_DIRECTORY_OVERRIDE}"
> +then
> +	TEST_OUTPUT_DIRECTORY="${TEST_OUTPUT_DIRECTORY_OVERRIDE}"
> +fi

Thanks for this comment. Hopefully that will make it clear to anybody
that the override mechanism is not meant for general use by developers.

-Peff
