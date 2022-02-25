Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE275C433EF
	for <git@archiver.kernel.org>; Fri, 25 Feb 2022 17:59:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231659AbiBYSAT (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 25 Feb 2022 13:00:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229984AbiBYSAS (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Feb 2022 13:00:18 -0500
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6E9821EB9C
        for <git@vger.kernel.org>; Fri, 25 Feb 2022 09:59:45 -0800 (PST)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 6C80D1017DB;
        Fri, 25 Feb 2022 12:59:43 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=HBMfiJBVRULW79/s1vJYmKjI1B6DAJiNiV1jE6
        /wgIg=; b=cHlZMD2H0Sied7hyjzHrVwwdgyk9rUNs5EjF1oJr9fJ+vsQ6gyTJD+
        Nv4g0F7KjU0p9Fu19d712nUS4zTmMYfJqoWCVx2Y8w8c85jfC2NwgRWPxXIwTUVZ
        SlKYpYBS6/VIIMNuYb/KrampgCRJCjhFG2IDwC+eEyS6p/mU0sksc=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 63D281017DA;
        Fri, 25 Feb 2022 12:59:43 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id C98B41017D9;
        Fri, 25 Feb 2022 12:59:42 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH] worktree: add -z option for list subcommand
References: <pull.1164.git.1645801727732.gitgitgadget@gmail.com>
Date:   Fri, 25 Feb 2022 09:59:41 -0800
In-Reply-To: <pull.1164.git.1645801727732.gitgitgadget@gmail.com> (Phillip
        Wood via GitGitGadget's message of "Fri, 25 Feb 2022 15:08:47 +0000")
Message-ID: <xmqqh78mesj6.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B58C7B72-9664-11EC-AE37-CB998F0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com> writes:

> +-z::
> +	When `--porcelain` is specified with `list` terminate each line with a
> +	NUL rather than a newline. This makes it possible to parse the output
> +	when a worktree path contains a newline character.

This makes it sound as if it were impossible.  As the changes this
patch makes to the documentation and the code indicate, we were
already doing quote_c_style(), so it is not quite correct to say so.

Perhaps "makes it easier" is more accurate?

Unless the original wasn't using quote_c_style() correctly and
wasn't quoting its output, that is?

> @@ -411,7 +417,8 @@ working tree itself.
>  
>  Porcelain Format
>  ~~~~~~~~~~~~~~~~
> -The porcelain format has a line per attribute.  Attributes are listed with a
> +The porcelain format has a line per attribute.  If `-z` is given then the lines
> +are terminated with NUL rather than a newline.  Attributes are listed with a
>  label and value separated by a single space.  Boolean attributes (like `bare`
>  and `detached`) are listed as a label only, and are present only
>  if the value is true.  Some attributes (like `locked`) can be listed as a label
> @@ -449,7 +456,7 @@ prunable gitdir file points to non-existent location
>  
>  ------------
>  
> -If the lock reason contains "unusual" characters such as newline, they
> +Unless `-z` is used any "unusual" characters in the lock reason such as newlines
>  are escaped and the entire reason is quoted as explained for the

OK.  That is sensible.

>  	reason = worktree_lock_reason(wt);
>  	if (reason && *reason) {
>  		struct strbuf sb = STRBUF_INIT;
> -		quote_c_style(reason, &sb, NULL, 0);
> -		printf("locked %s\n", sb.buf);
> +		if (line_terminator) {
> +			quote_c_style(reason, &sb, NULL, 0);
> +			reason = sb.buf;
> +		}
> +		printf("locked %s%c", reason, line_terminator);

OK.  I suspect write_name_quoted() may be a better fit that does not
require us to have our own strbuf, but this should be OK.

>  		strbuf_release(&sb);
>  	} else if (reason)
> -		printf("locked\n");
> +		printf("locked%c", line_terminator);

It is a shame that we need a special code path for an empty string
given as the reason, only for the single SP after "locked", but we
have to live with it, I guess.

>  	reason = worktree_prune_reason(wt, expire);
>  	if (reason)
> -		printf("prunable %s\n", reason);
> +		printf("prunable %s%c", reason, line_terminator);
>  
> -	printf("\n");
> +	fputc(line_terminator, stdout);
>  }

All code changes looked sensible.

> +	else if (!line_terminator && !porcelain)
> +		die(_("'-z' requires '--porcelain'"));
>  	else {
>  		struct worktree **worktrees = get_worktrees();
>  		int path_maxlen = 0, abbrev = DEFAULT_ABBREV, i;
> @@ -708,7 +716,8 @@ static int list(int ac, const char **av, const char *prefix)
>  
>  		for (i = 0; worktrees[i]; i++) {
>  			if (porcelain)
> -				show_worktree_porcelain(worktrees[i]);
> +				show_worktree_porcelain(worktrees[i],
> +							line_terminator);
>  			else
>  				show_worktree(worktrees[i], path_maxlen, abbrev);
>  		}
