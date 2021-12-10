Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4B21C433F5
	for <git@archiver.kernel.org>; Fri, 10 Dec 2021 21:55:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344539AbhLJV7b (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Dec 2021 16:59:31 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:54814 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344517AbhLJV7a (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Dec 2021 16:59:30 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id EBB31170A0C;
        Fri, 10 Dec 2021 16:55:54 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=nolwIaKhVnjEWRLvdYIPpR4q5ULdmpj9CpDEyz
        1QPqg=; b=FebuTN6nr25ejCxYN9JjFtIy4JczrE2B4NUU4w00AjSawAhGdM7Q0m
        dy5cHTthi388oWz4W6N3ijijDfnD553qkXgssOSlxNoHzPlAGgax/r0dcggJpajT
        9i9TwGdCYpn9QjW/6rEmYQDyijDoIH6ffT/RmYbmKZdj2jZDwCiYA=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id E53DC170A0B;
        Fri, 10 Dec 2021 16:55:54 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 45008170A0A;
        Fri, 10 Dec 2021 16:55:50 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     William Sprent via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        William Sprent <williams@unity3d.com>
Subject: Re: [PATCH v2] fast-export: fix surprising behavior with
 --first-parent
References: <pull.1084.git.1637666927224.gitgitgadget@gmail.com>
        <pull.1084.v2.git.1639037637231.gitgitgadget@gmail.com>
        <CABPp-BGdCizEGcwPS+0VB_vvYLpGCWKLqx-nbZtJ16QkVxzbGQ@mail.gmail.com>
Date:   Fri, 10 Dec 2021 13:55:48 -0800
In-Reply-To: <CABPp-BGdCizEGcwPS+0VB_vvYLpGCWKLqx-nbZtJ16QkVxzbGQ@mail.gmail.com>
        (Elijah Newren's message of "Thu, 9 Dec 2021 19:48:20 -0800")
Message-ID: <xmqqee6km8ez.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F033DD12-5A03-11EC-B10B-98D80D944F46-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

> ...  Here's what I think are the relevant points
> (and yeah, it's lengthy):
>
>
> The revision traversal machinery typically processes and returns all
> children before any parent.  fast-export needs to operate in the
> reverse fashion, handling parents before any of their children in
> order to build up the history starting from the root commit(s).  This
> would be a clear case where we could just use the revision traversal
> machinery's "reverse" option to achieve this desired affect.
>
> However, this wasn't what the code did.  It added its own array for
> queuing.  The obvious hand-rolled solution would be to just push all
> the commits into the array and then traverse afterwards, but it didn't
> quite do that either.  It instead attempted to process anything it
> could as soon as it could, and once it could, check whether it could
> process anything that had been queued.  As far as I can tell, this was
> an effort to save a little memory in the case of multiple root commits
> since it could process some commits before queueing all of them.  This
> involved some helper functions named has_unshown_parent() and
> handle_tail().  For typical invocations of fast-export, this
> alternative essentially amounted to a hand-rolled method of reversing
> the commits -- it was a bunch of work to duplicate the revision
> traversal machinery's "reverse" option.
>
> This hand-rolled reversing mechanism is actually somewhat difficult to
> reason about.  It takes some time to figure out how it ensures in
> normal cases that it will actually process all traversed commits
> (rather than just dropping some and not printing anything for them).
>
> And it turns out there are some cases where the code does drop commits
> without handling them, and not even printing an error or warning for
> the user.  Due to the has_unshown_parent() checks, some commits could
> be left in the array at the end of the "while...get_revision()" loop
> which would be unprocessed.  This could be triggered for example with
>     git fast-export main -- --first-parent
> or non-sensical traversal rules such as
>     git fast-export main -- --grep=Merge --invert-grep
>
> While most traversals that don't include all parents should likely
> trigger errors in fast-export (or at least require being used in
> combination with --reference-excluded-parents), the --first-parent
> traversal is at least reasonable and it'd be nice if it didn't just
> drop commits.  It'd also be nice to have a simpler "reverse traversal"
> mechanism.  Use the "reverse" option of the revision traversal
> machinery to achieve both.

The above is a very helpful and understandable explanation of what
is going on.  I am a bit puzzled by the very last part, though. By
"It'd also be nice to have a simpler 'reverse traversal' mechanism",
do you mean that the end users have need to control the direction
the traversal goes (in other words, they use "git fast-export" for
some thing, and "git fast-export --reverse" to achieve some other
things)?  Or do you just mean that we need to do a reverse traversal
but that is already available in the revision traversal machinery,
and not using it and rolling our own does not make sense?

> Even for the non-sensical traversal flags like the --grep one above,
> this would be an improvement.  For example, in that case, the code
> previously would have silently truncated history to only those commits
> that do not have an ancestor containing "Merge" in their commit
> message.  After this code change, that case would would include all

"would would" -> "would"

> commits without "Merge" in their commit message -- but any commit that
> previously had a "Merge"-mentioning parent would lose that parent
> (likely resulting in many new root commits).  While the new behavior
> is still odd, it is at least understandable given that
> --reference-excluded-parents is not the default.

Nicely written.
