Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B009C001DB
	for <git@archiver.kernel.org>; Mon, 14 Aug 2023 16:30:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232919AbjHNQaM (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 14 Aug 2023 12:30:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232620AbjHNQ3u (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Aug 2023 12:29:50 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A1D8E5B
        for <git@vger.kernel.org>; Mon, 14 Aug 2023 09:29:48 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id A3ABA1BF4A;
        Mon, 14 Aug 2023 12:29:48 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=e4cBeRZjWoPVWKBvjRFPwbB9FUSthBbNuBqjWj
        YDANY=; b=dGAGU4ErHyPYkdJPzlBnKS/cnEtbTlHjLC2TnAEqEto9fW0dmKcoWD
        VZXGkvmabS0rfU/Rz4SCms81cKL8X9NvIiHyQijVugU+X2vj1N4cHRxuniWs+eYF
        q0HrHoE1IRfBCNOlei8I8qid0EbESlQaSP7xE1espW9wsArrvz6Kg=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 9C4581BF49;
        Mon, 14 Aug 2023 12:29:48 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.58.166])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 570301BF48;
        Mon, 14 Aug 2023 12:29:45 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, johannes.schindelin@gmx.de,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH 2/3] setup: add discover_git_directory_reason()
References: <pull.1569.git.1692025937.gitgitgadget@gmail.com>
        <fbba6252aeabc9a77d8529e4725feb3ea995545f.1692025937.git.gitgitgadget@gmail.com>
Date:   Mon, 14 Aug 2023 09:29:44 -0700
In-Reply-To: <fbba6252aeabc9a77d8529e4725feb3ea995545f.1692025937.git.gitgitgadget@gmail.com>
        (Derrick Stolee via GitGitGadget's message of "Mon, 14 Aug 2023
        15:12:16 +0000")
Message-ID: <xmqqpm3plh8n.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C76811DE-3ABF-11EE-83D6-B31D44D1D7AA-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Derrick Stolee <derrickstolee@github.com>
>
> There are many reasons why discovering a Git directory may fail. In
> particular, 8959555cee7 (setup_git_directory(): add an owner check for
> the top-level directory, 2022-03-02) added ownership checks as a
> security precaution.
>
> Callers attempting to set up a Git directory may want to inform the user
> about the reason for the failure. For that, expose the enum
> discovery_result from within setup.c and into cache.h where
> discover_git_directory() is defined.
>
> I initially wanted to change the return type of discover_git_directory()
> to be this enum, but several callers rely upon the "zero means success".
> The two problems with this are:
>
> 1. The zero value of the enum is actually GIT_DIR_NONE, so nonpositive
>    results are errors.

True. discover_git_directory() already knows that negative return
values from setup_git_directory_gently_1() signal errors while 0 or
positive are OK.

> 2. There are multiple successful states, so some positive results are
>    successful.

Makes it sound as if some positive results are not successes, but is
that really the case?

> Instead of updating all callers immediately, add a new method,
> discover_git_directory_reason(), and convert discover_git_directory() to
> be a thin shim on top of it.

It makes sense to insulate callers who only want to know if the
discovery was successful or not (there only are two existing callers
anyway) from the details.  And turning a thin wrapper to the new API
that gives richer return codes is the way to go.  Nicely designed.

> Because there are extra checks that discover_git_directory_reason() does
> after setup_git_directory_gently_1(), there are other modes that can be
> returned for failure states. Add these modes to the enum, but be sure to
> explicitly add them as BUG() states in the switch of
> setup_git_directory_gently().

Good.

> -enum discovery_result {
> -	GIT_DIR_NONE = 0,
> -	GIT_DIR_EXPLICIT,
> -	GIT_DIR_DISCOVERED,
> -	GIT_DIR_BARE,
> -	/* these are errors */
> -	GIT_DIR_HIT_CEILING = -1,
> -	GIT_DIR_HIT_MOUNT_POINT = -2,
> -	GIT_DIR_INVALID_GITFILE = -3,
> -	GIT_DIR_INVALID_OWNERSHIP = -4,
> -	GIT_DIR_DISALLOWED_BARE = -5,
> -};

So we promote this discovery_result, that was private implementation
detail inside the setup code, to a public interface.  Is GIT_DIR_
prefix still appropriate, or would it make more sense to have a
common substring derived from the word DISCOVERY in them?

> @@ -1385,21 +1372,22 @@ static enum discovery_result setup_git_directory_gently_1(struct strbuf *dir,
>  	}
>  }
>  
> -int discover_git_directory(struct strbuf *commondir,
> -			   struct strbuf *gitdir)
> +enum discovery_result discover_git_directory_reason(struct strbuf *commondir,
> +						    struct strbuf *gitdir)
>  {
>  	struct strbuf dir = STRBUF_INIT, err = STRBUF_INIT;
>  	size_t gitdir_offset = gitdir->len, cwd_len;
>  	size_t commondir_offset = commondir->len;
>  	struct repository_format candidate = REPOSITORY_FORMAT_INIT;
> +	enum discovery_result result;
>  
>  	if (strbuf_getcwd(&dir))
> -		return -1;
> +		return GIT_DIR_CWD_FAILURE;

Makes sense.

>  	cwd_len = dir.len;
> -	if (setup_git_directory_gently_1(&dir, gitdir, NULL, 0) <= 0) {
> +	if ((result = setup_git_directory_gently_1(&dir, gitdir, NULL, 0)) <= 0) {

Can we split this into two simple statements?

	result = setup_git_directory_gently_1(...);
	if (result <= 0) {

>  		strbuf_release(&dir);
> -		return -1;
> +		return result;
>  	}

OK.

> @@ -1429,11 +1417,11 @@ int discover_git_directory(struct strbuf *commondir,
>  		strbuf_setlen(commondir, commondir_offset);
>  		strbuf_setlen(gitdir, gitdir_offset);
>  		clear_repository_format(&candidate);
> -		return -1;
> +		return GIT_DIR_INVALID_FORMAT;

OK, so this thing is new.  Earlier we thought we found a good
GIT_DIR but it turns out the repository is something we cannot use.
Over time we may acquire such a "now we found it, is it really good?"
sanity checks, but for now, this is the only case that turns what
gently_1() thought was good into a bad one.  OK.

>  	}
>  
>  	clear_repository_format(&candidate);
> -	return 0;
> +	return result;

And it makes perfect sense that everybody who passed such a "post
discovery check" are OK and we return the result from gently_1().

> @@ -1516,9 +1504,11 @@ const char *setup_git_directory_gently(int *nongit_ok)
>  		*nongit_ok = 1;
>  		break;
>  	case GIT_DIR_NONE:
> +	case GIT_DIR_CWD_FAILURE:
> +	case GIT_DIR_INVALID_FORMAT:
>  		/*
>  		 * As a safeguard against setup_git_directory_gently_1 returning
> -		 * this value, fallthrough to BUG. Otherwise it is possible to
> +		 * these values, fallthrough to BUG. Otherwise it is possible to
>  		 * set startup_info->have_repository to 1 when we did nothing to
>  		 * find a repository.
>  		 */

OK.

Not a new problem, but does anybody explicitly or implicitly return
DIR_NONE?  I didn't find any codepath that does so.  Presumably it
may have been arranged in the hope that a code structured like so:

	enum discovery_result res = GIT_DIR_NONE;

	if (some complex condition)
		res = ...;
	else if (another complex condition)
		res = ...;

	... sometime later ...
	if (res <= 0)
		we found a bad one

would ensure that "res" untouched by setup_git_directory_gently_1()
is still an error, but I am not sure if it is effective, given that
nobody uses GIT_DIR_NONE to assign or initialize anything.  And the
same effect can be had by leaving 'res' uninitialized---the compilers
are our friend.

Not a part of this review, but I wonder if it makes sense for us to
get rid of DIR_NONE.

> -int discover_git_directory(struct strbuf *commondir,
> -			   struct strbuf *gitdir);
> +static inline int discover_git_directory(struct strbuf *commondir,
> +					 struct strbuf *gitdir)
> +{
> +	return discover_git_directory_reason(commondir, gitdir) <= 0;
> +}

The _reason() thing is more or less like setup_git_directory_gently_1()
in that positives are success and everything else is an error.  And
the point of keeping this thin wrapper as discover_git_directory() is
to insulate the existing callers that discover_git_directory() returns
-1 for failure, while returning 0 for success.

So this wrapper smells very wrong.  It now flips the polarity of the
error return into a positive 1, no?  That does not achieve the goal
to insulate the callers from the change in implementation.

Other than that, as you wrote in the cover letter, I think it is an
excellent move to have an interface to expose details of what
discovery has found.

Thanks.
