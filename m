Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24863C433B4
	for <git@archiver.kernel.org>; Thu, 29 Apr 2021 02:22:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DF88A61450
	for <git@archiver.kernel.org>; Thu, 29 Apr 2021 02:22:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232936AbhD2CXX (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 28 Apr 2021 22:23:23 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:62330 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229888AbhD2CXW (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Apr 2021 22:23:22 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 2021112C6A8;
        Wed, 28 Apr 2021 22:22:37 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=QWdprBGSo6lmYIP1F9eBlHj07BnlOVdREy4r5u
        TC4k8=; b=uSfwYz7T83MIIgBJ+x+r9fL3DeivtKI4PnyYWz2Sgcv56bQ9AzrYGi
        sXDI33vi3vfGYjR/y/AcI4lg3TwQiZnRQF8YtQgqXGCR0fe470wafxVyiSS/Yj2Q
        LrN33u9cyKG5QB1O0geDP1/Ba1plKcpv1j88Wxk6DxlCRuLFbLLeI=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 09DF812C6A7;
        Wed, 28 Apr 2021 22:22:37 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 2DCC812C694;
        Wed, 28 Apr 2021 22:22:34 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Joachim Kuebart via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Joachim Kuebart <joachim.kuebart@gmail.com>,
        Luke Diamand <luke@diamand.org>
Subject: Re: [PATCH] git-p4: speed up search for branch parent
References: <pull.1013.git.git.1619640416533.gitgitgadget@gmail.com>
Date:   Thu, 29 Apr 2021 11:22:32 +0900
In-Reply-To: <pull.1013.git.git.1619640416533.gitgitgadget@gmail.com> (Joachim
        Kuebart via GitGitGadget's message of "Wed, 28 Apr 2021 20:06:56
        +0000")
Message-ID: <xmqq5z05akyf.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C1EA88F8-A891-11EB-A376-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Joachim Kuebart via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Joachim Kuebart <joachim.kuebart@gmail.com>

Thanks.  As git-p4 is not in my area of expertise, I'll make a style
critique first, while pinging Luke as an area expert (you can learn
who they are with "git shortlog --no-merges --since=18.months.ago
git-p4.py").

> Previously, the code iterated through the parent branch commits and
> compared each one to the target tree using diff-tree.

It is customary in this project to describe the problem in the
present tense.  In other words, whoever is writing the log message
still lives in the world without this patch applied to the system.

    The code iterates through the parent commits and compares each of
    them to the target tree using diff-tree.

But before that sentence, please prepare the reader with a bit
larger picture.  A reader may not know what purpose the comparison
serves.  Do we know that the tree of one of the parents of the
commit must match the tree of the target, and trying to see which
parent is the one with the same tree?  What is helped by learning
which parent has the same tree?

Perhaps

    The method searchParent() is used to find a commit in the
    history of the given 'parent' commit whose tree exactly matches
    the tree of the given 'target commit.  The code iterates through
    the commits in the history and compares each of them to the
    target tree by invoking diff-tree.

And then our log message would make observation, pointing out what
is wrong with it (after all comparing with diff-tree is not giving
us a wrong result---the point of this change is that spawning diff-tree
for each commit is wasteful when we only want to see exact matches).

    Because we only are interested in finding a tree that is exactly
    the same, and not interested in how other trees are different,
    having to spawn diff-tree for each and every commit is wasteful. 

> This patch outputs the revision's tree hash along with the commit hash,
> thereby saving the diff-tree invocation. This results in a considerable
> speed-up, at least on Windows.

And then our log message would order the codebase to "become like
so", in order to resolve the issue(s) pointed out in the
observation.  Perhaps

    Use the "--format" option of "rev-list" to find out the tree
    object name of each commit in the history, and find the tree
    whose name is exactly the same as the tree of the target commit
    to optimize this.

When making a claim on performance, it is helpful to our readers to
give some numbers, even in a limited test, e.g.

    In a sample history where ~100 commits needed to be traversed to
    find the fork point on my Windows box, the current code took
    10.4 seconds to complete, while the new code yields the same
    result in 1.8 seconds, which is a significant speed-up.

or something along these lines.

> Signed-off-by: Joachim Kuebart <joachim.kuebart@gmail.com>
>  git-p4.py | 22 +++++++++++-----------
>  1 file changed, 11 insertions(+), 11 deletions(-)
>
> diff --git a/git-p4.py b/git-p4.py
> index 09c9e93ac401..dbe94e6fb83b 100755
> --- a/git-p4.py
> +++ b/git-p4.py
> @@ -3600,19 +3600,19 @@ def importNewBranch(self, branch, maxChange):
>          return True
>  
>      def searchParent(self, parent, branch, target):
> +        for tree in read_pipe_lines(["git", "rev-parse",
> +                                     "{}^{{tree}}".format(target)]):
> +            targetTree = tree.strip()

It looks very strange to run a commit that you expect a single line
of output, and read the result in a loop.  Doesn't git-p4.py supply
a more suitable helper to read a single line output from a command?

> +        for blob in read_pipe_lines(["git", "rev-list", "--format=%H %T",
>                                       "--no-merges", parent]):

This is not a new problem you introduced, but when we hear word
"blob" in the context of this project, it reminds us of the "blob"
object, while the 'blob' variable used in this loop has nothing to
do with it.  Perhaps rename it to say 'line' or something?

> +            if blob[:7] == "commit ":
> +                continue

Perhaps blob.startswith("commit ") to avoid hardcoded string length?

> +            blob = blob.strip().split(" ")
> +            if blob[1] == targetTree:
>                  if self.verbose:
> +                    print("Found parent of %s in commit %s" % (branch, blob[0]))
> +                return blob[0]
> +        return None

