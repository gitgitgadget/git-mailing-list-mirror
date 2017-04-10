Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F39A820966
	for <e@80x24.org>; Mon, 10 Apr 2017 17:14:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754993AbdDJROD (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Apr 2017 13:14:03 -0400
Received: from cloud.peff.net ([104.130.231.41]:59289 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753760AbdDJROA (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Apr 2017 13:14:00 -0400
Received: (qmail 11218 invoked by uid 109); 10 Apr 2017 17:13:55 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 10 Apr 2017 17:13:55 +0000
Received: (qmail 26820 invoked by uid 111); 10 Apr 2017 17:14:15 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 10 Apr 2017 13:14:15 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 10 Apr 2017 13:13:53 -0400
Date:   Mon, 10 Apr 2017 13:13:53 -0400
From:   Jeff King <peff@peff.net>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Danny Sauer <danny@dannysauer.com>,
        Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Make git log work for git CWD outside of work tree
Message-ID: <20170410171352.s7r7tzheadxjlulw@sigill.intra.peff.net>
References: <20170409022128.21337-1-danny@dannysauer.com>
 <alpine.DEB.2.20.1704091238560.4268@virtualbox>
 <413a1456-cac6-56c8-ea45-38f14cf958ae@dannysauer.com>
 <xmqqvaqdqfhe.fsf@gitster.mtv.corp.google.com>
 <CACsJy8CLBY22j3EjR4PW3n+K6PWUzb-HCgxTVeCGpwtApZF-6g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CACsJy8CLBY22j3EjR4PW3n+K6PWUzb-HCgxTVeCGpwtApZF-6g@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 10, 2017 at 07:01:00PM +0700, Duy Nguyen wrote:

> > Similarly, if you replace "git add foo" with "git log", it still
> > should work in the above, i.e.
> >
> >     $ export GIT_DIR=~/myproject/.git GIT_WORK_TREE=~/myproject
> >     $ cd ~/myproject/../somewhere/else
> >     $ git log
> >
> > If Git is not chdir(2)ing to ~/myproject before calling cmd_log()
> > in the above (again, this is my down week so I didn't and will not
> > check with the code myself), we may want to call that a bug and fix
> > it, so that you do not have to do anything special to get to the
> > path of ".mailmap" that is at the top-level.
> 
> The behavior is "documented" in t1510 since f3bb8b4b84 (Merge branch
> 'nd/setup' - 2010-12-28)
> 
> "11. When user's cwd is outside worktree, cwd remains unchanged,
>     prefix is NULL."
> 
> This behavior probably started long before my topic though, mine was
> more of documentation, making worktree detection more consistent. It's
> the same case with defining GIT_DIR without GIT_WORK_TREE, I think:
> scripts started to depend on a behavior that we did not clearly
> define, by the time we knew what we wanted and we kept the old
> behavior forever.
> 
> I think it's just safer to go with Johannes' suggestion.
> 
> An alternative is, when you have found out you need to read .mailmap,
> you call setup_work_tree() then, which prepares the worktree for you
> (including moving back to cwd) or dies if worktree does not exist, or
> no-op if worktree has already been asked by somebody. Many commands do
> lazy worktree initialization this way.

I think this is much more than just .mailmap, though. For instance, I
have noticed a similar problem with .gitattributes:

  # set up a repo with an attribute
  git init repo
  (
    cd repo &&
    echo content >file &&
    echo "file diff=sed" >.gitattributes &&
    git add . &&
    git commit -m foo &&
    git config diff.sed.textconv 'sed s/^/foo:/'
  )

If I run:

  (cd repo && git log -p)

the diff for "file" shows:

  +foo:content

as expected. But:

  GIT_WORK_TREE=$PWD/repo GIT_DIR=$PWD/repo/.git git log -p

doesn't (while writing this I also noticed that "git log -p file"
doesn't work because of the DWIM lookup. That one is more debatable, but
I still think it makes more sense to move to $GIT_WORK_TREE).

-Peff
