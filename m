Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4559A2836B0
	for <git@vger.kernel.org>; Thu, 10 Apr 2025 11:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744285518; cv=none; b=aD44J0k4caR+T7Z4C8Udn35aDketutc92Zday529XxzesW4KwDxO8aTP1CWRnN+tdVpak4f/JCBjfY2/rJ+EonV8RUy5RAR5/zHz6l305voAK4FUdJVLBMAzK6D0oPfFCUUlFaI+CUYEObQehcEINmWYuT+U8D66cWI4gQG9+4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744285518; c=relaxed/simple;
	bh=9ME7s+R6liwaarCbliHf5elC5snmNHxLvgdcIkemdt0=;
	h=From:To:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=NzgnT3rlf3VRzynXpeNtVpUSEwBB+wUNR6lOiwALn5wFxLy7pR4S0FPoKiMZtK9B2apL+ry2kT9hO6xSnaEWw3LYxOKyrUWdG2bAYYIo4gkQWvYU1vhw11VXxvOEbFKKU3QpDitJgV5Mq+ODUrXAHkWzLocaTulBZmnTHDcu8C4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=HQ8iZ8MW; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="HQ8iZ8MW"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1744285511;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZbVKnkK/VLzDMRzJPUvepg3B/pKYnpzr08QnhS1ISKI=;
	b=HQ8iZ8MW4MasiIsV6RCwAv1ejfcmK+mme2Dq28iIhytEqY1EhvQfrKdxlVc9Ds0Fc+Naan
	GxTCT9BmULHgbqYcJXIZQ0oXNQgPwU0Z5yuQPa7/NSwNwMQbaVN4pz91BsfZJ6ggQNJU2t
	/zHJLGzZVsMRU1xLduUS9XkgLs3vFB4=
From: Toon Claes <toon@iotcl.com>
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Subject: Re: [PATCH 4/5] meson: wire up benchmarks
In-Reply-To: <20250331-pks-meson-benchmarks-v1-4-b2ace85616a3@pks.im>
References: <20250331-pks-meson-benchmarks-v1-0-b2ace85616a3@pks.im>
 <20250331-pks-meson-benchmarks-v1-4-b2ace85616a3@pks.im>
Date: Thu, 10 Apr 2025 13:44:55 +0200
Message-ID: <87r020dyvc.fsf@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT

Patrick Steinhardt <ps@pks.im> writes:

> Wire up benchmarks in Meson. The setup is mostly the same as how we wire
> up our tests. The only difference is that benchmarks get wired up via
> the `benchmark()` option instead of via `test()`, which gives them a bit
> of special treatment:
>
>   - Benchmarks never run in parallel.
>
>   - Benchmarks aren't run by default when tests are executed.
>
>   - Meson does not inject the `MALLOC_PERTURB` environment variable.
>
> Using benchmarks is quite simple:
>
>     ```
>     $ meson setup build
>     # Run all benchmarks.
>     $ meson test -C build --benchmark
>     # Run a specific benchmark.
>     $ meson test -C build --benchmark p0000-*
>     ```

I really appreciate the efforts, and I'd love to run the perf tests with
Meson, but at the moment I don't know how these changes are useful
because this doesn't print anything relevant:

    $ meson test -C build --benchmark 'p0005-*'
    ninja: Entering directory `/home/toon/devel/git/build'
    [1/28] Generating GIT-VERSION-FILE with a custom command (wrapped by meson to set env)
    1/1 p0005-status        OK              7.39s

    Ok:                 1
    Expected Fail:      0
    Fail:               0
    Unexpected Pass:    0
    Skipped:            0
    Timeout:            0

    Full log written to /home/toon/devel/git/build/meson-logs/testlog.txt

> Other than that the usual command line arguments accepted when running
> tests are also accepted when running benchmarks.
>
> Note that the benchmarking target is somewhat limited because it will
> only run benchmarks for the current build. Other usecases, like running
> benchmarks against multiple different versions of Git, are not currently
> supported. Users should continue to use "t/perf/run" for those usecases.
> The script should get extended at one point in time to support Meson,
> but this is outside of the scope of this series.

Yeah, this is unfortunate, but totally understandable. I've been digging
in `t/perf/run` and `f/perf/aggregate.perl` and it doesn't look easy to
adapt to Meson.

But I was wondering, instead of trying to fully integrate Meson into
those scripts, could we modify the scripts so they work with binaries
built by Meson? I mean, if we could run
`cd t/perf && ./run ../../build1 ../../build2 p0005*` and it would
simply run the benchmarks in those directories (without trying to check
out code and build the sources). I think this would help a lot already.

-- 
Toon
