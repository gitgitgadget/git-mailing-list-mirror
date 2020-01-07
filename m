Return-Path: <SRS0=IlH6=24=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E8D1C33C99
	for <git@archiver.kernel.org>; Tue,  7 Jan 2020 11:48:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B60E2070E
	for <git@archiver.kernel.org>; Tue,  7 Jan 2020 11:48:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727988AbgAGLsO (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Jan 2020 06:48:14 -0500
Received: from cloud.peff.net ([104.130.231.41]:58898 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727972AbgAGLsO (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Jan 2020 06:48:14 -0500
Received: (qmail 11478 invoked by uid 109); 7 Jan 2020 11:48:13 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 07 Jan 2020 11:48:13 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 29519 invoked by uid 111); 7 Jan 2020 11:53:47 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 07 Jan 2020 06:53:47 -0500
Authentication-Results: peff.net; auth=none
Date:   Tue, 7 Jan 2020 06:48:12 -0500
From:   Jeff King <peff@peff.net>
To:     Bradley Smith <brad@brad-smith.co.uk>
Cc:     Junio C Hamano <gitster@pobox.com>,
        James Coglan <jcoglan@gmail.com>, git@vger.kernel.org
Subject: Re: Assertion in git log graphing [regression in v2.25]
Message-ID: <20200107114812.GE1073219@coredump.intra.peff.net>
References: <CAHt=fUXTHc4JPsapvHKnw5vHhp2cBOYRNfdaSDWBUnKt8fWfeA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHt=fUXTHc4JPsapvHKnw5vHhp2cBOYRNfdaSDWBUnKt8fWfeA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jan 07, 2020 at 11:24:50AM +0000, Bradley Smith wrote:

> The following git repository (https://github.com/brads55/git-testcase)
> causes an assertion when running:
> 
>   $ git log --oneline --graph --all
> 
>   git-log: graph.c:1228: graph_output_collapsing_line: Assertion
> `graph->mapping[i - 3] == target' failed.

Thanks for the report, and especially for providing a reproduction case!

The problem is new in the v2.25 release candidates, so we should try to
deal with it before the release.

> The assertion seems to be caused by commit
> 0f0f389f12029b1c3745f8ed7aacfe6b2fc7a6cc. The graph structure of the
> above repository is as follows (as produced by v2.24.1):

Yeah, I can confirm that this introduces the problem. I admit to not
following the recent graph changes too closely, so I'll add James to the
cc for attention.

The assertion itself is quite old, so I wondered if it was even still
relevant. Removing it does produce a reasonable-looking graph:

  *   a0a130c Merge commit '8f076d8' into HEAD
  |\  
  | | *   f0f3be5 Merge commit '1b4b8d0' into HEAD
  | | |\  
  | | | * 1b4b8d0 6
  | | * | 2c44f1b 2
  | | | | * dd068b4 Merge commit '8f076d8' into HEAD
  | |_|_|/| 
  |/| | |/  
  | | |/|   
  | |/| |   
  | * | | 8f076d8 5
  | | |/  
  | |/|   
  * | | a261135 4
  | |/  
  |/|   
  * | a267dd6 1
  |/  
  * 68f4772 0

but the colors aren't quite right. In particular, in this segment:

    | | | | * dd068b4 Merge commit '8f076d8' into HEAD
    | |_|_|/| 
    |/| | |/  

the first-parent line coming from dd068b4 is red in the slashes, but
uncolored in the underscores.

So much for naive fix. :)

-Peff
