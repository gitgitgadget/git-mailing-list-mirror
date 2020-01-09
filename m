Return-Path: <SRS0=y4cH=26=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27AA4C32771
	for <git@archiver.kernel.org>; Thu,  9 Jan 2020 08:11:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB64A20673
	for <git@archiver.kernel.org>; Thu,  9 Jan 2020 08:11:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728340AbgAIILv (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Jan 2020 03:11:51 -0500
Received: from cloud.peff.net ([104.130.231.41]:60882 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1728267AbgAIILv (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Jan 2020 03:11:51 -0500
Received: (qmail 27730 invoked by uid 109); 9 Jan 2020 08:11:51 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 09 Jan 2020 08:11:51 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 16312 invoked by uid 111); 9 Jan 2020 08:17:34 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 09 Jan 2020 03:17:34 -0500
Authentication-Results: peff.net; auth=none
Date:   Thu, 9 Jan 2020 03:11:50 -0500
From:   Jeff King <peff@peff.net>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] clone: teach --single-branch and --branch during
 --recurse
Message-ID: <20200109081150.GC3978837@coredump.intra.peff.net>
References: <20200108231900.192476-1-emilyshaffer@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200108231900.192476-1-emilyshaffer@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 08, 2020 at 03:19:00PM -0800, Emily Shaffer wrote:

> Subject: clone: teach --single-branch and --branch during --recurse

A minor nit, but this subject confused me for a moment. I think we'd
usually say "teach" for a new feature being implemented, and this is
really just about passing along the existing features. Something like:

  clone: pass --single-branch and --branch when recursing submodules

would have been a bit more obvious (to me anyway).

> Previously, performing "git clone --recurse-submodules --single-branch"
> resulted in submodules cloning all branches even though the superproject
> cloned only one branch. Pipe --single-branch and its friend, --branch,
> through the submodule helper framework to make it to 'clone' later on.

Since I don't really use submodules, I don't have much data or even
intuition to go on. But could this be a regression for some situations?
E.g., imagine I have a repo "parent" whose branch "foo" has a submodule
"child", but "child" only has a branch "bar". What happens now if I "git
clone --recurse-submodules --single-branch -b foo parent", and what will
happen after this patch?

I think it works before, but doesn't now.

Setting up like this:

  git init child
  (
  	cd child
  	git checkout -b bar
  	echo whatever >file
  	git add file
  	git commit -m 'child commit'
  )
  
  git init parent
  cd parent
  git checkout -b foo
  git submodule add $PWD/../child
  git commit -m 'add submodule'

if I use the current tip of master, I get:

  $ git clone --recurse-submodules --single-branch -b foo parent cur
  Cloning into 'cur'...
  done.
  Submodule 'child' (/home/peff/tmp/parent/../child) registered for path 'child'
  Cloning into '/home/peff/tmp/cur/child'...
  done.
  Submodule path 'child': checked out 'b5cbfcc9fec3b7d67e305468624fed2ba1aa4758'

  $ git -C cur/child log -1 --oneline | cat
  b5cbfcc child commit

with your patch, I get:

  $ git.compile clone --recurse-submodules --single-branch -b foo parent new
  Cloning into 'new'...
  done.
  Submodule 'child' (/home/peff/tmp/parent/../child) registered for path 'child'
  Cloning into '/home/peff/tmp/new/child'...
  warning: Could not find remote branch foo to clone.
  fatal: Remote branch foo not found in upstream origin
  fatal: clone of '/home/peff/tmp/parent/../child' into submodule path '/home/peff/tmp/new/child' failed
  Failed to clone 'child'. Retry scheduled
  Cloning into '/home/peff/tmp/new/child'...
  warning: Could not find remote branch foo to clone.
  fatal: Remote branch foo not found in upstream origin
  fatal: clone of '/home/peff/tmp/parent/../child' into submodule path '/home/peff/tmp/new/child' failed
  Failed to clone 'child' a second time, aborting

  $ git -C new/child log -1 --oneline | cat
  11acb3a add submodule

(there's nothing checked out in the submodule).

I have no idea how common this kind of thing would be, and I expect in
most cases your patch would do what people want. But we might need to be
better about retrying without those options when the first clone fails.

-Peff
