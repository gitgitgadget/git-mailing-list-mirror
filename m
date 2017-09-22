Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F1492202A5
	for <e@80x24.org>; Fri, 22 Sep 2017 04:25:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751808AbdIVEZn (ORCPT <rfc822;e@80x24.org>);
        Fri, 22 Sep 2017 00:25:43 -0400
Received: from cloud.peff.net ([104.130.231.41]:46616 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751790AbdIVEZm (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Sep 2017 00:25:42 -0400
Received: (qmail 27979 invoked by uid 109); 22 Sep 2017 04:25:42 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 22 Sep 2017 04:25:42 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 1272 invoked by uid 111); 22 Sep 2017 04:26:19 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Fri, 22 Sep 2017 00:26:19 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 22 Sep 2017 00:25:40 -0400
Date:   Fri, 22 Sep 2017 00:25:40 -0400
From:   Jeff King <peff@peff.net>
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        git@vger.kernel.org
Subject: Re: [PATCH] git: add --no-optional-locks option
Message-ID: <20170922042539.fs37bauiabfqcjx5@sigill.intra.peff.net>
References: <20170921043214.pyhdsrpy4omy54rm@sigill.intra.peff.net>
 <7a2d895c-df8c-1305-234f-7f8e2b271ec2@kdbg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <7a2d895c-df8c-1305-234f-7f8e2b271ec2@kdbg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 21, 2017 at 08:25:50PM +0200, Johannes Sixt wrote:

> > +`GIT_OPTIONAL_LOCKS`::
> > +	If set to `0`, Git will avoid performing any operations which
> > +	require taking a lock and which are not required to complete the
> > +	requested operation. For example, this will prevent `git status`
> > +	from refreshing the index as a side effect. This is useful for
> > +	processes running in the background which do not want to cause
> > +	lock contention with other operations on the repository.
> > +	Defaults to `1`.
> 
> I don't think we should pass this environment variable to remote
> repositories. It should be listed in local_repo_env[] in environment.c.

I'm not sure I agree. This is really about the context in which the
command is executing, not anything about the particular repository
you're operating on.

For fetch/push operations that touch a remote, I doubt it would matter
either way (and anyway, those often cross network boundaries that don't
propagate environment variables anyway).

But imagine that "git status" learns to recurse into submodules and run
"git status" inside them. Surely we would want the submodule repos to
also avoid taking any unnecessary locks?

-Peff
