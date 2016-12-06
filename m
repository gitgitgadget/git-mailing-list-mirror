Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2885B1FC96
	for <e@80x24.org>; Tue,  6 Dec 2016 18:35:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752340AbcLFSfa (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Dec 2016 13:35:30 -0500
Received: from cloud.peff.net ([104.130.231.41]:52648 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751745AbcLFSf3 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Dec 2016 13:35:29 -0500
Received: (qmail 5427 invoked by uid 109); 6 Dec 2016 18:35:29 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 06 Dec 2016 18:35:29 +0000
Received: (qmail 15960 invoked by uid 111); 6 Dec 2016 18:36:07 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 06 Dec 2016 13:36:07 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 06 Dec 2016 13:35:28 -0500
Date:   Tue, 6 Dec 2016 13:35:28 -0500
From:   Jeff King <peff@peff.net>
To:     Stefan Beller <sbeller@google.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        David Aguilar <davvid@gmail.com>,
        Dennis Kaarsemaker <dennis@kaarsemaker.net>
Subject: Re: [PATCH v3 1/2] difftool: add a skeleton for the upcoming builtin
Message-ID: <20161206183527.t6rjkkff7fxv5i5c@sigill.intra.peff.net>
References: <xmqqshqadn0f.fsf@gitster.mtv.corp.google.com>
 <alpine.DEB.2.20.1611301325210.117539@virtualbox>
 <xmqqlgvz6x87.fsf@gitster.mtv.corp.google.com>
 <alpine.DEB.2.20.1612051126320.117539@virtualbox>
 <xmqqy3zu43yk.fsf@gitster.mtv.corp.google.com>
 <alpine.DEB.2.20.1612061411000.117539@virtualbox>
 <20161206133650.t7gkg4f6wzw3zxki@sigill.intra.peff.net>
 <alpine.DEB.2.20.1612061512190.117539@virtualbox>
 <20161206150955.mvq4ocamaei52bap@sigill.intra.peff.net>
 <CAGZ79kZoy2zSgSEc7kfAZ9tg9_uJxa+_FNFVO8UEDLVK6YDxVg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAGZ79kZoy2zSgSEc7kfAZ9tg9_uJxa+_FNFVO8UEDLVK6YDxVg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Dec 06, 2016 at 10:22:21AM -0800, Stefan Beller wrote:

> >> Maybe even go a step further and say that the config code needs a context
> >> "object".
> >
> > If I were writing git from scratch, I'd consider making a "struct
> > repository" object. I'm not sure how painful it would be to retro-fit it
> > at this point.
> 
> Would it be possible to introduce "the repo" struct similar to "the index"
> in cache.h?
> 
> From a submodule perspective I would very much welcome this
> object oriented approach to repositories.

I think it may be more complicated, because there's some implicit global
state in "the repo", like where files are relative to our cwd. All of
those low-level functions would have to start caring about which repo
we're talking about so they can prefix the appropriate working tree
path, etc.

For some operations that would be fine, but there are things that would
subtly fail for submodules. I'm thinking we'd end up with some code
state like:

  /* finding a repo does not modify global state; good */
  struct repository *repo = repo_discover(".");

  /* obvious repo-level operations like looking up refs can be done with
   * a repository object; good */
  repo_for_each_ref(repo, callback, NULL);

  /*
   * "enter" the repo so that we are at the top-level of the working
   * tree, etc. After this you can actually look at the index without
   * things breaking.
   */
  repo_enter(repo);

That would be enough to implement a lot of submodule-level stuff, but it
would break pretty subtly as soon as you asked the submodule about its
working tree. The solution is to make everything that accesses the
working tree aware of the idea of a working tree root besides the cwd.
But that's a pretty invasive change.

-Peff
