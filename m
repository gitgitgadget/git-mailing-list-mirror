Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87821C433FE
	for <git@archiver.kernel.org>; Fri, 11 Nov 2022 02:29:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231820AbiKKC3T (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Nov 2022 21:29:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231235AbiKKC3S (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Nov 2022 21:29:18 -0500
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE3E7D11A
        for <git@vger.kernel.org>; Thu, 10 Nov 2022 18:29:16 -0800 (PST)
Received: (qmail 28362 invoked by uid 109); 11 Nov 2022 02:29:16 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 11 Nov 2022 02:29:16 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 32680 invoked by uid 111); 11 Nov 2022 02:29:17 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 10 Nov 2022 21:29:17 -0500
Authentication-Results: peff.net; auth=none
Date:   Thu, 10 Nov 2022 21:29:15 -0500
From:   Jeff King <peff@peff.net>
To:     Glen Choo <chooglen@google.com>
Cc:     Taylor Blau <me@ttaylorr.com>,
        Glen Choo via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH] http: redact curl h2h3 headers in info
Message-ID: <Y22ze1m6ayQCv9B5@coredump.intra.peff.net>
References: <pull.1377.git.git.1667955151994.gitgitgadget@gmail.com>
 <Y2xnUyEoCFmbPtUI@nand.local>
 <kl6lpmdu3dl5.fsf@chooglen-macbookpro.roam.corp.google.com>
 <Y21yPIDmwB53e+aj@coredump.intra.peff.net>
 <kl6lk0422zgd.fsf@chooglen-macbookpro.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <kl6lk0422zgd.fsf@chooglen-macbookpro.roam.corp.google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Nov 10, 2022 at 02:53:54PM -0800, Glen Choo wrote:

> > There's some discussion in b66c77a64e (http: match headers
> > case-insensitively when redacting, 2021-09-22) about testing with
> > HTTP/2. Which ironically is basically this exact same bug in a different
> > form. ;)
> >
> > The short answer is that it's do-able, but probably there are some
> > headaches to make it work portably.
> 
> Argh, what a shame :( Okay, maybe it's not worth trying to use httpd
> then.
> 
> Some other ideas I had were:
> 
> - Create a test-tool that calls the redaction logic directly (without
>   involving about curl), and we pass the strings we want to redacted to
>   it. Way less than ideal, since we'd never be able to proactively catch
>   failures, but better than nothing I suppose.

I don't think this is worth the effort. It's nice to exercise the code a
bit, but it wouldn't have actually found this regression, since the
unexpected thing here was curl changing.

> - Write our own HTTP/2 server for redaction tests. I assume this won't
>   be trivial, but maybe not prohibitive, e.g. [1] implements its own
>   http server for credential helper tests.

These seems like a lot more work than just setting up HTTP/2 support for
Apache. I checked the recipe from b66c77a64e, and it still works. It
does indeed find the bug (my curl is 7.86.0) and confirms your fix.

I think a simple path forward could be something like:

  - teach lib-httpd to conditionally use the current set up versus the
    http2 one outlined in b66c77a64e

  - push most of t5551 into a lib-http-fetch.sh; the client-side set up
    from b66c77a64e checks for an HTTP2 prereq. The test that looks for
    chunked encoding (and only works on HTTP1) checks for !HTTP2.

  - t5551 tells lib-httpd to use the usual setup, and then sources
    lib-http-fetch; it behaves as before

  - t5559 (sadly, not contiguous without renumbering intermediate tests)
    tells lib-httpd to use http2, and sets the HTTP2 prereq. It runs the
    same tests but via http2.

We don't get the _whole_ test suite running with http2, but hopefully it
gives us a fairly representative sample. And it does find this bug.

I can try to work the above into patch form, but I may not get to it for
a day or two.

-Peff
