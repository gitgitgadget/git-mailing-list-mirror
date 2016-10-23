Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DDFE820987
	for <e@80x24.org>; Sun, 23 Oct 2016 09:30:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754826AbcJWJag (ORCPT <rfc822;e@80x24.org>);
        Sun, 23 Oct 2016 05:30:36 -0400
Received: from cloud.peff.net ([104.130.231.41]:33184 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753174AbcJWJaf (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 23 Oct 2016 05:30:35 -0400
Received: (qmail 11027 invoked by uid 109); 23 Oct 2016 09:30:34 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sun, 23 Oct 2016 09:30:34 +0000
Received: (qmail 17347 invoked by uid 111); 23 Oct 2016 09:30:57 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sun, 23 Oct 2016 05:30:57 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 23 Oct 2016 05:30:32 -0400
Date:   Sun, 23 Oct 2016 05:30:32 -0400
From:   Jeff King <peff@peff.net>
To:     Sven Strickroth <sven@cs-ware.de>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Subject: Re: Stash pop/apply conflict and --theirs and --ours
Message-ID: <20161023093032.iahc3itg6a5rqtdf@sigill.intra.peff.net>
References: <169639c9-054f-8f4c-26bd-3f130fa4c1ee@cs-ware.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <169639c9-054f-8f4c-26bd-3f130fa4c1ee@cs-ware.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Oct 23, 2016 at 12:58:12AM +0200, Sven Strickroth wrote:

> I regularly experience that beginners have problems unterstanding that
> --ours and --theirs are swapped when a conflict occurrs on git stash
> apply or stash pop.
> 
> From the HCI perspective this is really counter intuitive.

I know that people have complained about "rebase" swapping the two, but
I don't think anybody has ever mentioned it for stash. I'm not sure I
that they are swapped, though.

The "ours" content is generally what was in the HEAD before the
operation started, and "theirs" is what the operation is bringing into
that history. That is true of "merge" and "cherry-pick". And AFAICT, it
is true of "stash", too (I basically think of "stash apply" as a
cherry-pick).

So with a setup like:

  git init
  echo base >file
  git add file
  git commit -m file

  echo stash >file
  git stash

  echo master >file
  git commit -am master

  git checkout -b branch HEAD^
  echo branch >file
  git commit -am branch

if we merge, then --theirs is the branch we are merging:

  git checkout master
  git merge branch
  git checkout --theirs file
  cat file
  # "branch"

Likewise, if we cherry-pick:

  git reset --hard
  git cherry-pick branch
  git checkout --theirs file
  cat file
  # "branch"

And likewise if we apply the stash:

  git reset --hard
  git stash apply
  git checkout --theirs file
  cat file
  # "stash"

So that seems consistent to me.

I guess if you are stashing in order to pull somebody else's work, like:

  git stash
  git pull
  git stash pop

then conceptually the stash is "ours" and HEAD is "theirs". This is
exactly like the rebase case. E.g., if you instead did:

  git commit -m 'tmp stash'
  git pull --rebase

So I sympathize, but I don't think that having "stash" flip the order
would be the right thing to do in all cases. In theory there could be
some kind of option (and things like pull autostash could use it), but I
suspect it may be hard to implement in practice. The unpack-trees code
does not treat "ours" and "theirs" entirely symmetrically (the "ours"
side represents the current working tree, so we might do things like
check whether the index is fresh). I guess you could flip the "1" and
"2" bits in the index after the conflicted merge completes.

I'm still not convinced it's a good idea, though.

-Peff
