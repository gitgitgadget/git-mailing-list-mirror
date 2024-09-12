Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E83D719004A
	for <git@vger.kernel.org>; Thu, 12 Sep 2024 22:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726180458; cv=none; b=XykGAPVBE4qgqH14qyAedickUCKgcGJyoSVpRqztvpCuwSGGkqkuvD2q4soXwtb/I3zPOGEmIt5M6fvTG7PRdAXD6E0YdIBI8V2xLjtKoLKrX9Lb+lr3Rk/z6YwW6L53VBPUa9iVjxAmtMsxIcYa2Hd9d+XYlA4sdwP1943CM1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726180458; c=relaxed/simple;
	bh=yM/SZCaOHWGJO3P3AGolJJApJ3YG4y3y1DZzxv8juwE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dvuYh4vA9j/YJUDyilZYDO0irWUZbwZA9bXggpMV0ZReBuszp6JWAf+b0oK5iC6yxr6sJgtNOasXhSvXr0rhW6UJQheBQQuDIHEsccM+hCYYzIX3JG/tq0OpqRo/lJ3aAD0Qpi7PpFzq+uOHXd2ruq6Gi3A62+8n4hM//BM8cos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 19363 invoked by uid 109); 12 Sep 2024 22:34:15 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 12 Sep 2024 22:34:15 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 29328 invoked by uid 111); 12 Sep 2024 22:34:13 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 12 Sep 2024 18:34:13 -0400
Authentication-Results: peff.net; auth=none
Date: Thu, 12 Sep 2024 18:34:13 -0400
From: Jeff King <peff@peff.net>
To: Rodrigo <rodrigolive@gmail.com>
Cc: git@vger.kernel.org
Subject: [PATCH 0/2] fix bare repositories with Git.pm
Message-ID: <20240912223413.GA649897@coredump.intra.peff.net>
References: <CAGUZU_JZd_+8y19=kGif6u1+4n_+iOcVWV4p-kC0Uo=8Ev=aBA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAGUZU_JZd_+8y19=kGif6u1+4n_+iOcVWV4p-kC0Uo=8Ev=aBA@mail.gmail.com>

On Thu, Sep 12, 2024 at 06:32:00PM +0200, Rodrigo wrote:

> We're having an issue migrating from 2.31.1 to 2.46.0. The following
> Perl code does not work in 2.46.0 as it did in 2.31.1 (tested linux
> and darwin, did not check Windows):
> 
>     # test.pl
>     use Git;
>     my $repo = Git->repository( Directory => '/repo/bare.git' );
>     my ($fh, $ctx) = $repo->command_output_pipe('rev-list', "2acf3456");
>     print do { local $/; <$fh> };
> 
> Run:
> 
>    $ cd /home/rodrigo
>    $ perl test.pl
> 
> Fails with the error:
> 
>     fatal: not a git repository: '/home/rodrigo'

Yikes, good catch. That's a pretty bad bug. I'm surprised we didn't
cover this in the tests, but it's specific to bare repositories.

> Bug hunting through the Git.pm code and skimming through the Git SCM
> repo, there's a significant change (commit 20da61f25) that makes the
> recent Git.pm rely on:
> 
>      git rev-parse --is-bare-repository --git-dir

Yep, I confirmed via bisection that that commit is the culprit. Your
analysis is mostly good, though...

> for locating the correct (maybe a parent) repo directory. The change
> was understandably done for security (and other many) reasons. It
> started using --is-bare-repository to detect if it's a bare repository
> we're dealing with, instead of relying on the old Git.pm redundant
> code for bare repo detection, which was a sound decision. But some
> crucial code was taken out.

...the problem is actually that not enough code was taken out. ;) I left
the code in the bare-only code to turn the relative path to absolute,
but it used the wrong path (the one returned by rev-parse, rather than
the original Directory option that was passed in). That bare-only path
should just go away entirely, and both should use the same (correct)
code to get the absolute path.

> SOLUTION: I propose using "--absolute-git-dir" instead of "--git-dir":
> 
>     git rev-parse --is-bare-repository --absolute-git-dir
> 
> Which will replace the `.`  rev-parse response with a full path
> resolved by git itself (and not Perl). This means the change to the
> Perl code is minimal. I don't know if this will resolve all possible
> cases, but it does fix our issue.

It does fix all cases, but it leaves some redundant code in place.
Here are two patches. The first does the minimal fix within the code
(what 20da61f25 should have done!) and corrects the problem. The second
switches to --absolute-git-dir and drops the now-redundant code.

Thank you for a very thorough bug report!

  [1/2]: Git.pm: fix bare repository search with Directory option
  [2/2]: Git.pm: use "rev-parse --absolute-git-dir" rather than perl code

 perl/Git.pm         | 14 ++++++--------
 t/t9700-perl-git.sh |  3 ++-
 t/t9700/test.pl     |  5 +++++
 3 files changed, 13 insertions(+), 9 deletions(-)

-Peff
