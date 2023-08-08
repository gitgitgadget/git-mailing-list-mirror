Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E5A8C001B0
	for <git@archiver.kernel.org>; Tue,  8 Aug 2023 18:43:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230294AbjHHSnE (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Aug 2023 14:43:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233639AbjHHSma (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Aug 2023 14:42:30 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB07CEB390
        for <git@vger.kernel.org>; Tue,  8 Aug 2023 09:34:59 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 157581A12F0;
        Tue,  8 Aug 2023 12:34:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=vKsrgQFD/dkYtiozdWNFTZI3Mws4zImH3ruSQy
        HV1xQ=; b=pOeppYwNfFprRgqNjTmoEBXJeHGvHabWTXz1E5nHleySz1kGg6fcVd
        TL1+AmCRG1rnIWzHF4S/pevw2XPLyBY0qymlSeJG55wQuiXvMytMEPQaEBueZQ/V
        pjZJyF8oKqGywVqotV+IJyfORJ+23jDdfdrqxYHsS6K8C39jDvBSg=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 0D2B41A12EF;
        Tue,  8 Aug 2023 12:34:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.168.215.201])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 702A71A12EE;
        Tue,  8 Aug 2023 12:34:22 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, sandals@crustytoothpaste.net,
        lenaic@lhuard.fr, Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH 1/6] maintenance: add get_random_minute()
References: <pull.1567.git.1691434300.gitgitgadget@gmail.com>
        <fefdaa9457948ee5302e7cbfaae250e0b589d752.1691434300.git.gitgitgadget@gmail.com>
        <ZNFgIyuhlNd8I9Y2@nand.local> <xmqq4jlabea3.fsf@gitster.g>
        <xmqqzg329ycm.fsf@gitster.g> <ZNJVycLBUIXqZ0Xb@nand.local>
Date:   Tue, 08 Aug 2023 09:34:21 -0700
In-Reply-To: <ZNJVycLBUIXqZ0Xb@nand.local> (Taylor Blau's message of "Tue, 8
        Aug 2023 10:48:41 -0400")
Message-ID: <xmqqbkfha3xu.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 6E18EDE8-3609-11EE-B93C-307A8E0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

> I think that's an acceptable price to pay here, since we can drop the
> code to remember whether or not srand() has been called or not. Here's a
> patch that we could take in that direction:
> ...
>   - If a different function also calls `srand()`, the PRNG may start
>     generating repeated values (if that caller also initialized the PRNG
>     with `getpid()`).

Hmph, I didn't think about that one.  I do not think it can be a
viable attack vector to attack _this_ code, but the other function
might be.  But if the other function is worth attacking and
attackable, it ought to be using crypto-secure one and not srand(),
so this argument may not give us a good justification X-<.

Provided if code simplification is a good enough rationale, the
patch looks sensible, but I find its use of u64 a bit questionable
(though not wrong).  I would have expected that the type of "rand"
would be the same as backoff_ms and wait_ms, two variables involved
in the same expression.

Thanks.

> diff --git a/lockfile.c b/lockfile.c
> index 1d5ed01682..6587d407f4 100644
> --- a/lockfile.c
> +++ b/lockfile.c
> @@ -107,22 +107,17 @@ static int lock_file_timeout(struct lock_file *lk, const char *path,
>  	int n = 1;
>  	int multiplier = 1;
>  	long remaining_ms = 0;
> -	static int random_initialized = 0;
>
>  	if (timeout_ms == 0)
>  		return lock_file(lk, path, flags, mode);
>
> -	if (!random_initialized) {
> -		srand((unsigned int)getpid());
> -		random_initialized = 1;
> -	}
> -
>  	if (timeout_ms > 0)
>  		remaining_ms = timeout_ms;
>
>  	while (1) {
>  		long backoff_ms, wait_ms;
>  		int fd;
> +		uint64_t rand;
>
>  		fd = lock_file(lk, path, flags, mode);
>
> @@ -135,7 +130,10 @@ static int lock_file_timeout(struct lock_file *lk, const char *path,
>
>  		backoff_ms = multiplier * INITIAL_BACKOFF_MS;
>  		/* back off for between 0.75*backoff_ms and 1.25*backoff_ms */
> -		wait_ms = (750 + rand() % 500) * backoff_ms / 1000;
> +		if (csprng_bytes(&rand, sizeof(uint64_t)) < 0)
> +			return error_errno(_("unable to get random bytes for"
> +					     "lockfile backoff"));
> +		wait_ms = (750 + rand % 500) * backoff_ms / 1000;
>  		sleep_millisec(wait_ms);
>  		remaining_ms -= wait_ms;
>
> --
> 2.42.0.rc0.26.g802d811bac.dirty
>
> --- >8 ---
>
> Thanks,
> Taylor
