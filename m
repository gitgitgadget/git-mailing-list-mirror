Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5ECA1AD
	for <git@vger.kernel.org>; Thu, 16 Nov 2023 12:27:19 -0800 (PST)
Received: (qmail 26054 invoked by uid 109); 16 Nov 2023 20:27:19 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 16 Nov 2023 20:27:19 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 18482 invoked by uid 111); 16 Nov 2023 20:27:20 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 16 Nov 2023 15:27:20 -0500
Authentication-Results: peff.net; auth=none
Date: Thu, 16 Nov 2023 15:27:18 -0500
From: Jeff King <peff@peff.net>
To: "flobee.code" <flobee.code@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: gitmodulesSymlink .gitmodules is a symbolic link
Message-ID: <20231116202718.GD1146561@coredump.intra.peff.net>
References: <CAM30mqasEjEBbn1vSUwvKP6LLjAFSw3xoeLrB1zLWnH37Z2fUg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAM30mqasEjEBbn1vSUwvKP6LLjAFSw3xoeLrB1zLWnH37Z2fUg@mail.gmail.com>

On Wed, Nov 15, 2023 at 05:01:10PM +0100, flobee.code wrote:

> But in general I think the exclusion of symlinks to git system files
> is a mistake. It is implemented too sweepingly in my eyes.

I agree that the fact that we reject these at such a low level makes it
hard to use the tooling to rewrite the history to fix it.

But because of the security implications of out-of-tree symlinks from
untrusted repositories, it's important to catch these consistently. I
see your use case is for in-tree links, but detecting that makes the
checks much more complex. It also has always been the case that symlinks
do not behave consistently, as Git does not follow them when reading
in-index versions of meta files.

> And `git` itself also aborts. So I can't solve the problems this way.
> 
>     git filter-branch --tree-filter 'rm -f .gitmodules' HEAD
>     Rewrite [SomeHash] (3/185) (0 seconds passed, remaining 0 predicted) \
>         error: Invalid path '.gitmodules' Could not initialize the index

I didn't test, but you could probably get by with using "git replace" to
first fix up the offending trees, and then run filter-branch (though
there may be a lot of such trees, so you'd probably to script that
step). I also suspect that filter-repo would handle this better:

  https://github.com/newren/git-filter-repo

but didn't try it myself.

-Peff
