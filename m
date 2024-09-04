Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB2151779A5
	for <git@vger.kernel.org>; Wed,  4 Sep 2024 22:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725490572; cv=none; b=K5E1zND1tZQTcmj6cIX4hFwiREa385Eopb3ulz/aIuhfFgAqjkFvO9kYUE4MUCxEJ6710hp9ojx/3tQNbEBN7kdi3jRajv9vjDQvsFyjGg9f7J3I0vnEL6eneuG9UECrS3ExEcJTOXlWIw1Eaqb1KUY++2yIAN571J02NxhGRZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725490572; c=relaxed/simple;
	bh=iD+C6nt/ZxkcDvOhzqAtQeoy4FQqCKJ2KdpKXRnMe2w=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=uZ1HLtqg3dj0QKnCS4n7nysNqBJRr4ta/O5Y9pDAy4Ofx9CdxOcEDeNpPWTnzcvMjgjuqYBPaYMtKMyZXkxr8vVF7dv0gYZGn28bdPxZqtVpagRqLw9q2OjQU6ZpYT5Cvxtt1vGixEQWb3CdkX4vZ/MJzzqjepGwr44Pi7g5rAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=fqvgcAOL; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="fqvgcAOL"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id AC6611AA6B;
	Wed,  4 Sep 2024 18:56:09 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=iD+C6nt/ZxkcDvOhzqAtQeoy4FQqCKJ2KdpKXR
	nMe2w=; b=fqvgcAOLVGRxySOs8rFDqwtKNky3Agrj/rd6gKzuQj13EpCIqM1xTu
	xKW4cBKN79oKGuD9eWN/Ms4+jV4tpNS4GveErqXCBYdV4jKB+b0I9jH2SxZwQrEq
	S7e78rW1wmjxX4duxa98kMp1j571hGVXV7GOOOrHJyodtArcK2Cd0=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id A601F1AA6A;
	Wed,  4 Sep 2024 18:56:09 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.94.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 133E21AA69;
	Wed,  4 Sep 2024 18:56:09 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>, Elijah Newren <newren@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 21/22] merge-ort: fix two leaks when handling directory
 rename modifications
In-Reply-To: <da1c23a9ccf8c797ebcbe6ce5a8243c1d051fad6.1724656120.git.ps@pks.im>
	(Patrick Steinhardt's message of "Mon, 26 Aug 2024 09:22:37 +0200")
References: <cover.1724656120.git.ps@pks.im>
	<da1c23a9ccf8c797ebcbe6ce5a8243c1d051fad6.1724656120.git.ps@pks.im>
Date: Wed, 04 Sep 2024 15:56:07 -0700
Message-ID: <xmqq5xrb6naw.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 DFD8B746-6B10-11EF-BCF2-2BAEEB2EC81B-77302942!pb-smtp1.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

> There are two leaks in `apply_directory_rename_modifications()`:
>
>   - We do not release the `dirs_to_insert` string list.
>
>   - We do not release some `conflict_info` we put into the
>     `opt->priv->paths` string map.
>
> The former is trivial to fix. The latter is a bit less straight forward:
> the `util` pointer of the string map may sometimes point to data that
> has been allocated via `CALLOC()`, while at other times it may point to
> data that has been allocated via a `mem_pool`.
>
> It very much seems like an oversight that we didn't also allocate the
> conflict info in this code path via the memory pool, though. So let's
> fix that, which will also plug the memory leak for us.
>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---

May be nice if we can hear from the original author and the area
expert.

>  merge-ort.c                         | 4 +++-
>  t/t6423-merge-rename-directories.sh | 1 +
>  2 files changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/merge-ort.c b/merge-ort.c
> index 3752c7e595d..0ed3cd06b1a 100644
> --- a/merge-ort.c
> +++ b/merge-ort.c
> @@ -2710,7 +2710,7 @@ static void apply_directory_rename_modifications(struct merge_options *opt,
>  		struct conflict_info *dir_ci;
>  		char *cur_dir = dirs_to_insert.items[i].string;
>  
> -		CALLOC_ARRAY(dir_ci, 1);
> +		dir_ci = mem_pool_calloc(&opt->priv->pool, 1, sizeof(*dir_ci));
>  
>  		dir_ci->merged.directory_name = parent_name;
>  		len = strlen(parent_name);
> @@ -2838,6 +2838,8 @@ static void apply_directory_rename_modifications(struct merge_options *opt,
>  	 * Finally, record the new location.
>  	 */
>  	pair->two->path = new_path;
> +
> +	string_list_clear(&dirs_to_insert, 0);
>  }
>  
>  /*** Function Grouping: functions related to regular rename detection ***/
> diff --git a/t/t6423-merge-rename-directories.sh b/t/t6423-merge-rename-directories.sh
> index 88d1cf2cde9..4aaaf38be68 100755
> --- a/t/t6423-merge-rename-directories.sh
> +++ b/t/t6423-merge-rename-directories.sh
> @@ -25,6 +25,7 @@ test_description="recursive merge with directory renames"
>  #                     underscore notation is to differentiate different
>  #                     files that might be renamed into each other's paths.)
>  
> +TEST_PASSES_SANITIZE_LEAK=true
>  . ./test-lib.sh
>  . "$TEST_DIRECTORY"/lib-merge.sh
