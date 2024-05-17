Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9287A12FB0D
	for <git@vger.kernel.org>; Fri, 17 May 2024 23:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715988813; cv=none; b=LtcTf0g4sDYK4amoRf73XXICd6vU82dVyMlIpdriWBFajrGyxg5GH2UNN+6bPgFW1Fv7V0EUHJYPjL7AA7qo4HWZXkq9wslaoFhs9A+WhYCUbyiilWF6ixeHo1PWL15fiTG/sCweAStFy4DRMdPneRntbjRckqVsiCL0tJBAWlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715988813; c=relaxed/simple;
	bh=a4g+QEwV3/lbJM0ZVDBenuak8XU0KH+QckNlfGpuEr4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=jF9O5vwATOuu7TTBMZ4scnUrkfcmZvPBCA/xRzlPEBMgO9ge0GNVN5Fsp522FA3/mlIRNzfhu4vmfsvCMnObrLZ6OfvS4uKTTG/27Bjb97e7PTMD7pVsmrhWNFz6XVPOFn/5iNMkrSyBi/nLloaGoD7rrkewM42AxSTUXkwIgJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=JBhbE0sf; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="JBhbE0sf"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 605CC32001;
	Fri, 17 May 2024 19:33:24 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=a4g+QEwV3/lbJM0ZVDBenuak8XU0KH+QckNlfG
	puEr4=; b=JBhbE0sfRjy47zEK6GWPavoS0eQxO9OfW4SBN/14Fisy6EMWb59fTx
	oXosTQSaZ4Qv4EwpRjIvTzUui1K623iypclM6nZ1uCdJV6g21gVLEbl65nomS3KK
	HPCQ6djUgKP6H68aqQ5JgQZC4nE/EwJmvTdhrjfkrEu8ZfTa974E0=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 58B9832000;
	Fri, 17 May 2024 19:33:24 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id D758A31FFF;
	Fri, 17 May 2024 19:33:20 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "Tom Scogland via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Tom Scogland <scogland1@llnl.gov>
Subject: Re: [PATCH v2] archive: make --add-virtual-file honor --prefix
In-Reply-To: <pull.1719.v2.git.git.1715967267420.gitgitgadget@gmail.com> (Tom
	Scogland via GitGitGadget's message of "Fri, 17 May 2024 17:34:27
	+0000")
References: <pull.1719.git.git.1715721327429.gitgitgadget@gmail.com>
	<pull.1719.v2.git.git.1715967267420.gitgitgadget@gmail.com>
Date: Fri, 17 May 2024 16:33:19 -0700
Message-ID: <xmqqv83cdneo.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 D8AA9992-14A5-11EF-89BF-A19503B9AAD1-77302942!pb-smtp21.pobox.com

"Tom Scogland via GitGitGadget" <gitgitgadget@gmail.com> writes:

> Notably both explicitly state that they honor the last `--prefix` option
> before the `--add` option in question.  The implementation of
> `--add-file` seems to have always honored prefix, but the implementation
> of `--add-virtual-file` does not.

The above is misleading.

    The implementation of `--add-file` has always honored the prefix,
    while the implementation of `--add-virtual-file` has always ignored
    the prefix.

would make it easier to assess how long existing users may have been
relying on the current behaviour.

> Also note that `--add-virtual-file`
> explicitly states it will use the full path given, while `--add-file`
> uses the basename of the path it is given.

Yes, this is a very good thing to mention.  It is probably the
reason why the implementation decided not to add prefix to the "full
path" that already can have the leading directories.

> Modify archive.c to include the prefix in the path used by
> `--add-virtual-file` and add checks into
> the existing add-virtual-file test to verify:
>
> * that `--prefix` is honored
> * that leading path components are preserved
> * that both work together and separately

Very nice job explaining the chosen design clearly (even though I do
not necessarily agree with the direction this patch is going).

Also, given that this option was introduced for an explicit purpose
of using it to write out diagnostics archive file, we should mention
that this change does not break it in the proposed log message, at
least.  Of course, we should do so after verifying that is indeed
the case, and better yet, after verifying that it will be hard for
future changes to diagnose.c to trigger an unexpected behaviour
caused by this change [*].

> Changes since v1:
> - Revised the commit message style
> - Added tests for basename/non-basename behavior
> - Fixed archive.c to use full path for virtual and basename for add-file

The "changes since v1" section does not belong to the log message
proper, as v1 never happened as long as readers of "git log" are
concerned.  It is a very good thing to help reviewers to have below
the three-dash lines that comes after your sign-off, though.

> Signed-off-by: Tom Scogland <scogland1@llnl.gov>
> ---

>  archive.c              | 10 +++++-----
>  t/t5003-archive-zip.sh | 14 ++++++++++++--
>  2 files changed, 17 insertions(+), 7 deletions(-)
>
> diff --git a/archive.c b/archive.c
> index 5287fcdd8e0..64777a9870d 100644
> --- a/archive.c
> +++ b/archive.c
> @@ -365,12 +365,11 @@ int write_archive_entries(struct archiver_args *args,
>  
>  		put_be64(fake_oid.hash, i + 1);
>  
> +		strbuf_reset(&path_in_archive);
> +		if (info->base)
> +			strbuf_addstr(&path_in_archive, info->base);
>  		if (!info->content) {
> -			strbuf_reset(&path_in_archive);
> -			if (info->base)
> -				strbuf_addstr(&path_in_archive, info->base);
>  			strbuf_addstr(&path_in_archive, basename(path));
> -
>  			strbuf_reset(&content);
>  			if (strbuf_read_file(&content, path, info->stat.st_size) < 0)
>  				err = error_errno(_("cannot read '%s'"), path);
> @@ -380,8 +379,9 @@ int write_archive_entries(struct archiver_args *args,
>  						  canon_mode(info->stat.st_mode),
>  						  content.buf, content.len);
>  		} else {
> +			strbuf_addstr(&path_in_archive, path);
>  			err = write_entry(args, &fake_oid,
> -					  path, strlen(path),
> +					  path_in_archive.buf, path_in_archive.len,
>  					  canon_mode(info->stat.st_mode),
>  					  info->content, info->stat.st_size);
>  		}
> diff --git a/t/t5003-archive-zip.sh b/t/t5003-archive-zip.sh
> index 961c6aac256..0cf3aef8ace 100755
> --- a/t/t5003-archive-zip.sh
> +++ b/t/t5003-archive-zip.sh
> @@ -218,14 +218,24 @@ test_expect_success UNZIP 'git archive --format=zip --add-virtual-file' '
>  	fi &&
>  	git archive --format=zip >with_file_with_content.zip \
>  		--add-virtual-file=\""$PATHNAME"\": \
> -		--add-virtual-file=hello:world $EMPTY_TREE &&
> +		--add-virtual-file=hello:world \
> +		--add-virtual-file=with/dir/noprefix:withdirnopre \
> +		--prefix=subdir/ --add-virtual-file=with/dirprefix:withdirprefix \
> +		--prefix=subdir2/ --add-virtual-file=withoutdir:withoutdir \
> +		--prefix= $EMPTY_TREE &&
>  	test_when_finished "rm -rf tmp-unpack" &&
>  	mkdir tmp-unpack && (
>  		cd tmp-unpack &&
>  		"$GIT_UNZIP" ../with_file_with_content.zip &&
>  		test_path_is_file hello &&
>  		test_path_is_file "$PATHNAME" &&
> -		test world = $(cat hello)
> +		test world = $(cat hello) &&
> +		test_path_is_file with/dir/noprefix &&
> +		test withdirnopre = $(cat with/dir/noprefix) &&
> +		test_path_is_file subdir/with/dirprefix &&
> +		test withdirprefix = $(cat subdir/with/dirprefix) &&
> +		test_path_is_file subdir2/withoutdir &&
> +		test withoutdir = $(cat subdir2/withoutdir)

OK.  With different payload at different paths, it is easier than
the previous round to see where things are expected to go in the
result.


[Footnote]

 * I got curious and did this part for you.  After calling
   add_directory_to_archiver() that uses "--prefix" to move the
   target directory around in the output hierarchy, the code clears
   with "--prefix="---even a future change to diagnose.c adds more
   uses to --add-virtual-file= after it happens, it will not go to
   deep in the directory hierarchy where the last use of "--prefix"
   happened to be pointing at.

