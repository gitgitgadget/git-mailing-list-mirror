Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21759C433DB
	for <git@archiver.kernel.org>; Tue, 16 Mar 2021 20:34:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C536464F89
	for <git@archiver.kernel.org>; Tue, 16 Mar 2021 20:34:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231334AbhCPUeG (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Mar 2021 16:34:06 -0400
Received: from cloud.peff.net ([104.130.231.41]:38734 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231311AbhCPUdu (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Mar 2021 16:33:50 -0400
Received: (qmail 21119 invoked by uid 109); 16 Mar 2021 20:33:49 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 16 Mar 2021 20:33:49 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 1321 invoked by uid 111); 16 Mar 2021 20:33:49 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 16 Mar 2021 16:33:49 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 16 Mar 2021 16:33:48 -0400
From:   Jeff King <peff@peff.net>
To:     "Lamborn, Peter Craig" <plamborn@lanl.gov>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        "Nielsen, Johnathan Patrick" <jnielsen@lanl.gov>,
        "Herrera, Thomas Anthony" <taherrera@lanl.gov>
Subject: Re: GIT_SSH and mirror not working with git 2.30.1
Message-ID: <YFEWLNZ09ycJQ5uM@coredump.intra.peff.net>
References: <e39d23615e084671965fc96174ac881e@lanl.gov>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <e39d23615e084671965fc96174ac881e@lanl.gov>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Mar 16, 2021 at 06:53:24PM +0000, Lamborn, Peter Craig wrote:

> We have some machines behind firewalls and gateways that cannot access
> git repos directly.  We have been using GIT_SSH and mirror to push and
> pull git request through a less restricted machine.  This has been
> working for a while, specifically both git 2.24.1 and git 2.28 can
> handle the method we have been doing.
> [...]
> workstation$ cat ssh-hop.sh
> #!/bin/bash
>   
> MACHINE_REGEXP="<...>"
>   
> if [[ $1 =~ $MACHINE_REGEXP ]]; then
>   
>   exec ssh <gateway> ssh "$@"
>   
> else
>   exec ssh "$@"
> fi

I suspect the problem is that your script blindly matches "$1". Doing
so makes the assumption that Git will never pass any other options to
ssh. Traditionally Git _usually_ wouldn't do so (unless it needed
specific options like "-p", "-4/-6", etc).

But in Git's newer "v2" protocol, we have to pass an environment
variable across the wire, which requires using "-o". E.g.:

  [using v2.28]
  $ GIT_TRACE2_BRIEF=1 GIT_TRACE2=1 git ls-remote git@github.com:nosuch/repo 2>&1 | grep child_start
  child_start[0] ssh git@github.com 'git-upload-pack '\''nosuch/repo'\'''

  [using v2.29]
  $ GIT_TRACE2_BRIEF=1 GIT_TRACE2=1 git ls-remote git@github.com:nosuch/repo 2>&1 | grep child_start
  child_start[0] ssh -o SendEnv=GIT_PROTOCOL git@github.com 'git-upload-pack '\''nosuch/repo'\'''

> When you try the same thing with git 2.30.1, the "git push" commands
> still succeed.  But "git pull" returns this:

Using the new protocol became the default in v2.29. It also is only used
for fetching, not pushing. So that explains why it's a problem in
v2.30.1, and also why "git push" isn't affected.

> ssh: connect to host <destination machine> port 22: Operation timed out
> fatal: Could not read from remote repository.

This part is presumably just what happens when the "hop" behavior of
your script doesn't kick in. A straight "ssh" is run under the hood, but
your firewall probably times it out.

> Does git 2.30.1 change something about mirrors and/or GIT_SSH that
> would cause git pulls to fail?  Do we need to adjust our current
> process?

Adjusting your script to look for the hostname in the second-to-last
argument would probably be more robust. But as Andreas noted, using
ssh's ProxyJump feature would be better still.

-Peff
