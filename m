Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8166B79DF
	for <git@vger.kernel.org>; Fri, 29 Mar 2024 21:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711748586; cv=none; b=MV6EzhoI4wcqmY5RD2vcxCfGSQVxeh4cBlTa2xtz5wyAZhIrD6Na1L8aOIFxAxHo8cq+Vz0BiwlU+DJQm0FU/7CQqZoEKq02bromFLMTxhwSyScu0GSnicLiW9z5xHeV5zj2aOC7DO9XWdaXCyHP7FydoxmXp/3GAd/T3rHeVA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711748586; c=relaxed/simple;
	bh=tSYqNTZ6KFS+jTNrPJ0ctKLQey2hv+EAn4dBElc6Des=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=kLCTJDz1lM8MV0kxra+kqs2J0VJekOwwFr1PntM4KXaPaSfEzv2d6s+T77pQPS285uGeC1V5nO9aBQpqeF4+0OihHey+rQ/XQHQSHWrpu/isNE1mgAtymw2TvNWkN6zWKKpDgbbkg/3KkIB3Arh+qWvIXpEV55SgrEb3pM/xens=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=tDzXlQ4D; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="tDzXlQ4D"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 9846D1F59FD;
	Fri, 29 Mar 2024 17:43:02 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=tSYqNTZ6KFS+jTNrPJ0ctKLQey2hv+EAn4dBEl
	c6Des=; b=tDzXlQ4DDpJ/rlb4TiIrx86iGl8LoUZFdhwxvP3YzdAc+Y9utFVv+w
	xvW21XuJM54dtWKuf4UPLtWiCl8ee/ZxsNjOxKamY+nNZkMFdzfU/IJGS+sISr46
	T19gjWYFEeG7TAjcS4BSek30ZCljsL6cBWLPinzeohTqbSP8gZnAo=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 907831F59FC;
	Fri, 29 Mar 2024 17:43:02 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id E8D531F59FB;
	Fri, 29 Mar 2024 17:43:01 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Ghanshyam Thakkar <shyamthakkar001@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v2 3/3] builtin/add: error out when passing untracked
 path with -u
In-Reply-To: <20240329205649.1483032-5-shyamthakkar001@gmail.com> (Ghanshyam
	Thakkar's message of "Sat, 30 Mar 2024 02:26:21 +0530")
References: <20240318155219.494206-2-shyamthakkar001@gmail.com>
	<20240329205649.1483032-5-shyamthakkar001@gmail.com>
Date: Fri, 29 Mar 2024 14:43:00 -0700
Message-ID: <xmqqzfugvhnf.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 513C4E76-EE15-11EE-8ED5-78DCEB2EC81B-77302942!pb-smtp1.pobox.com

Ghanshyam Thakkar <shyamthakkar001@gmail.com> writes:

> When passing untracked path with -u option, it silently succeeds. There
> is no error message and the exit code is zero. This is inconsistent
> with other instances of git commands where the expected argument is a
> known path. In those other instances, we error out when the path is
> not known.
>
> Therefore, fix this by passing a character array to

"Therefore, fix" -> "Fix".

> add_files_to_cache() to collect the pathspec matching information and
> report the error if a pathspec does not match any cache entry. Also add
> a testcase to cover this scenario.
>
> Signed-off-by: Ghanshyam Thakkar <shyamthakkar001@gmail.com>
> ---
>  builtin/add.c         | 9 ++++++++-
>  t/t2200-add-update.sh | 6 ++++++
>  2 files changed, 14 insertions(+), 1 deletion(-)
>
> diff --git a/builtin/add.c b/builtin/add.c
> index ffe5fd8d44..650432bb13 100644
> --- a/builtin/add.c
> +++ b/builtin/add.c
> @@ -370,6 +370,7 @@ int cmd_add(int argc, const char **argv, const char *prefix)
>  	int add_new_files;
>  	int require_pathspec;
>  	char *seen = NULL;
> +	char *ps_matched = NULL;
>  	struct lock_file lock_file = LOCK_INIT;
>  
>  	git_config(add_config, NULL);
> @@ -547,15 +548,20 @@ int cmd_add(int argc, const char **argv, const char *prefix)
>  		string_list_clear(&only_match_skip_worktree, 0);
>  	}
>  
> +
>  	begin_odb_transaction();

Unnecessary change.

> +	ps_matched = xcalloc(pathspec.nr, 1);
>  	if (add_renormalize)
>  		exit_status |= renormalize_tracked_files(&pathspec, flags);
>  	else
>  		exit_status |= add_files_to_cache(the_repository, prefix,
> -						  &pathspec, NULL,
> +						  &pathspec, ps_matched,
>  						  include_sparse, flags);
>  
> +	if (take_worktree_changes)
> +		exit_status |= report_path_error(ps_matched, &pathspec);

Hmph, are we sure take_worktree_changes is true only when
add_renormalize is false?

>  	if (add_new_files)
>  		exit_status |= add_files(&dir, flags);

If report_path_error() detected that the pathspec were faulty,
should we still proceed to add new files?  This is NOT a rhetorical
question, as I do not know the answer myself.  I do not even know
offhand what add_files_to_cache() above did when pathspec elements
are not all consumed---if it does not complain and does not refrain
from doing any change to the index, then we should follow suite and
add_files() here, too.

> @@ -568,6 +574,7 @@ int cmd_add(int argc, const char **argv, const char *prefix)
>  			       COMMIT_LOCK | SKIP_IF_UNCHANGED))
>  		die(_("unable to write new index file"));
>  
> +	free(ps_matched);
>  	dir_clear(&dir);
>  	clear_pathspec(&pathspec);
>  	return exit_status;
> diff --git a/t/t2200-add-update.sh b/t/t2200-add-update.sh
> index c01492f33f..7cba325f08 100755
> --- a/t/t2200-add-update.sh
> +++ b/t/t2200-add-update.sh
> @@ -65,6 +65,12 @@ test_expect_success 'update did not touch untracked files' '
>  	test_must_be_empty out
>  '
>  
> +test_expect_success 'error out when passing untracked path' '
> +	echo content >baz &&
> +	test_must_fail git add -u baz 2>err &&
> +	test_grep -e "error: pathspec .baz. did not match any file(s) known to git" err
> +'
> +
>  test_expect_success 'cache tree has not been corrupted' '
>  
>  	git ls-files -s |
