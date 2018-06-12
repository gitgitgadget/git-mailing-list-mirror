Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 857121F403
	for <e@80x24.org>; Tue, 12 Jun 2018 10:08:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753909AbeFLKIN (ORCPT <rfc822;e@80x24.org>);
        Tue, 12 Jun 2018 06:08:13 -0400
Received: from cloud.peff.net ([104.130.231.41]:42284 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1752832AbeFLKIM (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Jun 2018 06:08:12 -0400
Received: (qmail 27342 invoked by uid 109); 12 Jun 2018 10:08:12 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 12 Jun 2018 10:08:12 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 22437 invoked by uid 111); 12 Jun 2018 10:08:27 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 12 Jun 2018 06:08:27 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 12 Jun 2018 06:08:10 -0400
Date:   Tue, 12 Jun 2018 06:08:10 -0400
From:   Jeff King <peff@peff.net>
To:     ch <cr@onlinehome.de>
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        git@vger.kernel.org
Subject: Re: [BUG] git-rebase: reword squashes commits in case of
 merge-conflicts
Message-ID: <20180612100810.GA27231@sigill.intra.peff.net>
References: <8e28202a-8646-53e8-8c22-389d61791c70@onlinehome.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <8e28202a-8646-53e8-8c22-389d61791c70@onlinehome.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jun 11, 2018 at 06:06:11PM +0200, ch wrote:

> After the rebase the 'stuff' branch only has a single commit even though I'd
> expect there to be two according to the instructions that were passed to
> git-rebase. It works as expected if there's either no merge-conflict at the
> reword or if the conflicting commit is applied as 'pick'.
> 
> I'm running git version 2.17.1.windows.2. I also tried native git version 2.7.4
> via WSL (running Ubuntu 16.04.4 LTS) and this version does not exhibit this
> behavior.

Thanks for a thorough report. I couldn't reproduce it on v2.17.1 on
Linux, which makes me wonder if the issue is related to git-for-windows
somehow. To the best of my knowledge (and a quick scan of "git diff"
results) the code should be the same, though.

I'm cc-ing Johannes, who is both the resident interactive-rebase expert
_and_ the Git for Windows maintainer. Copious quoting below.

-Peff

-- >8 --
> Hi all!
> 
> During a recent rebase operation on one of my repositories a number of commits
> unexpectedly ended up getting squashed into other commits. After some
> experiments it turned out that the 'reword' instruction seems to squash the
> referenced commit into the preceding commit if there's a merge-conflict.
> 
> Here's a small reproduction recipe to illustrate the behavior:
> 
>    1. Create a small test repository using the following Bash script:
> 
> ----
> function add_file()
> {
>      echo "$1" > "$2"
>      git add "$2"
>      git commit -m "$3"
> }
> 
> git init .
> 
> add_file "test" "file-1" "master"
> 
> git checkout -b stuff
> 
> add_file "aaa" "file-2" "feature_a"
> add_file "bbb" "file-2" "fixup! feature_a"
> add_file "ccc" "file-2" "fixup! feature_a"
> 
> add_file "ddd" "file-2" "feature_b"
> add_file "eee" "file-2" "fixup! feature_b"
> add_file "fff" "file-2" "fixup! feature_b"
> ----
> 
>    2. Run
> 
>         $ git rebase --autosquash --interactive --onto master master stuff
> 
>       to interactively rebase 'stuff' onto 'master'. This should generate the
>       following todo-stream:
> 
> ----
> pick ... feature_a
> fixup ... fixup! feature_a
> fixup <hash_1> fixup! feature_a
> pick <hash_2> feature_b
> fixup ... fixup! feature_b
> fixup ... fixup! feature_b
> ----
> 
>    3. Remove the fixup line right before the second pick (i.e. 'fixup <hash_1>')
>       in order to enforce a merge-conflict later when applying commit <hash_2>.
> 
>    4. Replace the second pick instruction (i.e. 'pick <hash_2>') with a reword.
> 
>    5. Launch the rebase operation. It should fail at the 'reword <hash_2>'
>       instruction due to a merge-conflict.
> 
>    6. Resolve the conflict by taking the remote-side (i.e. 'ddd'), add the
>       change to the index with git-add and run
> 
>         $ git rebase --continue
> 
>       This should spawn the commit message editor and after saving and quitting
>       the rebase should finish cleanly.
> 
> After the rebase the 'stuff' branch only has a single commit even though I'd
> expect there to be two according to the instructions that were passed to
> git-rebase. It works as expected if there's either no merge-conflict at the
> reword or if the conflicting commit is applied as 'pick'.
> 
> I'm running git version 2.17.1.windows.2. I also tried native git version 2.7.4
> via WSL (running Ubuntu 16.04.4 LTS) and this version does not exhibit this
> behavior.
> 
> - ch
