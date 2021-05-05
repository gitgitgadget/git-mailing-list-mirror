Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CA11C433B4
	for <git@archiver.kernel.org>; Wed,  5 May 2021 18:14:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4F184613BA
	for <git@archiver.kernel.org>; Wed,  5 May 2021 18:14:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234162AbhEESPs (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 May 2021 14:15:48 -0400
Received: from cloud.peff.net ([104.130.231.41]:45648 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230247AbhEESPr (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 May 2021 14:15:47 -0400
Received: (qmail 19529 invoked by uid 109); 5 May 2021 18:14:50 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 05 May 2021 18:14:50 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 12167 invoked by uid 111); 5 May 2021 18:14:50 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 05 May 2021 14:14:50 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 5 May 2021 14:14:49 -0400
From:   Jeff King <peff@peff.net>
To:     Theodor Negrescu <theodor.negrescu@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: BUG: Git path --config doesn't work with ~ symbol
Message-ID: <YJLgmXS/fJm1BQb4@coredump.intra.peff.net>
References: <CAEumJaDRvU8LP=q3PQ1z6-cg75DmbHE_7OXZVA+nm=-77pVLEg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAEumJaDRvU8LP=q3PQ1z6-cg75DmbHE_7OXZVA+nm=-77pVLEg@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 05, 2021 at 09:06:12PM +0300, Theodor Negrescu wrote:

> What did you do before the bug happened? (Steps to reproduce your issue)
> 
> I ran the command "git config --file ~/git-settings/.gitconfig -l"
> (git-settings is a repo where I keep my config, the global one is just
> an include)
> 
> What did you expect to happen? (Expected behavior)
> 
> It would list the settings in the file.
> 
> What happened instead? (Actual behavior)
> 
> fatal: unable to read config file '~/git-settings/.gitconfig': No such
> file or directory
> 
> What's different between what you expected and what actually happened?
> 
> The ~ symbol should point to my home folder.

I don't think this is a bug in git-config. It is generally the shell
that is responsible for expanding "~" and passing along the result to
commands. E.g.:

  $ strace -e execve git config --file ~/foo --list
  execve("/home/peff/local/git/current/bin/git", ["git", "config", "--file", "/home/peff/foo", "--list"], 0x7ffc10a88130 /* 55 vars */) = 0

> [System Info]
> git version:
> git version 2.31.1.windows.1
> cpu: x86_64
> built from commit: c5f0be26a7e3846e3b6268d1c6c4800d838c6bbb
> sizeof-long: 4
> sizeof-size_t: 8
> shell-path: /bin/sh
> feature: fsmonitor--daemon
> uname: Windows 10.0 19042
> compiler info: gnuc: 10.2
> libc info: no libc information available
> $SHELL (typically, interactive shell): <unset>

I'd guess this might be related to Windows somehow. Are you entering the
command in a bash shell, or via some other mechanism?

-Peff
