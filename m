Received: from out-175.mta1.migadu.com (out-175.mta1.migadu.com [95.215.58.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D85FA3232
	for <git@vger.kernel.org>; Tue,  4 Feb 2025 16:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738685874; cv=none; b=pqCGpRHvpj+9PtHqT92BZ0t5qIKY1CrdYoxi3UuOnMMTG8tfMpqGU4IpCzGyPV9QxgTMwAr9z3G3bfd+g+CZVqKDPOmQU3Ub0R1TiocTZDi6lqvXomAWbT5zALdM4k7N0y2ICpms9Uz+3JDi8ZTiNAIvZhhwFHKuAmHMzlzSsAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738685874; c=relaxed/simple;
	bh=glhwgGgmTmJnQbLGbpuBLdeH/M9/mlodbvcZGzDoyrk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=dGHAKhmbzdVGfepnUYW0Htz11nIuYykoMKKTKa/9WQYIQ8ceKVSjxjeACUn6MtKW0JQV5QNq+IfbO/IIqwH43Xyz8T0mlWsmMXEHvhbETfSP360d/xE+EcCnDux7EoW3+K++CLZZw3Km5d8mHek4jy14LwxQhs5qlAQVtg5oPWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=nwn2jpbS; arc=none smtp.client-ip=95.215.58.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="nwn2jpbS"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1738685866;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RfVKnRT0E0JaXuflh8U6AwdiQURjo9BmfmE1N6bQFIQ=;
	b=nwn2jpbSFcqu9P9LYA341PVNgn1ynXJOT11kMfNs18Y9JNhqqCmH7czKYUdDtaHfik5GZZ
	+tasyylGWH11rDXoyC9WVh2meLbnS4pa1ClxI7Bkg5umFq2HsnoEJFe61K9BdwOF63Pa/t
	oa2ELKDE/2/q8ZJ6mgEYBqdXaq7JJms=
From: Toon Claes <toon@iotcl.com>
To: Justin Tobler <jltobler@gmail.com>, git@vger.kernel.org
Cc: Justin Tobler <jltobler@gmail.com>
Subject: Re: [PATCH] ci: fix base commit fallback for check-whitespace and
 check-style
In-Reply-To: <20250131173938.3592899-1-jltobler@gmail.com>
References: <20250131173938.3592899-1-jltobler@gmail.com>
Date: Tue, 04 Feb 2025 17:17:24 +0100
Message-ID: <87ldul4rcb.fsf@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Migadu-Flow: FLOW_OUT

Justin Tobler <jltobler@gmail.com> writes:

> The check-whitespace and check-style CI scripts require a base commit.
> In GitLab CI, the base commit can be provided by several different
> predefined CI variables depending on the type of pipeline being
> performed.
>
> In 30c4f7e350 (check-whitespace: detect if no base_commit is provided,
> 2024-07-23), the GitLab check-whitespace CI job was modified to support
> CI_MERGE_REQUEST_DIFF_BASE_SHA as a fallback base commit if
> CI_MERGE_REQUEST_TARGET_BRANCH_SHA was not provided. The same fallback
> strategy was also implemented for the GitLab check-style CI job in
> bce7e52d4e (ci: run style check on GitHub and GitLab, 2024-07-23).
>
> The base commit fallback is implemented using shell parameter expansion
> where, if the first variable is unset, the second variable is used as
> fallback. In GitLab CI, these variables can be set but null. This has
> the unintended effect of selecting an empty first variable which results
> in CI jobs providing an invalid base commit and failing.

I didn't know using this expansion was possible without a colon, but as
you pointed out (off-list), it is. From [1]:

    Omitting the colon results in a test only for a parameter that is
    unset. Put another way, if the colon is included, the operator tests
    for both parameter=E2=80=99s existence and that its value is not null; =
if
    the colon is omitted, the operator tests only for existence.

> Fix the issue by defaulting to the fallback variable if the first is
> unset or null.

Yeah, makes sense to do this.


> Signed-off-by: Justin Tobler <jltobler@gmail.com>
> ---
> Successful GitLab CI check-whitespace and check-style runs:
>   - https://gitlab.com/gitlab-org/git/-/jobs/9011117606
>   - https://gitlab.com/gitlab-org/git/-/jobs/9011117607
> ---
>  .gitlab-ci.yml | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
> index 9254e01583..273a8bad39 100644
> --- a/.gitlab-ci.yml
> +++ b/.gitlab-ci.yml
> @@ -183,7 +183,7 @@ check-whitespace:
>    # be defined in all pipelines.
>    script:
>      - |
> -      R=3D${CI_MERGE_REQUEST_TARGET_BRANCH_SHA-${CI_MERGE_REQUEST_DIFF_B=
ASE_SHA:?}} || exit
> +      R=3D${CI_MERGE_REQUEST_TARGET_BRANCH_SHA:-${CI_MERGE_REQUEST_DIFF_=
BASE_SHA:?}} || exit
>        ./ci/check-whitespace.sh "$R"
>    rules:
>      - if: $CI_PIPELINE_SOURCE =3D=3D 'merge_request_event'
> @@ -203,7 +203,7 @@ check-style:
>    # be defined in all pipelines.
>    script:
>      - |
> -      R=3D${CI_MERGE_REQUEST_TARGET_BRANCH_SHA-${CI_MERGE_REQUEST_DIFF_B=
ASE_SHA:?}} || exit
> +      R=3D${CI_MERGE_REQUEST_TARGET_BRANCH_SHA:-${CI_MERGE_REQUEST_DIFF_=
BASE_SHA:?}} || exit
>        ./ci/run-style-check.sh "$R"
>    rules:
>      - if: $CI_PIPELINE_SOURCE =3D=3D 'merge_request_event'
>
> base-commit: 3b0d05c4a79d0e441283680a864529b02dca5f08
> --=20
> 2.48.1.157.g3b0d05c4a7

Simple fix, but thank you so much for figuring out and submitting this
patch. I approve!

[1]: https://www.gnu.org/software/bash/manual/html_node/Shell-Parameter-Exp=
ansion.html

--
Toon

