Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D13E71F8CF
	for <e@80x24.org>; Fri,  9 Jun 2017 23:19:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751583AbdFIXTk (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Jun 2017 19:19:40 -0400
Received: from cloud.peff.net ([104.130.231.41]:37291 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751545AbdFIXTk (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Jun 2017 19:19:40 -0400
Received: (qmail 1822 invoked by uid 109); 9 Jun 2017 23:19:39 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 09 Jun 2017 23:19:39 +0000
Received: (qmail 26263 invoked by uid 111); 9 Jun 2017 23:19:39 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 09 Jun 2017 19:19:39 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 09 Jun 2017 19:19:35 -0400
Date:   Fri, 9 Jun 2017 19:19:35 -0400
From:   Jeff King <peff@peff.net>
To:     Brandon Williams <bmwill@google.com>
Cc:     Stefan Beller <sbeller@google.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [BUG?] gitlink without .gitmodules no longer fails recursive
 clone
Message-ID: <20170609231935.ysolxkiuhhpa3xrd@sigill.intra.peff.net>
References: <20170606035650.oykbz2uc4xkr3cr2@sigill.intra.peff.net>
 <CAGZ79kY-uzardfOvrJufatYgU9bqx4XZMU_GFq5zwc-vtzM-3Q@mail.gmail.com>
 <20170606181024.GA189073@google.com>
 <20170606183914.6iowfhimo5yrvmtf@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170606183914.6iowfhimo5yrvmtf@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 06, 2017 at 02:39:14PM -0400, Jeff King wrote:

> > Just for some background on the new behavior and how this functionality
> > changed: My series changed how 'submodule init' behaved if you have
> > 'submodule.active' set.  Once set (like how clone --recurse does now)
> > when not provided any path to a submodule, a list of 'active' submodules
> > matching the 'submodule.active' pathspec will be initialized.  One of
> > the requirements to be 'active' is to have an entry in the .gitmodules
> > file so gitlinks without an entry in the .gitmodules file will simply be
> > ignored now.
> 
> OK, thanks for the explanation. I certainly agree that treating
> .gitmodules as the source of truth is consistent and easy to explain.
> I'll update my test to handle the new behavior (it's a regression test
> for how GitHub Pages handles some broken setups).

I've been chatting with Pages folks about the kinds of errors they see,
and I was surprised how easy it is to get into this situation.

In an ideal world the user do:

  git submodule add git://host/repo.git path

which adds the gitlink and the .gitmodules entry. But it doesn't seem
unreasonable for somebody unfamiliar with submodules to do:

  git clone git://host/repo.git path
  git add path

This does add the entry as a gitlink, but doesn't write any sort of
.gitmodules entry. With the old code, cloning the repository (either by
another user, or in our case during a Pages build), a recursive clone or
submodule init would complain loudly. But now it's just quietly ignored.
Which seems unfortunate.

I actually don't think the old behavior was that great. Somebody _else_
would see the error and was responsible for filtering it back to the
original author. But what we really want is to warn the user when
they're creating the broken situation.

Should "git add" check whether there's a matching .gitmodules entry for
the path and issue a warning otherwise?

Sort of orthogonal, but I kind of wonder if the recursive clone should
also issue a warning. Not for an inactive submodule (which obviously is
normal) but for one that is inactive because it does not even have a
.gitmodules entry. I suppose that _could_ be considered normal in a
post-v2.13 world (e.g., if the owner of the repo "deactivates" a module
by deleting its .gitmodules entry).  But since it's indistinguishable
from the broken case, perhaps that would be better done with a specific
"active = false" flag in .gitmodules.

-Peff
