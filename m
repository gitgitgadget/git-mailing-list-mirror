Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3501D4E
	for <git@vger.kernel.org>; Wed,  6 Dec 2023 11:11:50 -0800 (PST)
Received: (qmail 4127 invoked by uid 109); 6 Dec 2023 19:11:50 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 06 Dec 2023 19:11:50 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 27522 invoked by uid 111); 6 Dec 2023 19:11:50 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 06 Dec 2023 14:11:50 -0500
Authentication-Results: peff.net; auth=none
Date: Wed, 6 Dec 2023 14:11:48 -0500
From: Jeff King <peff@peff.net>
To: "Jeremiah Steele (Jerry)" <jeremiah@dubsado.com>
Cc: git@vger.kernel.org
Subject: Re: git switch has fatal dependency on default fetch config
Message-ID: <20231206191148.GA103708@coredump.intra.peff.net>
References: <634F40AF-25F8-4FE6-BDE3-08798E699A9E@dubsado.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <634F40AF-25F8-4FE6-BDE3-08798E699A9E@dubsado.com>

On Tue, Dec 05, 2023 at 07:41:28PM -0800, Jeremiah Steele (Jerry) wrote:

> Changing the default fetch refspec for a remote breaks git switch:
> 
> % git branch -r
>   origin/HEAD -> origin/master
>   origin/feature
>   origin/master
> % git remote set-branches origin master
> % git switch -c feature --track origin/feature
> fatal: cannot set up tracking information; starting point 'origin/feature' is not a branch
> % git remote set-branches --add origin feature
> % git switch -c feature --track origin/feature
> branch 'feature' set up to track 'origin/feature'.
> Switched to a new branch 'feature'
> 
> It seems like I should be able to fetch a remote branch and track it
> without having to monkey around with my default fetch config. Is there
> a reason git switch has a hard dependency on the default remote fetch
> refspec configuration?

I think it's required by the form of the tracking config, which is
defined by a named remote and a remote branch, like:

  [branch "foo"]
  remote = origin
  merge = refs/heads/foo

You explicitly asked to track "origin/feature", which means that Git has
to be able to turn that into config as above. It can handle two cases:

  1. It's a local branch in refs/heads/, in which case the remote is "."
     and the "merge" field is the name of the branch.

  2. It's a ref that can be found by reversing a fetch refspec. With the
     default remote.origin.fetch refspec of refs/heads/*:refs/remotes/origin/*,
     we know that "refs/remotes/origin/feature" comes from "refs/heads/feature"
     on the "origin" remote.

     But since you used "remote set-branches" to limit that refspec, we
     can't do that same reversal. And "origin/feature", while we do
     still have it as a ref, does not correspond to any remote ref we'd
     fetch. So we don't know how to set up the tracking config.

The notion of "tracking" really came about as defining what "git pull"
does. And without a remote that fetches, "git pull" does not really make
much sense.

I'd guess that you are more interested in being able to just use
@{upstream}, especially as the default for things like rebase, etc. And
that could work without being able to actually fetch the ref. But those
two things are intertwined in Git. You obviously can still base a branch
off of "origin/feature", but you'll have to specify it manually when
doing rebase, etc.

-Peff
