Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 740561F597
	for <e@80x24.org>; Tue, 31 Jul 2018 15:50:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732467AbeGaRbZ (ORCPT <rfc822;e@80x24.org>);
        Tue, 31 Jul 2018 13:31:25 -0400
Received: from cloud.peff.net ([104.130.231.41]:37098 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1732417AbeGaRbZ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Jul 2018 13:31:25 -0400
Received: (qmail 26373 invoked by uid 109); 31 Jul 2018 15:50:29 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 31 Jul 2018 15:50:29 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 1408 invoked by uid 111); 31 Jul 2018 15:50:31 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 31 Jul 2018 11:50:31 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 31 Jul 2018 11:50:28 -0400
Date:   Tue, 31 Jul 2018 11:50:28 -0400
From:   Jeff King <peff@peff.net>
To:     George Shammas <georgyo@gmail.com>
Cc:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>, git@vger.kernel.org
Subject: Re: git merge -s subtree seems to be broken.
Message-ID: <20180731155027.GA16910@sigill.intra.peff.net>
References: <CAF1Ko+FBP5UmETmh071dvn9iv8-N-3YgaP61q-4jQvxFdN0GTA@mail.gmail.com>
 <CAF1Ko+FNfjWMteccfKDBjPEW76rGBLQkGb1icUHmzEZ0fKQJBA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAF1Ko+FNfjWMteccfKDBjPEW76rGBLQkGb1icUHmzEZ0fKQJBA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jul 31, 2018 at 11:03:17AM -0400, George Shammas wrote:

> Bisecting around, this might be the commit that introduced the breakage.
> 
> https://github.com/git/git/commit/d8febde
> 
> I really hope that it hasn't been broken for 5 years and I am just doing
> something wrong.

Unfortunately, I think it has been broken for five years.

The problem introduced in that commit is that each iteration through the
loop advances the tree pointers. But when we're walking two lists and
see that one omits an entry the other has, we have to advance _one_ list
and keep the other where it is. So if we instrument the score_*
functions to see which ones trigger, your reproduction gives this with
the original code:

  warning: scoring trees:
    8e12d9b6bc57fe6308315914628dd4fd7665ca59
    aed1d7c5809e53d49b52c43a6103827046d60286
  warning: score_matches: .bookignore
  warning: score_matches: .gitignore
  warning: score_matches: .mailmap
  warning: score_differs: .travis.yml
  warning: score_matches: COPYING
  warning: score_differs: INSTALL.adoc
  warning: score_differs: Makefile
  warning: score_differs: NEWS.adoc
  warning: score_differs: README.adoc
  warning: score_missing: appveyor.yml
  warning: score_matches: autogen.sh
  warning: score_matches: book.json
  [...]

and the new one does:

  warning: scoring trees:
    8e12d9b6bc57fe6308315914628dd4fd7665ca59
    aed1d7c5809e53d49b52c43a6103827046d60286
  warning: score_matches: .bookignore
  warning: score_matches: .gitignore
  warning: score_matches: .mailmap
  warning: score_differs: .travis.yml
  warning: score_matches: COPYING
  warning: score_differs: INSTALL.adoc
  warning: score_differs: Makefile
  warning: score_differs: NEWS.adoc
  warning: score_differs: README.adoc
  warning: score_missing: appveyor.yml
  warning: score_missing: autogen.sh
  warning: score_missing: book.json

We're fine at first, but as soon as one tree has appveyor.yml and the
other doesn't, we get out of sync. We compare "autogen" and "appveyor",
and realize that they do not match. But then we need to increment
pointer for the tree with "appveyor" only, and leave the other in place,
at which point we'd realize that they both have "autogen". Instead, we
increment both, and after that we compare "autogen.sh" to "book.json",
and so on.

So the assertion in that commit message that "the calls to
update_tree_entry() are not needed any more" is just wrong. We have
decide whether to call it based on the "cmp" value.

I quoted your original reproduction below for the benefit of René
(cc'd).

-Peff

> On Tue, Jul 31, 2018 at 10:09 AM George Shammas <georgyo@gmail.com> wrote:
> 
> > At work, we recently updated from a massively old version of git (1.7.10)
> > to 2.18. There are a few code bases that use subtrees, and they seem to
> > have completely broke when trying to merge in updates.
> >
> > I have confirmed that it works correctly in 1.7.10.  The 2.18 behavior is
> > clearly incorrect.
> >
> > git init
> > echo init > test
> > git add test
> > git commit -m init
> >
> > git remote add tig https://github.com/jonas/tig.git
> > git fetch tig
> > git merge -s ours --no-commit --allow-unrelated-histories tig-2.3.0
> > git read-tree --prefix=src/ -u tig-2.3.0
> > git commit -m "Get upstream tig-2.3.0"
> > # Notice how the history are merged, and that the source from the upstream
> > repo is in src
> >
> > echo update > test
> > git commit -a -m "test"
> >
> > git merge -s subtree tig-2.4.0
> > # Boom, in 2.18 instead of merging into the subtree, it just deletes
> > everything in the repository, which is clearly the wrong behavior.
> >
