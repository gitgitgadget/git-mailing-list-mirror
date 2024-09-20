Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E3891BF37
	for <git@vger.kernel.org>; Fri, 20 Sep 2024 16:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726850595; cv=none; b=KnO/8AA/skdsk+ETGLYbH/9vDQLqNCAkJf0f+j7qmT63ChRlgspJOJvlwjTryMwr7guLwKpVvDBcc1LI2K1GgGnzVgkSUBMg4KR4NUW1UM4wZ5TFD+unTWtidZazg/yO1wA6JcDsY31zKMjOVYy3K0uEtaS469Ye+AQgh1D4wQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726850595; c=relaxed/simple;
	bh=TZ3qmX6vUxs3SUDIQ0vUNxSGJm/mhdyQCq0mwHkXU5I=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=fyFolXbqNyDULdBHQ9PEUwE28gGzy9gqdBRQfnXU1uGb/tOg7+c+hZ8bgnmklYJs8vn+faxz3d4gUz0jILQWkHWzFqXTx8//NrL3t4pBcdXOoKc1oR7eudZhtqkEkZREt1u/4kAeZbpf+tJdF2rtgVsbElSN09ar/deS7Rv76PE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=u+qaudoj; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="u+qaudoj"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 9A28F1BADF;
	Fri, 20 Sep 2024 12:43:12 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=TZ3qmX6vUxs3SUDIQ0vUNxSGJm/mhdyQCq0mwH
	kXU5I=; b=u+qaudojOWCx+IQ48rFQtlF+BOMPQFNwt6A8SuM980MjL4pDRBuQh7
	L/jY8cubORfEs43qnpTvYbLPGpUmEny6WExMyreHmn7MRtFM9Kdtrcxipny7/Z3/
	QBZcMI1e5O4ZD+zPGZZ/TF6c4FhzAsV5+N6s8LB6l0HiC92GOtet4=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 90E781BADE;
	Fri, 20 Sep 2024 12:43:12 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.108.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 08D901BADD;
	Fri, 20 Sep 2024 12:43:11 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 09/23] dir: fix off by one errors for ignored and
 untracked entries
In-Reply-To: <d5c9cccb8291a1941e6ee1bc8023232e8d5384de.1726484308.git.ps@pks.im>
	(Patrick Steinhardt's message of "Mon, 16 Sep 2024 13:45:49 +0200")
References: <cover.1726484308.git.ps@pks.im>
	<d5c9cccb8291a1941e6ee1bc8023232e8d5384de.1726484308.git.ps@pks.im>
Date: Fri, 20 Sep 2024 09:43:09 -0700
Message-ID: <xmqqfrpu46oy.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 6CB366D8-776F-11EF-81FF-9B0F950A682E-77302942!pb-smtp2.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

> In `treat_directory()` we perform some logic to handle ignored and
> untracked entries. When populating a directory with entries we first
> save the current number of ignored/untracked entries and then populate
> new entries at the end of our arrays that keep track of those entries.
> When we figure out that all entries have been ignored/are untracked we
> then remove this tail of entries from those vectors again. But there is
> an off by one error in both paths that causes us to not free the first
> ignored and untracked entries, respectively.
>
> Fix these off-by-one errors to plug the resulting leak. While at it,
> massage the code a bit to match our modern code style.
>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  dir.c                                              | 6 ++----
>  t/t3011-common-prefixes-and-directory-traversal.sh | 1 +
>  t/t7061-wtstatus-ignore.sh                         | 1 +
>  t/t7521-ignored-mode.sh                            | 1 +
>  4 files changed, 5 insertions(+), 4 deletions(-)
>
> diff --git a/dir.c b/dir.c
> index 5a23376bdae..787bcb7a1a4 100644
> --- a/dir.c
> +++ b/dir.c
> @@ -2135,8 +2135,7 @@ static enum path_treatment treat_directory(struct dir_struct *dir,
>  			 */
>  			state = path_none;
>  		} else {
> -			int i;
> -			for (i = old_ignored_nr + 1; i<dir->ignored_nr; ++i)
> +			for (int i = old_ignored_nr; i < dir->ignored_nr; i++)
>  				FREE_AND_NULL(dir->ignored[i]);
>  			dir->ignored_nr = old_ignored_nr;

So the only effect this bug had was that the entry in the array at
the old_ignored_nr did not get freed, even though the code correctly
updated that the length of the dir->ignored[] after truncation.  I
speculated, before looking at the code change but only from what was
in the proposed log message, that the resulting array ended up to
have an extra entry, or to lose an entry, due to miscounting, but
that is not what is going on.  If the bug's nature was that we
screwed up the length of the updated array, somebody would certainly
have noticed a bug in the end-user observable behaviour that a path
that should be ignored is not getting ignored or the other way
around.  Interesting.

I would imagine this is something hard to spot with code inspection
alone, yet fairly easy for the leak checker to notice.  I am happy
to see that it does really help to have good code coverage in the
test suite.

Thanks.
