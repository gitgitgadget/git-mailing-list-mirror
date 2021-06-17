Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02FE3C48BE5
	for <git@archiver.kernel.org>; Thu, 17 Jun 2021 01:30:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C5A32613DF
	for <git@archiver.kernel.org>; Thu, 17 Jun 2021 01:30:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232084AbhFQBcQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Jun 2021 21:32:16 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:57044 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231942AbhFQBcQ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Jun 2021 21:32:16 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 61289D856D;
        Wed, 16 Jun 2021 21:30:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=MiNIVYMnSaTKlqAlujng26FTAJOSL4LcZRkF2v
        5qdIg=; b=TzQHvhdLvo9R5wdqlKC+rcbFKXVyRzA72a5zpmNOgNmMAfrFrcyihw
        Ij3osNLov2q4L6ILKWeR/hSgnPJua9HiMeYnlM30oRKLlJc/EZ9Hdv/AWubxigeT
        K487I50ZOlcxlpb9xYUOwl3mwPcpwI8gQmtpzkluSo3E04xQQuKXU=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 41FC6D856B;
        Wed, 16 Jun 2021 21:30:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.196.36.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id BF7E3D856A;
        Wed, 16 Jun 2021 21:30:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [RFC PATCH 0/2] MVP implementation of remote-suggested hooks
References: <cover.1623881977.git.jonathantanmy@google.com>
Date:   Thu, 17 Jun 2021 10:30:06 +0900
In-Reply-To: <cover.1623881977.git.jonathantanmy@google.com> (Jonathan Tan's
        message of "Wed, 16 Jun 2021 16:31:47 -0700")
Message-ID: <xmqq35thnuqp.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 8CC182EE-CF0B-11EB-BC31-FD8818BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

>  1. The remote repo administrator creates a new branch
>     "refs/heads/suggested-hooks" pointing to a commit that has all the
>     hooks that the administrator wants to suggest. The hooks are
>     directly referenced by the commit tree (i.e. they are in the "/"
>     directory).

wants to suggest?  They simply suggest ;-)

>  2. When a user clones, Git notices that
>     "refs/remotes/origin/suggested-hooks" is present and prints out a
>     message about a command that can be run.

Can be run to install?  Or can be run to first inspect?  Or both?

>  3. If the user runs that command, Git will install the hooks pointed to
>     by that ref, and set hook.autoupdate to true. This config variable
>     is checked whenever "git fetch" is run: whenever it notices that
>     "refs/remotes/origin/suggested-hooks" changes, it will reinstall the
>     hooks.
>
>  4. To turn off autoupdate, set hook.autoupdate to false. Existing hooks
>     will remain.

OK, so "verify even if you implicitly trust" is actively discouraged.

> Design choices:
>
>  1. Where should the suggested hooks be in the remote repo? A branch,
>     a non-branch ref, a config? I think that a branch is best - it is
>     relatively well-understood and any hooks there can be
>     version-controlled (and its history is independent of the other
>     branches).

As people mentioned in the previous discussions, "independent of the
other branches" has advantages and disadvantages.  The most recent
set of hooks may have some that would not work well with older
codebase, so care must be taken to ensure any hook works on across
versions of the main codebase.  Which may not be a huge downside,
but something users must be aware of.

>  2. When and how should the local repo update its record of the remote's
>     suggested hooks? If we go with storing the hooks in a branch of a
>     remote side, this would automatically mean (with the default
>     refspec) that it would be in refs/remotes/<remote>/<name>. This
>     incurs network and hard disk cost even if the local repo does not
>     want to use the suggested hooks, but I think that typically they
>     would want to use it if they're going to do any work on the repo
>     (they would either have to trust or inspect Makefiles etc. anyway,
>     so they can do the same for the hooks), and even if they don't want
>     to use the remote's hooks, they probably still want to know what the
>     remote suggests.

A way to see what changes are made to recommendation would be
useful, and a branch that mostly linearly progresses is a good way
to give it to the users.

Of course, that can be done with suggested hooks inline with the
rest of the main codebase, too.

>  4. Should the local repo try to notice if the hooks have been changed
>     locally before overwriting upon autoupdate? This would be nice to
>     have, but I don't know how practical it would be. In particular, I
>     don't know if we can trust that
>     "refs/remotes/origin/suggested-hooks" has not been clobbered.

Meaning clobbered by malicious parties?  Then the whole thing is a
no-go from security point of view.  Presumably you trust the main
content enough to work on top of it, so as long as you can trust
that refs/remotes/origin/hooks to the same degree that you would
trust refs/remotes/origin/master, I do not think it is a problem.

Whatever mechanism you use to materialize an updated version of the
hooks can and should record which commit on the suggested-hooks
branch the .git/hooks/* file is based on.  Then when the user wants
to update to a different version of suggested-hooks (either because
you auto-detected, or the user issued a command to update), you have

 - The current version in .git/hooks/*

 - The old pristine version (you recorded the commit when you
   updated the .git/hooks/* copy the last time)

 - The new pristine version (you have a remote-tracking branch).

and it is not a brain surgery to perform three-way merge to update
the first using the difference between the second and the third.

>  5. Should we have a command that manually updates the hooks with what's
>     in "refs/heads/suggested-hooks"? This is not in this patch set, but
>     it sounds like a good idea.

I wonder if having it bound as a submodule to a known location in
the main contents tree makes it easier to manage and more flexible.
Just like you can update the working tree of a submodule to a
version that is bound to the superproject tree, or to a more recent
version of the "branch" in the submodule, you can support workflows
that allow suggested hooks to advance independent of the main
contents version and that uses a specific version of suggested hooks
tied to the main contents.



> There are perhaps other points that I haven't thought of, of course.
>
> [1] https://lore.kernel.org/git/pull.908.git.1616105016055.gitgitgadget@gmail.com/
>
> Jonathan Tan (2):
>   hook: move list of hooks
>   clone,fetch: remote-suggested auto-updating hooks
>
>  builtin/bugreport.c |  38 ++------------
>  builtin/clone.c     |  10 ++++
>  builtin/fetch.c     |  21 ++++++++
>  builtin/hook.c      |  13 +++--
>  hook.c              | 118 ++++++++++++++++++++++++++++++++++++++++++++
>  hook.h              |   5 ++
>  t/t5601-clone.sh    |  36 ++++++++++++++
>  7 files changed, 202 insertions(+), 39 deletions(-)
