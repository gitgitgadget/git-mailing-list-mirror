Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E160DC433F5
	for <git@archiver.kernel.org>; Wed,  2 Feb 2022 21:05:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347384AbiBBVFH (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Feb 2022 16:05:07 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:50875 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241103AbiBBVFG (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Feb 2022 16:05:06 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id BE19B17FEEB;
        Wed,  2 Feb 2022 16:05:05 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=NiVs+67+MnGL5PkFrrfkFIk2vMzTJb7yuL8T0g
        NqK60=; b=V1dDXHItCEfupqD7kFz9KxH6smKclgSLrAIpq5n+vZzNo1e0GU60Gl
        SDBRCuPgTXHrzgK/ANYCykP/cntGcu8b2fBHD2EbURzHi2akJj8wd4rCpwOYG5bM
        XWnpUcY6d8Yl4WB8BneIm4mlf7fxk0rF2kc7CxjvWJtty8asq8QRc=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id B715317FEEA;
        Wed,  2 Feb 2022 16:05:05 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 937EB17FEE8;
        Wed,  2 Feb 2022 16:05:02 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Viaceslavus via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Viaceslavus <vaceslavkozin619@gmail.com>
Subject: Re: [PATCH] forbid a hard reset before the initial commit
References: <pull.1137.git.1643802721612.gitgitgadget@gmail.com>
Date:   Wed, 02 Feb 2022 13:05:01 -0800
In-Reply-To: <pull.1137.git.1643802721612.gitgitgadget@gmail.com> (Viaceslavus
        via GitGitGadget's message of "Wed, 02 Feb 2022 11:52:01 +0000")
Message-ID: <xmqq4k5hyo76.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C9F32576-846B-11EC-BCE6-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Viaceslavus via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Viacelaus <vaceslavkozin619@gmail.com>
>
> Performing 'git reset --hard' on empty repo with staged files
> may have the only one possible result - deleting all staged files.

Sure.  It has the only one possible result, which is a sign that the
command is well designed to give a robust and predictable end user
experience.

I know you wanted to say "there is only one possible result, and
that result cannot be anything but bad. You Git folks are stupid to
design a command that only can have a bad result, so I'll fix that
stupidity for you".

But the thing is, not everybody agrees with your "deleting all files
that added to the index when asked to 'reset --hard' is bad".  It is
the most obvious way to go back to the "pristine" state, and after
all, that is what "reset --hard" is about.

Many readers on the list are non-native speakers.  You must be
careful with your rhetorics, because they often will not be taken in
the way you meant them to be taken by them.  When you can say "doing
X does Y" and convey the core of what you want to say, do so,
instead of saying "doing X has only one possible result, which is
Y". You may lose the "you Git folks are stupid" part of the message,
but you're better off not to sound rude anyway ;-)

> Such behaviour may be unexpected or even dangerous. With this
> commit, when running 'git reset --hard', git will check for the
> existence of commits in the repo; in case of absence of such, and
> also if there are any files staged, git will die with an error.

This directly contradicts with, and likely will regress the fix made
by, what 166ec2e9 (reset: allow reset on unborn branch, 2013-01-14)
wanted to do.  I do not think we want this change in its current
form.

When starting a new project on a hosting provider like GitHub these
days, you can have them create the initial commit that records the
copy of the license file, and the first thing you do on your local
machine after leaving the browser to create the repository over
there is to clone from it.  After that, you'd populate the working
tree with the rest of the project files, and record the result.  If
you say "reset --hard" before committing, you'll equally lose all
the newly added files, but because the history is not empty, the
approach taken by this patch would not work to protect you, I
suspect.  It almost always is a mistake to special case an empty
repository or an empty history.

Having said all that, I am sympathetic to the cause to make it
harder to discard a lot of work by mistake.  It is just that
disabling "reset --hard" only when it is trying to go back to an
empty tree is not an effective way to do so.  It is even less so
when you do not give any escape hatch in case the user knew what
they were doing and really meant to go back to the pristine state.

    Side note.  Yes, "git diff --cached | git apply -R --index" or
    "git rm --cached -r ." as a workaround, but when the user wanted
    to do "reset --hard", we should have a way to let them do so.

Off the top of my head, here are a couple of possible ways to
improve the design of this change (note: I am not saying that I'll
unconditionally take such a patch that implements any of these):

 * Detect if we are being interactive, and offer Yes/No choice to
   give an interactive user a chance to abort when we detect a
   "risky" situation.  Don't do anything if we are not interactive,
   and don't make it impossible to do things that we may (mis)detect
   as risky.

 * Instead of "we are going back to the state without any commit
   yet", use a better heuristics, such as "we'd lose a newly added
   path (i.e. the path exists in the index and in the working tree
   but does not exist in HEAD)" as a sign to flag the situation as
   possibly risky.  Or limit that further to protect only when we'd
   lose more than N-percent of the paths in the index that way.

But both are hard problems.

Many existing scripts do rely on "reset --hard" to be a robust and
predictable way to go back to the pristine state, and they will be
very upset if we misdetect and prompt the user who is not sitting in
front of the keyboard.
