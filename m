Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB153EE49A5
	for <git@archiver.kernel.org>; Tue, 22 Aug 2023 19:45:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230283AbjHVTpe (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Aug 2023 15:45:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230273AbjHVTpd (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Aug 2023 15:45:33 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F1F7CED
        for <git@vger.kernel.org>; Tue, 22 Aug 2023 12:45:30 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id D90D01FF41;
        Tue, 22 Aug 2023 15:45:29 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=68MI9PX8uvIGzswURFN6uCWtZgXJdnQvFbXJpx
        1j59A=; b=hoY9JUObFKlnFoIwt7HG7OxqkIoZkaxN9dWjx+qfTM1OGyc456mWwg
        GyXsNRbrKa+1+7RqNaRohnKJT0fVt4IY1eVuN7R3lA42Dzq97Qc35is/GXq7pC1O
        y+KJc5QQD8Ie4430eChY4h39gQLqDFt5YrZnQe0vbz3tK1C5RtOAg=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id D22E21FF40;
        Tue, 22 Aug 2023 15:45:29 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.58.166])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id EE7541FF3B;
        Tue, 22 Aug 2023 15:45:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, johannes.schindelin@gmx.de,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH v2 3/3] scalar reconfigure: help users remove buggy repos
References: <pull.1569.git.1692025937.gitgitgadget@gmail.com>
        <pull.1569.v2.git.1692725056.gitgitgadget@gmail.com>
        <7ac7311863d2e05c3dc8e26cb821fe8a7c4b6804.1692725056.git.gitgitgadget@gmail.com>
Date:   Tue, 22 Aug 2023 12:45:25 -0700
In-Reply-To: <7ac7311863d2e05c3dc8e26cb821fe8a7c4b6804.1692725056.git.gitgitgadget@gmail.com>
        (Derrick Stolee via GitGitGadget's message of "Tue, 22 Aug 2023
        17:24:15 +0000")
Message-ID: <xmqqmsyilv3e.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 714381CE-4124-11EE-BEDA-F515D2CDFF5E-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

> @@ -664,6 +664,7 @@ static int cmd_reconfigure(int argc, const char **argv)
>  	git_config(get_scalar_repos, &scalar_repos);
>  
>  	for (i = 0; i < scalar_repos.nr; i++) {
> +		int succeeded = 0;
>  		const char *dir = scalar_repos.items[i].string;
>  
>  		strbuf_reset(&commondir);
> @@ -674,27 +675,51 @@ static int cmd_reconfigure(int argc, const char **argv)
>  
>  			if (errno != ENOENT) {
>  				warning_errno(_("could not switch to '%s'"), dir);
> -				res = -1;
> -				continue;
> +				goto loop_end;

This is after seeing chdir(dir) failed.  If the user manually
removed the enlisted directory, ENOENT would be one of the most
likely errors.  If the user dropped a file to the place after it was
vacated, we may get ENOTDIR, which is also not so bad.

In any case, is it desirable to keep the enlistment still configured
by jumping to loop_end in these "other" error conditions?  If the
reason why we cannot chdir() into it is because of some tentative
glitch that may resolve by itself, retaining the enlistment data may
have value, because it can be reused without the user having to
recreate the enlistment when the "tentatively unavailable" directory
comes back online, I guess, but how realistic would such an error
be?

>  			}
>  
>  			strbuf_addstr(&buf, dir);
>  			if (remove_deleted_enlistment(&buf))
> -				res = error(_("could not remove stale "
> -					      "scalar.repo '%s'"), dir);
> -			else
> -				warning(_("removing stale scalar.repo '%s'"),
> +				error(_("could not remove stale "
> +					"scalar.repo '%s'"), dir);
> +			else {
> +				warning(_("removed stale scalar.repo '%s'"),
>  					dir);
> +				succeeded = 1;
> +			}
>  			strbuf_release(&buf);
> -		} else {
> -			git_config_clear();
> +			goto loop_end;
> +		}

So the above is "what if we fail to chdir()", which looked sensible.
Then comes the "what if we don't have a usable repository there?", which
was lost in [PATCH 2/3].

> +		switch (discover_git_directory_reason(&commondir, &gitdir)) {
> +		case GIT_DIR_INVALID_OWNERSHIP:
> +			warning(_("repository at '%s' has different owner"), dir);
> +			goto loop_end;
> +
> +		case GIT_DIR_DISCOVERED:
> +			succeeded = 1;
> +			break;
> +
> +		default:
> +			warning(_("repository not found in '%s'"), dir);
> +			break;

Among the error cases, INVALID_OWNERSHIP is one of the possibilities
that merits specialized message to the end-user.  I wonder if others
also deserve to be explained, though.

 - HIT_CEILING and HIT_MOUNT_POINT will happen when there is no
   usable repository between "dir" and the specified ceiling.

 - INVALID_GITFILE and INVALID_FORMAT are signs of some repository
   corruption.

 - DISALLOWED_BARE is unlikely to happen in the scalar context.

> +		}
> +
> +		git_config_clear();
> +
> +		the_repository = &r;
> +		r.commondir = commondir.buf;
> +		r.gitdir = gitdir.buf;
>  
> -			the_repository = &r;
> -			r.commondir = commondir.buf;
> -			r.gitdir = gitdir.buf;
> +		if (set_recommended_config(1) >= 0)
> +			succeeded = 1;
>  
> -			if (set_recommended_config(1) < 0)
> -				res = -1;
> +loop_end:
> +		if (!succeeded) {
> +			res = -1;
> +			warning(_("to unregister this repository from Scalar, run\n"
> +				  "\tgit config --global --unset --fixed-value scalar.repo \"%s\""),
> +				dir);

Ah, OK.  So the strategy is to punt on accepting the responsibility
for removing an inaccessible directory; rather, we just report that
we had trouble chdir() and let the user decide.  Which makes sense.

Thanks.

>  		}
>  	}
