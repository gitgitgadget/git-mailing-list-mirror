Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 974D81CCB45
	for <git@vger.kernel.org>; Fri,  6 Sep 2024 16:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725639693; cv=none; b=UaNLrtLbr3UY8xyv7x/1JCwUBOgM5FuS5a6lL4wdZoB24DySPLMogPii8h8w37ApYWqkVqfNomE2vr0bEbIzU+PRMuQTnEzXPTCyDCtgh7hUhaGSdMKZywx+e15pXS+TWUUeAC0dqPvF9351IPZb7exiiEc95zWsLXp4bUmk2mI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725639693; c=relaxed/simple;
	bh=I1AuL6j/HEeXkpUK/R8+gaPOWKvyKsaSGuHyU3pqgIs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Kn8byJY8mQXsKalUNeciK0yg3P9g3S7AapZOByQMcPLha7jzSPR14JD5GNxniN0U9Q9cwYEuzwzaAkV+nO00jRnrS3GHI1tWoJWbIoIM63Cnq/1fxLLhlu3wLUxs5TgDQ/G1F8Mis2lUU/X+2j9Y20GdOU7nE7zaDqhVqpIUqOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=HvquK+xT; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="HvquK+xT"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 83FCA366BF;
	Fri,  6 Sep 2024 12:21:30 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=I1AuL6j/HEeXkpUK/R8+gaPOWKvyKsaSGuHyU3
	pqgIs=; b=HvquK+xTwb9WlimI1b/Kf/GPvjbxnY5iAoDtpxK2nz4s7d/Sxd74qZ
	AzLUSz1br0AEP0kwTnH4ggaytNtHtwmJUuxb0mRrE2obKYCXahAbFuzfBWrZHn9v
	GuUFXoCwvE7fZdYR2FOBmo64L+MO7IcpA65mz1NRwUGWRfFHtt1fI=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 7C2B5366BE;
	Fri,  6 Sep 2024 12:21:30 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.94.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id B7611366BD;
	Fri,  6 Sep 2024 12:21:28 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Brian Lyles <brianmlyles@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v3] interpret-trailers: handle message without trailing
 newline
In-Reply-To: <20240906145743.2059405-1-brianmlyles@gmail.com> (Brian Lyles's
	message of "Fri, 6 Sep 2024 09:50:08 -0500")
References: <20240905173445.1677704-1-brianmlyles@gmail.com>
	<20240906145743.2059405-1-brianmlyles@gmail.com>
Date: Fri, 06 Sep 2024 09:21:27 -0700
Message-ID: <xmqqy144wy60.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 121902E0-6C6C-11EF-8747-2BAEEB2EC81B-77302942!pb-smtp1.pobox.com

Brian Lyles <brianmlyles@gmail.com> writes:

> When git-interpret-trailers is used to add a trailer to a message that
> does not end in a trailing newline, the new trailer is added on the line
> immediately following the message instead of as a trailer block
> separated from the message by a blank line.
>
> For example, if a message's text was exactly "The subject" with no
> trailing newline present, `git interpret-trailers --trailer
> my-trailer=true` will result in the following malformed commit message:
>
>     The subject
>     my-trailer: true
>
> While it is generally expected that a commit message should end with a
> newline character, git-interpret-trailers should not be returning an
> invalid message in this case.

I am not sure if the above example resulted in "an invalid message",
though ;-)  As far as Git is concerned, a commit log can contain any
sequence of bytes.

But of course, various tools to manipulate the messages (e.g.
"commit --amend" and your editor that gets invoked by it,
"interpret-trailers") may not be prepared to see any arbitrary
bytes.  I would have written

    While a commit message can contain arbitrary byte sequence, the
    fact that the user invoked the interpret-trailers command on it
    means that the contents is expected to be a proper text, which
    should not end in an incomplete line.  Instead of detecting and
    erroring out upon seeing such a log message, complete the last
    line if it lacks the terminating LF.

or something like that, if I were working on this change.

> Use `strbuf_complete_line` to ensure that the message ends with a
> newline character when reading the input.
>
> Signed-off-by: Brian Lyles <brianmlyles@gmail.com>
> ---
>
> The range-diff from v2 is not included since the patch is so different
> that range-diff is not able to provide anything meaningful.

Very sensible.

Will queue.  Thanks.

> diff --git a/t/t7513-interpret-trailers.sh b/t/t7513-interpret-trailers.sh
> index 3d3e13ccf8..d78cae3e04 100755
> --- a/t/t7513-interpret-trailers.sh
> +++ b/t/t7513-interpret-trailers.sh
> @@ -175,6 +175,46 @@ test_expect_success 'with only a title in the message' '
>  	test_cmp expected actual
>  '
>
> +test_expect_success 'with a bodiless message that lacks a trailing newline after the subject' '
> +	cat >expected <<-\EOF &&
> +		area: change
> +
> +		Reviewed-by: Peff
> +		Acked-by: Johan
> +	EOF
> +	printf "area: change" |
> +	git interpret-trailers --trailer "Reviewed-by: Peff" \
> +		--trailer "Acked-by: Johan" >actual &&
> +	test_cmp expected actual
> +'
> +
> +test_expect_success 'with a bodied message that lacks a trailing newline after the body' '
> +	cat >expected <<-\EOF &&
> +		area: change
> +
> +		details about the change.
> +
> +		Reviewed-by: Peff
> +		Acked-by: Johan
> +	EOF
> +	printf "area: change\n\ndetails about the change." |
> +	git interpret-trailers --trailer "Reviewed-by: Peff" \
> +		--trailer "Acked-by: Johan" >actual &&
> +	test_cmp expected actual
> +'
> +
> +test_expect_success 'with a message that lacks a trailing newline after the trailers' '
> +	cat >expected <<-\EOF &&
> +		area: change
> +
> +		Reviewed-by: Peff
> +		Acked-by: Johan
> +	EOF
> +	printf "area: change\n\nReviewed-by: Peff" |
> +	git interpret-trailers --trailer "Acked-by: Johan" >actual &&
> +	test_cmp expected actual
> +'
> +
>  test_expect_success 'with multiline title in the message' '
>  	cat >expected <<-\EOF &&
>  		place of
> --
> 2.45.2
