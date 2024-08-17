Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A27212CDBE
	for <git@vger.kernel.org>; Sat, 17 Aug 2024 07:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723878571; cv=none; b=MxAqcL+PuquufW5/NC3medPnFLN6pbizkCCfmCJMtP/XIeqHKqMu5eFpKxxcBlF+FntuQ9Q2xXbx7fKVYo0Fjm+OM5HyFquLc8BIzs70CVh9MjxMIv4tx45jX3izgDwHugKON9bVEBIN7RcSrxcYQPuxR1T/o68Vpz+Z1p2SK0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723878571; c=relaxed/simple;
	bh=Faid33iS2ec/txHAMPk6MoyuXreuZFycyuCbjzhvlF8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OC40QOxA0GIrkdMRAruRRzhKzljNy2/N8atU/TvcFt4GuFhc/NFssTFxU1LkyeRzPg94dMw5b8Oyi6EEpNgbC1V12utOMoCLPKQ42cChSYvpy8leUu8gnB5M13QzTjSY7A1l05ArWlMyQPRjG1CUjUWbidkS6YBwyd6+0eFCiDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 23306 invoked by uid 109); 17 Aug 2024 07:09:27 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 17 Aug 2024 07:09:27 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 27413 invoked by uid 111); 17 Aug 2024 07:09:29 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 17 Aug 2024 03:09:29 -0400
Authentication-Results: peff.net; auth=none
Date: Sat, 17 Aug 2024 03:09:24 -0400
From: Jeff King <peff@peff.net>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Phillip Wood <phillip.wood123@gmail.com>,
	phillip.wood@dunelm.org.uk, James Liu <james@jamesliu.io>,
	Derrick Stolee <stolee@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 6/7] builtin/maintenance: add a `--detach` flag
Message-ID: <20240817070924.GA1438563@coredump.intra.peff.net>
References: <cover.1723533091.git.ps@pks.im>
 <cover.1723804990.git.ps@pks.im>
 <347d0a200201ce215f5b2c46d23de0cdd0181956.1723804990.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <347d0a200201ce215f5b2c46d23de0cdd0181956.1723804990.git.ps@pks.im>

On Fri, Aug 16, 2024 at 12:45:15PM +0200, Patrick Steinhardt wrote:

> +test_expect_success '--no-detach causes maintenance to not run in background' '
> [...]
> +		# We have no better way to check whether or not the task ran in
> +		# the background than to verify whether it output anything. The
> +		# next testcase checks the reverse, making this somewhat safer.
> +		git maintenance run --no-detach >out 2>&1 &&
> +		test_line_count = 1 out
> [...]
> +test_expect_success '--detach causes maintenance to run in background' '
> +	test_when_finished "rm -rf repo" &&
> +	git init repo &&
> +	(
> +		cd repo &&
> +
> +		test_commit something &&
> +		git config set maintenance.gc.enabled false &&
> +		git config set maintenance.loose-objects.enabled true &&
> +		git config set maintenance.loose-objects.auto 1 &&
> +		git config set maintenance.incremental-repack.enabled true &&
> +
> +		git maintenance run --detach >out 2>&1 &&
> +		test_must_be_empty out
> +	)
> +'

This second test seems to fail racily (or maybe always? see below). In
CI on Windows, I saw:

  'out' is not empty, it contains:
  fc9fea69579f349e3b02e3264cffbef03e4b1852

That would make sense to me if the detached process still held the
original stdout/stderr channel open (in which case we'd racily see the
same line as in the no-detach case). But we do appear to call
daemonize(), which closes both.

Curiously, the code in gc.c does this:

          /* Failure to daemonize is ok, we'll continue in foreground. */
          if (opts->detach > 0)
                  daemonize();

and the only way for daemonize to fail is if NO_POSIX_GOODIES is set.
Which I'd expect on Windows. But then I'd expect this test to _always_
fail on Windows. Does it? If so, should it be marked with !MINGW?

While investigating that, I ran it with --stress locally (on Linux) and
got some odd (and definitely racy) results. The test itself passes, but
the "rm -rf repo" in the test_when_finished sometimes fails with:

  rm: cannot remove 'repo/.git/objects': Directory not empty

or similar (sometimes it's another directory like 'repo/.git'). My guess
is that the background process is still running and creating files in
the repository, racing with rm's call to rmdir().

Even if we remove the test_when_finished, it would mean that the final
cleanup after test_done might similarly fail, leaving a crufty trash
directory. I think to make this robust, we'd need some way of detecting
when the background process has finished. I don't think we report the
pid anywhere, and the daemonize() call means it won't even be in the
same process group. Maybe we could spin looking for the incremental pack
it will create (and timeout after N seconds)? That feels pretty hacky,
but I can't think of anything better.

-Peff
