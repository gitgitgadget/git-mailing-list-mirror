Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CE13D2F0
	for <git@vger.kernel.org>; Mon, 30 Oct 2023 17:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96B7AC0
	for <git@vger.kernel.org>; Mon, 30 Oct 2023 10:56:57 -0700 (PDT)
Received: (qmail 3868 invoked by uid 109); 30 Oct 2023 17:56:57 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 30 Oct 2023 17:56:57 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 13591 invoked by uid 111); 30 Oct 2023 17:56:58 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 30 Oct 2023 13:56:58 -0400
Authentication-Results: peff.net; auth=none
Date: Mon, 30 Oct 2023 13:56:56 -0400
From: Jeff King <peff@peff.net>
To: Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH] tests: handle "funny" exit code 127 produced by
 MSVC-compiled exes
Message-ID: <20231030175656.GA855403@coredump.intra.peff.net>
References: <pull.1604.git.1698680732691.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <pull.1604.git.1698680732691.gitgitgadget@gmail.com>

On Mon, Oct 30, 2023 at 03:45:32PM +0000, Johannes Schindelin via GitGitGadget wrote:

> Now, `jk/tree-name-and-depth-limit` introduces a pair of test cases that
> expect a command that produces a stack overflow to fail, which it
> typically does with exit code 139 (which means SIGSEGV).

I think you're misinterpreting the purpose of the tests from that
series; they're not intended to segfault. Quoting from t6700:

  # We'll test against two depths here: a small one that will let us check the
  # behavior of the config setting easily, and a large one that should be
  # forbidden by default. Testing the default depth will let us know whether our
  # default is enough to prevent segfaults on systems that run the tests.

So for the "big tree" tests in that file, we are looking for a
controlled failure rather than a segfault. And indeed, the end of that
series already lowered the default to accommodate the msys windows
build; see the discussion in 4d5693ba05 (lower core.maxTreeDepth default
to 2048, 2023-08-31).

So I think the test is working as designed here: it is showing us that
the default value is not sufficient to protect MSVC builds from running
out of stack space. There are a few options there:

  1. We can lower the default everywhere.

  2. We can lower it just for MSVC builds.

  3. We can accept the situation and skip the tests for that build.

There's a bit more discussion in the commit I referenced above.

> Let's work around this by:
> 
> 1) recording which C compiler was used, and
> 
> 2) adding an MSVC-only exception to `test_must_fail` to treat 127 as a
>    regular failure.
> 
> There is a slight downside of this approach in that a real missing
> command could be mistaken for a failure. However, this would be caught
> on other platforms, and besides, we use `test_must_fail` only for `git`
> and `scalar` anymore, and we can be pretty certain that both are there.

I think there is another much worse downside to your patch: we will stop
noticing when MSVC builds segfault in the tests. The purpose of
test_must_fail is to allow controlled and expected failure returns from
the command, but still report on unexpected situations (signal death,
command not found, and so on).

-Peff
