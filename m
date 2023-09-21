Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA76BE7D0A6
	for <git@archiver.kernel.org>; Thu, 21 Sep 2023 19:56:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231267AbjIUT4V (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Sep 2023 15:56:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230264AbjIUT4G (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Sep 2023 15:56:06 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2F6FB0A1F
        for <git@vger.kernel.org>; Thu, 21 Sep 2023 12:04:17 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 50FBF1ED17;
        Thu, 21 Sep 2023 15:04:16 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type; s=sasl; bh=TjoFjr9BouNOKFzSP81/H0U+Y8KwJOsowx8Mak
        YozKg=; b=qT0pf6gmHtW2pwYpClK16gNWw61Twf2wTxPjJO87C0r4nFtr9pGmWU
        bPp4QFHtZTjc2KNhMdCDAwrJeQLwU0VOqvzmI/82DGRnYTS/2YBiNDari1TIUsMa
        zx4jSu8rMGeLqoiwA0xtgThMmxfSJliQKV5yIhz7UtfTHcULj8Zvk=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 491B21ED16;
        Thu, 21 Sep 2023 15:04:16 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id C77671ED13;
        Thu, 21 Sep 2023 15:04:12 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Patrick Steinhardt <ps@pks.im>
Cc:     git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH] revision: make pseudo-opt flags read via stdin behave
 consistently
In-Reply-To: <b93d4c8c23552abab64084b62f27944e7e192c0c.1695290733.git.ps@pks.im>
        (Patrick Steinhardt's message of "Thu, 21 Sep 2023 12:05:57 +0200")
References: <b93d4c8c23552abab64084b62f27944e7e192c0c.1695290733.git.ps@pks.im>
Date:   Thu, 21 Sep 2023 12:04:11 -0700
Message-ID: <xmqqmsxf5owk.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A6F0A9BA-58B1-11EE-9B4D-F515D2CDFF5E-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Patrick Steinhardt <ps@pks.im> writes:

> Instead, we change the behaviour of how pseudo-opts read via standard
> input influence the flags such that the effect is fully localized. With
> this change, when reading `--not` via standard input, it will:
>
>     - _Not_ influence subsequent revisions or pseudo-options passed on
>       the command line, which is a change in behaviour.
>
>     - Influence pseudo-options passed via standard input.
>
>     - Influence normal revisions passed via standard input, which is a
>       change in behaviour.
>
> Thus, all flags read via standard input are fully self-contained to that
> standard input, only.

I have to wonder what the most natural expectation by end-users be,
when "cmd --opt1 --stdin --opt3 arg2" is run and its stdin is fed
"--opt2 arg1".  One interpretation may be to act as if "--stdin" on
the command line is replaced with what was read, but taken literally
that would make "cmd --opt1 --opt2 arg1 --opt3 arg2" that does not
make sense (i.e. options must come before arguments).  We could
declare "--stdin is replaced by options read from there, and
non-options read from the standard input are handled separately",
but then it could be argued "cmd --opt1 --opt2 --opt3 arg2 arg1"
and "cmd --opt1 --opt2 --opt3 arg1 arg2" are equally plausible.

So in a sense, "what is read from --stdin is self contained" may be
the easiest to explain position to take.

> While this is a breaking change as well, the behaviour has only been
> recently introduced with Git v2.42.0. Furthermore, the current behaviour
> can be regarded as a simple bug. With that in mind it feels like the
> right thing to do retroactively change it and make the behaviour sane.

While I also appreciate your cautious approach to consider the risk
that this "fix" may have negative consequence, I tend to agree that
the behaviour is simply buggy and deserves to be fixed on the
'maint' track.

> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> Reported-by: Christian Couder <christian.couder@gmail.com>
> ---
>  Documentation/rev-list-options.txt |  6 +++++-
>  revision.c                         | 10 +++++-----
>  t/t6017-rev-list-stdin.sh          | 21 +++++++++++++++++++++
>  3 files changed, 31 insertions(+), 6 deletions(-)
>
> diff --git a/Documentation/rev-list-options.txt b/Documentation/rev-list-options.txt
> index a4a0cb93b2..9bf13bac53 100644
> --- a/Documentation/rev-list-options.txt
> +++ b/Documentation/rev-list-options.txt
> @@ -151,6 +151,8 @@ endif::git-log[]
>  --not::
>  	Reverses the meaning of the '{caret}' prefix (or lack thereof)
>  	for all following revision specifiers, up to the next `--not`.
> +	When used on the command line before --stdin, the revisions passed
> +	through stdin will not be affected by it.

Do we also need to say "when read from --stdin, the revisions passed
on the command line are not affected" as well?  I know you have it
where you explian "--stdin" in the next hunk, but since you are
adding one-half of the interaction, it may be less confusing to also
mention the other half at the same time.

> @@ -240,7 +242,9 @@ endif::git-rev-list[]
>  	them from standard input as well. This accepts commits and
>  	pseudo-options like `--all` and `--glob=`. When a `--` separator
>  	is seen, the following input is treated as paths and used to
> -	limit the result.
> +	limit the result. Flags like `--not` which are read via standard input
> +	are only respected for arguments passed in the same way and will not
> +	influence any subsequent command line arguments.

Other than that, looking good, and the changes to the code look all
sensible.

Thanks.
