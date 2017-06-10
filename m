Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 820E71F8CF
	for <e@80x24.org>; Sat, 10 Jun 2017 06:13:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751817AbdFJGNa (ORCPT <rfc822;e@80x24.org>);
        Sat, 10 Jun 2017 02:13:30 -0400
Received: from cloud.peff.net ([104.130.231.41]:37451 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751741AbdFJGN3 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 10 Jun 2017 02:13:29 -0400
Received: (qmail 27458 invoked by uid 109); 10 Jun 2017 06:13:29 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sat, 10 Jun 2017 06:13:29 +0000
Received: (qmail 28813 invoked by uid 111); 10 Jun 2017 06:13:28 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sat, 10 Jun 2017 02:13:28 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 10 Jun 2017 02:13:26 -0400
Date:   Sat, 10 Jun 2017 02:13:26 -0400
From:   Jeff King <peff@peff.net>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     Brandon Williams <bmwill@google.com>, git@vger.kernel.org,
        sbeller@google.com, jrnieder@gmail.com, jacob.keller@gmail.com,
        Johannes.Schindelin@gmx.de, sandals@crustytoothpaste.net,
        peartben@gmail.com, pclouds@gmail.com, gitster@pobox.com,
        git@jeffhostetler.com, avarab@gmail.com
Subject: Re: [PATCH v2 00/32] repository object
Message-ID: <20170610061326.2dkdnvpjdq5d7223@sigill.intra.peff.net>
References: <20170531214417.38857-1-bmwill@google.com>
 <20170608234100.188529-1-bmwill@google.com>
 <20170609174034.61889ae8@twelve2.svl.corp.google.com>
 <20170610060712.foqre5fscaxu3tnx@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20170610060712.foqre5fscaxu3tnx@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jun 10, 2017 at 02:07:12AM -0400, Jeff King wrote:

> I think the repository object has to become a kitchen sink of sorts,
> because we have tons of global variables representing repo-wide config.
> ls-files doesn't respect a lot of config, but what should, e.g.:
> 
>   git config core.quotepath true
>   git -C submodule config core.quotepath false
>   git ls-files --recurse-submodules
>
> [...]
>
> [1] I wanted to see how Brandon's series behaved for this quotepath
>     case, but unfortunately I couldn't get it to work in even a simple
>     case.  :(
> 
>       $ git ls-files --recurse-submodules
>       fatal: index file corrupt

Ah, this was just hitting the bug mentioned later in the thread. With
that fix, I can see that it does indeed behave differently than the
current code:

  git config core.quotepath true
  git -C submodule config core.quotepath false
  (cd submodule &&
   echo hello >buenos_días &&
   git add .
  )
  git ls-files --recurse-submodules

shows:

  submodule/buenos_días

before the patch series, and:

  "submodule/buenos_d\303\255as"

after.

Like I said, I doubt this is a bug that anybody cares much about, but
it's hard to know what other repo-specific global-variable usage is
lurking in low-level code.

-Peff
