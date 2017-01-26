Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6CAD21F70F
	for <e@80x24.org>; Thu, 26 Jan 2017 21:12:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753416AbdAZVMJ (ORCPT <rfc822;e@80x24.org>);
        Thu, 26 Jan 2017 16:12:09 -0500
Received: from cloud.peff.net ([104.130.231.41]:45566 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751880AbdAZVMI (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Jan 2017 16:12:08 -0500
Received: (qmail 30082 invoked by uid 109); 26 Jan 2017 21:12:07 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 26 Jan 2017 21:12:07 +0000
Received: (qmail 27757 invoked by uid 111); 26 Jan 2017 21:12:07 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 26 Jan 2017 16:12:07 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 26 Jan 2017 16:12:05 -0500
Date:   Thu, 26 Jan 2017 16:12:05 -0500
From:   Jeff King <peff@peff.net>
To:     Kyle Meyer <kyle@kyleam.com>
Cc:     git@vger.kernel.org
Subject: Re: HEAD's reflog entry for a renamed branch
Message-ID: <20170126211205.5gz3zsrptop7n34n@sigill.intra.peff.net>
References: <87pojmwq5y.fsf@kyleam.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87pojmwq5y.fsf@kyleam.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jan 16, 2017 at 06:17:29PM -0500, Kyle Meyer wrote:

> I noticed that, after renaming the current branch, the corresponding
> message in .git/logs/HEAD is empty.
> 
> For example, running
> 
>     $ mkdir test-repo
>     $ cd test-repo
>     $ git init
>     $ echo abc >file.txt
>     $ git add file.txt
>     $ git commit -m"Add file.txt"
>     $ git branch -m master new-master

Thanks for providing a simple reproduction recipe.

> resulted in the following reflogs:
> 
>    $ cat .git/logs/refs/heads/new-master
>    00000... 68730... Kyle Meyer <kyle@kyleam.com> 1484607020 -0500	commit (initial): Add file.txt
>    68730... 68730... Kyle Meyer <kyle@kyleam.com> 1484607020 -0500	Branch: renamed refs/heads/master to refs/heads/new-master
> 
>    $ cat .git/logs/HEAD
>    00000... 68730... Kyle Meyer <kyle@kyleam.com> 1484607020 -0500	commit (initial): Add file.txt
>    68730... 00000... Kyle Meyer <kyle@kyleam.com> 1484607020 -0500
> 
> I expected the second line of .git/logs/HEAD to mirror the second line
> of .git/logs/refs/heads/new-master.  Are the empty message and null sha1
> in HEAD's entry intentional?

The null sha1 is correct, I think. The branch we were on went away, and
we use the null sha1 to indicate "no value" in both the creation and
deletion cases.

It's unfortunate that there's no message. This is because the rename
calls delete_ref() under the hood, but that function doesn't take a
reflog message argument at all. It usually doesn't matter because
deleting the ref will also delete the reflog.

But as your example shows, deletions _can_ get logged in the HEAD
reflog; the low-level ref code detects when HEAD points to the updated
ref and logs an entry there, too.

You can see the same thing with a simpler example:

  $ git init
  $ git commit -m foo --allow-empty
  $ git update-ref -d refs/heads/master
  $ cat .git/logs/HEAD
  00000...  8ffd1... Jeff King <peff@peff.net> 1485464779 -0500	commit (initial): foo
  8ffd1...  00000... Jeff King <peff@peff.net> 1485464787 -0500

This doesn't come up much because most porcelain commands will refuse to
delete the current branch (notice I had to use "update-ref" and not
"branch -d").

I'd say there are two potential improvements:

  - delete_ref() should take a reflog message argument, in case it
    updates the HEAD reflog (as a bonus, this will future-proof us for a
    day when we might keep reflogs for deleted refs).

  - "git branch -m" does seem to realize when we are renaming HEAD,
    because it updates HEAD to point to the new branch name. But it
    should probably insert another reflog entry mentioning the rename
    (we do for "git checkout foo", even when "foo" has the same sha1 as
    the current HEAD).

-Peff
