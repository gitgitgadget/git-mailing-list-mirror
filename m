Return-Path: <SRS0=w+PN=DX=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3ED6DC433E7
	for <git@archiver.kernel.org>; Fri, 16 Oct 2020 20:00:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DC7E820874
	for <git@archiver.kernel.org>; Fri, 16 Oct 2020 20:00:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391648AbgJPUAc (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 16 Oct 2020 16:00:32 -0400
Received: from cloud.peff.net ([104.130.231.41]:34736 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391628AbgJPUAc (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Oct 2020 16:00:32 -0400
Received: (qmail 31464 invoked by uid 109); 16 Oct 2020 20:00:32 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 16 Oct 2020 20:00:32 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 12221 invoked by uid 111); 16 Oct 2020 20:00:31 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 16 Oct 2020 16:00:31 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 16 Oct 2020 16:00:31 -0400
From:   Jeff King <peff@peff.net>
To:     Elijah Newren <newren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: Funny test flake failure: t7518-ident-corner-cases.sh, test 1
Message-ID: <20201016200031.GA3355643@coredump.intra.peff.net>
References: <CABPp-BHQK-AtAJa6V1mtu6_jq3oeUeL_0p00RCRNA6Jw3DpJSg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CABPp-BHQK-AtAJa6V1mtu6_jq3oeUeL_0p00RCRNA6Jw3DpJSg@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 16, 2020 at 12:29:26PM -0700, Elijah Newren wrote:

> The issue comes from this test code:
> 
>        (
>                sane_unset GIT_AUTHOR_EMAIL &&
>                GIT_AUTHOR_NAME= &&
>                test_must_fail git commit --allow-empty -m foo 2>err &&
>                test_i18ngrep ! null err
>        )
> 
> The last line expects 'null' to NOT be found in err, unfortunately,
> the file err contained the line:
> 
> fatal: empty ident name (for
> <runner@fv-az128-670.gcliasfzo2nullsdbrimjtbyhg.cx.internal.cloudapp.net>)
> not allowed
> 218
> 
> Note that 'null' appears as a substring of the domain name, found
> within 'gcliasfzo2nullsdbrimjtbyhg'.

Heh. That's an amusing find. Good detective work, and sorry I created
the problem.

> +# confirm that we do not segfault _and_ that we do not say "(null)", as
> +# glibc systems will quietly handle our NULL pointer
> 
> Should we tighten the test to check for "(null)" instead of "null", or
> should we do something else?  Or just ignore it as it is somewhat
> unlikely that anyone ever hits this flake again?

I think it's worth tightening the test. The "(null)" phrasing is pretty
common, and it's really the best we can do. The chance that somebody is
on a platform that neither segfaults not prints "(null)", _and_ that
they introduce a regression there seems pretty low. And in comparison,
you already wasted time tracking down a false negative. Let's make sure
that doesn't happen again.

I wish there was an environment variable or something we could set in
the test suite to convince glibc to actually segfault on NULL (because
it _will_ segfault on other platforms, and we're rather catch such
things sooner rather than later).

Another option, I guess, is that we probably _do_ run the tests on such
a platform (IIRC BSD will segfault, so macos probably does). So we could
just remove the grep entirely from this test and let any regression get
caught there.

Of the two, I think I have a slight preference for matching (null), but
I don't feel strongly.

-Peff
