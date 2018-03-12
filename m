Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 874201F404
	for <e@80x24.org>; Mon, 12 Mar 2018 23:28:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751386AbeCLX2s (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Mar 2018 19:28:48 -0400
Received: from cloud.peff.net ([104.130.231.41]:54674 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751312AbeCLX2r (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Mar 2018 19:28:47 -0400
Received: (qmail 13091 invoked by uid 109); 12 Mar 2018 23:28:47 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 12 Mar 2018 23:28:47 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 18919 invoked by uid 111); 12 Mar 2018 23:29:40 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Mon, 12 Mar 2018 19:29:40 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 12 Mar 2018 19:28:44 -0400
Date:   Mon, 12 Mar 2018 19:28:44 -0400
From:   Jeff King <peff@peff.net>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Brandon Williams <bmwill@google.com>,
        Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org,
        sbeller@google.com, gitster@pobox.com, stolee@gmail.com,
        git@jeffhostetler.com, pclouds@gmail.com
Subject: Re: [PATCH v3 04/35] upload-pack: convert to a builtin
Message-ID: <20180312232844.GB1968@sigill.intra.peff.net>
References: <20180221134422.2386e1aca39fe673235590e7@google.com>
 <20180222095833.GC12442@sigill.intra.peff.net>
 <20180222180715.GB185096@google.com>
 <20180222181400.GA19035@sigill.intra.peff.net>
 <20180222193814.GA256918@aiede.svl.corp.google.com>
 <20180222201940.GB23561@sigill.intra.peff.net>
 <20180222202150.GA23985@sigill.intra.peff.net>
 <20180222212634.GC256918@aiede.svl.corp.google.com>
 <20180222214457.GB30638@sigill.intra.peff.net>
 <20180312224355.GC58506@aiede.svl.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180312224355.GC58506@aiede.svl.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 12, 2018 at 03:43:55PM -0700, Jonathan Nieder wrote:

> Hi,
> 
> Jeff King wrote:
> > On Thu, Feb 22, 2018 at 01:26:34PM -0800, Jonathan Nieder wrote:
> 
> >> Keep in mind that git upload-archive (a read-only command, just like
> >> git upload-pack) also already has the same issues.
> >
> > Yuck. I don't think we've ever made a historical promise about that. But
> > then, I don't think the promise about upload-pack has ever really been
> > documented, except in mailing list discussions.
> 
> Sorry to revive this old side-thread.  Good news: for a dashed command
> like git-upload-archive, the pager selection code only runs for
> commands with RUN_SETUP or RUN_SETUP_GENTLY:
> 
> 	if (use_pager == -1 && p->option & (RUN_SETUP | RUN_SETUP_GENTLY) &&
> 	    !(p->option & DELAY_PAGER_CONFIG))
> 		use_pager = check_pager_config(p->cmd);
> 
> None of upload-pack, receive-pack,git-serve, or upload-archive set
> those flags, so we (narrowly) escape trouble here.

Right, I saw that earlier. But I actually think that is stale from the
days when it wasn't safe to call check_pager_config() too early. So I
could very well see somebody removing it and causing a spooky
vulnerability at a distance.

> Later today I should be able to send a cleanup to make the behavior
> more obvious.

Thanks. I'm still on the fence over the whole builtin concept, but
certainly a "don't ever turn on a pager" flag seems like a reasonable
thing to have.

An alternative approach is some kind of global for "don't trust the
local repo" flag. That could be respected from very low-level code
(e.g., where we read and/or respect the pager command, but also in other
places like hooks, other config that runs arbitrary commands, etc). And
then upload-pack would set that to "do not trust", and other programs
would default to "trust".

We could even give it an environment variable, which would allow
something like:

  tar xf maybe-evil.git.tar
  cd maybe-evil
  export GIT_TRUST_REPO=false
  git log

without worrying about pager.log config, etc. My two concerns with this
approach would be:

  1. We have to manually annotate any "dangerous" code to act more
     safely when it sees the flag. Which means it's highly likely to
     a spot, or to add a new feature which doesn't respect it. And
     suddenly that's a security hole. So I'm concerned it may create a
     false sense of security and actually make things worse.

  2. As a global, I'm not sure how it would interact with multi-repo
     processes like submodules. In theory it ought to go into the
     repository struct, but it would often need to be set globally
     before we've even discovered the repo.

     That might be fine, though. It's really more about context than
     about a specific repo (so you may say "don't trust this repo", and
     that extends to any submodules you happen to access, too).

I dunno. I think (2) is probably OK, but (1) really gives me pause.

-Peff
