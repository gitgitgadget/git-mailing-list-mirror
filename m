Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD043C04A94
	for <git@archiver.kernel.org>; Mon, 14 Aug 2023 16:45:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229953AbjHNQom (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 14 Aug 2023 12:44:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232459AbjHNQoe (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Aug 2023 12:44:34 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B6F9D2
        for <git@vger.kernel.org>; Mon, 14 Aug 2023 09:44:33 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 8126A197F4B;
        Mon, 14 Aug 2023 12:44:32 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=3kEbfiKgnHRvkqGSmNwumeptfJrXbxp3jZ5aci
        GseWs=; b=WSKnLDUbuyVMro+GmF931kvaUgIsAkftGCXgaiFtaZkHHzaKBrL2S9
        Xi6FEHoJiSdK6G/StoLaHAvBrdmQ5Y3bx7QOU+5SUaM2NJSovyqkFXpgBxh6PV5n
        6B6B8rGVacmCOxEQs5DZUHBpZ2sFOYyNAZDOWU1eWONge1tNUcsHg=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 77D94197F4A;
        Mon, 14 Aug 2023 12:44:32 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.58.166])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id E0ADE197F49;
        Mon, 14 Aug 2023 12:44:31 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, johannes.schindelin@gmx.de,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH 3/3] scalar reconfigure: help users remove buggy repos
References: <pull.1569.git.1692025937.gitgitgadget@gmail.com>
        <907410f76c4a5d7ef325545f52696a9a0c00b6b3.1692025937.git.gitgitgadget@gmail.com>
Date:   Mon, 14 Aug 2023 09:44:30 -0700
In-Reply-To: <907410f76c4a5d7ef325545f52696a9a0c00b6b3.1692025937.git.gitgitgadget@gmail.com>
        (Derrick Stolee via GitGitGadget's message of "Mon, 14 Aug 2023
        15:12:17 +0000")
Message-ID: <xmqqcyzplgk1.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D7D68F30-3AC1-11EE-972D-C65BE52EC81B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

> diff --git a/scalar.c b/scalar.c
> index 938bb73f3ce..7d87d7ea724 100644
> --- a/scalar.c
> +++ b/scalar.c
> @@ -664,6 +664,7 @@ static int cmd_reconfigure(int argc, const char **argv)
>  	git_config(get_scalar_repos, &scalar_repos);
>  
>  	for (i = 0; i < scalar_repos.nr; i++) {
> +		int failed = 0;
>  		const char *dir = scalar_repos.items[i].string;

OK.  You need a variable that lets you tell if the repository this
round of the loop dealt with was good, and do not want to abort the
loop, so you cannot reuse the "res" outside of the loop.  Makes sort
of sense.

I wonder if it makes it simpler to initialize "failed" to true
and clear it when you see it succeeded, though.

> @@ -674,30 +675,51 @@ static int cmd_reconfigure(int argc, const char **argv)
>  
>  			if (errno != ENOENT) {
>  				warning_errno(_("could not switch to '%s'"), dir);
> +				failed = -1;
> +				goto loop_end;

Such a change lets you drop this assignment ...

>  			}
>  
>  			strbuf_addstr(&buf, dir);
>  			if (remove_deleted_enlistment(&buf))
> +				failed = error(_("could not remove stale "
> +						 "scalar.repo '%s'"), dir);

... and this one, but ...

>  			else
> -				warning(_("removing stale scalar.repo '%s'"),
> +				warning(_("removed stale scalar.repo '%s'"),
>  					dir);

... you'd need to drop, i.e. "failed = 0", here while you warn.  It
is a nice touch to update the message, by the way.

>  			strbuf_release(&buf);
> +			goto loop_end;
> +		}
> +
> +		switch (discover_git_directory_reason(&commondir, &gitdir)) {
> +		case GIT_DIR_INVALID_OWNERSHIP:
> +			warning(_("repository at '%s' has different owner"), dir);
> +			failed = -1;
> +			goto loop_end;
> +
> +		case GIT_DIR_DISCOVERED:
> +			break;

... and you'd need to drop i.e. "failed = 0", here, too. but
other assignments in the switch can go.

> +		default:
> +			warning(_("repository not found in '%s'"), dir);
> +			failed = -1;
> +			break;
> +		}
> +
> +		git_config_clear();
> +
> +		the_repository = &r;
> +		r.commondir = commondir.buf;
> +		r.gitdir = gitdir.buf;
> +
> +		if (set_recommended_config(1) < 0)
> +			failed = -1;

And the polarity of the check and assignment here needs flipping.

> +loop_end:
> +		if (failed) {
> +			res = failed;

This assignment is a bit misleading, as if the value in "failed"
actually matters, when it does not.  It is merely a "did we not
succeed this round, 0 or non-zero?" boolean.  It would have been
easier to see what was going on by saying

	if (failed) {
		res = -1;

here, I would think.

> +			warning(_("to unregister this repository from Scalar, run\n"
> +				  "\tgit config --global --unset --fixed-value scalar.repo \"%s\""),
> +				dir);
>  		}
>  	}

Other than that, this step nicely justifies why the previous step
[PATCH 2/3] is a good thing to do.

Thanks.
