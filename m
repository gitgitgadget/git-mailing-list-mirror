Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D6B5C433B4
	for <git@archiver.kernel.org>; Fri,  7 May 2021 23:05:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 13664613C8
	for <git@archiver.kernel.org>; Fri,  7 May 2021 23:05:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229925AbhEGXGT (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 7 May 2021 19:06:19 -0400
Received: from cloud.peff.net ([104.130.231.41]:47744 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229812AbhEGXGT (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 May 2021 19:06:19 -0400
Received: (qmail 4755 invoked by uid 109); 7 May 2021 23:05:19 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 07 May 2021 23:05:19 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 5529 invoked by uid 111); 7 May 2021 23:05:19 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 07 May 2021 19:05:19 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 7 May 2021 19:05:17 -0400
From:   Jeff King <peff@peff.net>
To:     Elijah Newren <newren@gmail.com>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>
Subject: Re: [PATCH 1/5] t7300: add testcase showing unnecessary traversal
 into ignored directory
Message-ID: <YJXHrXWVDSgg5TZw@coredump.intra.peff.net>
References: <pull.1020.git.git.1620360300.gitgitgadget@gmail.com>
 <a3bd253fa8e8ae47d19beb35327d8283ffa49289.1620360300.git.gitgitgadget@gmail.com>
 <CAPig+cTzvKhUaNEXwRAVwV1Vkb7jpHNkcOytEPq0Gg33TrJXNg@mail.gmail.com>
 <CABPp-BGzUBF8S8t3nixi3TCkiBe7oS1fQ5cNCozicb20iZxshA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CABPp-BGzUBF8S8t3nixi3TCkiBe7oS1fQ5cNCozicb20iZxshA@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, May 06, 2021 at 10:00:49PM -0700, Elijah Newren wrote:

> > > +               >directory-random-file.txt &&
> > > +               # Put this file under directory400/directory399/.../directory1/
> > > +               depth=400 &&
> > > +               for x in $(test_seq 1 $depth); do
> > > +                       mkdir "tmpdirectory$x" &&
> > > +                       mv directory* "tmpdirectory$x" &&
> > > +                       mv "tmpdirectory$x" "directory$x"
> > > +               done &&
> >
> > Is this expensive/slow loop needed because you'd otherwise run afoul
> > of command-line length limits on some platforms if you tried creating
> > the entire mess of directories with a single `mkdir -p`?
> 
> The whole point is creating a path long enough that it runs afoul of
> limits, yes.
> 
> If we had an alternative way to check whether dir.c actually recursed
> into a directory, then I could dispense with this and just have a
> single directory (and it could be named a single character long for
> that matter too), but I don't know of a good way to do that.  (Some
> possiibilities I considered along that route are mentioned at
> https://lore.kernel.org/git/CABPp-BF3e+MWQAGb6ER7d5jqjcV=kYqQ2stM_oDyaqvonPPPSw@mail.gmail.com/)

I don't have a better way of checking the dir.c behavior. But I think
the other half of Eric's question was: why can't we do this setup way
more efficiently with "mkdir -p"?

I'd be suspicious that it would work portably because of the long path.
But I think the perl I showed earlier would create it in much less time:

  $ touch directory-file
  $ time sh -c '
      for x in $(seq 1 400)
      do
        mkdir tmpdirectory$x &&
	mv directory* tmpdirectory$x &&
	mv tmpdirectory$x directory$x
      done
    '
    real	0m2.222s
    user	0m1.481s
    sys		0m0.816s

  $ time perl -e '
      for (reverse 1..400) {
        my $d = "directory$_";
	mkdir($d) and chdir($d) or die "mkdir($d): $!";
      }
      open(my $fh, ">", "some-file");
    '
    real	0m0.010s
    user	0m0.001s
    sys		0m0.009s

-Peff
