Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 468691F403
	for <e@80x24.org>; Tue, 12 Jun 2018 09:35:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933685AbeFLJfg (ORCPT <rfc822;e@80x24.org>);
        Tue, 12 Jun 2018 05:35:36 -0400
Received: from cloud.peff.net ([104.130.231.41]:42222 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S933509AbeFLJfe (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Jun 2018 05:35:34 -0400
Received: (qmail 25495 invoked by uid 109); 12 Jun 2018 09:35:34 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 12 Jun 2018 09:35:34 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 22177 invoked by uid 111); 12 Jun 2018 09:35:49 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 12 Jun 2018 05:35:49 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 12 Jun 2018 05:35:32 -0400
Date:   Tue, 12 Jun 2018 05:35:32 -0400
From:   Jeff King <peff@peff.net>
To:     Crni Gorac <cgorac@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: "linking" to files from another repo
Message-ID: <20180612093532.GA26123@sigill.intra.peff.net>
References: <CAO65DGcYt85sjTkjSK9ERaoMf6n56LG8WJ7q4pWymmaNQ+wLYw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAO65DGcYt85sjTkjSK9ERaoMf6n56LG8WJ7q4pWymmaNQ+wLYw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 12, 2018 at 10:18:31AM +0200, Crni Gorac wrote:

> I'm working on a large closed-source project.  For one of clients, I
> had to create a library that consists of some directories from
> original project, and even within these directories, not all files are
> used for the library.  On top of that, I've added some files specific
> for this library, in separate directories and in the library repo
> top-level directory.  Most of files from original project are
> unchanged, and for some, I had to make some small changes (mostly to
> exclude dependencies on other stuff from the original project).  We're
> now switching to Git from another VCS, and I'm wondering is there any
> way to automatically "link" those pieces from the main project repo
> into my library repo?  So far, I would run update in the main project
> repo, check is any of files that I'm using in library changed, and if
> so, then I would either copy the new version of given file into the
> library (if given file unchanged for the library), or merge updates
> manually (if given file is one of these files that are slightly
> changed for the library), and then commit all these changes in the
> library repo.  None of changes in the library will ever go back into
> the main project, i.e. the flow of updates is uni-directional here.
> So, any support in Git to automate the procedure of updating the
> library with the changes made for corresponding files in the main
> project?

If I understand your case correctly, this is usually solved with a
"vendor" branch type of workflow. E.g.:

  # Import the first version of the library verbatim onto the branch
  # "upstream".
  git init
  git checkout -b upstream
  tar xf the-lib-1.0.tar
  git add .
  git commit -m 'import version 1.0'

  # Now make your changes on master.
  git checkout -b master upstream
  hack hack hack
  git commit -m 'fixed some bits'

  # Time passes. You want to import 1.1. Do this on the upstream branch,
  # where we know that we can overwrite the state completely (since we
  # are replacing upstream's 1.0 with their 1.1).
  git checkout upstream
  rm -rf *
  tar xf the-lib-1.1.tar
  git add -A
  git commit -m 'import version 1.1'

  # And now you can merge 1.1 into your master branch. The git history
  # you've created reflects two lines of development: upstream's and
  # your custom changes. So merging will never "undo" the changes you've
  # made (but you'll probably see conflicts if you deleted a file and
  # upstream changed it, for example).
  git checkout master
  git merge upstream

Note that your "master" branch doesn't have to be _just_ the changes to
upstream. It can actually be your whole project, complete with changes
to the upstream library.

-Peff
