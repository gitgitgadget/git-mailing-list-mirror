Return-Path: <SRS0=1eW7=DV=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E63DC433DF
	for <git@archiver.kernel.org>; Wed, 14 Oct 2020 18:07:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ED70321D81
	for <git@archiver.kernel.org>; Wed, 14 Oct 2020 18:07:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728559AbgJNSHI (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 14 Oct 2020 14:07:08 -0400
Received: from cloud.peff.net ([104.130.231.41]:60036 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727371AbgJNSHI (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Oct 2020 14:07:08 -0400
Received: (qmail 18201 invoked by uid 109); 14 Oct 2020 18:07:08 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 14 Oct 2020 18:07:08 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 19296 invoked by uid 111); 14 Oct 2020 18:07:07 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 14 Oct 2020 14:07:07 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 14 Oct 2020 14:07:07 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Taylor Blau <me@ttaylorr.com>, Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH v2 1/3] test-lib: allow selecting tests by
 substring/regex with --run
Message-ID: <20201014180707.GB24279@coredump.intra.peff.net>
References: <pull.878.git.git.1602545164.gitgitgadget@gmail.com>
 <pull.878.v2.git.git.1602616786.gitgitgadget@gmail.com>
 <41e2528e83ba7087c9d21f0b15efed416f1512f8.1602616786.git.gitgitgadget@gmail.com>
 <20201014170413.GB21687@coredump.intra.peff.net>
 <CAPc5daVa4j5mDvTzCFCX2bLr1qVFLO=P=nSakT+mDG1kqeXa+g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAPc5daVa4j5mDvTzCFCX2bLr1qVFLO=P=nSakT+mDG1kqeXa+g@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 14, 2020 at 10:46:15AM -0700, Junio C Hamano wrote:

> > I like that you allow regexes. It's unfortunate that the skip-check
> > costs us a process in every test. It may not be that big a deal since we
> > only pay it if you use a non-numeric selector. But I wonder if there's
> > any reason not to use "expr" here, as well.
> 
> If you define the pattern is not regexp but is glob, you can use
> case/esac to do this without any forking.

Yes, that would probably be OK for most purposes, though I admit my real
love for regex support is the ability to use "." instead of space to
avoid quoting arguments. ;)

Globs may make some real patterns slightly simpler, though. I imagine
that the "setup" example may need to be "set.?up" or "set.*up" in
practice. Which is only "set*up" as a glob (I also don't have a problem
standardizing on one spelling as people find cases).

> Your expr may well be built-in, though.

Yeah, that was my assumption, though I didn't bother to test it. Having
done so, it looks like it's not a built-in either in dash or bash.  So
switching to it from grep may be buying less in practice than I thought.

We're also running a ton of exprs earlier in the function. Running:

  strace -f -e execve -o foo.out ./t0003-attributes.sh --run=10

appears to exec expr 65 times. There are only 103 execves total in the
whole run, so that's more than half of them! It might be worth seeing if
some of those could do globbing via case/esac.

Repeating without "--run" yields 39 exprs out of 492 execs. So that's
less abysmal. Most of those are from test_oid_cache.

-Peff
