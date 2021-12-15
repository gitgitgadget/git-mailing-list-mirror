Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D68CEC433EF
	for <git@archiver.kernel.org>; Wed, 15 Dec 2021 22:32:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231262AbhLOWcj (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Dec 2021 17:32:39 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:51804 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230453AbhLOWcj (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Dec 2021 17:32:39 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 576EE10D7E8;
        Wed, 15 Dec 2021 17:32:38 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=urHt9DAbcbk9cWMXauPp5I/jwYNZq2qLxGLxyd
        YLmzk=; b=A65p5Sl4t1kXmq4whTyA66GNCG7AntPhtj72PgZerUcWLmKqgdg8VN
        mGDUZbwlhWL1aYf9dsfAKdWyKmx5WgdXlxXX4ph26QMJwzOrQ3XYWQD5x78Y/BPd
        m0ZoP3t9bLYXt+G7StVGe0PEX9B6W3qZdQaqc9JpT4pAmnF8T2GcU=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 4F61F10D7E7;
        Wed, 15 Dec 2021 17:32:38 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id AAC1D10D7E6;
        Wed, 15 Dec 2021 17:32:37 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "kashav madan via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, kashav madan <kshvmdn@gmail.com>
Subject: Re: [PATCH] help: add space after autocorrect prompt
References: <pull.1166.git.git.1639604468498.gitgitgadget@gmail.com>
Date:   Wed, 15 Dec 2021 14:32:36 -0800
In-Reply-To: <pull.1166.git.git.1639604468498.gitgitgadget@gmail.com> (kashav
        madan via GitGitGadget's message of "Wed, 15 Dec 2021 21:41:08 +0000")
Message-ID: <xmqqh7b933ej.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E7FE5D56-5DF6-11EC-895C-CB998F0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"kashav madan via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Kashav Madan <kshvmdn@gmail.com>
>
> Signed-off-by: Kashav Madan <kshvmdn@gmail.com>
> ---
>     help: add space after autocorrect prompt

The patch looks OK-ish, but let's make sure.  We will find what we
should write in the log message while doing so.

If you look at the output from

    $ git grep -C2 git_prompt \*.c

you'll notice that existing message given to git_prompt look like
these:

    yesno = git_prompt(_("Are you sure [Y/n]? "), PROMPT_ECHO);

    yesno = git_prompt(_("Do you want me to do it for you "
                         "[Y/n]? "), PROMPT_ECHO);

    strbuf_addf(&msg, _("Run '%s' instead? (y/N)"), assumed);
    answer = git_prompt(msg.buf, PROMPT_ECHO);

The last one is what you are touching in this patch.

There is another one in credential.c that asks not just a single
yes/no answer, so it is justifiably different from all the others,
but the one you noticed is different from what we see above in three
points:

 - It does not leave a SP before where the end-user input goes;
 - It append (y/N) _after_ question mark;
 - It encloses the choices in (), not [].

You are only addressing the first inconsistency, leaving the other
two still there.

So, perhaps you would want to explain the change this way

    Subject: [PATCH] help: update auto-correction prompt to look more like others

    There are three callsite of git_prompt() helper function to ask
    a "yes/no" question to the end user, but one of them in help.c
    that asks if the suggested auto-correction is OK, which is given
    when the user makes a possible typo in a Git subcommand name, is
    formatted differently from others.  Update the format string to
    make the prompt string look more consistent.


And you'd want to update the string more like so:

> -			strbuf_addf(&msg, _("Run '%s' instead? (y/N)"), assumed);
> +			strbuf_addf(&msg, _("Run '%s' instead [y/N]? "), assumed);

to fix all three points, not just one.

Thanks.
