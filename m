Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD3FC208AB
	for <git@vger.kernel.org>; Fri, 20 Oct 2023 21:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="aOi94UVA"
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF3BCD68
	for <git@vger.kernel.org>; Fri, 20 Oct 2023 14:29:10 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 053EC1A42F1;
	Fri, 20 Oct 2023 17:29:10 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=aLvFpX+JfCRPxL+lRVFewgtJv5u8TfPxacJPvn
	wLei4=; b=aOi94UVAjLo72E+7kOMfVHRWWypec+4eYj/0cTvvRWg20Xl0tmaxRT
	fSDyrU8MOhLOw0BYpHmytHkfR0OLN324Z8umMf1jV7vgCxZWEe8qwr+PutiwwGX8
	ur+8UZZk4F9RBwOyMiMoln1pGo5WZzrnUvTtKiqb19VYZCFrB465w=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id F05FC1A42F0;
	Fri, 20 Oct 2023 17:29:09 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 61ABB1A42EF;
	Fri, 20 Oct 2023 17:29:09 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "Linus Arver via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Glen Choo <glencbz@gmail.com>,  Christian Couder
 <chriscool@tuxfamily.org>,  Phillip Wood <phillip.wood123@gmail.com>,
  Jonathan Tan <jonathantanmy@google.com>,  Linus Arver <linusa@google.com>
Subject: Re: [PATCH v5 2/3] trailer: find the end of the log message
In-Reply-To: <ce25420db29c9953095db652584dbed4e35d67ad.1697828495.git.gitgitgadget@gmail.com>
	(Linus Arver via GitGitGadget's message of "Fri, 20 Oct 2023 19:01:34
	+0000")
References: <pull.1563.v4.git.1695709372.gitgitgadget@gmail.com>
	<pull.1563.v5.git.1697828495.gitgitgadget@gmail.com>
	<ce25420db29c9953095db652584dbed4e35d67ad.1697828495.git.gitgitgadget@gmail.com>
Date: Fri, 20 Oct 2023 14:29:08 -0700
Message-ID: <xmqqr0lpoue3.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 B47D1330-6F8F-11EE-844A-78DCEB2EC81B-77302942!pb-smtp1.pobox.com

"Linus Arver via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Linus Arver <linusa@google.com>
>
> Previously, trailer_info_get() computed the trailer block end position
> by
>
> (1) checking for the opts->no_divider flag and optionally calling
>     find_patch_start() to find the "patch start" location (patch_start), and
> (2) calling find_trailer_end() to find the end of the trailer block
>     using patch_start as a guide, saving the return value into
>     "trailer_end".
>
> The logic in (1) was awkward because the variable "patch_start" is
> misleading if there is no patch in the input. The logic in (2) was
> misleading because it could be the case that no trailers are in the
> input (yet we are setting a "trailer_end" variable before even searching
> for trailers, which happens later in find_trailer_start()). The name
> "find_trailer_end" was misleading because that function did not look for
> any trailer block itself --- instead it just computed the end position
> of the log message in the input where the end of the trailer block (if
> it exists) would be (because trailer blocks must always come after the
> end of the log message).
>
> Combine the logic in (1) and (2) together into find_patch_start() by
> renaming it to find_end_of_log_message(). The end of the log message is
> the starting point which find_trailer_start() needs to start searching
> backward to parse individual trailers (if any).
>
> Helped-by: Jonathan Tan <jonathantanmy@google.com>
> Helped-by: Junio C Hamano <gitster@pobox.com>
> Signed-off-by: Linus Arver <linusa@google.com>
> ---
>  trailer.c | 64 +++++++++++++++++++++++++++++++++++--------------------
>  1 file changed, 41 insertions(+), 23 deletions(-)
>
> diff --git a/trailer.c b/trailer.c
> index 3c54b38a85a..70c81fda710 100644
> --- a/trailer.c
> +++ b/trailer.c
> @@ -809,21 +809,50 @@ static ssize_t last_line(const char *buf, size_t len)
>  }
>  
>  /*
> - * Return the position of the start of the patch or the length of str if there
> - * is no patch in the message.
> + * Find the end of the log message as an offset from the start of the input
> + * (where callers of this function are interested in looking for a trailers
> + * block in the same input). We have to consider two categories of content that
> + * can come at the end of the input which we want to ignore (because they don't
> + * belong in the log message):
> + *
> + * (1) the "patch part" which begins with a "---" divider and has patch
> + * information (like the output of git-format-patch), and
> + *
> + * (2) any trailing comment lines, blank lines like in the output of "git
> + * commit -v", or stuff below the "cut" (scissor) line.
> + *
> + * As a formula, the situation looks like this:
> + *
> + *     INPUT = LOG MESSAGE + IGNORED
> + *
> + * where IGNORED can be either of the two categories described above. It may be
> + * that there is nothing to ignore. Now it may be the case that the LOG MESSAGE
> + * contains a trailer block, but that's not the concern of this function.
>   */
> -static size_t find_patch_start(const char *str)
> +static size_t find_end_of_log_message(const char *input, int no_divider)
>  {
> +	size_t end;
>  	const char *s;
>  
> -	for (s = str; *s; s = next_line(s)) {
> +	/* Assume the naive end of the input is already what we want. */
> +	end = strlen(input);
> +
> +	if (no_divider) {
> +		return end;
> +	}

OK.  The early return may make sense, as we are essentially
declaring that everything is the "INPUT (= message + ignored)".

You do not need {braces} around a single-statement block, though.

Other than that, I didn't find anything quesionable in any of the
patches in this round.  Looking good.

Thanks.
