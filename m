Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8289322EF8
	for <git@vger.kernel.org>; Mon, 13 Nov 2023 18:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AF6D10F4
	for <git@vger.kernel.org>; Mon, 13 Nov 2023 10:49:10 -0800 (PST)
Received: (qmail 20243 invoked by uid 109); 13 Nov 2023 18:49:10 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 13 Nov 2023 18:49:10 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 5230 invoked by uid 111); 13 Nov 2023 18:49:10 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 13 Nov 2023 13:49:10 -0500
Authentication-Results: peff.net; auth=none
Date: Mon, 13 Nov 2023 13:49:09 -0500
From: Jeff King <peff@peff.net>
To: Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc: Josh Steadmon <steadmon@google.com>,
	Phillip Wood <phillip.wood@dunelm.org.uk>, git@vger.kernel.org,
	Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH] ci: avoid running the test suite _twice_
Message-ID: <20231113184909.GB3838361@coredump.intra.peff.net>
References: <pull.1613.git.1699894837844.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <pull.1613.git.1699894837844.gitgitgadget@gmail.com>

On Mon, Nov 13, 2023 at 05:00:37PM +0000, Johannes Schindelin via GitGitGadget wrote:

> This is a late amendment of 19ec39aab54 (ci: stop linking the `prove`
> cache, 2022-07-10), fixing a bug that had been hidden so far.

We don't seem to have that commit in Junio's tree; it is only in
git-for-windows.

Not that we should not fix things if they are broken, but I am trying
to understand if git/git is experiencing the same bug. It sounds like
not yet, though from looking at 19ec39aab54, I would expect to get these
doubled runs any time we store the prove state. But maybe without that
commit our state-file symlink is going somewhere invalid, and prove
fails to actually store anything?

> But starting with that commit, we run `prove` _twice_ in CI, and with
> completely different sets of tests to run. Due to the bug, the second
> invocation re-runs all of the tests that were already run as part of the
> first invocation. This not only wastes build minutes, it also frequently
> causes the `osx-*` jobs to fail because they already take a long time
> and now are likely to run into a timeout.
> 
> The worst part about it is that there is actually no benefit to keep
> running with `--state=slow,save`, ever since we decided no longer to
> try to reuse the Prove cache between CI runs.
> 
> So let's just drop that Prove option and live happily ever after.

Yes, I think this is the right thing to do regardless. If we are not
saving the state to use between two related runs, there is no point
storing it in the first place.

I do have to wonder, though, as somebody who did not follow the
unit-test topic closely: why are the unit tests totally separate from
the rest of the suite? I would think we'd want them run from one or more
t/t*.sh scripts. That would make bugs like this impossible, but also:

  1. They'd be run via "make test", so developers don't have to remember
     to run them separately.

  2. They can be run in parallel with all of the other tests when using
     "prove -j", etc.

-Peff
