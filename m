Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B02B238E23
	for <git@vger.kernel.org>; Wed, 11 Dec 2024 12:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733920700; cv=none; b=iTOvP12gqL6+juhyQoLW6JwcPjYLrSrLEBSOTajdophDZ3fVfhtodD9Owv6NrwpT69IeErATTDtWroAXBL6k5VnhdnHXAhPoUgwDgzcj45EmS5G2wkTI/mPLIEaI+rXI52Shin3IUffM8WgEGwp+vBkuc3w3eHuBw0a74uDvNS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733920700; c=relaxed/simple;
	bh=d+KClUe3vF8NFAJDPcaTuty7Kz52X2mInoNBjGnaO0A=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=IqQNoCxX8T4OaOrSavvfe0G2MvG2ZJ2QVP1fKgnFRdz1cnezeBww6UJqygeT8j3ya/P8Lju+ltSvaw1kfNKwTHzk/WsUYa2BJDTVXZFWo5yKIPfiMG3atNsYN8Y4g0chU2tbQQZQGTSwMpvRXEown8xoqJkx9QZ5vtwF/2wmL18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=O0rDvipw; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="O0rDvipw"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1733920691;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qiRIGprpue8dw7rrnHKAzDHLsuN21T6jwAkEBBQxRy0=;
	b=O0rDvipw0tICLPauJeZUqumE3Rj0GoV6fLLBMbr/1PjyAc4jIgvr9VJA3KtlEaHWZx2/Pl
	7jKhxcclA8Jg6VL/lstDOh427dGdv2AClBFMVYQj7GTiX+PGlYXTvOmm4oLBeuxoNwG8Pj
	7uW3NloiybcpK4A7SH2KUtr6O8JxFnU=
From: Toon Claes <toon@iotcl.com>
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>, karthik nayak
 <karthik.188@gmail.com>
Subject: Re: [PATCH v2 3/4] ci/lib: do not interpret escape sequences in
 `group ()` arguments
In-Reply-To: <20241210-pks-ci-section-fixes-v2-3-e087cfd174f4@pks.im>
References: <20241210-pks-ci-section-fixes-v2-0-e087cfd174f4@pks.im>
 <20241210-pks-ci-section-fixes-v2-3-e087cfd174f4@pks.im>
Date: Wed, 11 Dec 2024 13:37:53 +0100
Message-ID: <874j3ajsym.fsf@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT

Patrick Steinhardt <ps@pks.im> writes:

> We use printf to set up sections with GitLab CI, which requires us to
> print a bunch of escape sequences via printf. The group name is
> controlled by the user and is expanded directly into the formatting
> string, which may cause problems in case the argument controls escape
> sequences or formatting directives.

Could it be you mean "contains" instead of "controls"?

>
> Fix this potential issue by using formatting directives to pass variable
> data.
>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  ci/lib.sh | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/ci/lib.sh b/ci/lib.sh
> index a54601be923bf475ba1a9cafd98bb1cb71a10255..f15f77f03a06120afbee438cee76ddc2683e1fa2 100755
> --- a/ci/lib.sh
> +++ b/ci/lib.sh
> @@ -18,7 +18,7 @@ elif test true = "$GITLAB_CI"
>  then
>  	begin_group () {
>  		need_to_end_group=t
> -		printf "\e[0Ksection_start:$(date +%s):$(echo "$1" | tr ' ' _)[collapsed=true]\r\e[0K$1\n"
> +		printf '\e[0Ksection_start:%s:%s[collapsed=true]\r\e[0K%s\n' "$(date +%s)" "$(echo "$1" | tr ' ' _)" "$1"

Personally I find this line rather lengthy and hard to read with all the
single and double quotes. So I would suggest to split the line with a
backslash and put the arguments on a separate line. But I don't think
there's a general guideline on this, so feel free to ignore.

>  		trap "end_group '$1'" EXIT
>  		set -x
>  	}
> @@ -27,7 +27,7 @@ then
>  		test -n "$need_to_end_group" || return 0
>  		set +x
>  		need_to_end_group=
> -		printf "\e[0Ksection_end:$(date +%s):$(echo "$1" | tr ' ' _)\r\e[0K\n"
> +		printf '\e[0Ksection_end:%s:%s\r\e[0K\n' "$(date +%s)" "$(echo "$1" | tr ' ' _)"

Same here.

But that's all I've got on this patch series. Looking good!

--
Toon
