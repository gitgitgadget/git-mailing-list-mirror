Return-Path: <SRS0=4+BP=3K=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E8D9C2D0CE
	for <git@archiver.kernel.org>; Tue, 21 Jan 2020 16:24:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79C6922525
	for <git@archiver.kernel.org>; Tue, 21 Jan 2020 16:24:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729273AbgAUQYf (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Jan 2020 11:24:35 -0500
Received: from cloud.peff.net ([104.130.231.41]:41188 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727817AbgAUQYf (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Jan 2020 11:24:35 -0500
Received: (qmail 7466 invoked by uid 109); 21 Jan 2020 16:24:34 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 21 Jan 2020 16:24:34 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 11364 invoked by uid 111); 21 Jan 2020 16:31:27 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 21 Jan 2020 11:31:27 -0500
Authentication-Results: peff.net; auth=none
Date:   Tue, 21 Jan 2020 11:24:33 -0500
From:   Jeff King <peff@peff.net>
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, jrnieder@gmail.com,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH v2] fetch: document and test --refmap=""
Message-ID: <20200121162433.GA6215@coredump.intra.peff.net>
References: <pull.532.git.1579274939431.gitgitgadget@gmail.com>
 <pull.532.v2.git.1579570692766.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <pull.532.v2.git.1579570692766.gitgitgadget@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jan 21, 2020 at 01:38:12AM +0000, Derrick Stolee via GitGitGadget wrote:

> Update the documentation to clarify how '--refmap=""' works and
> create tests to guarantee this behavior remains in the future.

Yeah, this looks like a good solution to me.

> This can be accomplished by overriding the configured refspec using
> '--refmap=' along with a custom refspec:
> 
>   git fetch <remote> --refmap= +refs/heads/*:refs/hidden/<remote>/*

This isn't strictly related to your patch, but since the rationale here
describes the concept of a background job and people might end up using
it as a reference, do you want to add in --no-tags to help them out?

>     Thanks for all the feedback leading to absolutely no code change. It's
>     good we already have the flexibility for this. I'm a bit embarrassed
>     that I did not discover this, so perhaps this doc change and new tests
>     will help clarify the behavior.

If it makes you feel better, I only found --refmap because I was the one
who implemented the original "update based on refspecs" logic, and while
looking for that commit with "git log --grep=opportunistic" I stumbled
onto Junio's commit adding --refmap, which referenced mine. Maybe this
also works as a good case study in why we should write good commit
messages and refer to related work. :)

Anyway, I wasn't at all sure that a blank --refmap= would do what you
want until I tried it. But it was always intended to work that way. From
c5558f80c3 (fetch: allow explicit --refmap to override configuration,
2014-05-29):

  +static int parse_refmap_arg(const struct option *opt, const char *arg, int unset)
  +{
  +       ALLOC_GROW(refmap_array, refmap_nr + 1, refmap_alloc);
  +
  +       /*
  +        * "git fetch --refmap='' origin foo"
  +        * can be used to tell the command not to store anywhere
  +        */
  +       if (*arg)
  +               refmap_array[refmap_nr++] = arg;
  +       return 0;
  +}

At first I thought the comment was wrong, since we don't actually
increment refmap_nr. But the ALLOC_GROW makes refmap_array non-NULL,
which is what triggers the "do not use configured refspecs" logic.

This code switched to refspec_append() in e4cffacc80 (fetch: convert
refmap to use struct refspec, 2018-05-16), and I think we actually do
push an empty string onto the list. Which then triggers the "do not use
configured refspecs" logic, but doesn't match anything itself. I'm not
sure whether that behavior was entirely planned, or just what the code
happens to do. So it's doubly useful to add a test here covering the
expected behavior.

>  Documentation/fetch-options.txt |  5 ++++-
>  t/t5510-fetch.sh                | 24 ++++++++++++++++++++++++
>  2 files changed, 28 insertions(+), 1 deletion(-)

The patch looks good to me.

-Peff
