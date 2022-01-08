Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C27DC433F5
	for <git@archiver.kernel.org>; Sat,  8 Jan 2022 07:11:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233652AbiAHHLM (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 8 Jan 2022 02:11:12 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:56115 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231136AbiAHHLM (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 8 Jan 2022 02:11:12 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id A75811732C1;
        Sat,  8 Jan 2022 02:11:11 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=1h/4I70klxqRy1wjQ4lFlfln8VbSCVUhox6enN
        /U/vM=; b=glr8Tvow0OhBneGVjE6aXyvI0I8F/qVsz1PVqdqLlT+CupqhTDVuZe
        J9HdXzjKzZgj4rGor8PcJO41LeL56O1JEtXQ77PAQ1GqYHG8j8uERZwh02GBieET
        5F8nmSSo9CgX1KY0lkWI6s7lhgPh4iXz+F2C/2a6tHi+lcf2K9a60=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 9FA5C1732BE;
        Sat,  8 Jan 2022 02:11:11 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 17D0D1732BD;
        Sat,  8 Jan 2022 02:11:09 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "John Cai via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, John Cai <johncai86@gmail.com>
Subject: Re: [PATCH v6] receive-pack.c: consolidate find header logic
References: <pull.1125.v5.git.git.1641430309837.gitgitgadget@gmail.com>
        <pull.1125.v6.git.git.1641499655700.gitgitgadget@gmail.com>
Date:   Fri, 07 Jan 2022 23:11:07 -0800
In-Reply-To: <pull.1125.v6.git.git.1641499655700.gitgitgadget@gmail.com> (John
        Cai via GitGitGadget's message of "Thu, 06 Jan 2022 20:07:35 +0000")
Message-ID: <xmqqwnja3do4.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2754DF1C-7052-11EC-91F2-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"John Cai via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: John Cai <johncai86@gmail.com>
>
> There are two functions that have very similar logic of finding a header
> value. find_commit_header, and find_header. We can conslidate the logic
> by introducing a new function find_header_mem, which is equivalent to
> find_commit_header except it takes a len parameter that determines how
> many bytes will be read. find_commit_header and find_header can then both
> call find_header_mem.
>
> This reduces duplicate logic, as the logic for finding header values
> can now all live in one place.
>
> Signed-off-by: John Cai <johncai86@gmail.com>
> ---
>     Consolidate find_header logic into one function
> +const char *find_header_mem(const char *msg, size_t len,
> +			const char *key, size_t *out_len)
>  {
>  	int key_len = strlen(key);
>  	const char *line = msg;
>  
> -	while (line) {
> +	/*
> +	 * NEEDSWORK: It's possible for strchrnul() to scan beyond the range
> +	 * given by len. However, current callers are safe because they compute
> +	 * len by scanning a NUL-terminated block of memory starting at msg.
> +	 * Nonetheless, it would be better to ensure the function does not look
> +	 * at msg beyond the len provided by the caller.
> +	 */
> +	while (line && line < msg + len) {
>  		const char *eol = strchrnul(line, '\n');

Thanks; queued.
