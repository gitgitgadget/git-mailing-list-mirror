Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25909281528
	for <git@vger.kernel.org>; Thu, 10 Apr 2025 11:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744284900; cv=none; b=feP6KmnG/DZ2T+AShjPQ0amy9wrrRHjkUTP5EYTGDCH9Jlc8ELx6O+axJF69ymlCUK8T9UFXko4YkIbKTgM1QlOkBpOjHlbCQ7WUH46edhn/4GFZuNP+7KF+VDFqkLdrsWOnhk3TgDl/lzhxLwjaKUnmS/K2NLioXGKdYti1ylI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744284900; c=relaxed/simple;
	bh=C9HT4aUxSX3FiFw6LArI6tK/vltHJaJpukvHOmwdThc=;
	h=From:To:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=riRwiQu+r5ACWIhULqfs1N/R+3djZPUXvlr8x7pfDl9VrNbCH2XDHqTiuX+OG9JodYrgD/Q3LeFAwWMeD7C2LlqP+xvPeMhNQaZz4Zri1QHFJkrOvGZIZaXSBoUYuuEJvWpo6ydMMIcYy50oa3NIm9r1TkILtJlz+w4jtS1t9Aw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=EIojYSBG; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="EIojYSBG"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1744284892;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3YC5JxKaF13E0EuYQfg/QqbJ+gXLGiZ5ZgmOcKpNX7s=;
	b=EIojYSBGNeJZn92srVtSjXHIs5/1swCzxLoIw1hzCLTv0pfe2UcwjZ+/cIK8PwgRDVduib
	xd1s34cKl1M+0a1NSFoyknv3SSusqHRSuSAbtJvdw5q35w+rMERKwU4iYJ0vt4FYkBxCD4
	ufUdYcOrjBbPV0uV6jmXynJdPSFDGbg=
From: Toon Claes <toon@iotcl.com>
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Subject: Re: [PATCH 3/5] t/perf: fix benchmarks with out-of-tree builds
In-Reply-To: <20250331-pks-meson-benchmarks-v1-3-b2ace85616a3@pks.im>
References: <20250331-pks-meson-benchmarks-v1-0-b2ace85616a3@pks.im>
 <20250331-pks-meson-benchmarks-v1-3-b2ace85616a3@pks.im>
Date: Thu, 10 Apr 2025 13:34:35 +0200
Message-ID: <87v7rcdzck.fsf@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT

Patrick Steinhardt <ps@pks.im> writes:

> The "perf-lib.sh" script is sourced by all of our benchmarking suites to
> make available common infrastructure. The script assumes that build and
> source directory are the same, which works for our Makefile. But the
> assumption breaks with both CMake and Meson, where the build directory
> can be located in an arbitrary place.
>
> Adapt the script so that it works with out-of-tree builds. This prepares
> us for wiring up benchmarks in Meson.
>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  t/perf/perf-lib.sh | 26 ++++++++++++++++++++++++--
>  1 file changed, 24 insertions(+), 2 deletions(-)
>
> diff --git a/t/perf/perf-lib.sh b/t/perf/perf-lib.sh
> index 4173eee4def..5406557b7ca 100644
> --- a/t/perf/perf-lib.sh
> +++ b/t/perf/perf-lib.sh
> @@ -25,7 +25,29 @@ TEST_OUTPUT_DIRECTORY=$(pwd)
>  TEST_NO_CREATE_REPO=t
>  TEST_NO_MALLOC_CHECK=t
>  
> -. ../test-lib.sh
> +# While test-lib.sh computes the build directory for us, we also have to do the
> +# same thing in order to locate the script via GIT-BUILD-OPTIONS in the first
> +# place.
> +GIT_BUILD_DIR="${GIT_BUILD_DIR:-$TEST_DIRECTORY/..}"
> +if test -f "$GIT_BUILD_DIR/GIT-BUILD-DIR"
> +then
> +	GIT_BUILD_DIR="$(cat "$GIT_BUILD_DIR/GIT-BUILD-DIR")" || exit 1
> +	# On Windows, we must convert Windows paths lest they contain a colon
> +	case "$(uname -s)" in
> +	*MINGW*)
> +		GIT_BUILD_DIR="$(cygpath -au "$GIT_BUILD_DIR")"
> +		;;
> +	esac
> +fi
> +
> +if test ! -f "$GIT_BUILD_DIR"/GIT-BUILD-OPTIONS
> +then
> +	echo >&2 'error: GIT-BUILD-OPTIONS missing (has Git been built?).'
> +	exit 1
> +fi
> +
> +. "$GIT_BUILD_DIR"/GIT-BUILD-OPTIONS
> +. "$GIT_SOURCE_DIR"/t/test-lib.sh
>  
>  unset GIT_CONFIG_NOSYSTEM
>  GIT_CONFIG_SYSTEM="$TEST_DIRECTORY/perf/config"
> @@ -324,7 +346,7 @@ test_at_end_hook_ () {
>  	if test -z "$GIT_PERF_AGGREGATING_LATER"; then
>  		(
>  			cd "$TEST_DIRECTORY"/perf &&
> -			"$PERL_PATH" ./aggregate.perl --results-dir="$TEST_RESULTS_DIR" $(basename "$0")
> +			"$PERL_PATH" "$GIT_SOURCE_DIR"/t/perf/aggregate.perl --results-dir="$TEST_RESULTS_DIR" $(basename "$0")
>  		)
>  	fi
>  }
>
> -- 
> 2.49.0.604.gff1f9ca942.dirty

I'm not sure if it's related to this commit, but this patch series has
broken something:

    $ make && cd t/perf && ./run . master p0005-status.sh

    === Running 1 tests in this tree ===
    ok 1 - setup repo
    perf 2 - read-tree status br_ballast (4629): 1 ok
    # passed all 2 test(s)
    1..2
    === Unpacking 485f5f863615e670fd97ae40af744e14072cfe18 in build/485f5f863615e670fd97ae40af744e14072cfe18 ===
    === Building 485f5f863615e670fd97ae40af744e14072cfe18 (master) ===
    GIT_VERSION=2.49.GIT
        * new build flags
        CC daemon.o
        * new link flags
        CC common-main.o
        CC abspath.o
        CC add-interactive.o
        CC add-patch.o
        [snip]
        CC t/unit-tests/unit-test.o
        CC t/unit-tests/lib-oid.o
        LINK t/unit-tests/bin/unit-tests
        GEN gitweb/gitweb.cgi
        GEN gitweb/static/gitweb.js
    === Running 1 tests in /home/toon/devel/git/t/perf/build/485f5f863615e670fd97ae40af744e14072cfe18/bin-wrappers ===
    ok 1 - setup repo
    perf 2 - read-tree status br_ballast (4629): 1 ok
    # passed all 2 test(s)
    1..2
    cannot open test-results/p0005-status.subtests: No such file or directory at ./aggregate.perl line 159.

--
Toon
