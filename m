Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2A8B61F6AC
	for <e@80x24.org>; Tue,  3 Jul 2018 14:15:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932799AbeGCOPW (ORCPT <rfc822;e@80x24.org>);
        Tue, 3 Jul 2018 10:15:22 -0400
Received: from cloud.peff.net ([104.130.231.41]:57712 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S932219AbeGCOPV (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Jul 2018 10:15:21 -0400
Received: (qmail 20116 invoked by uid 109); 3 Jul 2018 14:15:20 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 03 Jul 2018 14:15:20 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 2119 invoked by uid 111); 3 Jul 2018 14:15:20 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 03 Jul 2018 10:15:20 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 03 Jul 2018 10:15:19 -0400
Date:   Tue, 3 Jul 2018 10:15:19 -0400
From:   Jeff King <peff@peff.net>
To:     Mike Hommey <mh@glandium.org>
Cc:     git@vger.kernel.org, Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: Re: Checks added for CVE-2018-11235 too restrictive?
Message-ID: <20180703141518.GA21629@sigill.intra.peff.net>
References: <20180703070650.b3drk5a6kb4k4tnp@glandium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180703070650.b3drk5a6kb4k4tnp@glandium.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jul 03, 2018 at 04:06:50PM +0900, Mike Hommey wrote:

> I had a first shot at that a few months ago, but the format of the
> metadata branch made it impossible to push to github, hitting its push
> size limit. With some pre-processing work, I was able to push the data
> to github, with the intent to come back with a new metadata branch
> format that would make the push directly possible.

This is sort of tangential to your email here, but I'm curious which
limit you hit. Too-big blob, tree, or commit?

> Fast forward to this week, where I was trying to upload a new metadata
> branch, and failed in a rather interesting way: multiple lines looking
> like:
> 
> remote: error: object 81eae74b046d284c47e788143bbbcc681cb53418: gitmodulesMissing: unable to read .gitmodules blob
> 
> which, apart from the fact that they have some formatting issue, appear
> to be new from the fixes for CVE-2018-11235.

Also tangential to your main point (I promise I'll get to it ;) ), but
what formatting issue do you mean? Are you referring to
"gitmodulesMissing"? That's a machine-readable tag which means you can
set "fsck.gitmodulesMissing" to "ignore".

> I can see what those fixes are trying to prevent, but they seem to be
> overly restrictive, at least in the context of transfer.fsckObjects.
> 
> The core problem is that the mercurial repository has some .gitmodules
> files in some subdirectories. As a consequence, the git objects storing
> the info for those mercurial files contain trees with .gitmodules files
> with a commit ref, and that's what the remote is complaining about.
> 
> (Surpringly, it doesn't hit the "non-blob found at .gitmodules" case
> first, which is weird).

The reason it doesn't hit the "non-blob" case is that we are trying to
analyze the object itself. So we don't pay any attention to the mode in
the containing tree, but instead literally look for 81eae74b0. If it
were a non-blob we'd complain then, but in fact we don't have it at all
(which is otherwise OK because it's a gitlink).

> A small testcase to reproduce looks like this:
> 
> $ git init bar; cd bar
> $ git fast-import <<EOF
> commit refs/heads/bar
> committer Bar <bar@bar> 0 +0000
> data 0
>                                                                  
> M 160000 81eae74b046d284c47e788143bbbcc681cb53418 bar/.gitmodules
>                                                                  
> EOF
>
> [...]
> 
> Would it be reasonable to make the transfer.fsckObject checks ignore
> non-blob .gitmodules?

I'm open to the idea that the new checks are too restrictive (both this
and the gitmodulesParse error we're discussing in [1]). They definitely
outlaw things that _used_ to be OK. And the security benefit is a little
hand-wavy. They're not strictly needed to block the recent
vulnerability[2].  However, they _could_ protect us from future problems
(e.g., an overflow in the config-parsing code, which is not accessible
to attackers outside of .gitmodules). So there is some value in being
restrictive, but it's mostly hypothetical for now.

So I think we could simply loosen these cases without immediate effect.
That said, I'm not sure that having a gitlink .gitmodules is sane in the
first place. Attempting to "git submodule init" there is going to cause
errors. Well, sort of -- your example actually includes it in a
subdirectory of the repository, so technically we wouldn't use it for
real submodules. That fudging (finding .gitmodules anywhere instead of
just at the root) was a conscious decision to reduce the complexity and
cost of the check.

It sounds like in this case you don't have existing history that does
this with .gitmodules, but are rather looking into designing a new
feature that stuffs data into git trees. I'd be interested to hear a bit
more about that feature to see if there are other alternatives.

[1] https://public-inbox.org/git/2fc2d53f-e193-2a2a-9f8f-b3e1d256d940@ramsayjones.plus.com/

[2] If you do not have the object, or cannot parse it as config, it
    cannot have a malicious config name in it. We do have to be wary of
    cases where we get the tree in one push, and then later get the
    pointed-to object. But I think for anything _except_ a gitlink, we'd
    complain about the missing object for the first push. And for a
    gitlink, we wouldn't check out the blob, so we're OK.
