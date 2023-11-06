Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 588042941E
	for <git@vger.kernel.org>; Mon,  6 Nov 2023 17:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F9E8B0
	for <git@vger.kernel.org>; Mon,  6 Nov 2023 09:20:25 -0800 (PST)
Received: (qmail 21753 invoked by uid 109); 6 Nov 2023 17:20:25 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 06 Nov 2023 17:20:25 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 11507 invoked by uid 111); 6 Nov 2023 17:20:26 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 06 Nov 2023 12:20:26 -0500
Authentication-Results: peff.net; auth=none
Date: Mon, 6 Nov 2023 12:20:24 -0500
From: Jeff King <peff@peff.net>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 1/4] test-bloom: stop setting up Git directory twice
Message-ID: <20231106172024.GA10414@coredump.intra.peff.net>
References: <cover.1699267422.git.ps@pks.im>
 <fb1cc73ed3395ba3de72aba70d7679dd85ebb034.1699267422.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <fb1cc73ed3395ba3de72aba70d7679dd85ebb034.1699267422.git.ps@pks.im>

On Mon, Nov 06, 2023 at 11:45:53AM +0100, Patrick Steinhardt wrote:

> We're setting up the Git directory twice in the `test-tool bloom`
> helper, once at the beginning of `cmd_bloom()` and once in the local
> subcommand implementation `get_bloom_filter_for_commit()`. This can lead
> to memory leaks as we'll overwrite variables of `the_repository` with
> newly allocated data structures. On top of that it's simply unnecessary.
> 
> Fix this by only setting up the Git directory once.

Makes sense. This situation was created by 094a685cd7 (t: make
test-bloom initialize repository, 2020-07-29), which added the setup
call at the start of the program.

That commit closed the door to running test-bloom outside of a
repository for sub-commands that could handle it (perhaps the murmur3
one, but I didn't test). So there are two possible directions here:

  - drop the call in cmd__bloom() and make sure all of the relevant
    sub-command functions do the setup.

  - drop the one command-specific one (i.e., your patch)

In practice I don't think anybody cares about running this test-helper
outside of a repository, and having to do setup in each sub-command is
an extra maintenance burden. So I think your patch is the best
direction.

-Peff
