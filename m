Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E78EE1F461
	for <e@80x24.org>; Thu, 29 Aug 2019 14:00:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727815AbfH2OAO (ORCPT <rfc822;e@80x24.org>);
        Thu, 29 Aug 2019 10:00:14 -0400
Received: from cloud.peff.net ([104.130.231.41]:32896 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727309AbfH2OAO (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Aug 2019 10:00:14 -0400
Received: (qmail 23779 invoked by uid 109); 29 Aug 2019 14:00:14 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 29 Aug 2019 14:00:14 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 23108 invoked by uid 111); 29 Aug 2019 14:01:42 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 29 Aug 2019 10:01:42 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 29 Aug 2019 10:00:13 -0400
From:   Jeff King <peff@peff.net>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Matheus Tavares Bernardino <matheus.bernardino@usp.br>,
        Git Mailing List <git@vger.kernel.org>,
        Brandon Williams <bwilliams.eng@gmail.com>,
        Denton Liu <liu.denton@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH 1/2] config: allow config_with_options() to handle any
 repo
Message-ID: <20190829140013.GC1797@sigill.intra.peff.net>
References: <cover.1566863604.git.matheus.bernardino@usp.br>
 <4920d3c474375abb39ed163c5ed6138a5e5dccc6.1566863604.git.matheus.bernardino@usp.br>
 <CACsJy8Dry7MfKBi5EKw4Ka9r63QVmDjPv9nAozS0mC6Z7-sG=w@mail.gmail.com>
 <CAHd-oW4h80xrp6y65dqZbq_a67ncArC9rrNq7F7rAhBbrALOkA@mail.gmail.com>
 <CAHd-oW6doh=06nxUkMLWZOwNMyUOogLRbLstD0bJVQxLauR_Aw@mail.gmail.com>
 <CACsJy8DpTxpejkOHCYPnt3saC-h-3Ez0TthAPnPvHHThaG64bQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CACsJy8DpTxpejkOHCYPnt3saC-h-3Ez0TthAPnPvHHThaG64bQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 29, 2019 at 04:31:34PM +0700, Duy Nguyen wrote:

> > If so, how could we get R there? I mean, we could pass it through this
> > chain, but the chain already passes a "struct config_options", which
> > carries the "commondir" and "git_dir" fields. So it would probably be
> > confusing to have them and an extra repository parameter (which also
> > has "commondir" and "git_dir"), right? Any ideas on how to better
> > approach this?
> 
> I would change 'struct config_options' to carry 'struct repository'
> which also contains git_dir and other info inside. Though I have no
> idea how big that change would be (didn't check the code). Config code
> relies on plenty callbacks without "void *cb_data" so relying on
> global state is the only way in some cases.

I'm not sure about that, at least for this particular git_pathdup(). We
pass along the git_dir because we might not have a repository struct yet
(i.e., when reading config before repo discovery has happened).

So it might be that this case should actually be making a path out of
$git_dir/config.worktree (but I'm not 100% sure, as I don't know the ins
and outs of worktree config files).

I'm sure there are other gotchas in the config code, though, related to
things for which we _do_ need a repository. E.g., include_by_branch()
looks at the_repository, and should use a repository struct matching the
git_dir we're looking at (though it may be acceptable to bail during
early pre-repo-initialization config and just disallow branch includes,
which is what happens now).

-Peff
