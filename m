Return-Path: <SRS0=WCE0=5E=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7F8DC4332B
	for <git@archiver.kernel.org>; Thu, 19 Mar 2020 16:51:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94133206D7
	for <git@archiver.kernel.org>; Thu, 19 Mar 2020 16:51:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728047AbgCSQvu (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 19 Mar 2020 12:51:50 -0400
Received: from cloud.peff.net ([104.130.231.41]:44074 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727146AbgCSQvu (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Mar 2020 12:51:50 -0400
Received: (qmail 26153 invoked by uid 109); 19 Mar 2020 16:51:50 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 19 Mar 2020 16:51:50 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 28893 invoked by uid 111); 19 Mar 2020 17:01:29 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 19 Mar 2020 13:01:29 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 19 Mar 2020 12:51:49 -0400
From:   Jeff King <peff@peff.net>
To:     Eric Wong <e@yhbt.net>
Cc:     Timothee Cour <timothee.cour2@gmail.com>, git@vger.kernel.org
Subject: Re: git makes it impossible to ignore or override global gitconfig,
 needs `GITCONFIGFILE`
Message-ID: <20200319165149.GA4074934@coredump.intra.peff.net>
References: <CANri+Ey71QbWxNH+RhMfYuUSDEpYtv28ushUhK8Tt0xWUAU9iw@mail.gmail.com>
 <20200319064407.GA26408@dcvr>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200319064407.GA26408@dcvr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 19, 2020 at 06:44:07AM +0000, Eric Wong wrote:

> Timothee Cour <thelastmammoth@gmail.com> wrote:
> > git makes it impossible to ignore global gitconfig. This is
> > essentially what's being asked here:
> > https://stackoverflow.com/questions/23400449/how-to-make-git-temporarily-ignore-gitconfig
> > 
> > ## proposal:
> > add an environment variable (like for tig and other programs), eg:
> > `GITCONFIGFILE=~/.gitconfig_temp git diff`
> > seems like an easy change that would make it easy for users to ignore
> > or override their gitconfig
> 
> You can use GIT_CONFIG for that, and there's also
> GIT_CONFIG_NOSYSTEM.  They're both documented in the
> git-config(5) manpage.

I don't think $GIT_CONFIG is what Timothee whats. It only affects the
git-config command, not config lookup in other programs. And it
overrides _all_ config lookup, as if "git config --file" had been used.

There's no variable to suppress just the user-level gitconfig. The usual
technique (that we use in the test scripts) is to point $HOME somewhere
else, but that may affect other programs.

I wouldn't be opposed to GIT_CONFIG_NOGLOBAL if there's a use case, but
it sounds like the desire is to actually provide new config. That can
also be done for specific options with "git -c". Under the hood that is
using GIT_CONFIG_PARAMETERS in the environment; you can set it
individually, but note that it's a little picky about quoting (the
individual keys are shell-quoted, but it insists that there is an outer
layer of single-quotes, even if they weren't necessary; I wouldn't be
opposed to making it more friendly). You can see what it produces like
this:

  git -c alias.dump='!echo "$GIT_CONFIG_PARAMETERS"' dump

-Peff
