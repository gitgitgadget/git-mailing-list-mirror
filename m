Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E72FC6FD20
	for <git@archiver.kernel.org>; Fri, 24 Mar 2023 19:28:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230157AbjCXT2v (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Mar 2023 15:28:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229734AbjCXT2u (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Mar 2023 15:28:50 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0C451E294
        for <git@vger.kernel.org>; Fri, 24 Mar 2023 12:28:49 -0700 (PDT)
Received: (qmail 6381 invoked by uid 109); 24 Mar 2023 19:28:49 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 24 Mar 2023 19:28:49 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 4810 invoked by uid 111); 24 Mar 2023 19:28:48 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 24 Mar 2023 15:28:48 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 24 Mar 2023 15:28:48 -0400
From:   Jeff King <peff@peff.net>
To:     "Baumann, Moritz" <moritz.baumann@sap.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Feature Request: Option to make "git rev-list --objects" output
 duplicate objects
Message-ID: <20230324192848.GC536967@coredump.intra.peff.net>
References: <AS1PR02MB8185A45DB63216699AFB2C5494849@AS1PR02MB8185.eurprd02.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <AS1PR02MB8185A45DB63216699AFB2C5494849@AS1PR02MB8185.eurprd02.prod.outlook.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 24, 2023 at 03:51:21PM +0000, Baumann, Moritz wrote:

> …and then used the resulting list for all subsequent checks. After writing some
> unit tests, I noticed that the returned list is not sufficient: If you generate
> the exact same file twice, once with a "bad" name and once with a "good" name,
> you will only see one of those names and therefore the hook will mistakenly
> allow the push.
> 
> So, what I would want/need is an option that forces "git rev-list --objects"
> to output the object multiple times if it has multiple names in the commit
> range. Admittedly, such an option would likely only be useful for hooks that
> validate file names.

Another problem you might not have run into yet: the names given by
rev-list are not quoted in any way, and will just omit newlines. So if
your hook is trying to avoid malicious garbage like "foo\nbar", it won't
work.

Those names are really just intended as hints for pack-objects. I
suspect the documentation could be more clear about these limitations.

> Would it be feasible to implement such an option? If so, does it sound like a
> good or bad idea?
> 
> Is there any alternative for my use case that doesn't involve walking the
> commits one-by-one? (That's what we previously did and what turned out to be
> quite slow on our repository.)

I'm not sure what you mean by "one by one", since that is inherently
what rev-list is doing under the hood. If you mean "running a separate
process for each commit", then yes, that will be slow. But if you want
to know all of the names touched in a set of commits, I have used
something like this before:

  git rev-list $new --not --all |
  git diff-tree --stdin --format= -r -c --name-only

A few notes:

  - the names may be quoted if they have metacharacters; use "-z" if
    your reading side can handle it to make things simpler

  - merges are always tricky. I think "-c" will give you what you want
    (showing names which differed from any parent), but I didn't think
    too hard.  Using "-m" definitely would work, but may produce extra
    names (ones where the merge just brought together two lines of
    history, even though the commit where one of those lines touched the
    file may have been excluded via "--not --all").

  - if you are assuming the existing names are good, then probably
    --diff-filter=A would be useful, as it would show only
    newly-introduced names.

-Peff
