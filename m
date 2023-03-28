Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EDFBC6FD18
	for <git@archiver.kernel.org>; Tue, 28 Mar 2023 18:32:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229778AbjC1Sc5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Mar 2023 14:32:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbjC1Sc4 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Mar 2023 14:32:56 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACE0B19A0
        for <git@vger.kernel.org>; Tue, 28 Mar 2023 11:32:54 -0700 (PDT)
Received: (qmail 1406 invoked by uid 109); 28 Mar 2023 18:32:54 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 28 Mar 2023 18:32:54 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 589 invoked by uid 111); 28 Mar 2023 18:32:53 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 28 Mar 2023 14:32:53 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 28 Mar 2023 14:32:53 -0400
From:   Jeff King <peff@peff.net>
To:     "Baumann, Moritz" <moritz.baumann@sap.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Feature Request: Option to make "git rev-list --objects" output
 duplicate objects
Message-ID: <20230328183253.GD18558@coredump.intra.peff.net>
References: <AS1PR02MB8185A45DB63216699AFB2C5494849@AS1PR02MB8185.eurprd02.prod.outlook.com>
 <20230324192848.GC536967@coredump.intra.peff.net>
 <AS1PR02MB8185DF947EBC583318481E1994889@AS1PR02MB8185.eurprd02.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <AS1PR02MB8185DF947EBC583318481E1994889@AS1PR02MB8185.eurprd02.prod.outlook.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Mar 28, 2023 at 08:08:02AM +0000, Baumann, Moritz wrote:

> > But if you want
> > to know all of the names touched in a set of commits, I have used
> > something like this before:
> >
> >   git rev-list $new --not --all |
> >   git diff-tree --stdin --format= -r -c --name-only
> 
> Thanks, that looks promising and solves at least one of my use cases. The only
> minor problem is that there seems to be no way to pipe the diff-tree output to
> cat-file without massaging it with awk first.
> 
> I have three uses cases in my pre-receive hooks:
> 
> 1. Filters solely based on the file name
>    ? your suggestions works perfectly here
> 2. Filters based only on file contents
>    ? git rev-list --objects + git cat-file provide everything I need
> 3. One filter based on file size and name (forbid large files, with exceptions)
>    ? I'm guessing "git rev-list | git diff-tree --stdin | awk |
>      git cat-file --batch-check" is the best solution to extract the necessary
>      information from git in this case?

Yes, that's how I would do all of those. Having to massage the output
between diff-tree and cat-file is a little annoying, but at least can
still be done in O(1) processes. And you really need some language
capable of parsing cat-file output anyway, so it's not too big of a
lift.

One thing we did at GitHub is teach index-pack to collect a list of
too-big paths (since naturally it knows the size of every blob as it
indexes it), and write them out to a special path. Then our pre-receive
hook could quickly check the list and act on it (warning above a certain
size, rejecting above another), without having to traverse again.

I haven't sent those patches upstream, though, for a few reasons:

  - we only hooked index-pack, not unpack-objects (we only use the
    former, not the latter, but in stock Git you might see either)

  - getting just the object names is kind of awkward. You have to then
    invoke rev-list to find the names of hits (though at least you only
    do so when there is a problem object; the happy case remains fast).

  - it's actually not that helpful to avoid the traversal if you have
    other stuff you want to check anyway (like file contents, or names).
    It was one of those things we optimized a long time ago, and I kind
    of doubt is doing much good these days.

-Peff
