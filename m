Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD518C433F5
	for <git@archiver.kernel.org>; Fri, 15 Oct 2021 17:14:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 991A8610E8
	for <git@archiver.kernel.org>; Fri, 15 Oct 2021 17:14:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242106AbhJORQ7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 15 Oct 2021 13:16:59 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:55933 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238023AbhJORQ6 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Oct 2021 13:16:58 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 3E667EA1C9;
        Fri, 15 Oct 2021 13:14:49 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=erlD45pv0CL6vUWbF03Oeo44LMYCG+hvdkFzZb
        WW8hw=; b=YLT4o64tYVWUePe+A6A+80ZfgKD0FWMcTfTVWPXPPsplsuti+wPRuK
        Zsyt73ka/5s36dL6Xa3t4GGDxGWASUQda1Ah6etHwKUC5ymDWF/BJ03/Q3ncsQe1
        OUpJB8bbZtFUSOtBneJ/XON1FhNF7UM5tozWSb8VnJMoviO4TdeXk=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 35974EA1C8;
        Fri, 15 Oct 2021 13:14:49 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 9C736EA1C7;
        Fri, 15 Oct 2021 13:14:48 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     git@vger.kernel.org, Glen Choo <chooglen@google.com>,
        Carlo Arenas <carenas@gmail.com>
Subject: Re: [PATCH v2] Documentation: specify base point when generating
 MyFirstContribution patchset
References: <20211015122515.47535-1-bagasdotme@gmail.com>
Date:   Fri, 15 Oct 2021 10:14:47 -0700
In-Reply-To: <20211015122515.47535-1-bagasdotme@gmail.com> (Bagas Sanjaya's
        message of "Fri, 15 Oct 2021 19:25:16 +0700")
Message-ID: <xmqqo87q6whk.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 66BFE430-2DDB-11EC-9ECD-CD991BBA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Bagas Sanjaya <bagasdotme@gmail.com> writes:

> +It would help those who review and test your patches to specify on what
> +commit the patches should be applied to. To do so, use the `--base` option
> +when running `format-patch`. The option expects hash of the commit the
> +patchset is based on. Since we base `psuh` on top of `master`, the base
> +commit hash can be determined by: 
> +
> +----
> +$ git show -s --format="%H" master
> +----

That's a littie bit wasteful.

If we need to teach more stuff (like --format="%H"), one thing that
more directly help this exact use case is to teach

    git merge-base master psuh

here.  But read on.

> +The output of command above can be passed to `--base` option. Replace `<base>`
> +with your own hash:
> +
> +----
> +$ git format-patch --cover-letter --base=<base> -o psuh/ master..psuh
> +----
> +

If we set up the psuh branch correctly, we can use the `--base=auto`
option, which would reduce the number of things readers need to
learn by one.  Then the whole example in this patch can be reduced
to (after dropping "Since we base `psuh` on top of `master`..." at
the end of the previous paragraph):

    patchset is based on.  As we forked `psuh` to build on
    `origin/master`, we can use the `--base=auto` option when
    running the `format-patch` command, like so:

    ----
    $ git format-patch --cover-letter --base=auto -o psuh/ origin/master..psuh
    ----

That is one fewer step the user needs to execute.

This needs one line change in the earlier part of the document (not
touched by the patch under discussion here). 

In the [[setup-workspace]] section, we create the psuh by branching
out of the origin/master (not 'master', so the references to
`master` in the patch under discussion need to be updated, which I
did in the above paragraph already), like so:

    ----
    $ git checkout -b psuh origin/master
    ----

All we need to do is to pass the `-t` option there, i.e.

    ----
    $ git checkout -t -b psuh origin/master
    ----
    
to make the --base=auto work, I think.

Thanks.


[Addendum]

Also, if the tutorial text naturally guides the user to be "on" the
`psuh` branch when the patches are taken from it, we could even
shorten the command to

    ----
    $ git format-patch --cover-letter --base=auto -o psuh/ @{u}..
    ----

That extra shortening would need a bit more work in the earlier part
of [[format-patch]] section around the part that says "Luckily, this
is pretty simple".  Basically, we need to invent a plausible story
for the user to have done "git checkout psuh" earlier, so that it is
clear to the readers that the `psuh` branch is the current branch.

So it probably is a good idea to leave it outside the scope of this
topic.
