Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10056C433DB
	for <git@archiver.kernel.org>; Wed, 20 Jan 2021 19:54:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D2B622343E
	for <git@archiver.kernel.org>; Wed, 20 Jan 2021 19:54:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392737AbhATTyi (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 Jan 2021 14:54:38 -0500
Received: from cloud.peff.net ([104.130.231.41]:33324 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392756AbhATTyX (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Jan 2021 14:54:23 -0500
Received: (qmail 28808 invoked by uid 109); 20 Jan 2021 19:53:40 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 20 Jan 2021 19:53:40 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 25595 invoked by uid 111); 20 Jan 2021 19:53:40 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 20 Jan 2021 14:53:40 -0500
Authentication-Results: peff.net; auth=none
Date:   Wed, 20 Jan 2021 14:53:39 -0500
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Jacob Vosmaer <jacob@gitlab.com>, git@vger.kernel.org,
        Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH 1/1] builtin/pack-objects.c: avoid iterating all refs
Message-ID: <YAiKQ0M0/14Q13Ee@coredump.intra.peff.net>
References: <20210119143348.27535-1-jacob@gitlab.com>
 <20210119143348.27535-2-jacob@gitlab.com>
 <87lfco801g.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87lfco801g.fsf@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 20, 2021 at 09:50:19AM +0100, Ævar Arnfjörð Bjarmason wrote:

> To elaborate on other things that aren't really your problem & Taylor's
> E-Mail downthread we originally added this because:
> 
>     If new annotated tags have been introduced then we can also include
>     them in the packfile, saving the client from needing to request them
>     through a second connection.
> 
> I've barked up this whole tag fetch tree before 97716d217c (fetch: add a
> --prune-tags option and fetch.pruneTags config, 2018-02-09) but really
> not this specific area.
> 
> I wonder if longer term simply moving this to be work the client does
> wouldn't make more sense. I.e. if we just delete this for_each_ref()
> loop.
>     
> We're just saving a client from saying they "want" a tag. I.e. with the
> whole thing removed we need this to make t5503-tagfollow.sh pass (see
> [1] at the end for the dialog, the tag is 3253df4d...):

Isn't this an ordering problem, though? The client cannot mention
auto-followed tags in a "want", because they first need to "want" the
main history, receive the pack, and then realize they want the others.

So we are not just saving the client from sending a "want", but making a
second full connection to do so. That seems to be an optimization worth
continuing to have.

But here...

>     diff --git a/t/t5503-tagfollow.sh b/t/t5503-tagfollow.sh
>     index 6041a4dd32..1ddc430aef 100755
>     --- a/t/t5503-tagfollow.sh
>     +++ b/t/t5503-tagfollow.sh
>     @@ -134,6 +134,7 @@ test_expect_success 'fetch B, S (commit and tag : 1 connection)' '
>      test_expect_success 'setup expect' '
>      cat - <<EOF >expect
>      want $B
>     +want $T
>      want $S
>      EOF
>      '
>     @@ -146,6 +147,7 @@ test_expect_success 'new clone fetch master and tags' '
>                     cd clone2 &&
>                     git init &&
>                     git remote add origin .. &&
>     +               git config --add remote.origin.fetch "+refs/tags/*:refs/tags/*" &&
>                     GIT_TRACE_PACKET=$UPATH git fetch &&
>                     test $B = $(git rev-parse --verify origin/master) &&
>                     test $S = $(git rev-parse --verify tag2) &&
> 
> We're also saving the client the work of having to go through
> refs/tags/* and figure out whether there are tags there that aren't on
> our main history.

You seem to be against auto-following at all. And certainly I can see an
argument that it is not worth the trouble it causes. But it is the
default behavior, and I suspect many people are relying on it. Fetching
every tag indiscriminately is going to grab a bunch of extra unwanted
objects in some repos. An obvious case is any time "clone
--single-branch --depth" is used.

Maybe I'm not quite understanding what you're proposing.

-Peff
