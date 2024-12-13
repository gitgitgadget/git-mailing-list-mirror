Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C91451B4153
	for <git@vger.kernel.org>; Fri, 13 Dec 2024 09:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734083949; cv=none; b=H+iS2gU/K6Jw8dNZF7GObRW9GKTg8eFPDt9xdPxg6J7/vjBxYmLjcgzqD/mLiZCR1Vx64JX0xHUozqt1dfLKWvthmuLZNutJpt5VyYeez4HLsiX4mIQZG41FPeihPQB/0rIOa0adswF4MSD6ue/JJy0XET/edVSXjkcTTOnH30M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734083949; c=relaxed/simple;
	bh=0PHW0qaTMPL5De4tEIBLaZozyWyRxmCjE7OUa1SADRM=;
	h=From:To:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=k1D5bjAKx3BamIUoZHVRi7GBta65dgOhSbmxRf0L1JMeg7LPulE8Bv2gMC+ee/5pEXXiuUHmbcjtDM5ZuDwFn0X3ZN8gZ/D95/dVK1IwDpFPT43TirDrE1NsiSYtP38cO6cKv8U+1PZFso4keO9Q6hzwas4iWq9s9fJDrq40v+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=AJCUkeJn; arc=none smtp.client-ip=95.215.58.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="AJCUkeJn"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1734083939;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZMnT9CwOks/C3JYXA2OW+z4kUS8SA117JMnitqwKgCw=;
	b=AJCUkeJnaHvPYHy7ZrHmzDRbGtOk3WFZ6QDErPmPnAJWtieDW2arVtLTJ5gk5Rnh+40nfT
	EtGY5IbFB2pRxzvKisB0p174kzcwHAIoANmocJQC2FawxzOYkj7813of7rcpujBbjDO0Lu
	G5Q9nEFvMDLfIZcwt934l8uiex5tngM=
From: Toon Claes <toon@iotcl.com>
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Subject: Re: [PATCH 4/8] meson: detect missing tests at configure time
In-Reply-To: <20241211-pks-meson-ci-v1-4-28d18b494374@pks.im>
References: <20241211-pks-meson-ci-v1-0-28d18b494374@pks.im>
 <20241211-pks-meson-ci-v1-4-28d18b494374@pks.im>
Date: Fri, 13 Dec 2024 10:58:47 +0100
Message-ID: <87bjxfj44o.fsf@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT

Patrick Steinhardt <ps@pks.im> writes:

> It is quite easy for the list of integration tests to go out-of-sync
> without anybody noticing. Introduce a new configure-time check that
> verifies that all tests are wired up properly.
>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  t/meson.build | 36 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 36 insertions(+)
>
> diff --git a/t/meson.build b/t/meson.build
> index 9e676e69363ed6311426500d98fe281e30d26bcb..f1fbc6ae179079f4d5d86f9a60956fad84d0495c 100644
> --- a/t/meson.build
> +++ b/t/meson.build
> @@ -1092,6 +1092,42 @@ integration_tests = [
>    't9903-bash-prompt.sh',
>  ]
>  
> +# Sanity check that we are not missing any tests present in 't/'. This check
> +# only runs once at configure time and is thus best-effort, only. It is
> +# sufficient to catch missing test suites in our CI though.
> +foreach glob, tests : {
> +  't[0-9][0-9][0-9][0-9]-*.sh': integration_tests,
> +  'unit-tests/t-*.c': unit_test_programs,
> +  'unit-tests/u-*.c': clar_test_suites,
> +}
> +  actual_tests = run_command(shell, '-c', 'ls ' + glob,
> +    check: true,
> +    env: script_environment,
> +  ).stdout().strip().split('\n')
> +
> +  if tests != actual_tests
> +    missing_tests = [ ]
> +    foreach actual_test : actual_tests
> +      if actual_test not in tests
> +        missing_tests += actual_test
> +      endif
> +    endforeach
> +    if missing_tests.length() > 0
> +      error('Missing tests:\n\n - ' + '\n - '.join(missing_tests))

This gives nice output:

    $ touch t/unit-tests/u-bar.c t/unit-tests/u-foo.c

    $ meson setup builddir --reconfigure

    The Meson build system
    Version: 1.4.1
    [snip]
    Configuring update.sample using configuration
    Configuring exclude using configuration

    t/meson.build:1116:6: ERROR: Problem encountered: Missing tests:

     - unit-tests/u-bar.c
     - unit-tests/u-foo.c

    A full log can be found at git/builddir/meson-logs/meson-log.txt

But I think the error message is a little bit confusing. It sounds like
the test file is missing, but it's the configuration of the test that is
missing.

Now I've realized it hard to write a good error message here. But I
would suggest something like "Tests files found, but not configured".

> +    endif
> +
> +    superfluous_tests = [ ]
> +    foreach integration_test : tests
> +      if integration_test not in actual_tests
> +        superfluous_tests += integration_test
> +      endif
> +    endforeach
> +    if superfluous_tests.length() > 0
> +      error('Superfluous tests:\n\n - ' + '\n - '.join(superfluous_tests))

Also here I would suggest different error message, maybe something like
"Tests configured, but file not found"

-- 
Toon
