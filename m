Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88AB0210B
	for <git@vger.kernel.org>; Sat, 20 Jan 2024 22:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705789571; cv=none; b=r1nA3ZNqKvUQiGSEH0EWHh5wu0RlJ9Vb7TOcCZO1foVuV/cMg1BRH/ys+YduNV+EUCXYPNhSGMeaNtM5AsnYgNzIK7TReM6ud9D9igf0RnYyIWWeR1vamXZn6+281eCHrcyEvhnsC+HMMJ2vwmxS6SX2Jbe38caKkhiaFdnYrK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705789571; c=relaxed/simple;
	bh=fi5wAKZ8/oKG/7GD5L+/Pt7qsKhZoYTdoqtgpjXU/Gc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=oDmjoGS77WJydxBEUZXJkt8VZu4j74otjd9nZGeV1v2nW5gspvitotqEc+900qO3ZXMbag5PrKyKyVx9OpnFYutdFBGzdsBQJ3NU9MVNCX3KEbAeSH9A9JitsBnKt5SPcBvKHdvV47egRFmNN0t/ofgInHgnK6FCwzGg4U/7Tjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=BkBA9OAw; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="BkBA9OAw"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id C0CAE1B40B;
	Sat, 20 Jan 2024 17:26:08 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=fi5wAKZ8/oKG/7GD5L+/Pt7qsKhZoYTdoqtgpj
	XU/Gc=; b=BkBA9OAwKOwmNsLLzad5UuT/ltOmeAFYa5Bb/Dk4Wf8wLDEULjSgw0
	a8LBQFCqLmqSsmvc/rvymqiHfPAF4hRtr7lT+x8l91jVocfAOmavpQEyIpmCEZF2
	Yv4J7TFIcpQYtPmMJDCQpBz+IVL495LbIj5SJwZ2I59MlZYUvhzSM=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id B8F2B1B40A;
	Sat, 20 Jan 2024 17:26:08 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.200.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 540121B409;
	Sat, 20 Jan 2024 17:26:05 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "Kyle Lippincott via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Kyle Lippincott <spectral@google.com>
Subject: Re: [PATCH] setup: allow cwd=.git w/ bareRepository=explicit
In-Reply-To: <pull.1645.git.1705709303098.gitgitgadget@gmail.com> (Kyle
	Lippincott via GitGitGadget's message of "Sat, 20 Jan 2024 00:08:22
	+0000")
References: <pull.1645.git.1705709303098.gitgitgadget@gmail.com>
Date: Sat, 20 Jan 2024 14:26:03 -0800
Message-ID: <xmqqh6j7ej5w.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 E68D94E4-B7E2-11EE-B9DE-A19503B9AAD1-77302942!pb-smtp21.pobox.com

"Kyle Lippincott via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Kyle Lippincott <spectral@google.com>
>
> The safe.bareRepository setting can be set to 'explicit' to disallow
> implicit uses of bare repositories, preventing an attack [1] where an
> artificial and malicious bare repository is embedded in another git
> repository. Unfortunately, some tooling uses myrepo/.git/ as the cwd
> when executing commands, and this is blocked when
> safe.bareRepository=explicit. Blocking is unnecessary, as git already
> prevents nested .git directories.

In other words, if the directory $D that is the top level of the
working tree of a non-bare repository, you should be able to chdir
to "$D/.git" and run your git command without explicitly saying that
you are inside $GIT_DIR (e.g. "git --git-dir=$(pwd) cmd")?

It makes very good sense.

I briefly wondered if this would give us a great usability
improvement especially for hook scripts, but they are given GIT_DIR
when called already so that is not a big upside, I guess.

> Teach git to not reject uses of git inside of the .git directory: check
> if cwd is .git (or a subdirectory of it) and allow it even if
> safe.bareRepository=explicit.


>     My primary concern with this patch is that I'm unsure if we need to
>     worry about case-insensitive filesystems (ex: cwd=my_repo/.GIT instead
>     of my_repo/.git, it might not trigger this logic and end up allowed).

You are additionally allowing ".git" so even if somebody has ".GIT"
that won't be allowed by this change, no?

>     I'm assuming this isn't a significant concern, for two reasons:
>     
>      * most filesystems/OSes in use today (by number of users) are at least
>        case-preserving, so users/tools will have had to type out .GIT
>        instead of getting it from readdir/wherever.
>      * this is primarily a "quality of life" change to the feature, and if
>        we get it wrong we still fail closed.

Yup.

If we really cared (which I doubt), we could resort to checking with
is_ntfs_dotgit() and is_hfs_dotgit(), but that would work in the
direction of loosening the check even further, which I do not know
is needed.

> -			if (get_allowed_bare_repo() == ALLOWED_BARE_REPO_EXPLICIT)
> +			if (get_allowed_bare_repo() == ALLOWED_BARE_REPO_EXPLICIT &&
> +			    !ends_with_path_components(dir->buf, ".git"))
>  				return GIT_DIR_DISALLOWED_BARE;

Thanks.
