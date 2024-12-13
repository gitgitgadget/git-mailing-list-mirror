Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7232B18BBAC
	for <git@vger.kernel.org>; Fri, 13 Dec 2024 10:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734084078; cv=none; b=BTuBAvDPJkoHEUPFurd51f0rJVOfNfw4LCKEDmyj17b8O+OdU3EP/1bTHCPmTO8wAD0vMKz2eo3fXAbqQ3hoda1Xpna7MjV2GDAiShohFWH7F/OWjfjb0Z9FJ6ytKF1S4BcVHrfrheN5cP3nPQjkkmFtTDGE2rtUZgeyiUeTEdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734084078; c=relaxed/simple;
	bh=sS1YfmqIE7OmzjSKdiRwAQk9Mv2Hop5LToWppCe17yY=;
	h=From:To:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=H2/s3it6PhzrbNDQTVrn8tl7jkdmrxh44FlGyFIDGIPDxc1n1+yN92PuB2TdTv39wxBonzEBGrQAlMK+OLxR3Q3mCKdzu8sQJ7JnrbKPp4HrxLpBPI46FrNluvEg6qtQvmTIh3YPCJxBJugsmAVVOYxONmgvohtYs2/EcKfKkSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=N5m/+oDG; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="N5m/+oDG"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1734084070;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vcH5f7LY95+t4l8JJma11cVhQgmgY6kj8jegj0bbypY=;
	b=N5m/+oDGlMm426WLAV0Z7UavfZQxLv5yJbTaXfyjwworvJIMZg1itq+UJ/j6KBQrM5ZC9T
	x+exEJ8fOgxpHKmRCjmZ1O6WvGpkN9MH87BaC+FX5GOosWZmS9vqNQN5tXb/Kf5Br7roB7
	0UPFUGTD8pz/eqYvF/w/NBBB/8z4RgQ=
From: Toon Claes <toon@iotcl.com>
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Subject: Re: [PATCH 7/8] t: introduce compatibility options to clar-based tests
In-Reply-To: <20241211-pks-meson-ci-v1-7-28d18b494374@pks.im>
References: <20241211-pks-meson-ci-v1-0-28d18b494374@pks.im>
 <20241211-pks-meson-ci-v1-7-28d18b494374@pks.im>
Date: Fri, 13 Dec 2024 11:00:57 +0100
Message-ID: <878qsjj412.fsf@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT

Patrick Steinhardt <ps@pks.im> writes:

> Our unit tests that don't yet use the clar unit testing framework ignore
> any option that they do not understand. It is thus fine to just pass
> test options we set up globally to those unit tests as they are simply
> ignored. This makes our life easier because we don't have to special
> case those options with Meson, where test options are set up globally
> via `meson test --test-args=`.
>
> But our clar-based unit testing framework is way stricter here and will
> fail in case it is passed an unknown option. Stub out these options with
> no-ops to make our life a bit easier.
>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  parse-options.h          | 12 ++++++++++++
>  t/unit-tests/unit-test.c | 19 ++++++++++++++++++-
>  2 files changed, 30 insertions(+), 1 deletion(-)
>
> diff --git a/parse-options.h b/parse-options.h
> index f0801d4532a175b65783689f2a68fb56da2c8e87..d01361ca97fd7227a0005b5c447d954fea472ca0 100644
> --- a/parse-options.h
> +++ b/parse-options.h
> @@ -353,6 +353,18 @@ struct option {
>  	.callback = parse_opt_noop_cb, \
>  }
>  
> +static char *parse_options_noop_ignored_value MAYBE_UNUSED;
> +#define OPT_NOOP_ARG(s, l) { \
> +	.type = OPTION_CALLBACK, \
> +	.short_name = (s), \
> +	.long_name = (l), \
> +	.value = &parse_options_noop_ignored_value, \
> +	.argh = "ignored", \
> +	.help = N_("no-op (backward compatibility)"), \
> +	.flags = PARSE_OPT_HIDDEN, \
> +	.callback = parse_opt_noop_cb, \
> +}
> +
>  #define OPT_ALIAS(s, l, source_long_name) { \
>  	.type = OPTION_ALIAS, \
>  	.short_name = (s), \
> diff --git a/t/unit-tests/unit-test.c b/t/unit-tests/unit-test.c
> index a474cdcfd351d9d624178a769329252237f951b7..fa8818842a42478c7a8fa6f6ecbee0777bdf472f 100644
> --- a/t/unit-tests/unit-test.c
> +++ b/t/unit-tests/unit-test.c
> @@ -18,8 +18,25 @@ int cmd_main(int argc, const char **argv)
>  			 N_("immediately exit upon the first failed test")),
>  		OPT_STRING_LIST('r', "run", &run_args, N_("suite[::test]"),
>  				N_("run only test suite or individual test <suite[::test]>")),
> -		OPT_STRING_LIST('x', "exclude", &exclude_args, N_("suite"),
> +		OPT_STRING_LIST(0, "exclude", &exclude_args, N_("suite"),

Could you please explain in the commit message why it's safe to unassign
`-x` from `--exclude`?


-- 
Toon
