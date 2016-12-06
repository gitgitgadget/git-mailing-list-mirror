Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3B0741FC96
	for <e@80x24.org>; Tue,  6 Dec 2016 14:24:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751803AbcLFOYu (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Dec 2016 09:24:50 -0500
Received: from cloud.peff.net ([104.130.231.41]:52426 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751685AbcLFOYs (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Dec 2016 09:24:48 -0500
Received: (qmail 20001 invoked by uid 109); 6 Dec 2016 14:24:47 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 06 Dec 2016 14:24:47 +0000
Received: (qmail 13757 invoked by uid 111); 6 Dec 2016 14:25:25 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 06 Dec 2016 09:25:25 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 06 Dec 2016 09:24:46 -0500
Date:   Tue, 6 Dec 2016 09:24:46 -0500
From:   Jeff King <peff@peff.net>
To:     Matthew Patey <matthew.patey2167@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: Bug: stash staged file move loses original file deletion
Message-ID: <20161206142446.5ba3wc625p5o6nct@sigill.intra.peff.net>
References: <CAFQpxxKbn4vBMzVcLZgBVvuL2fsOGNMHR1WC+aTOG_RAWkZ_Gg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAFQpxxKbn4vBMzVcLZgBVvuL2fsOGNMHR1WC+aTOG_RAWkZ_Gg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Dec 05, 2016 at 09:37:51AM -0500, Matthew Patey wrote:

> Git version 2.8.0 (sorry can't update to more recent on my machine) on Ubuntu.

The behavior is the same on more recent versions of git, too. The short
answer is "use --index". The longer one is below.

> After moving a file, if the new file is in the index but the deletion
> of the old file is not staged, git stash loses the deletion operation.
> Repro:
> 
> 1. git mv a b
> This will have both the "deletion" and the "file added" in the index
> 
> 2. git stash; git stash pop
> Now file a is still in the index, but file b deletion is not staged.
> 
> 3. git stash; git stash show -v
> This will show that the deletion operation is not in the stash
> 
> 4. git stash pop
> Again confirms the issue, file a is in the index, but file b is
> present and unmodified in the working directory.

Thanks for a clear reproduction case. I think the oddball, though, is
not that "b" is not staged for deletion, but that the addition of "a"
_is_ staged.

Applying a stash usually does not re-stage index contents, unless you
specify --index. For example, try:

  # Make a staged change
  echo change >>a
  git add a

  # This puts the change back into the working tree, but does _not_
  # put it into the index.
  git stash apply

  # Now reset to try again.
  git reset --hard

  # This does restore the index.
  git stash apply --index

So in your case, the deletion of "b" is following that same rule. What's
unusual is that "a" is staged. There's code specifically in git-stash
specifically to make sure this is the case, but I don't remember offhand
why this is so. The code comes from the original f2c66ed19 (Add
git-stash script, 2007-06-30), which in turn seems to come from Junio's
comments in:

  http://public-inbox.org/git/7vmyyq2zrz.fsf@assigned-by-dhcp.pobox.com/

I don't see any specific reasoning, but I think it is simply that it is
confusing for the files to become untracked totally. These days we have
intent-to-add via "git add -N", so that might actually be a better
choice for this case.

Anyway, that history digression is neither here nor there for your case.
If you want to restore the index contents, use "--index". That does what
you were expecting:

  $ git mv a b
  $ git stash && git stash apply --index
  Saved working directory and index state WIP on master: 5355755 foo
  HEAD is now at 5355755 foo
  On branch master
  Changes to be committed:
          renamed:    a -> b

-Peff
