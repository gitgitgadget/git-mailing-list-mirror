Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AB911FC7F0
	for <git@vger.kernel.org>; Fri,  3 Jan 2025 18:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735928266; cv=none; b=mqZj19b8vDDoHcgxuTi75J+GQlHpVKFoFFdeVcd4Kjk2DenVR4Q+RTBeZFJ0vn/PRPN+UHMC/n532Sbi2VrHrZyvF6FY7/2tkGZFlgd15pVMAD1Y+nbQaU7l9RzjeZHjmDni9qodLVFjOfx6iMXGa+8F9ZMk18DOwnmLJ2IGo0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735928266; c=relaxed/simple;
	bh=o2k45HE2FytJhNigr2B/+inUCyiAsQaA9KkP4JSCLlY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m2cg+wkLeF3vzrk8PmEddHEjfX/UZcW/nPfBs9pCj+1IsCgyhEhcNM6gpjK1KowAll1pRsB97NrzXw8nI71Dw9f03874Z0edun4m+JdMy4IRtyM1k1RFKKAFnrm9j1wz5lEm4AC2JEsd7EFBQ1CbHvbMJAmeamG/LjIAf6Agl+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=K37kdWaC; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="K37kdWaC"
Received: (qmail 17932 invoked by uid 109); 3 Jan 2025 18:17:43 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=o2k45HE2FytJhNigr2B/+inUCyiAsQaA9KkP4JSCLlY=; b=K37kdWaCCrQi2SGA12WIzbgWRwrCN9EFx4mmXMChn9+qQGC8SgoGv1hRuk447GY4i2id/JfWNQDu3aPKrCRYAcaw57RR5Ni0L3Z1b6yu4efaGjJmgu4f0Z16tMJ/Q88D1Qs1mfVWJXECGap4bSilUFxEPdytO56Ih99E2cg+4n60YDiLNOhVEghPbX43RDuYS9mHv6V9MmajzRRAmuvSdKZyRV1WcZsgtdgWbJD0ZVdZjYJa4MhFyMPBtQHpJJr0GXEhXXspPvK5kWzfh3n+NSlefDkQUIdWNPgj5coMD//Z9WQwrOuHPcKZ0RmZ3VUBdOkLsptFMTq+FeXJcnAlOA==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 03 Jan 2025 18:17:42 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 3463 invoked by uid 111); 3 Jan 2025 18:17:40 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 03 Jan 2025 13:17:40 -0500
Authentication-Results: peff.net; auth=none
Date: Fri, 3 Jan 2025 13:17:39 -0500
From: Jeff King <peff@peff.net>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 02/10] t7422: fix flaky test caused by buffered stdout
Message-ID: <20250103181739.GA2527684@coredump.intra.peff.net>
References: <20250103-b4-pks-ci-fixes-v1-0-a9bb95dff833@pks.im>
 <20250103-b4-pks-ci-fixes-v1-2-a9bb95dff833@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250103-b4-pks-ci-fixes-v1-2-a9bb95dff833@pks.im>

On Fri, Jan 03, 2025 at 03:46:39PM +0100, Patrick Steinhardt wrote:

> One test in t7422 asserts that `git submodule status --recursive`
> properly handles SIGPIPE. This test is flaky though and may sometimes
> not see a SIGPIPE at all:
> 
>     expecting success of 7422.18 'git submodule status --recursive propagates SIGPIPE':
>             { git submodule status --recursive 2>err; echo $?>status; } |
>                     grep -q X/S &&
>             test_must_be_empty err &&
>             test_match_signal 13 "$(cat status)"

I couldn't reproduce with --stress, but you can trigger it all the time
with:

diff --git a/t/t7422-submodule-output.sh b/t/t7422-submodule-output.sh
index f21e920367..9338c75626 100755
--- a/t/t7422-submodule-output.sh
+++ b/t/t7422-submodule-output.sh
@@ -168,7 +168,7 @@ done
 
 test_expect_success !MINGW 'git submodule status --recursive propagates SIGPIPE' '
 	{ git submodule status --recursive 2>err; echo $?>status; } |
-		grep -q X/S &&
+		{ sleep 1 && grep -q X/S; } &&
 	test_must_be_empty err &&
 	test_match_signal 13 "$(cat status)"
 '

The problem is that git-submodule may write all of its output before
grep exits, and it gets stored in the pipe buffer. And then even if grep
exits before reading all of it, it is too late for SIGPIPE, and the data
in the pipe is just discarded by the OS.

So this:

> The issue is caused by us using grep(1) to terminate the pipe on the
> first matching line in the recursing git-submodule(1) process. Standard
> streams are typically buffered though, so this condition is racy and may
> cause us to terminate the pipe after git-submodule(1) has already
> exited, and in that case we wouldn't see the expected signal.
> 
> Fix the issue by converting standard streams to be unbuffered. I have
> only been able to reproduce this issue a single time after running t7422
> with `--stress` after an extended amount of time, so I cannot claim to
> be fully certain that this fix is sufficient.

isn't quite right. Even without input buffering on grep's part, it may
be too slow to read the data. And adding a sleep as above shows that it
still fails with your patch.

The usual way to reliably get SIGPIPE is to make sure the writer
produces enough data to fill the pipe buffer. But it's tricky to get
"submodule status" to produce a lot of data without having a ton of
submodules, which is expensive to set up.

But we can hack around it by stuffing the pipe full with a separate
process. Like this:

diff --git a/t/t7422-submodule-output.sh b/t/t7422-submodule-output.sh
index f21e920367..c4df2629e8 100755
--- a/t/t7422-submodule-output.sh
+++ b/t/t7422-submodule-output.sh
@@ -167,8 +167,15 @@ do
 done
 
 test_expect_success !MINGW 'git submodule status --recursive propagates SIGPIPE' '
-	{ git submodule status --recursive 2>err; echo $?>status; } |
-		grep -q X/S &&
+	{
+		# stuff pipe buffer full of input so that submodule status
+		# will require blocking on write; this script will write over
+		# 128kb. It might itself get SIGPIPE, so we must not &&-chain
+		# it directly.
+		{ perl -le "print q{foo} for (1..33000)" || true; } &&
+		git submodule status --recursive 2>err
+		echo $? >status
+	} | { sleep 1 && head -n 1 >/dev/null; } &&
 	test_must_be_empty err &&
 	test_match_signal 13 "$(cat status)"
 '
A few notes:

  - the sleep is still there to demonstrate that it always works, but
    obviously we'd want to remove that

  - I swapped out "grep" for "head". What we are matching is not
    relevant; the important thing is that the reader closes the pipe
    immediately. So I guess in that sense we could probably even just
    pipe to "true" or similar.

  - I tried using test_seq to avoid the inline perl, but it doesn't
    work! The problem is that it's implemented as a shell function. So
    when it gets SIGPIPE, the whole subshell is killed, and we never
    even run git-submodule at all. So it has to be a separate process
    (though I guess it could be test_seq in a subshell).

Anyway, hopefully that gives you enough to play around with.

-Peff
