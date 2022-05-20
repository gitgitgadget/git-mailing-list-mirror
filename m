Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60BAEC433EF
	for <git@archiver.kernel.org>; Fri, 20 May 2022 18:39:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352988AbiETSj0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 20 May 2022 14:39:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353012AbiETSjC (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 May 2022 14:39:02 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09198195BFC
        for <git@vger.kernel.org>; Fri, 20 May 2022 11:39:00 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 121C119BDA3;
        Fri, 20 May 2022 14:39:00 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=DWYcAVqt9Vc312mbCrGWeG/OxrY8IjCH6DHX57
        XO2SU=; b=NiEAzGiOTl/DWn7zFTR8dObWIuPglukjVvWc28glY2MHrUtGkUdp3H
        fEdY1TovNLwC+kQZNncilXSCv7puZkruMmwS7zkzYSyvqqpXraNuLF/+M1gIsQhW
        Ldww6JNt2RqTqMrTOkTCSLPKlPcpRUZUI4qU1F5BEcKbuogvmfhOg=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 0BDE619BDA2;
        Fri, 20 May 2022 14:39:00 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.247.111.240])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id AA0BC19BDA0;
        Fri, 20 May 2022 14:38:56 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Kevin Locke <kevin@kevinlocke.name>
Cc:     git@vger.kernel.org, Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH] setup: don't die if realpath(3) fails on getcwd(3)
References: <80eeba2b2a58af2a5497f398beb5c03447c41f61.1653003552.git.kevin@kevinlocke.name>
Date:   Fri, 20 May 2022 11:38:55 -0700
In-Reply-To: <80eeba2b2a58af2a5497f398beb5c03447c41f61.1653003552.git.kevin@kevinlocke.name>
        (Kevin Locke's message of "Thu, 19 May 2022 17:39:13 -0600")
Message-ID: <xmqqtu9kgibk.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 1B43A87A-D86C-11EC-925C-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Kevin Locke <kevin@kevinlocke.name> writes:

> Prior to Git 2.35.0, git could be run from an inaccessible working
> directory so long as the git repository specified by options and/or
> environment variables was accessible.  For example:
>
>     git init repo
>     mkdir -p a/b
>     cd a/b
>     chmod u-x ..
>     git -C "${PWD%/a/b}/repo" status
>
> If this example seems a bit contrived, consider running with the
> repository owner as a substitute UID (e.g. with runuser(1) or sudo(8))
> without ensuring the working directory is accessible by that user.
>
> The code added by e6f8861bd4 to preserve the working directory attempts
> to normalize the path using strbuf_realpath().  If that fails, as in the
> case above, it is treated as a fatal error.

Thanks.  As this thing is primarily for safety, I am inclined to say
that I'd prefer to see it error out when we cannot figure out the
necessary info to keep that safety promise to the users, than using
an unnormalized value as a stand-in and letting the logic that is
designed to be fed a normalized value do random (and possibly wrong)
things.  But see below.

> Fixes: e6f8861bd4 ("setup: introduce startup_info->original_cwd")

AFAIK, we do not use this kind of trailer in this project.  Casting
in stone the claim that this "fixes" would be embarrassing when it
turns out that it does not fix it (or even worse, breaks it).

> Signed-off-by: Kevin Locke <kevin@kevinlocke.name>
> ---
>  setup.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
>
> diff --git a/setup.c b/setup.c
> index a7b36f3ffb..fb68caaae0 100644
> --- a/setup.c
> +++ b/setup.c
> @@ -458,11 +458,13 @@ static void setup_original_cwd(void)
>  	 *     not startup_info->original_cwd.
>  	 */
>  
> -	/* Normalize the directory */
> -	strbuf_realpath(&tmp, tmp_original_cwd, 1);
> -	free((char*)tmp_original_cwd);
> +	/* Try to normalize the directory.  Fails if ancestor not readable. */
> +	if (strbuf_realpath(&tmp, tmp_original_cwd, 0)) {
> +		free((char*)tmp_original_cwd);
> +		startup_info->original_cwd = strbuf_detach(&tmp, NULL);
> +	} else
> +		startup_info->original_cwd = tmp_original_cwd;

I am OK to loosen the "we try not to remove the original cwd" logic
so that it does not kick in when we cannot figure out the original
cwd in the first place.  But if that is the case, then I'd rather
see "startrup_info->original_cwd set to NULL" as the signal that we
are in such a situation.

Elijah, what's your take on this change?

>  	tmp_original_cwd = NULL;
> -	startup_info->original_cwd = strbuf_detach(&tmp, NULL);
>  
>  	/*
>  	 * Get our worktree; we only protect the current working directory
