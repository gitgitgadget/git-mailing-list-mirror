Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9BE22421F
	for <git@vger.kernel.org>; Mon, 13 Nov 2023 21:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 752AAD5E
	for <git@vger.kernel.org>; Mon, 13 Nov 2023 13:08:21 -0800 (PST)
Received: (qmail 20901 invoked by uid 109); 13 Nov 2023 21:08:21 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 13 Nov 2023 21:08:21 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 6730 invoked by uid 111); 13 Nov 2023 21:08:22 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 13 Nov 2023 16:08:22 -0500
Authentication-Results: peff.net; auth=none
Date: Mon, 13 Nov 2023 16:08:20 -0500
From: Jeff King <peff@peff.net>
To: Janik Haag <janik@aq0.de>
Cc: git@vger.kernel.org
Subject: Re: git-bisect reset not deleting .git/BISECT_LOG
Message-ID: <20231113210820.GB2028092@coredump.intra.peff.net>
References: <bef9d5b3-bb64-4662-8952-d000872c5244@aq0.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <bef9d5b3-bb64-4662-8952-d000872c5244@aq0.de>

On Mon, Nov 13, 2023 at 09:42:09PM +0100, Janik Haag wrote:

> Thank you for filling out a Git bug report!
> Please answer the following questions to help us understand your issue.
> 
> What did you do before the bug happened? (Steps to reproduce your issue)
> ```bash
> git init /tmp/reproduce-bisect-warning
> cd /tmp/reproduce-bisect-warning
> touch .git/BISECT_LOG
> git bisect reset
> git switch -c log
> ```
> 
> What did you expect to happen? (Expected behavior)
> 
> `git-bisect reset` should have deleted .git/BISECT_LOG
> 
> What happened instead? (Actual behavior)
> 
> .git/BISECT_LOG is still there

I don't think this is really specific to BISECT_LOG. In "bisect reset",
we'll call bisect_clean_state(), which removes a bunch of files. The
problem in your example is that "bisect reset" sees that we are not
bisecting and bails early.

Which I can kind of see, as part of the "reset" process is to reset to
the original pre-bisect commit. If it's not given on the command line,
the default is to use BISECT_START, which of course does not exist.

  As a side note, "git bisect reset HEAD" will do what you want, because
  it skips the BISECT_START check. But obviously that's not something
  normal users should need to know about, and I think is even an
  accidental side-effect of the conversion in 5e82c3dd22
  (bisect--helper: `bisect_reset` shell function in C, 2019-01-02).

So really, you just want the "clean" part of "bisect reset", but not the
"reset". We could have a separate "bisect clean" that would do what you
want (clean state without trying to reset HEAD). But I don't think it
would be unreasonable to "reset" to just unconditionally clean. I think
it would probably just be a few lines in bisect_reset() to avoid the
early return, and skip the call to "checkout" when we have no branch to
go back to.

Maybe a good simple patch for somebody interested in getting into Git
development?

-Peff
