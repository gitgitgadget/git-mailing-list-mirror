Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1B3BC636D4
	for <git@archiver.kernel.org>; Sat, 11 Feb 2023 01:59:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229508AbjBKB7y (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Feb 2023 20:59:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjBKB7x (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Feb 2023 20:59:53 -0500
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89CC46C7C3
        for <git@vger.kernel.org>; Fri, 10 Feb 2023 17:59:52 -0800 (PST)
Received: (qmail 21232 invoked by uid 109); 11 Feb 2023 01:59:52 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 11 Feb 2023 01:59:52 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 30210 invoked by uid 111); 11 Feb 2023 01:59:51 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 10 Feb 2023 20:59:51 -0500
Authentication-Results: peff.net; auth=none
Date:   Fri, 10 Feb 2023 20:59:51 -0500
From:   Jeff King <peff@peff.net>
To:     phillip.wood@dunelm.org.uk
Cc:     Elijah Newren <newren@gmail.com>, John Cai <johncai86@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        John Cai via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH 2/2] diff: teach diff to read gitattribute diff-algorithm
Message-ID: <Y+b2l4Le2gTxGwO8@coredump.intra.peff.net>
References: <pull.1452.git.git.1675568781.gitgitgadget@gmail.com>
 <8e73793b0db3e84366a9c6441cc0fdc04f9614a5.1675568781.git.gitgitgadget@gmail.com>
 <230206.865yce7n1w.gmgdl@evledraar.gmail.com>
 <B544D9E8-13C4-4682-9BDA-D6E19B51C91D@gmail.com>
 <d18a5c32-2f15-93ad-ccbf-e8f048edb311@dunelm.org.uk>
 <65129323-326F-4E4A-B6F8-06DC3BBE7B58@gmail.com>
 <CABPp-BHhhUhRqn=kKcDiV3EMckBSk2EE8TKZ-PoeqTsKWuvAng@mail.gmail.com>
 <1ddac91b-7552-3e1e-9888-9e21e808104d@dunelm.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1ddac91b-7552-3e1e-9888-9e21e808104d@dunelm.org.uk>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 09, 2023 at 02:44:15PM +0000, Phillip Wood wrote:

> To see the differences between the output of patience and histogram
> algorithms I diffed the output of "git log -p --no-merges
> --diff-algorithm=patience" and "git log -p --no-merges
> --diff-algorithm=histogram". The first three differences are
> 
> - 6c065f72b8 (http: support CURLOPT_PROTOCOLS_STR, 2023-01-16)
>   In get_curl_allowed_protocols() the patience algorithm shows the
>   change in the return statement more clearly
> 
> - 47cfc9bd7d (attr: add flag `--source` to work with tree-ish, 2023-01-14)
>    The histogram algorithm shows read_attr_from_index() being moved
>    whereas the patience algorithm does not making the diff easier to
>    follow.
> 
> - b0226007f0 (fsmonitor: eliminate call to deprecated FSEventStream
> function, 2022-12-14)
>   In fsm_listen__stop_async() the histogram algorithm shows
>   data->shutdown_style = SHUTDOWN_EVENT;
>   being moved, which is not as clear as the patience output which
>   shows it as a context line.

Just a small counter-point, since I happened to be looking at myers vs
patience for something elsewhere in the thread, but:

  git show 35bd13fcd2caa4185bf3729655ca20b6a5fe9b6f builtin/add.c

looks slightly better to me with myers, even though it is 2 lines
longer. The issue is that patience and histogram are very eager to use
blank lines as anchor points, so a diff like:

  -some words
  -
  -and some more
  +unrelated content
  +
  +but it happens to also be two paragraphs

in myers becomes:

  -some words
  +unrelated content
  
  -and some more
  +but it happens to also be two paragraphs

in patience (here I'm using single lines, but in practice these may be
paragraphs, or stanzas of code). I think that's also the _strength_ of
patience in many cases, but it really depends on the content. Replacing
a multi-stanza block with another one may be the best explanation for
what happened. Or the two stanzas may be independent, and showing the
change for each one may be better.

I'm not sure which one happens more often. And you'd probably want to
weight it by how good/bad the change is. In the example I showed I don't
find patience very much worse, since it's already a pretty ugly diff.
But in cases where patience shines, it may be making things
significantly more readable.

I don't have a super strong opinion, but I just wanted to chime in that
it is not clear to me that patience/histogram is always a win over myers
(yes, I know your examples were comparing patience vs histogram, but the
larger thread is discussing the other).

-Peff
