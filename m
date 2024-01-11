Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58B94DDA6
	for <git@vger.kernel.org>; Thu, 11 Jan 2024 07:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 29087 invoked by uid 109); 11 Jan 2024 07:13:30 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 11 Jan 2024 07:13:30 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 3437 invoked by uid 111); 11 Jan 2024 07:13:32 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 11 Jan 2024 02:13:32 -0500
Authentication-Results: peff.net; auth=none
Date: Thu, 11 Jan 2024 02:13:29 -0500
From: Jeff King <peff@peff.net>
To: Justin Tobler via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Justin Tobler <jltobler@gmail.com>
Subject: Re: [PATCH 1/2] t1401: generalize reference locking
Message-ID: <20240111071329.GC48154@coredump.intra.peff.net>
References: <pull.1634.git.1704912750.gitgitgadget@gmail.com>
 <cb78b549e5e826ffef39c55bd726164e6b7bb755.1704912750.git.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cb78b549e5e826ffef39c55bd726164e6b7bb755.1704912750.git.gitgitgadget@gmail.com>

On Wed, Jan 10, 2024 at 06:52:29PM +0000, Justin Tobler via GitGitGadget wrote:

> From: Justin Tobler <jltobler@gmail.com>
> 
> Some tests set up reference locks by directly creating the lockfile.
> While this works for the files reference backend, reftable reference
> locks operate differently and are incompatible with this approach.
> Refactor the test to use git-update-ref(1) to lock refs instead so that
> the test does not need to be aware of how the ref backend locks refs.

It looks like you re-create this situation in a backend-agnostic way by
having two simultaneous updates that conflict on the lock (but don't
care how that lock is implemented).

That works, but I think we could keep it simple. This test doesn't care
about the exact error condition we create. The point was just to die in
create_symref() and make sure the exit code was propagated. So something
like this would work:

  $ git symbolic-ref refs/heads refs/heads/foo
  error: unable to write symref for refs/heads: Is a directory

(note that you get a different error message if the refs are packed,
since there we can notice the d/f conflict manually).

There may be other ways to stimulate a failure. I thought "symbolic-ref
HEAD refs/heads/.invalid" might work, but sadly the refname format check
happens earlier.

I think it is worth avoiding the fifo magic if we can. It's complicated,
and it means that not all platforms run the test.

-Peff
