Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 143B23B83EC
	for <git@vger.kernel.org>; Tue,  2 Jun 2026 07:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780387009; cv=none; b=PP2cDgSzWfRLlCeVq5KZuE/prd2wU1d6lPELrJE3OSeHJkIm1GOsR2Tq8qDvv7KxDQikeXsOXkhNXOammxiDHkJasq07VjT8Hdi45g7Lqy/psDdg8YsiCC6Gn2ldUCtLcHoe5hJb75KB1A5wGlx5HduqyynyPdz1FCsHhxA1zrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780387009; c=relaxed/simple;
	bh=CKOL/P3CAvjOpNYDURMCpy/Gew1sHfAzOYQbfPjsnf8=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=mFQRLReQcO+qxrupcLUfsZqA2FSmOh+1jvjoan5/vagecEjjP7YtfrfMw82Yj//DvNf6y/VKGgaFOf5ljCoAm8+u2zaC4KcUyuCfrz6nWwH2yHFi1FXh5wWCarn2wPY6neF9Qbi3gPZ+dWzwBVqjbNtHiKPWCy5JYdmeMcL9OS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=VVzQH+gD; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="VVzQH+gD"
Received: (qmail 31022 invoked by uid 106); 2 Jun 2026 07:56:47 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:subject:message-id:mime-version:content-type; s=20240930; bh=CKOL/P3CAvjOpNYDURMCpy/Gew1sHfAzOYQbfPjsnf8=; b=VVzQH+gDZsBt6XxdbqcQqun2MfQzFTMqtJRndmzvobLNQbXDdufSYNRHzV/5tK7AhwEYSgLURoAjXyBrZqbD0nPjSe3NhBNiSKCv/cZQdyYH2DFcHhe40KOfTRGBlb0ali4SuiVAZICk6CqLPTrehVKFfnqhBa4bVIxtD/jmsFAAHfrmvgaIRBGJMz68Y+u2EyZNn82zKK87rsalBMGQ0FB9ITgosTqZunAWMU1sA8ZBW5SVihQo/SxvQ5GiBIsK1KKfszMJW4aYG2MHpiJmRQxuaUVQlxz4r6spobhCAjCjfM/K4dZ8cO1AJE2XDgV3y304CT5eg/ft1/C9cUqPVA==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 02 Jun 2026 07:56:47 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 76887 invoked by uid 111); 2 Jun 2026 07:56:51 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 02 Jun 2026 03:56:51 -0400
Authentication-Results: peff.net; auth=none
Date: Tue, 2 Jun 2026 03:56:46 -0400
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Subject: [BUG] t/perf scripts lose GIT_PERF_* when used with --verbose-log
Message-ID: <20260602075646.GA753532@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Imagine I have a perf script like this:

  #!/bin/sh
  test_description=foo
  . ./perf-lib.sh
  echo >&2 "large_repo = $GIT_PERF_LARGE_REPO"
  test_perf_large_repo
  [...some actual tests...]

If I run the command below, I'd expect it to use linux.git as the test
repo (and print to stderr telling me so). And it does:

  $ GIT_PERF_LARGE_REPO=/path/to/linux.git ./p1234-foo.sh
  large_repo = /path/to/linux.git
  [...]

This is courtesy of 32b74b9809 (perf: do allow `GIT_PERF_*` to be
overridden again, 2025-04-04). But that breaks if we use --tee or any
other option which implies it:

  $ GIT_PERF_LARGE_REPO=/path/to/linux.git ./p1234-foo.sh --verbose-log
  large_repo = /home/peff/compile/git/t/..
  [...]

What happens in the happy path is this:

  0. The script sources perf-lib.sh.

  1. perf-lib.sh stashes GIT_PERF_* in a variable to restore later.

  2. perf-lib.sh sources GIT-BUILD-OPTIONS, which overwrites the
     environment.

  3. perf-lib.sh sources test-lib.sh.

  4. test-lib.sh itself sources GIT-BUILD-OPTIONS.

  5. Eventually test-lib.sh finishes, returning control to perf-lib.sh.

  6. perf-lib.sh restores GIT_PERF_* from the stashed copy. All is well.

But if --tee or --verbose-log is used, then step 5 never happens!
Instead test-lib.sh re-executes a second copy of the script piped to
tee. And that re-executed copy sees the environment we had after step 4,
with all of GIT_PERF_* coming from GIT-BUILD-OPTIONS. So even though it
tries to do the save/restore, its step 1 never sees the original
environment (so it "saves" nothing useful).

This is especially insidious if you use the "./run" program to compare
versions. It reads GIT-BUILD-OPTIONS, too, and also knows how to
preserve GIT_PERF_*, courtesy of 79d301c767 (t/perf/run: preserve
GIT_PERF_* from environment, 2026-01-06). But it reads GIT_TEST_OPTS
from the build-options file and runs each script with it. So while this
may work:

  $ GIT_PERF_LARGE_REPO=/path/to/linux.git ./run HEAD p1234-foo.sh
  [...]
  === Running 1 tests in /home/peff/compile/git/t/perf/build/1211f0ef99a75931f170bc2a838172a45300ad63/bin-wrappers ===
  large_repo = /path/to/linux.git
  [...]

you may get spooky action at a distance from whenever you last ran make:

  $ make -C ../.. GIT_TEST_OPTS=--verbose-log
  $ GIT_PERF_LARGE_REPO=/path/to/linux.git ./run HEAD p1234-foo.sh
  [...]
  === Running 1 tests in /home/peff/compile/git/t/perf/build/1211f0ef99a75931f170bc2a838172a45300ad63/bin-wrappers ===
  large_repo = /home/peff/compile/git/t/..

Doubly confusing if that GIT_TEST_OPTS is in your config.mak (because
you want normal "make test" to run under prove but still keep logs, and
you put it in the file ages ago).

I don't think this can be fixed by perf-lib.sh. The problem is internal
to test-lib.sh, which is overwriting the environment when it sources
GIT-BUILD-OPTIONS, without any opportunity for perf-lib to act before
getting re-executed. It would require test-lib.sh itself to have some
notion of "here are some stashed variables; restore them via eval".

Which just feels like stacking band-aids upon band-aids. The original
problem started with 4638e8806e (Makefile: use common template for
GIT-BUILD-OPTIONS, 2024-12-06), though one could argue that even before
then the precedence rules were kind of sketchy (it just made things much
worse because now it crops up even if you don't set GIT_PERF_LARGE_REPO
in your config.mak at all).

So I dunno. I couldn't quite bring myself to write a patch, but I
thought I'd at least write a warning to the list in case anybody else is
bit by it.

-Peff
