Received: from bsmtp1.bon.at (bsmtp1.bon.at [213.33.87.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B2163A759F
	for <git@vger.kernel.org>; Wed, 25 Mar 2026 10:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.33.87.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774433237; cv=none; b=TiINVI9bNoRHfkkmYRhVokjfAV93Qff+8nRtBcs46hlQcyAHEexOa0XXTXMRkA0SLi6hUyRdh4yZe+hbR2+9bWblLWp8raUahv5HoJl6UoVXL9n8sdBUfniitNFjV0hASrJqQ/ywTBfoz8waCyeM3hqO5ClW4Lb4JwJKJAGqcuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774433237; c=relaxed/simple;
	bh=T1hJBMCiHTth7M/07niXVabVJ+/AFOMHxSG55mnZ1tw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=q0aq7CJkcnFRS2IOBtfx1jKIqSq62S+kSGMhhpoFap5QVZDT88z9LpcQGOEyjBhC7fSHA8kNVdFaT65RMOo8WyUHtMT1kjUkw4+hIW8HnGAIseyWRFa4d2K+AukQK+3PY9cn/3v7sOp5rkjVoXAGz1FJvT2//HVpd4eFoiGj+QQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org; spf=pass smtp.mailfrom=kdbg.org; arc=none smtp.client-ip=213.33.87.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kdbg.org
Received: from [192.168.0.103] (unknown [93.83.142.38])
	by bsmtp1.bon.at (Postfix) with ESMTPSA id 4fgjHt4lGbzRpXD;
	Wed, 25 Mar 2026 11:07:06 +0100 (CET)
Message-ID: <6cdcece0-8cc5-4c87-8727-6d3e17424a9e@kdbg.org>
Date: Wed, 25 Mar 2026 11:07:06 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GSoC PATCH v4 3/3] graph: add documentation and tests about
 --graph-lane-limit
Content-Language: en-US
To: Pablo Sabater <pabloosabaterr@gmail.com>, git@vger.kernel.org
Cc: christian.couder@gmail.com, karthik.188@gmail.com, jltobler@gmail.com,
 ayu.chandekar@gmail.com, siddharthasthana31@gmail.com,
 chandrapratap3519@gmail.com, gitster@pobox.com
References: <20260322195406.108280-1-pabloosabaterr@gmail.com>
 <20260323215935.74486-1-pabloosabaterr@gmail.com>
 <20260323215935.74486-4-pabloosabaterr@gmail.com>
From: Johannes Sixt <j6t@kdbg.org>
In-Reply-To: <20260323215935.74486-4-pabloosabaterr@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Am 23.03.26 um 22:59 schrieb Pablo Sabater:
> @@ -1259,6 +1259,11 @@ This implies the `--topo-order` option by default, but the
>  	in between them in that case. If _<barrier>_ is specified, it
>  	is the string that will be shown instead of the default one.
>  
> +`--graph-lane-limit=<n>`::
> +	When `--graph` is used, limit the number of graph lanes to be shown.
> +	Lanes over the limit are replaced with a truncation mark '.'. By default
> +	there is no limit.

This should probably mention that 0 means no limit.

> +
>  ifdef::git-rev-list[]
>  `--count`::
>  	Print a number stating how many commits would have been
> diff --git a/t/t4215-log-skewed-merges.sh b/t/t4215-log-skewed-merges.sh
> index 28d0779a8c..650701df42 100755
> --- a/t/t4215-log-skewed-merges.sh
> +++ b/t/t4215-log-skewed-merges.sh
> @@ -370,4 +370,57 @@ test_expect_success 'log --graph with multiple tips' '
>  	EOF
>  '
>  
> +test_expect_success 'log --graph --graph-lane-limit=2 limited to two lanes' '
> +	check_graph --graph-lane-limit=2 M_7 <<-\EOF
> +	*-.   7_M4
> +	|\ \
> +	| | * 7_G
> +	| | * 7_F
> +	| * . 7_E
> +	| * . 7_D
> +	* | . 7_C
> +	| |/
> +	|/|
> +	* | 7_B
> +	|/
> +	* 7_A

I'm confused. If the lane limit is 2, why do we have actually have 3 lanes?

> +test_expect_success 'log --graph --graph-lane-limit=3 limited to three lanes' '
> +	check_graph --graph-lane-limit=3 M_1 M_3 M_5 M_7 <<-\EOF
> +	*   7_M1
> +	|\
> +	| | *   7_M2
> +	| | |\
> +	| | | * 7_H
> +	| | | . 7_M3
> +	| | | . 7_J
> +	| | | . 7_I
> +	| | | . 7_M4
> +	| |_|_.
> +	|/| | .
> +	| | |_.
> +	| |/| .
> +	| | | .
> +	| | |/.
> +	| | * . 7_G
> +	| | | .
> +	| | |/.
> +	| | * . 7_F
> +	| * | . 7_E
> +	| | |/.
> +	| |/| .
> +	| * | . 7_D
> +	| | |/
> +	| |/|
> +	* | | 7_C
> +	| |/
> +	|/|
> +	* | 7_B
> +	|/
> +	* 7_A

Same here. Why is there a fourth lane?

Oh! "Truncation" here does not mean that the vertial lines are cut off
and are supposed to continue sometime later in the chart. It literally
means that the *line* is truncated and just some stuff *on that line* is
omitted.

Ouch! That was not what I was expecting. I thought that truncation means
that when the eye follows a line vertically, it finds the truncation
point of the line at some point, and then the continuation of that line
is again some time later down the chart. The only clue which lanes are
the same would be the color, which would have to be remedied somehow.

I don't know what to make of it. I have to reconsider.

-- Hannes

