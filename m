Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D24B2C433EF
	for <git@archiver.kernel.org>; Sat, 25 Dec 2021 00:35:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231946AbhLYAf5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Dec 2021 19:35:57 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:56177 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbhLYAf5 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Dec 2021 19:35:57 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 1104C164845;
        Fri, 24 Dec 2021 19:35:57 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=UU9yS7s+co5QHfyiE9ETzYQknE3mX2TmoYEegH
        3e3hA=; b=fau/K/3ZeDNt3iTQJwpCnuvfu+qZxcx1mgbrTJ8OcKUsMkBbKpW2pQ
        18A2oqPa8mjs+dJbYn7It2Z08Qwy0PpapPGG7rH0I+Dob2uouw++Zq2eTOqxNpN8
        vsu1LzjhKk5CyhHWLKFbhdZm2m+T5V3a3+jasJbbIz9dHVKhmIYok=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 09843164844;
        Fri, 24 Dec 2021 19:35:57 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 6723D164842;
        Fri, 24 Dec 2021 19:35:53 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     John Cai <jcai@gitlab.com>
Cc:     Erik Cervin Edin <erik@cervined.in>, git@vger.kernel.org
Subject: Re: bug: git name-rev --stdin --no-undefined on detached head
References: <CA+JQ7M-ORVCj6teGjVy01SF=f0=PdKKYdHNU9ruK9XUAX9F8Ag@mail.gmail.com>
        <DA9B4728-C45D-4CA0-A40D-4A81665AB0E6@gitlab.com>
        <xmqqk0ft3i3g.fsf@gitster.g>
Date:   Fri, 24 Dec 2021 16:35:52 -0800
In-Reply-To: <xmqqk0ft3i3g.fsf@gitster.g> (Junio C. Hamano's message of "Fri,
        24 Dec 2021 11:42:27 -0800")
Message-ID: <xmqqsfuh1pxz.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9DE74E0A-651A-11EC-AA31-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Two possible things we can do to improve are
>
>  * Fix the documentation; it is not for scripters but for annotating
>    text with object names.
>
>  * Possibly add --names-from-standard-input option that would behave
>    more like "we cannot afford to stuff all object names on the
>    command line, so we feed them one by one from the standard input"
>    mode the "--stdin" option of other subcommands use.
>
> I do not think the latter is so important, as it is perfectly OK to
> use xargs to split the large input into multiple invocations of
> name-rev.  This is unlike "pack-objects --stdin" where the command
> needs to see _all_ input in a single invocation.

This is primarily to teach newer developers how incompatible changes
are done in this project.  I am not suggesting that introducing such
an incompatible change and following through these steps to the end
is a good idea in this case.

Hypothetically, if name-rev were so important a command that the
xargs based workaround were unacceptable, what we would probably
do is to make the following changes over time.

 1. Introduce a new `--annotate-text` option, which is a synonym to
    the current `--stdin` option.  `--stdin` will work the same way
    as today, but using it will issue a warning() to the standard
    error to tell people to use the `--annotate-text` option
    instead.

 2. After a while, change `--stdin` to die() with a suggestion that
    people should instead pipe into xargs to invoke name-rev
    instead.

 3. After the above two steps, users and scripts of `--stdin` will
    go extinct.  Reintroduce `--stdin` but with a behaviour more in
    line with the `--stdin` option of other subcommands, i.e. take
    one arg per line from the standard input, and behave as if they
    came in the argv[] array.

The idea is to give users an early warning that is annoying enough
to encourage migration, ample time to adjust to the new world order,
and to ensure that there are no stragglers that gets hurt when the
name gets reused for an option with totally different behaviour.

It may not be a bad idea to do steps #1 and #2, though.  I do not
think xargs name-rev is bad enough to require going to the step #3,
but `--stdin` that exists and does a wrong thing is much worse than
`--stdin` that does not exist, and finishing upto step #2 is enough
to rectify that.
