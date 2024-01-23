Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A17E5F841
	for <git@vger.kernel.org>; Tue, 23 Jan 2024 14:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706019095; cv=none; b=i8IePtEn/jF013K7DtWa66OeXEKk37hZEjLr2MTPQrDnSyjifvnmG5XAbzjDLig8ahxjxmCuYl1maf35BX8/I+jiHzXJewxAusDmcP3cZDkbmo7CrdBWgzn/VBA7qKVyAPeVVnJxVN1VnKp/lGZe+z1kuD0umo3h9UN2Bbhf2pk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706019095; c=relaxed/simple;
	bh=K2wxcqczAmPUVy9xSL8bc8XqhCUgIhwlSpgb++p7zg4=;
	h=References:From:To:Cc:Subject:Date:In-reply-to:Message-ID:
	 MIME-Version:Content-Type; b=Cp7nA+wjnaNj4fHpbWpwmgAsjv5Jmb1D6kAdxdM3RWQrryMgQ0wx9glxy4JhxUQ5+RUFgNAqnlXqiBmas2Rea4O/IWQcir9NizT40sbhrq1WqWom9qkooUwaRwn6rmPLztNuTI97IJHqLJuWvJYwOQ2CQBJiDjmCYvpVe746UD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=KE+AFn8J; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="KE+AFn8J"
References: <cover.1704802213.git.ps@pks.im>
 <cover.1704877233.git.ps@pks.im>
 <1284b70fab6dd85114cb24fc5c7b6c49e35eb135.1704877233.git.ps@pks.im>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1706019089;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RhjO+lAMo6pMg4N9tAn/DSBAskbYylXJbzEgjTn41sM=;
	b=KE+AFn8JgYiAVuGqKVUtBIIkZT6Egh9tmG5THpxDc9ddfQPOJOgC3+WHAOVxnA1cY263P7
	6g16pU8H8RHMnwpMQkBrSnkP9Q9plOqZgwWQUVNO3yArCnifRA5uW+QsQljYeDhuDqHesN
	hURIYLYVl3Q2Ubjsr2OVshKgbnOqqvw=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Toon Claes <toon@iotcl.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>, Eric Sunshine
 <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 3/6] t1302: make tests more robust with new extensions
Date: Tue, 23 Jan 2024 15:08:00 +0100
In-reply-to: <1284b70fab6dd85114cb24fc5c7b6c49e35eb135.1704877233.git.ps@pks.im>
Message-ID: <87a5owqgzi.fsf@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT


Patrick Steinhardt <ps@pks.im> writes:

> [[PGP Signed Part:Undecided]]
> [1. text/plain]
> In t1302 we exercise logic around "core.repositoryFormatVersion" and
> extensions. These tests are not particularly robust against extensions
> like the newly introduced "refStorage" extension.
>
> Refactor the tests to be more robust:
>
>   - Check the DEFAULT_REPO_FORMAT prereq to determine the expected
>     repository format version. This helps to ensure that we only need to
>     update the prereq in a central place when new extensions are added.
>
>   - Use a separate repository to rewrite ".git/config" to test
>     combinations of the repository format version and extensions. This
>     ensures that we don't break the main test repository.
>
>   - Do not rewrite ".git/config" when exercising the "preciousObjects"
>     extension.
>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  t/t1302-repo-version.sh | 19 +++++++++++++++----
>  1 file changed, 15 insertions(+), 4 deletions(-)
>
> diff --git a/t/t1302-repo-version.sh b/t/t1302-repo-version.sh
> index 179474fa65..7c680c91c4 100755
> --- a/t/t1302-repo-version.sh
> +++ b/t/t1302-repo-version.sh
> @@ -79,8 +84,13 @@ mkconfig () {
>
>  while read outcome version extensions; do
>  	test_expect_success "$outcome version=$version $extensions" "
> -		mkconfig $version $extensions >.git/config &&
> -		check_${outcome}
> +		test_when_finished 'rm -rf extensions' &&
> +		git init extensions &&
> +		(
> +			cd extensions &&
> +			mkconfig $version $extensions >.git/config &&

Why did you not remove the use of `mkconfig` here?

--
Toon
