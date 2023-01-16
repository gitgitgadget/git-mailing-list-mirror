Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46867C54EBE
	for <git@archiver.kernel.org>; Mon, 16 Jan 2023 17:58:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234253AbjAPR60 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 16 Jan 2023 12:58:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232546AbjAPR6B (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Jan 2023 12:58:01 -0500
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EF5B305C7
        for <git@vger.kernel.org>; Mon, 16 Jan 2023 09:38:36 -0800 (PST)
Received: (qmail 15622 invoked by uid 109); 16 Jan 2023 17:38:35 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 16 Jan 2023 17:38:35 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 31808 invoked by uid 111); 16 Jan 2023 17:38:36 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 16 Jan 2023 12:38:36 -0500
Authentication-Results: peff.net; auth=none
Date:   Mon, 16 Jan 2023 12:38:34 -0500
From:   Jeff King <peff@peff.net>
To:     Philip Oakley <philipoakley@iee.email>
Cc:     Git List <git@vger.kernel.org>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Elijah Newren <newren@gmail.com>
Subject: Re: test_pause giving '__git_ps1: not found' warning
Message-ID: <Y8WLmmjL2HH2szGs@coredump.intra.peff.net>
References: <bce6ac3a-17a6-beed-43ef-5a1e0dd92a5d@iee.email>
 <8355f48b-dbf9-7cfe-c85c-0d6ca5926c8c@iee.email>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8355f48b-dbf9-7cfe-c85c-0d6ca5926c8c@iee.email>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jan 14, 2023 at 05:49:15PM +0000, Philip Oakley wrote:

> On 14/01/2023 14:54, Philip Oakley wrote:
> > I was trying to refine a test_expect_failure test [1] and tried
> > inserting a `test_pause &&` test line [2].
> > 
> > I then found, when it paused, I was repeatedly given the warning line
> >     /bin/sh: 1: __git_ps1: not found
> > in the terminal until I expected the test shell.
> > 
> > my PS1 is working normally in the terminal, but not here.  Is this
> > expected, or do I need to set up anything else?
> > 
> > Normally I'm on Git for Windows, but this was on my old laptop (Acer
> > 7741 i5 4GB ram..) converted to Ubuntu 20.04, which I use when away.

On Ubuntu, your /bin/sh is likely to be dash. And unless you've set
TEST_SHELL_PATH, that's what test_pause will use.

> My local .bashrc has
> 
>     . /home/philip/git-completion.bash
>     . ~/git-prompt.sh
>     export GIT_PS1_SHOWDIRTYSTATE=1
>     export PS1='\w$(__git_ps1 " (%s)")\$ '

It's unusual to export PS1. Only the shell needs it. But by exporting
it, the child "dash" will see it, but of course doesn't have the
__git_ps1() function defined. And thus the complaint.

If you stop exporting it, then you'd see dash's regular prompt. Which
fixes the "whoops, __git_ps1() is not defined" problem, but probably is
not quite what you want, if you really wanted a nice prompt.

> Not sure why I have a relative and an absolute path but... ,  so I'll try
> updating the git-prompt.sh to an absolute path, and if that works, maybe
> think about adding an extra comment to the `test-lib-functions.sh` to note
> the change of HOME and potential '__git_ps1' problem

It looks like test_pause() has various options for retaining shell,
term, home, etc, and includes documentation. I haven't played with them
myself, though. Usually I just use "-i" to stop the test, and then
investigate the result in one of my regular shells (and in the rare case
of "oops, it succeeds when I expect it to fail, I insert "false &&" as
appropriate).

-Peff
