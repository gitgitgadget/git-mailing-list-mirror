Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35BAFC433FE
	for <git@archiver.kernel.org>; Sun, 14 Nov 2021 06:32:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0AF1860551
	for <git@archiver.kernel.org>; Sun, 14 Nov 2021 06:32:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229691AbhKNGfC (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 14 Nov 2021 01:35:02 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:61851 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbhKNGfC (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 14 Nov 2021 01:35:02 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 4DD12F7C80;
        Sun, 14 Nov 2021 01:32:08 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=tafw3uBOXL4iPTkK69dWq2I/aXFIYCf0fRfMUs
        Jlg0U=; b=obQWEpmMXLDkmBHYWnaBuilriw+FAKrdizGYGAcrWRu6ozk8UoEHM+
        JlAdfyyxza4QQSxRk+jwmJsEAvLTERy9hLVFZ4h76kJy1mWDAmmR3dXMO2B/cfRM
        FWEqQxEX3yok2Rk96OJNlwK/+pPUomlht3lbr0c4VLgKzJoL11i+k=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 32A53F7C7F;
        Sun, 14 Nov 2021 01:32:08 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 76A05F7C7E;
        Sun, 14 Nov 2021 01:32:07 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Git List Mailing <git@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Kees Cook <keescook@chromium.org>,
        Linux API <linux-api@vger.kernel.org>
Subject: Re: [GIT PULL] per signal_struct coredumps
References: <878ry512iv.fsf@disp2133>
        <CAHk-=wivLcb3ELGSf=fM0u=PxP5m1=jRrVXDOr0+QJZRZggaHg@mail.gmail.com>
        <871r3uy2vw.fsf@disp2133>
        <CAHk-=wh8v4OC=9rjFs-QH0evVrGQu+wCVL5gE8Y-uTvqh42XNA@mail.gmail.com>
Date:   Sat, 13 Nov 2021 22:32:06 -0800
In-Reply-To: <CAHk-=wh8v4OC=9rjFs-QH0evVrGQu+wCVL5gE8Y-uTvqh42XNA@mail.gmail.com>
        (Linus Torvalds's message of "Sat, 13 Nov 2021 11:14:28 -0800")
Message-ID: <xmqqbl2nmemx.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 96E7923E-4514-11EC-B0F8-62A2C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Linus Torvalds <torvalds@linux-foundation.org> writes:

> The basic issue is how to sanely keep track of a cover letter when you
> have a branch that you haven't sent out yet, but will ask somebody to
> pull. It may still be seeing more testing and development before that
> pull happens, though.
>
> This very much smells of what the "branch description" is all about, but
>
>  (a) I suspect "git branch --edit-description" is not very well known

True.


>  (b) it works well with "git request-pull", but not so much some other
> things (like copying it into a signed tag)

I think that is just a matter of programming ;-)

>  (c) it makes an unholy mess of your config file if you actually use
> it for extensive explanations (branch descriptions _work_ for
> multi-line messages, but it really was designed as a one-liner thing).

Not, really.

The "-m" option similar to "commit/tag" is deliberately omitted and
use of editor is forced, to encourage better than one-liner
information.  cf. b7200e83 (branch: teach --edit-description option,
2011-09-20).

The unholy mess is true if you are in the habit of editing .git/config
in your editor, but that is to be expected if you are storing multi
paragraph description as a value of a configuration variable.

>  (d) it doesn't work across repositories (ie multiple developers or
> even just a single developer on multiple machines).

This is the biggest issue.

> IOW, the "branch description" is _kind_ of the right thing, but not really.

Having said all that, quite honestly, as the inventor of the
"--edit-description", I did it as sort of a joke, and not a serious
"feature".

> An empty commit would do it as well, but an empty commit very easily
> gets lost (git rebase etc). The fake merge does have similar issues.

These days, I think rebase distinguishes between "an empty commit
that is deliberately empty from the beginning" and "a commit that
was not empty, but because we are applying on a new base, it has
become unnecessary and empty", and we can tell the command to drop
the latter while keeping the former.  So if I were to design a
recommended workflow (and add any missing workflow elements), it
would be:

 - You develop your N-patch series on a branch;

 - You conclude with an empty commit that records your cover letter
   material.

 - "git commit" may want to learn a new option that automatically
   prepares summary of the last N patches in the commit log
   editor, and the option should imply the "--allow-empty" option.
   That would help when editing such an empty commit that will
   become the cover letter.

 - You repeatedly "rebase -i", "cherry-pick", etc. to whip your
   branch into shape.

 - You can push and fetch such a branch among your machines and your
   group.

 - "git format-patch" may want to recognize that the topmost commit
   is an empty commit, and use that as the seed material for the
   cover letter.

 - If your project's pull request requires a signed tag with cover
   letter material, "git tag -s" may want to learn a new option to
   be fed such a branch with N-patch plus the topmost empty commit,
   and tag the last real commit in the topic (i.e. the parent of the
   topmost empty commit) with material taken from the topmost empty
   commit.

> Both a fake merge, and an empty commit have the advantage that they
> are easy to see and work with (ie "git log" and all the other git
> workflows work very naturally).
>
> Comments from git people?
>
>                 Linus

I can see how the above outline would work.  I do not know if it
would work well for your project, or there are other workflows for
which the above outline would be insufficient.

