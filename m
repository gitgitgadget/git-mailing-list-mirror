Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1892FC433B4
	for <git@archiver.kernel.org>; Wed,  5 May 2021 18:32:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EBA93613C4
	for <git@archiver.kernel.org>; Wed,  5 May 2021 18:32:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234640AbhEESdd (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 May 2021 14:33:33 -0400
Received: from cloud.peff.net ([104.130.231.41]:45692 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234089AbhEESdd (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 May 2021 14:33:33 -0400
Received: (qmail 19603 invoked by uid 109); 5 May 2021 18:32:35 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 05 May 2021 18:32:35 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 12528 invoked by uid 111); 5 May 2021 18:32:36 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 05 May 2021 14:32:36 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 5 May 2021 14:32:35 -0400
From:   Jeff King <peff@peff.net>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Theodor Negrescu <theodor.negrescu@gmail.com>,
        Git List <git@vger.kernel.org>
Subject: Re: BUG: Git path --config doesn't work with ~ symbol
Message-ID: <YJLkw59nxAU6/vVT@coredump.intra.peff.net>
References: <CAEumJaDRvU8LP=q3PQ1z6-cg75DmbHE_7OXZVA+nm=-77pVLEg@mail.gmail.com>
 <YJLgmXS/fJm1BQb4@coredump.intra.peff.net>
 <CAPig+cTX179z5MrTvSmgYGzZdc4xz=2G_ffHsyVOXsKVHrL93w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAPig+cTX179z5MrTvSmgYGzZdc4xz=2G_ffHsyVOXsKVHrL93w@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 05, 2021 at 02:21:38PM -0400, Eric Sunshine wrote:

> On Wed, May 5, 2021 at 2:14 PM Jeff King <peff@peff.net> wrote:
> > On Wed, May 05, 2021 at 09:06:12PM +0300, Theodor Negrescu wrote:
> > > I ran the command "git config --file ~/git-settings/.gitconfig -l"
> > > (git-settings is a repo where I keep my config, the global one is just
> > > an include)
> >
> > I don't think this is a bug in git-config. It is generally the shell
> > that is responsible for expanding "~" and passing along the result to
> > commands. E.g.:
> >
> >   $ strace -e execve git config --file ~/foo --list
> >   execve("/home/peff/local/git/current/bin/git", ["git", "config", "--file", "/home/peff/foo", "--list"], 0x7ffc10a88130 /* 55 vars */) = 0
> >
> > I'd guess this might be related to Windows somehow. Are you entering the
> > command in a bash shell, or via some other mechanism?
> 
> Is OPT_FILENAME supposed to handle tilde-expansion? I ask because
> git-config is using OPT_STRING for this option, whereas other commands
> use OPT_FILENAME for their `--file` options.

No, I don't think so. The point of OPT_FILENAME() is that it handles the
directory-change from setting up the git directory before we even the
the cmd_*() function.

But that isn't necessary here, because cmd_config() applies the prefix
manually. So this works as expected:

  $ git init
  $ mkdir subdir
  $ git config --file=foo my.dir root
  $ git config --file=subdir/foo my.dir sub
  $ git config --file=foo --list
  my.dir=root
  $ cd subdir
  $ git config --file=foo --list
  my.dir=sub

Possibly the code could be simplified a little by using OPT_FILENAME(),
though.

-Peff
