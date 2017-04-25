Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3438A207D6
	for <e@80x24.org>; Tue, 25 Apr 2017 03:22:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S980331AbdDYDWt (ORCPT <rfc822;e@80x24.org>);
        Mon, 24 Apr 2017 23:22:49 -0400
Received: from cloud.peff.net ([104.130.231.41]:39507 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S980328AbdDYDWr (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Apr 2017 23:22:47 -0400
Received: (qmail 16610 invoked by uid 109); 25 Apr 2017 03:22:45 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 25 Apr 2017 03:22:45 +0000
Received: (qmail 5676 invoked by uid 111); 25 Apr 2017 03:23:09 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 24 Apr 2017 23:23:09 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 24 Apr 2017 23:22:42 -0400
Date:   Mon, 24 Apr 2017 23:22:42 -0400
From:   Jeff King <peff@peff.net>
To:     Stefan Beller <sbeller@google.com>
Cc:     Philip Oakley <philipoakley@iee.org>,
        Orgad Shaneh <orgads@gmail.com>,
        Dakota Hawkins <dakotahawkins@gmail.com>,
        git <git@vger.kernel.org>
Subject: Re: Submodule/contents conflict
Message-ID: <20170425032242.wlmqrkgkeg3ytfle@sigill.intra.peff.net>
References: <CAGHpTBJCjNa8gQRkMah30ehESdsVVKNy+6CuLSf9hfDedR+tPA@mail.gmail.com>
 <CAGZ79kZ5440r1EHOVP3eXxe5u=u16y_jXTA0C4hLJA2kUkF-kg@mail.gmail.com>
 <4BF0A1BFFFFD421EB8C5F7E6FEF14357@PhilipOakley>
 <CAGZ79kZDzuSHw4siSkiekw73bBq9R8gg_R+a7NyNUG6bYxc2Og@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAGZ79kZDzuSHw4siSkiekw73bBq9R8gg_R+a7NyNUG6bYxc2Og@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 24, 2017 at 04:43:28PM -0700, Stefan Beller wrote:

> >> On the main list thare is a similar "issue" [1] regarding the expectation for `git checkout`,
> >> and importantly (for me) these collected views regarding the "Git Data Protection and
> >> Management Principles" is not within the Git documentation.
> >
> > Yes, that's an interesting point. What concerns me is that the commit
> > c5326bd62b7e168ba1339dacb7ee812d0fe98c7c which introduced this
> > into checkout isn't consistent with reset. Seems that nobody noticed this before.
> 
> It seems as if we'd want to see the code from
> c5326bd62b7e168ba1339dacb7ee812d0fe98c7c
> to be part of any worktree touching command, specifically reset?

Note that that commit is just about "git checkout <commit> -- <paths>".
The matching reset command, "git reset <commit> -- <paths>" does handle
this the same way. Or at least I claimed so here:

  http://public-inbox.org/git/20141107081324.GA19845@peff.net/

and that is what I modeled the code in c5326bd62b after.

But note that none of that should ever affect _what_ gets checked out at
a file or content level. It may only affect the timestamps on the
resulting files. And I think those timestamps are not something Git
makes any promises about.

So if Git can elide a write and keep a timestamp up to date, that is a
great optimization and we should do that. But from an outside viewer's
perspective, we guarantee nothing. We might choose to rewrite a
stat-dirty file (updating its timestamp) rather than read its contents
to see if it might have the same content that we're about to write. And
the file may look stat dirty only because of the racy-git file/index
timestamp problem, even if it wasn't actually modified.

> > It also has a similarity to
> > https://public-inbox.org/git/1492287435.14812.2.camel@gmail.com/  regarding
> > how checkout operates.

I didn't look too deeply into this one, but it really looks like
somebody caring too much about when git needs to write (and I'd suspect
it's impacted by the racy-git thing, too).

-Peff
