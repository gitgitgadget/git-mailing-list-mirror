Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5ADE0C433F5
	for <git@archiver.kernel.org>; Fri, 21 Jan 2022 23:09:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229495AbiAUXJw (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 Jan 2022 18:09:52 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:56760 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbiAUXJw (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Jan 2022 18:09:52 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id B04B615C113;
        Fri, 21 Jan 2022 18:09:51 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=quWMpp+uNsxauxYkd1AgJnvVXINV78ClFtOEjo
        UmwwY=; b=Hdks1326C9iBnzDh0huyP4kfPslmBNvIVudIxWb1uX1Ghm5b9htv5J
        Lfs3gDQKW5wt2Is9KpsBvOcNnTvAXsYi2nVzVhii8MUPPzWlfaUXvS8huMjHH/pt
        6AlU4387w5CudXtV55aiTx42uApL/c/KFnInmWJ9dVgXeGGnUWiZg=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id A941A15C112;
        Fri, 21 Jan 2022 18:09:51 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 0E53515C110;
        Fri, 21 Jan 2022 18:09:49 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Lauri Rooden <lauri@rooden.ee>
Cc:     git@vger.kernel.org
Subject: Re: Strange checkout with GIT_WORK_TREE
References: <CAHqym3xs_M7BvvFDq2pHM-+DgK_nJcBakVEBL-GiNwnCRzMwWA@mail.gmail.com>
Date:   Fri, 21 Jan 2022 15:09:47 -0800
In-Reply-To: <CAHqym3xs_M7BvvFDq2pHM-+DgK_nJcBakVEBL-GiNwnCRzMwWA@mail.gmail.com>
        (Lauri Rooden's message of "Fri, 21 Jan 2022 18:37:58 +0200")
Message-ID: <xmqqv8yceldw.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3B44EC5C-7B0F-11EC-9473-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Lauri Rooden <lauri@rooden.ee> writes:

> echo "Checkout to other work-tree: $GIT_COPY"
> GIT_WORK_TREE=$GIT_COPY git checkout HEAD~1

In this particular case, it happens that it does not make a
difference, but it is discouraged to set GIT_WORK_TREE without
setting GIT_DIR.

    GIT_DIR was invented as a way to say "I am at the top of the
    working tree but I do not have .git/ directory here---it is at
    that other place, i.e. $GIT_DIR".  And this was OK if you worked
    only at the top of the working tree.  GIT_WORK_TREE was then
    invented to help folks who do not always work at the top of the
    working tree.  With that, they can still set GIT_DIR to point at
    the location of the repository proper, use GIT_WORK_TREE to
    point at the top of the working tree, and chdir freely to any
    subdirectory of $GIT_WORK_TREE and expect things to work.

So, the more kosher way to do the above is

	echo "checkout to other work-tree: $GIT_COPY"
	cd "$GIT_COPY"
	GIT_DIR="$GIT_ROOT/.git" git checkout HEAD~

but what you wrote also happens to the same thing.  We auto-discover
the git directory (i.e. the current directory has .git/ directory in
it, and that is used as the GIT_DIR).

Now, what you observed is totally expected.

Because HEAD~ in "git checkout HEAD~" is *not* a branch name, it is
a short-hand of "git checkout --detach HEAD~".  It is "I want to
switch to the named commit, not on any branch.  Note that I may have
local changes, and please carry them when you switch to the commit".

And when you run the above "git checkout", do you have local
changes?  Yes, you do.  Since

 * Your GIT_DIR is "$GIT_ROOT/.git"; your HEAD has two files, a.txt
   and b.txt, with 1 and 2 in it, respectively.  They match the
   index in that GIT_DIR.

 * Your working tree is "$GIT_COPY".  You do not have a.txt and
   b.txt.  I.e. your local change is to remove a.txt and b.txt

Now you want to move to the state of HEAD~, where each of a.txt and
b.txt has 1 in it.  So, if there weren't any local change, switching
to this commit would change a.txt and b.txt to have 1 in them.

Now between HEAD and HEAD~, there was no change to a.txt; so we
honor your local change to REMOVE a.txt.  That is why you do not
have "$GIT_COPY/a.txt" in the result.

But b.txt is different between HEAD and HEAD~.  Pedantically, this
*should* result in "the difference between two commits and your
local change conflicts", and make the "checkout" command fail
without doing anything.  But there is an ancient special case to
help working in a sparsely populated working tree that allows Git
to treat "missing" file as the same as "unchanged" file, and I think
that is what is kicking in.  Instead of treating your "deletion" as
something that conflicts with the change between HEAD and HEAD~ to
turn 2 to 1, the command pretends as if you left b.txt as-is, and
let you switch to HEAD~, instread of failing.

In any case, if you wanted to make a copy of a different commit into
a separate directory, use of GIT_DIR/GIT_WORK_TREE is totally a
wrong way to do so.  If you go and look at $GIT_ROOT after your
switching to "HEAD~", $GIT_ROOT/.git/HEAD and $GIT_ROOT/.git/index
have moved to the "Initial" commit, but your working tree files in
$GIT_ROOT are left as before, which would totally be confusing.

Using "git worktree" to create $GIT_COPY as an additional worktree,
or "git clone" to create $GIT_COPY as an additional repository, may
be what you are looking for.





