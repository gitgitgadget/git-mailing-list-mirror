Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0124C433ED
	for <git@archiver.kernel.org>; Tue,  4 May 2021 12:55:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B5CB261040
	for <git@archiver.kernel.org>; Tue,  4 May 2021 12:55:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230411AbhEDM4X (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 May 2021 08:56:23 -0400
Received: from smtp.hosts.co.uk ([85.233.160.19]:46926 "EHLO smtp.hosts.co.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230306AbhEDM4X (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 May 2021 08:56:23 -0400
Received: from host-92-1-139-132.as13285.net ([92.1.139.132] helo=[192.168.1.37])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <philipoakley@iee.email>)
        id 1lduaE-000B3f-8a; Tue, 04 May 2021 13:55:27 +0100
Subject: Re: gitignore + commit with excludes = bug
To:     Paul Jackson <mailnew4ster@gmail.com>, git@vger.kernel.org
References: <CAGKR6vKwojz8_bs9oRasQPCamZJ-4mrmBKBZQCJKhX=8w+SzDg@mail.gmail.com>
From:   Philip Oakley <philipoakley@iee.email>
Message-ID: <e4c3d482-03b4-141c-e47b-cb3e175da3ab@iee.email>
Date:   Tue, 4 May 2021 13:55:26 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <CAGKR6vKwojz8_bs9oRasQPCamZJ-4mrmBKBZQCJKhX=8w+SzDg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Paul,

On 01/05/2021 19:37, Paul Jackson wrote:
> Hello,
>
> I stumbled upon what I believe is a bug in git.
> See the following reproduction steps:
>
> mkdir test
> cd test
> git init
> echo 1 > ignored
> echo 1 > not-ignored
> echo ignored > .gitignore
> git add -A -- ':!ignored' || echo 'ERROR!!!'
>
> In these steps, I ignore the "ignored" file twice - first time in
> .gitignore, and second time in the "git add" command. I didn't expect
> this to be a problem, but I'm getting the following error message:
>
> The following paths are ignored by one of your .gitignore files:
> ignored
>
> It looks as if git thinks I wanted to include, not exclude "ignored"
> in "git add".
I was intrigued by this. The man pages can be hard to decipher, and it
may be an 'as designed' feature, but still not intuitive

It took a while to find the relevant parts of the man pages.

The `-A` option of `add` is under
https://git-scm.com/docs/git-add#Documentation/git-add.txt---no-ignore-removal
which has caveats for whether a pathspec is given.

The `exclude` magic pathspec is under
https://git-scm.com/docs/gitglossary#Documentation/gitglossary.txt-exclude
and again has caveats and a double negative regarding whether the
`exclude` pathspec counts as a path spec.

I _think_ that it is saying that the `exclude` pathspec is ignored for
the purpose of the `-A` (all) condition for git add.
The `git add` then decides that the the set of files to be added is just
the single 'not-ignored' file, having already used the `.gitignore` to
"exclude" the 'ignored' file from that set of files to add.

Now your "exclude" pathspec comes into play and tries remove the named
"exclude" file from the set, and doesn't find it. Or at least that's how
I read it as a plausible explanation. That said, I haven't looked at the
code, so that could be all wrong.

A possible place to start is the
https://gitlab.cecs.anu.edu.au/comp8440/git/commit/ef79b1f8704668a6cdf4278f9255e03ca785bfb4
patch (google..) or
https://github.com/git/git/commit/ef79b1f8704668a6cdf4278f9255e03ca785bfb4

Also locate where the error message is generated. It maybe just a warning.

--
Philip




