Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 373F4C07E96
	for <git@archiver.kernel.org>; Tue, 13 Jul 2021 21:13:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1B99A60FE9
	for <git@archiver.kernel.org>; Tue, 13 Jul 2021 21:13:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235534AbhGMVQb (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 13 Jul 2021 17:16:31 -0400
Received: from cloud.peff.net ([104.130.231.41]:48258 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229478AbhGMVQb (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Jul 2021 17:16:31 -0400
Received: (qmail 12033 invoked by uid 109); 13 Jul 2021 21:13:41 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 13 Jul 2021 21:13:41 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 14097 invoked by uid 111); 13 Jul 2021 21:13:41 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 13 Jul 2021 17:13:41 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 13 Jul 2021 17:13:40 -0400
From:   Jeff King <peff@peff.net>
To:     Jiang Xin <worldhello.net@gmail.com>
Cc:     Patrick Steinhardt <psteinhardt@gitlab.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Junio C Hamano <gitster@pobox.com>,
        Git List <git@vger.kernel.org>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>
Subject: Re: [PATCH] revision: allow pseudo options after --end-of-options
Message-ID: <YO4CBKuwCEL4Xdzg@coredump.intra.peff.net>
References: <20210708150316.10855-1-worldhello.net@gmail.com>
 <YOcvaFL7+6qcIOUa@camp.crustytoothpaste.net>
 <CANYiYbGYzbMoU_2wb4duppASoYUjGLsJsr692Xe3GaVBOXUsBA@mail.gmail.com>
 <YOoXCJV2ssef/KsN@camp.crustytoothpaste.net>
 <YOyByjmGu1oDXK4X@coredump.intra.peff.net>
 <CANYiYbF3dcOzZ5gqbYkstxv+WRxZwnoxoNP28A6px44YD98k1Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CANYiYbF3dcOzZ5gqbYkstxv+WRxZwnoxoNP28A6px44YD98k1Q@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jul 13, 2021 at 04:57:46PM +0800, Jiang Xin wrote:

> > Though in my experience it is usually a static "--not --all" or "--not
> > --branches --tags" or similar in such a function. I don't think I've
> > ever seen a case quite like the code above in practice.
> 
> Last week, I made a study on how gitlab wrap and execute a git
> command. I saw the following code [1]:
> 
>     if c.supportsEndOfOptions() {
>         commandArgs = append(commandArgs, "--end-of-options")
>     }
>     if len(postSepArgs) > 0 {
>         commandArgs = append(commandArgs, "--")
>     }
> 
> I was surprised to see the options "--end-of-options" and "--" used
> next to each other, and the DashDash option ("--") is not mandatory.

I think using --end-of-options there is pointless. The "--" will always
signal the end of options (_and_ revisions). So if there is nothing
between the two, then the former cannot be doing anything.

For programmatic use, I do think one should always use "--". Even if
there are no paths, it makes it clear that the arguments before it are
meant to be revisions. This matters a little less in a bare repo, I
think (because we do not have a working tree to try to DWIM-match the
paths in), but it's good practice in general.

I don't think you can just blindly add "--" in such a function, though.
It depends on what the interface of the function is (i.e., are its
callers passing in options, revisions, and pathspecs as separate data
structures). It does look like you're going in that direction below,
though.

> I
> want to make some changes on it, but when I try to construct a git
> command like this:
> 
>     git.SubCmd{
>         Name: "log",
>         Flags: []git.Option{
>             git.Flag{
>                     Name: "--stat"
>             },
>             git.ValueFlag{
>                     Name: "--pretty",
>                     Value: "%m %s",
>             },
>             git.Flag{
>                     Name: "--no-decorate",
>             },
>         },
>         Args: []string {
>             "topic1",
>             "--not",
>             "main",
>             "release",
>         },
>         PostSepArgs: []string {
>             "src/hello.c",
>             "doc",
>         },
>     }
> 
> The generated git command will be:
> 
>     git log --stat --pretty="%m %s" --no-decorate \
>         topic1 --not main release \
>         --end-of-options \
>         -- \
>         src/hello.c doc
> 
> It works.

Right, but you are not getting any protection against "topic1" being an
option. The --end-of-options is doing nothing.

> But if I move the "--end-of-options" before the revisions like this:
> 
>     git log --stat --pretty="%m %s" --no-decorate \
>         --end-of-options \
>        topic1 --not main release \
>         -- \
>         src/hello.c doc
> 
> The generated command failed to execute with error: unknown revision "--not".
> 
> It's reasonable for gitlab to construct git commands using mainly three fields:
> 1. Flags: for options like "--option", or "--key value".
> 2. Args: for args like revisions.
> 3. PostSepArgs: for pathspecs.
> 
> And if the command supports these options, it's better to add
> "--end-of-options" between 1 and 2, and add "--" between 2 and 3.

Yeah, so the problem there is that the definition of "Args" is kind of
fuzzy. Sometimes it is useful to include stuff like "--not", and
sometimes it is dangerous or unexpected. Later you say:

> If we can handle revision pseudo opts as pseudo revisions instead of
> options as in this patch, the only disadvantage is that we cannot
> handle branches whose names conflict with well-known options such as
> "--not" and "--all". But users can input full branch names, such as
> "refs/heads/--not", "refs/heads/--all".

but the point of --end-of-options is that you do not necessarily trust
the caller (or the user) to have prefixes with "refs/heads/" as
appropriate. It is about telling Git unambiguously what the various bits
on the command-line mean so that it knows how to correctly interpret
them.

It might be worthwhile to split the function interface into two sets:
positive and negative traversal tips. And then the function can turn:

  {
    Options: { "--stat" }
    Tips: { "topic1" }
    Not-Tips: { "main", "release" }
    Pathspecs: { "src/hello.c }
  }

into:

  git rev-list --stat --end-of-options topic1 ^main ^release -- src/hello.c

which is unambiguous, even if "--not" appears in "Tips". (You can also
keep a single Args array, but then the caller is responsible for putting
in the "^" markers).

-Peff
