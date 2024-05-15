Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A8AC62A02
	for <git@vger.kernel.org>; Wed, 15 May 2024 15:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715786627; cv=none; b=YEoJHZKP73ggSXqdN3WFlE4SNVXAG5Vuhde4NNCqDYw8151QjR9bUi6a6ZK7RtpQtwenhDbe3fM9qymzef9/3JlJ394xnsAlIPDi3sRZ1AErhANbEBXaPlZc6rO3KXqw3o1SDZuHQuEnSQRo88TLVohiYSk5VASUi5JaFzRFvOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715786627; c=relaxed/simple;
	bh=BuPir/owrhgMxMRCrOnwg9sy2LwjkwWR8WM+kRl++20=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=nMnYahWXKC7QH0jJYg5O1ZbyMf/AkMS62TExWWe1sJFFvdzCD0GOtDmp9xEhenXwVwnfhqg4zMG4P/5izAHICv1OxpebjlxN9289CgxPIOnZm2BMFbflvYp1gN3G+QlHvWqPysZ6DVFEc4hYP2Orab/4M8e/BfItvoTMeQUK2l0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=WRJBoWTb; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="WRJBoWTb"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id CAB1C1D440;
	Wed, 15 May 2024 11:23:43 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=BuPir/owrhgMxMRCrOnwg9sy2LwjkwWR8WM+kR
	l++20=; b=WRJBoWTbZ/NUUmlbqSfP6LjQB0thtUNNgQbeE3oJ0VhapcPFw7IBxa
	oPkIu8iijWCjDpi6vespSggNHQUgn7S7xp+HyuQFLgn32liIbvGeQccd507GSPxK
	rTx0dPJdt9FxWtEaUqIMx0tL0z6PqtYXu6A/HL4ClepAHyigtB6as=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id C2BA31D43F;
	Wed, 15 May 2024 11:23:43 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 3273D1D43E;
	Wed, 15 May 2024 11:23:43 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "Tom Scogland via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Tom Scogland <scogland1@llnl.gov>
Subject: Re: [PATCH] archive: make --add-virtual-file honor --prefix
In-Reply-To: <pull.1719.git.git.1715721327429.gitgitgadget@gmail.com> (Tom
	Scogland via GitGitGadget's message of "Tue, 14 May 2024 21:15:26
	+0000")
References: <pull.1719.git.git.1715721327429.gitgitgadget@gmail.com>
Date: Wed, 15 May 2024 08:23:42 -0700
Message-ID: <xmqqcypn14ld.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 1D613A06-12CF-11EF-BF5A-78DCEB2EC81B-77302942!pb-smtp1.pobox.com

"Tom Scogland via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Tom Scogland <scogland1@llnl.gov>
>
> The documentation for archive states:
>
>   The path of the file in the archive is built by concatenating the
>   value of the last `--prefix` moption (if any) before this
>   `--add-virtual-file` and <path>.
>
> This matches the documentation for --add-file and the behavior works for
> that option, but --prefix is ignored for --add-virtual-file.

This first paragraph was a bit hard to parse for me.

You will contrast the quoted paragraph with another one you did not
quote later in this paragraph, so it is more helpful to readers if
you instead said:

    The documentatation for archive describes its
    "--add-virtual-file" option like so:

        ... excerpt from --add-virtual-file description ...

    This description is the same as "--add-file", and "--add-file"
    does behave the way as described.  "--add-virtual-file" however
    ignores "--prefix".

> This commit modifies archive.c to include the prefix in the path and
> adds a check into the existing add-virtual-file test to ensure that it
> honors both the most recent prefix before the flag.

Style: "This comit modifies" -> "Modify".

An obvious alternative fix is to update the documentation, which
would be a much safer thing to do, given that there may be existing
scripts written during the two years since --add-virtual-file option
was introduced and has been behaving exactly this way.  They will
all be broken big time once the command starts honoring the
"--prefix" option.

> In looking for others with this issue, I found message
> a143e25a70b44b82b4ee6fa3bb2bcda4@atlas-elektronik.com on the mailing
> list, where Stefan proposed a basically identical patch to archive.c
> back in February, so the main addition here is the test along with that
> patch.

This pargraph should come _after_ the three-dash lines below.

> Signed-off-by: Tom Scogland <scogland1@llnl.gov>
> ---
>     archive: make --add-virtual-file honor --prefix

The implementation looked obvious, assuming that it is a good idea
to change it (I've already talked about a safer alternative fix).

> diff --git a/t/t5003-archive-zip.sh b/t/t5003-archive-zip.sh
> index 961c6aac256..acc8bc4fcd6 100755
> --- a/t/t5003-archive-zip.sh
> +++ b/t/t5003-archive-zip.sh
> @@ -218,14 +218,18 @@ test_expect_success UNZIP 'git archive --format=zip --add-virtual-file' '
>  	fi &&
>  	git archive --format=zip >with_file_with_content.zip \
>  		--add-virtual-file=\""$PATHNAME"\": \
> -		--add-virtual-file=hello:world $EMPTY_TREE &&
> +		--add-virtual-file=hello:world \
> +		--prefix=subdir/ --add-virtual-file=hello:world \
> +		--prefix= $EMPTY_TREE &&

Instead of reusing the exactly the same name and contents, use
something different so that it is clear to the later test which of
the two "--add-virtual-file" options created these two paths in the
unpacked directories.  I.e., create something like

	--prefix=subdir/ --add-virtual-file=good:night

here and update the test below to match.

>  	test_when_finished "rm -rf tmp-unpack" &&
>  	mkdir tmp-unpack && (
>  		cd tmp-unpack &&
>  		"$GIT_UNZIP" ../with_file_with_content.zip &&
>  		test_path_is_file hello &&
>  		test_path_is_file "$PATHNAME" &&
> -		test world = $(cat hello)
> +		test world = $(cat hello) &&
> +		test_path_is_file subdir/hello &&
> +		test world = $(cat subdir/hello)
>  	)
>  '

Other than that, looks good to me.  Thanks.
