Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F4651BF2D
	for <git@vger.kernel.org>; Tue, 16 Jan 2024 15:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 23448 invoked by uid 109); 16 Jan 2024 15:00:28 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 16 Jan 2024 15:00:28 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 29111 invoked by uid 111); 16 Jan 2024 15:00:27 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 16 Jan 2024 10:00:27 -0500
Authentication-Results: peff.net; auth=none
Date: Tue, 16 Jan 2024 10:00:27 -0500
From: Jeff King <peff@peff.net>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: Pratyush Yadav <me@yadavpratyush.com>, git@vger.kernel.org
Subject: Re: Strange behaviour when pushing a commit object to remote's
 refs/HEAD
Message-ID: <20240116150027.GB2119690@coredump.intra.peff.net>
References: <mafs0fryypg82.fsf@yadavpratyush.com>
 <CAOLa=ZS8YBhzaYx=9016KxErsMsazsF09rcuPs=-WpEGjV+ruw@mail.gmail.com>
 <mafs0a5p5pl6y.fsf@yadavpratyush.com>
 <CAOLa=ZRfr+oEKCo8AfFSAFtS8pbDgmG_EeBSwm7GwukzVcqSrg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAOLa=ZRfr+oEKCo8AfFSAFtS8pbDgmG_EeBSwm7GwukzVcqSrg@mail.gmail.com>

On Tue, Jan 16, 2024 at 08:24:04AM -0500, Karthik Nayak wrote:

> This is one of those ambiguities, we store HEAD for remotes as
>      $GIT_DIR/refs/remotes/<remote>/HEAD
> and remote branches as
>      $GIT_DIR/refs/remotes/<remote>/<branch>
> 
> So what happens if there is a branch named HEAD? This is the problem
> you're facing...

Yeah, this is a long-standing issue. The reason we have not fixed it is
that it would require a new refs/remotes layout, which implies new
lookup rules (e.g., dwim_ref() will convert the name "foo" to
"refs/remotes/foo/HEAD", but would need to be taught about the new
layout). Likewise, a new layout should probably store per-remote tags
(rather than splatting them into the main refs/tags/) along with new
dwim_ref() rules to make lookup work more or less as it does now.

So it's not impossible, but some care has to be given the design and
to handling compatibility. If anybody is interested, there are probably
some nuggets of wisdom to mine from this old thread:

  https://lore.kernel.org/git/AANLkTi=yFwOAQMHhvLsB1_xmYOE9HHP2YB4H4TQzwwc8@mail.gmail.com/

In the meantime, I think the current wisdom is "don't name a branch
HEAD". ;) We even added logic to "git branch" to forbid this, but tools
like "git push" are a bit more flexible.

-Peff
