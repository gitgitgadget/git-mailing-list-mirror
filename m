Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1BF331F463
	for <e@80x24.org>; Wed, 11 Sep 2019 18:05:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729744AbfIKSFD (ORCPT <rfc822;e@80x24.org>);
        Wed, 11 Sep 2019 14:05:03 -0400
Received: from cloud.peff.net ([104.130.231.41]:46794 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1729145AbfIKSFD (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Sep 2019 14:05:03 -0400
Received: (qmail 16534 invoked by uid 109); 11 Sep 2019 18:05:02 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 11 Sep 2019 18:05:02 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 27023 invoked by uid 111); 11 Sep 2019 18:07:00 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 11 Sep 2019 14:07:00 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 11 Sep 2019 14:05:01 -0400
From:   Jeff King <peff@peff.net>
To:     Konstantinos Dalamagkidis <konstantinos@dalamagkidis.info>
Cc:     git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Git.pm normalizes $GIT_DIR, was Re: git-send-email does not use
 conditional configuration
Message-ID: <20190911180501.GA26087@sigill.intra.peff.net>
References: <CANTPZbbLNJPEEeG8BgdDEVYS=gudz4SvqGe==28EQHXDXUxuwQ@mail.gmail.com>
 <20190911140833.GA13916@sigill.intra.peff.net>
 <d4717b7f-b7a4-208b-6b83-7993b6bd7886@dalamagkidis.info>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d4717b7f-b7a4-208b-6b83-7993b6bd7886@dalamagkidis.info>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 11, 2019 at 06:58:26PM +0200, Konstantinos Dalamagkidis wrote:

> I am using "includeIf.gitdir:/work". I tried to reproduce it at my home
> workstation where I have the exact same configuration, but in the beginning
> I couldn't. Then I realized, that at work the /work folder is actually a
> symlink to a different directory. When I did the same at home, I could
> reproduce the issue:
> 
> % pwd
> /work/repo
> % git send-email --dry-run -1 --to nobody | grep ^From
> From: Konstantinos Dalamagkidis <work-email@example.com>
> % cd ../repo-symlink
> % git send-email --dry-run -1 --to nobody | grep ^From
> From: Konstantinos Dalamagkidis <personal-email@example.com>
> % realpath .
> /home/dalamagkidis/tmp/repo
> 
> It appears that git-config and git-send-email parse the gitdir slightly
> differently when it comes to symlinks. More specifically git-send-email uses
> the realpath of the repository to determine which configuration to use. It
> also explains why nobody came across this problem before.

Ah, that's interesting. In both cases it's git-config who is doing the
path comparison. And it should be happy with either form due to
0624c63ce6 (config: match both symlink & realpath versions in
IncludeIf.gitdir:*, 2017-05-16).

But if send-email is normalizing the path and setting $GIT_DIR before we
even hit git-config, then that would fool it (git-config never even sees
the symlinked path). And that seems to be the case, which is due to the
Git.pm perl module. Running:

  git init repo
  ln -s repo link
  cd link
  git config alias.env '!echo $GIT_DIR'
  perl -MGit -le '
    my $repo = Git->repository();
    print "env=", $repo->command(qw(env));
    print "resolved=", $repo->command(qw(rev-parse --git-dir));
  '

gives me:

  env=/home/peff/tmp/repo/.git
  resolved=/home/peff/tmp/repo/.git

I'd argue that Git.pm probably shouldn't be setting $GIT_DIR at all when
we've auto-discovered the repo from the current directory (instead all
of the sub-programs should just do their own auto-discovery). But even
if we feed the constructor another repository path, it probably should
be keeping what it puts in $GIT_DIR as close to what it was original
given.

I'll admit I'm slightly afraid to touch Git.pm at all, though. It's old,
rarely touched code that I suspect has poor test coverage. But I'll cc
Ævar, who was the most recent brave person. ;)

-Peff
