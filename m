Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF46255C0E
	for <git@vger.kernel.org>; Mon, 18 Mar 2024 17:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710782885; cv=none; b=AD2M02FdfimxmH8O2aWmPihARHUtKlvISFLXU4n/54Z7s0XadYlaHyXsMHa50lgsRzHnWJUk5oGzx0gCql/OGQi+/RoHDHqMtB435RdCZSVGeoJ207E+TuRHS93MfZKHHeiwkKTGo9RmNkdp1llZTJ5ydRM7QfvDSjse4cTI04o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710782885; c=relaxed/simple;
	bh=JZjv/MNh1Dhe9VPxt/27CC9KKOChIOW9aHVfOvNbvu0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=EQZcTF5/rAJktMAfGG5QqeO/mNfa8fE3V2t0oR6XdoSJQBhX1+qqAc+rcMsPIjSxxaBeHQ+HCI/vgBk3Ydilwz72QvDTQGcEhM5w6T1QtUTGDAtQvcPExFgiS5LunkIgcNw4k4fvLteh2zDr9YPi6dqJpEU6HbHOU1z2GXIGEDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=wFmNje8x; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="wFmNje8x"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 77C242E89E;
	Mon, 18 Mar 2024 13:28:02 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=JZjv/MNh1Dhe9VPxt/27CC9KKOChIOW9aHVfOv
	Nbvu0=; b=wFmNje8xwOV2dGPI5xV8nRb0PKCaQOMimuW0vgypjXwJ728shINUeS
	edNtD3cQpvXxrJjFU1rood5tAMOPbXlDMl3MH7jG9p0NLLqz1Kxqi+du/za84c+X
	6InmLl1gxUeIzA62mLgdpSeqU7UQhV0GowrGOnnaUc/vlhaXxnXB8=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 717BC2E89D;
	Mon, 18 Mar 2024 13:28:02 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.185.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 04FB22E898;
	Mon, 18 Mar 2024 13:27:58 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Ghanshyam Thakkar <shyamthakkar001@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 1/2] builtin/commit: error out when passing untracked
 path with -i
In-Reply-To: <20240318155219.494206-4-shyamthakkar001@gmail.com> (Ghanshyam
	Thakkar's message of "Mon, 18 Mar 2024 21:21:59 +0530")
References: <20240318155219.494206-2-shyamthakkar001@gmail.com>
	<20240318155219.494206-4-shyamthakkar001@gmail.com>
Date: Mon, 18 Mar 2024 10:27:57 -0700
Message-ID: <xmqqedc7h2le.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 DD6EDFCA-E54C-11EE-BBFF-A19503B9AAD1-77302942!pb-smtp21.pobox.com

Ghanshyam Thakkar <shyamthakkar001@gmail.com> writes:

> Currently when we provide a pathspec which does not match any tracked
> path alongside --include, we do not error like without --include. If
> there is something staged, it will commit the staged changes and ignore
> the pathspec which does not match any tracked path. And if nothing is
> staged, it will print the status. Exit code is 0 in both cases (unlike
> without --include). This was also described in the TODO comment before
> the relevant testcase.

Drop "currently" (cf. https://lore.kernel.org/git/xmqqle6xbep5.fsf@gitster.g/)

> Fix this by matching the pathspec against index and report error if
> any. And amend the relevant testcase and remove the TODO comment.

> [RFC]: I am still unsure about the removal of --include related lines
> from the testcase which checks whether the index is expanded or not from
> t1092. Will separating it into a separate testcase of its own and
> marking that to expect failure be better?
>
>  builtin/commit.c                         | 15 +++++++++++++++
>  t/t1092-sparse-checkout-compatibility.sh |  4 ----
>  t/t7501-commit-basic-functionality.sh    | 16 +---------------
>  3 files changed, 16 insertions(+), 19 deletions(-)
>
> diff --git a/builtin/commit.c b/builtin/commit.c
> index a91197245f..f8f5909673 100644
> --- a/builtin/commit.c
> +++ b/builtin/commit.c
> @@ -441,6 +441,21 @@ static const char *prepare_index(const char **argv, const char *prefix,
>  	 * (B) on failure, rollback the real index.
>  	 */
>  	if (all || (also && pathspec.nr)) {
> +		if (!all) {
> +			int i, ret;
> +			char *ps_matched = xcalloc(pathspec.nr, 1);
> +
> +			/* TODO: audit for interaction with sparse-index. */
> +			ensure_full_index(&the_index);
> +			for (i = 0; i < the_index.cache_nr; i++)
> +				ce_path_match(&the_index, the_index.cache[i],
> +					      &pathspec, ps_matched);
> +
> +			ret = report_path_error(ps_matched, &pathspec);
> +			free(ps_matched);
> +			if (ret)
> +				exit(1);
> +		}
>  		repo_hold_locked_index(the_repository, &index_lock,
>  				       LOCK_DIE_ON_ERROR);
>  		add_files_to_cache(the_repository, also ? prefix : NULL,

"git grep" for report_path_error() gives me four or five hits but
they way all of them populate ps_matched array are different [*],
so we cannot have a helper function to do so.

    Side note: They tend to do "looping over all the paths, see with
    ce_path_match() if the path matches, and do something with that
    path if it does".  They do not do a separate useless loop that
    is only for checking if all the pathspec elements match, like
    the loop in this patch does.

In a sense, not making this into a helper function is the right
thing to do.  It would avoid encouraging this anti-pattern of adding
a separate and otherwise useless loop.

We must already be using pathspec elements to decide to do the
"include" addition among all paths that we know about in some loop
separately, no?  Isn't that what the call to add_files_to_cache() we
see in the post-context doing?  Shouldn't that loop (probably the
one in diff-lib.c:run_diff_files(), that calls ce_path_match() for
each and every path we know about) be the one who needs to learn to
optionally collect the ps_matched information in addition to what it
is already doing?

Thanks.
