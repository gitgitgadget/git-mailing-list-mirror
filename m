Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 894B7D535
	for <git@vger.kernel.org>; Wed, 10 Jul 2024 07:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720595785; cv=none; b=AMKxRi9ez0O6SbUv6gkJk114dhduwiYH9JwB+DD7bLckukx/8FLcJOnr+g8ravMt9OLlGPjyfdmgb6NnOTZpdhe2KV89WAs35H1CW6DzDFQiFPXjlQScLaaq7lpd701mUfCe9bNj5J+Viim/uNfsMZzpYQ99EJq2Dm13UKraF7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720595785; c=relaxed/simple;
	bh=OlKXmCn57lThTimlN67V+MUEYq4oQG1UhrOOyO9dPeI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DodHa3PJfC4XjEe5FLcUY8rn2FzRpWDf3RsvakiwG3xRE+6t30uv+8llkEB4P4s01mHHe72ZsF3eAMXSlJntCHYPwn5WKdrXGZFXmhhCUztTdgVsgX6S013gYvKg05FYoCgbAg/6T3zd3sRLi4QzLnC1l29SDtbSXaCyLA0N9pA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 838 invoked by uid 109); 10 Jul 2024 07:16:22 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 10 Jul 2024 07:16:22 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 9906 invoked by uid 111); 10 Jul 2024 07:16:20 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 10 Jul 2024 03:16:20 -0400
Authentication-Results: peff.net; auth=none
Date: Wed, 10 Jul 2024 03:16:21 -0400
From: Jeff King <peff@peff.net>
To: =?utf-8?B?UnViw6lu?= Justo <rjusto@gmail.com>
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] test-lib: GIT_TEST_SANITIZE_LEAK_LOG enabled by
 default
Message-ID: <20240710071621.GA2049772@coredump.intra.peff.net>
References: <598149bf-6541-4c9e-8c94-a108e3ee7fd7@gmail.com>
 <d5c307e3-79c5-4795-838d-4a425b012ec0@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d5c307e3-79c5-4795-838d-4a425b012ec0@gmail.com>

On Wed, Jul 10, 2024 at 11:30:13AM +0900, Rubén Justo wrote:

> As we currently describe in t/README, it can happen that:
> 
>     Some tests run "git" (or "test-tool" etc.) without properly checking
>     the exit code, or git will invoke itself and fail to ferry the
>     abort() exit code to the original caller.
> 
> Therefore, GIT_TEST_SANITIZE_LEAK_LOG=true is needed to be set to
> capture all memory leaks triggered by our tests.
> 
> It seems unnecessary to force users to remember this option, as
> forgetting it could lead to missed memory leaks.
> 
> We could solve the problem by setting GIT_TEST_SANITIZE_LEAK_LOG to
> "true" by default, but that might suggest we think "false" makes sense,
> which isn't the case.
> 
> Therefore, the best approach is to remove the option entirely while
> maintaining the capability to detect memory leaks in blind spots of our
> tests.

Yeah, I think that reasoning makes sense.

> diff --git a/ci/lib.sh b/ci/lib.sh
> index 814578ffc6..51f8f59a29 100755
> --- a/ci/lib.sh
> +++ b/ci/lib.sh
> @@ -370,7 +370,6 @@ linux-musl)
>  linux-leaks|linux-reftable-leaks)
>  	export SANITIZE=leak
>  	export GIT_TEST_PASSING_SANITIZE_LEAK=true
> -	export GIT_TEST_SANITIZE_LEAK_LOG=true
>  	;;

OK, we can drop this line snice it's now the default. Good.

> diff --git a/t/README b/t/README
> index d9e0e07506..c2a732d59e 100644
> --- a/t/README
> +++ b/t/README
> @@ -382,33 +382,9 @@ mapping between "TEST_PASSES_SANITIZE_LEAK=true" and
> those tests that
>  pass under "SANITIZE=leak". This is especially useful when testing a
>  series that fixes various memory leaks with "git rebase -x".
> 
> -GIT_TEST_SANITIZE_LEAK_LOG=true will log memory leaks to
> -"test-results/$TEST_NAME.leak/trace.*" files. The logs include a
> -"dedup_token" (see +"ASAN_OPTIONS=help=1 ./git") and other options to
> -make logs +machine-readable.
> -
> -With GIT_TEST_SANITIZE_LEAK_LOG=true we'll look at the leak logs
> -before exiting and exit on failure if the logs showed that we had a
> -memory leak, even if the test itself would have otherwise passed. This
> -allows us to catch e.g. missing &&-chaining. This is especially useful
> -when combined with "GIT_TEST_PASSING_SANITIZE_LEAK", see below.
> -
>  GIT_TEST_PASSING_SANITIZE_LEAK=check when combined with "--immediate"
>  will run to completion faster, and result in the same failing
>  tests. The only practical reason to run
> -GIT_TEST_PASSING_SANITIZE_LEAK=check without "--immediate" is to
> -combine it with "GIT_TEST_SANITIZE_LEAK_LOG=true". If we stop at the
> -first failing test case our leak logs won't show subsequent leaks we
> -might have run into.
> -
> -GIT_TEST_PASSING_SANITIZE_LEAK=(true|check) will not catch all memory
> -leaks unless combined with GIT_TEST_SANITIZE_LEAK_LOG=true. Some tests
> -run "git" (or "test-tool" etc.) without properly checking the exit
> -code, or git will invoke itself and fail to ferry the abort() exit
> -code to the original caller. When the two modes are combined we'll
> -look at the "test-results/$TEST_NAME.leak/trace.*" files at the end of
> -the test run to see if had memory leaks which the test itself didn't
> -catch.

After this patch, the documentation seems to end abruptly with "The only
practical reason to run". I think we need to either delete those lines,
too, or complete the thought.

I do think they are saying something useful, which is: in "check" mode,
you should always use "--immediate" since the point is just to find
scripts which aren't labeled correctly. But I think that is true whether
you are using the leak log or not. Your log will be incomplete, of
course, if you used "--immediate", but the point is to see whether we
find even one.

>  GIT_TEST_PROTOCOL_VERSION=<n>, when set, makes 'protocol.version'
>  default to n.
> diff --git a/t/test-lib.sh b/t/test-lib.sh
> index 79d3e0e7d9..942828c55d 100644
> --- a/t/test-lib.sh
> +++ b/t/test-lib.sh
> @@ -1270,8 +1270,8 @@ check_test_results_san_file_ () {
>  		say "As TEST_PASSES_SANITIZE_LEAK=true isn't set the above leak is 'ok'
> with GIT_TEST_PASSING_SANITIZE_LEAK=check" &&
>  		invert_exit_code=t
>  	else
> -		say "With GIT_TEST_SANITIZE_LEAK_LOG=true our logs revealed a memory
> leak, exit non-zero!" &&
> -		invert_exit_code=t
> +		say "Our logs revealed a leak!" &&
> +		test "$test_failure" != 0 || invert_exit_code=t
>  	fi
>  }

This adds back in the test_failure fix from 47c6d4dad2 (test-lib: fix
GIT_TEST_SANITIZE_LEAK_LOG, 2024-06-30), but in a different way. I think
we'd want to build on top, and then you just need to update the messages
on either side of that final elif/else.

> @@ -1555,28 +1555,28 @@ then
>  		passes_sanitize_leak=t
>  	fi
> 
> -	if test "$GIT_TEST_PASSING_SANITIZE_LEAK" = "check"
> +	if test -z "$passes_sanitize_leak" &&
> +	   ! test "$GIT_TEST_PASSING_SANITIZE_LEAK" = "check" &&
> +	   test_bool_env GIT_TEST_PASSING_SANITIZE_LEAK false
>  	then
> -		sanitize_leak_check=t
> -		if test -n "$invert_exit_code"
> +		skip_all="skipping $this_test under GIT_TEST_PASSING_SANITIZE_LEAK=true"
> +		test_done
> +	else
> +		if test "$GIT_TEST_PASSING_SANITIZE_LEAK" = "check"
>  		then
> [...]

I'm not sure why we need to touch this block. The "if
GIT_TEST_SANITIZE_LEAK_LOG" just below it I assumed would go away. But
all of this has to do with "check" versus "true", etc? There might be
new refactoring / simplification opportunities opened up by getting rid
of the LEAK_LOG variable, but we should do those on top.

I guess what's happening is that you've rearranged it so that:

> -	if test_bool_env GIT_TEST_SANITIZE_LEAK_LOG false
> -	then
>  		if ! mkdir -p "$TEST_RESULTS_SAN_DIR"
>  		then
>  			BAIL_OUT "cannot create $TEST_RESULTS_SAN_DIR"

...when this conditional goes away, the existing body is still in the
"else". But even though it would make the diff noisy to reindent, I
think we are better off doing so to make it clear what the actual change
is.

> @@ -1599,9 +1599,6 @@ elif test "$GIT_TEST_PASSING_SANITIZE_LEAK" = "check"
> ||
>       test_bool_env GIT_TEST_PASSING_SANITIZE_LEAK false
>  then
>  	BAIL_OUT_ENV_NEEDS_SANITIZE_LEAK "GIT_TEST_PASSING_SANITIZE_LEAK=true"
> -elif test_bool_env GIT_TEST_SANITIZE_LEAK_LOG false
> -then
> -	BAIL_OUT_ENV_NEEDS_SANITIZE_LEAK "GIT_TEST_SANITIZE_LEAK_LOG=true"
>  fi

OK, this final elif is responsible for complaining when you set LEAK_LOG
but don't have an actual leak-checking build. But once it goes away,
there's no need to complain. Makes sense.

-Peff
