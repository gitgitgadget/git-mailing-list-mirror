Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 30C2A20248
	for <e@80x24.org>; Thu, 21 Mar 2019 09:44:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728203AbfCUJoQ (ORCPT <rfc822;e@80x24.org>);
        Thu, 21 Mar 2019 05:44:16 -0400
Received: from cloud.peff.net ([104.130.231.41]:58794 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727829AbfCUJoQ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Mar 2019 05:44:16 -0400
Received: (qmail 10769 invoked by uid 109); 21 Mar 2019 09:44:16 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 21 Mar 2019 09:44:16 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 8485 invoked by uid 111); 21 Mar 2019 09:44:38 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 21 Mar 2019 05:44:38 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 21 Mar 2019 05:44:14 -0400
Date:   Thu, 21 Mar 2019 05:44:14 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 0/13] more unused parameter cleanups
Message-ID: <20190321094414.GA2894@sigill.intra.peff.net>
References: <20190320081258.GA5621@sigill.intra.peff.net>
 <87woksd322.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87woksd322.fsf@evledraar.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 21, 2019 at 09:50:13AM +0100, Ævar Arnfjörð Bjarmason wrote:

> LGTM from skimming it, FWIW this is now what we need to compile cleanly
> with -Wextra:
> 
>     make DEVELOPER=1 DEVOPTS="extra-all" CFLAGS="-Wno-unused-parameter -Wno-missing-field-initializers -Wno-sign-compare -Wno-empty-body" all
> 
> For some such as -Wempty-body we'd really need to contort ourselves to
> get it passing anywhere near cleanly (all of those have existing "/*
> this is intentional! */" comments).

I think we could probably define a NOOP_BODY macro or function and use
that instead. But it may not be worth the trouble. I'd have to see how
painful that would be, and whether it might find any cases that actually
look like real bugs.

For -Wunused-parameter I am working towards being able to actually
enable that everywhere. It is not _too_ bad to annotate the instances
which must be there, and my digging with it has uncovered several real
bugs. Right now I'm in the "drop useless parameters" phase, which I
expect will take one or two more rounds.

Then I'll start on the "annotate unused ones we must keep" series, which
culminates in actually flipping on the switch with DEVELOPER (or rather,
stopping flipping it off).

You can see my progress on the jk/unused-4-mark branch of
https://github.com/peff/git (I think the contents are good, but the
commit messages and organization need some cleanup).

> I wonder if for the rest of these it's worth re-picking up this old
> suggestions of yours about #pragma:
> https://public-inbox.org/git/20170126143252.ne533mcv3n2ksbai@sigill.intra.peff.net/
> 
> I.e. for us to define our own macro for these cases & use it.

The push/pop ones may be of use (which both clang and gcc seem to
support), since that would let us localize the effects. I think in many
cases there's usually a more readable solution, though (e.g., you'd want
to annotate specific parameters as unused with single word, not a 3-line
push-diag/declare-param/pop-diag mess).

-Peff
