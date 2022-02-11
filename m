Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4666C433EF
	for <git@archiver.kernel.org>; Fri, 11 Feb 2022 23:03:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239391AbiBKXDV (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Feb 2022 18:03:21 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:45070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbiBKXDU (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Feb 2022 18:03:20 -0500
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DBCAC65
        for <git@vger.kernel.org>; Fri, 11 Feb 2022 15:03:18 -0800 (PST)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 06368124826;
        Fri, 11 Feb 2022 18:03:18 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Ab3ycB56bbwMiaFvzFw8KDkvs4zwL3XupzQwmq
        u7rt8=; b=uYqv1SfbkMLIjK+96X2Knka31sGabzyfAMbrPa1OHtn4jsqebjOaYZ
        f2lAGZ8Fo3gDgZj2i5mDUU8wbHRJgDAPKVYnGJJALdnN84AfUylE9oGgJSkQh0CH
        OGjaMa4VNbHMovzgYNJvVWALmLulFlETz3o2x5WNspfB+4nXM0Q/g=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id F2162124825;
        Fri, 11 Feb 2022 18:03:17 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.185.212.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 65753124824;
        Fri, 11 Feb 2022 18:03:17 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Viaceslavus via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Viaceslavus <vaceslavkozin619@gmail.com>
Subject: Re: [PATCH v2] hard reset safe mode
References: <pull.1137.git.1643802721612.gitgitgadget@gmail.com>
        <pull.1137.v2.git.1644618404948.gitgitgadget@gmail.com>
Date:   Fri, 11 Feb 2022 15:03:16 -0800
In-Reply-To: <pull.1137.v2.git.1644618404948.gitgitgadget@gmail.com>
        (Viaceslavus via GitGitGadget's message of "Fri, 11 Feb 2022 22:26:44
        +0000")
Message-ID: <xmqqee4980qz.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: CC81CC96-8B8E-11EC-8AD6-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Viaceslavus via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Viacelaus <vaceslavkozin619@gmail.com>
>
> The power of hard reset may frequently be inconvinient for a common user. So
> this is an implementation of safe mode for hard reset. It can be switched on
> by setting 'reset.safe' config variable to true. When running 'reset --hard'
> with 'reset.safe' enabled git will check if there are any staged changes
> that may be discarded by this reset. If there is a chance of deleting the
> changes, git will ask the user for a confirmation with Yes/No choice.

There needs an explanation on how this avoids breaking scripts that
trust that "git reset --hard HEAD" reliably matches the index and
the working tree files to what is recorded in HEAD without getting
stuck waiting for any user input.  "They can turn off reset.safe" is
not an acceptable answer.

> +static int check_commit_exists(const char *refname, const struct object_id *oid, int f, void *d)
> +{
> +	return is_branch(refname);
> +}

The returned value from a for_each_ref() callback is used to tell
the caller "stop here, no need to further iterate and call me with
other refs".  I think this wants to say "if I ever get called even
once, tell the caller to stop, so that it can tell its caller that
it was stopped".

> +static void accept_discarding_changes(void) {
> +	int answer = getc(stdin);
> +	printf(_("Some staged changes may be discarded by this reset. Continue? [Y/n]"));
> +
> +	if (answer != 'y' && answer != 'Y') {
> +		printf(_("aborted\n"));
> +		exit(1);
> +	}
> +}

I'd think at least we should use git_prompt(), instead of
hand-rolled prompt routine like this one that assumes that an
end-user is sitting in front of the terminal waiting to be prompted.

If updating "git reset" like this patch does were a good idea to
begin with, that is.

> +static void detect_risky_reset(int commits_exist) {
> +	int cache = read_cache();
> +	if(!commits_exist) {
> +		if(cache == 1) {
> +			accept_discarding_changes();
> +		}
> +	}
> +	else {
> +		if(has_uncommitted_changes(the_repository, 1)) {
> +			accept_discarding_changes();
> +		}
> +	}
> +}

Style (too many to list---see Documentation/CodingGuidelines).

> +	if (reset_type == HARD) {
> +		int safe = 0;
> +		git_config_get_bool("reset.safe", &safe);
> +		if (safe) {
> +			int commits_exist = for_each_fullref_in("refs/heads", check_commit_exists, NULL);

The callback is called for each and every ref inside "refs/heads/",
so by definition, shouldn't any of them pass "is_branch(refname)"?

In any case, why does this have to be done by the caller?  If the
helper claims to be capable of detecting a "risky reset" (if such a
thing exists, that is), and if the helper behaves differently when
there is any commit on any branch or not as its implementation
detail, shouldn't it figure out if there is a commit _inside_ the
helper itself, not forcing the caller to compute it for it?

> +			detect_risky_reset(commits_exist);
> +		}
> +	}
> +
>  	if (reset_type == NONE)
>  		reset_type = MIXED; /* by default */
>  

> diff --git a/t/t7104-reset-hard.sh b/t/t7104-reset-hard.sh
> index cf9697eba9a..c962c706bed 100755
> --- a/t/t7104-reset-hard.sh
> +++ b/t/t7104-reset-hard.sh
> @@ -44,4 +44,31 @@ test_expect_success 'reset --hard did not corrupt index or cache-tree' '
>  
>  '
>  
> +test_expect_success 'reset --hard in safe mode on unborn branch with staged files results in a warning' '
> +	git config reset.safe on &&

Use either "test_when_finished" or "test_config", which is a good
way to isolate each test from side effects of running the test that
comes before it.
