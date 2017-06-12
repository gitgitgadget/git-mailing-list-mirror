Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 663A820C4C
	for <e@80x24.org>; Mon, 12 Jun 2017 21:28:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752903AbdFLV2N (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Jun 2017 17:28:13 -0400
Received: from cloud.peff.net ([104.130.231.41]:38514 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752619AbdFLV2M (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Jun 2017 17:28:12 -0400
Received: (qmail 2244 invoked by uid 109); 12 Jun 2017 21:28:07 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 12 Jun 2017 21:28:07 +0000
Received: (qmail 16412 invoked by uid 111); 12 Jun 2017 21:28:07 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 12 Jun 2017 17:28:07 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 12 Jun 2017 17:28:05 -0400
Date:   Mon, 12 Jun 2017 17:28:05 -0400
From:   Jeff King <peff@peff.net>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     Brandon Williams <bmwill@google.com>, git@vger.kernel.org,
        sbeller@google.com, jrnieder@gmail.com, jacob.keller@gmail.com,
        Johannes.Schindelin@gmx.de, sandals@crustytoothpaste.net,
        peartben@gmail.com, pclouds@gmail.com, gitster@pobox.com,
        git@jeffhostetler.com, avarab@gmail.com
Subject: Re: [PATCH v2 00/32] repository object
Message-ID: <20170612212804.vjg3dvxjvbmayksz@sigill.intra.peff.net>
References: <20170531214417.38857-1-bmwill@google.com>
 <20170608234100.188529-1-bmwill@google.com>
 <20170609174034.61889ae8@twelve2.svl.corp.google.com>
 <20170610060712.foqre5fscaxu3tnx@sigill.intra.peff.net>
 <20170612120140.3da90194@twelve2.svl.corp.google.com>
 <20170612191121.GB154599@google.com>
 <20170612130409.07725a75@twelve2.svl.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170612130409.07725a75@twelve2.svl.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jun 12, 2017 at 01:04:09PM -0700, Jonathan Tan wrote:

> > I'm not sure I know what you mean by config variables which are static,
> > are you referring to the in-memory options which are populated by
> > querying the config?  Those I wouldn't want to see placed in a
> > 'repository object'.
> 
> Yes. I agree that I wouldn't want to see them placed in a repository
> object, but after reading Peff's e-mail, I was thinking of what happens
> if a file repeatedly invokes a config-sensitive function in another
> file. For example:
> 
>  a.c
>   for (i = 0; i < 100; i++) b_output(repo, x);
> 
>  b.c
>   void b_output(struct repository *repo, int x)
>   {
>    /* print the configured "b.prefix" followed by x */
>   }
> 
> We probably wouldn't want to parse the repo's configset every time
> b_output() is invoked, but then, where to store our parsed "b.prefix"?
> The only alternatives I see is to have a static hashmap in b.c (keyed by
> repo, as described above), which would work if such a situation is rare
> (or can be made rare), but if it is common, maybe we have no choice but
> to put it in struct repository.

I think besides optimization, we often parse the textual config into
variables and then _modify_ those variables based on other input (most
often command-line arguments provided by the user, but sometimes other
circumstances).

You can move the resolution to the point-of-use instead of
point-of-setting, but that's going to be a big change to how most of the
code already works.

-Peff
