Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD9A61BBBD8
	for <git@vger.kernel.org>; Thu, 31 Oct 2024 16:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730391924; cv=none; b=lyX3+Dc22zhsqoA+JCvLSZjvLpgnLOJ/2rLQqwXSWfV3+Z+Yk5jwgZD70HDg99AeQCkGhbEMPViCXIn8LqB1pJ5r8Pyv8RpRwAcLXYfjKALaaPxuDz/A5zV0AslOmTNrbld8n5+sqgHpAGs26y4DyUzEYMLzxvBV6nu4uFVkyNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730391924; c=relaxed/simple;
	bh=w4+RQpinZdRF9psv6pDw5AfOuRFuCeuVgW2hScBDQ0o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mrtv4VqxtmfIXp+cVg4VKOn1nO2eicdYGig6m6ege6odMNeVk50W5QqKsuV/1hZ5vXvjnmAt0LqwlvO8OWdOApOOiZYD5+qyq+oiENp3FWKCCOv7Hu3DmVGrlEoIwHaDFzmh83fSyPpGX9H2j+209skdEzAGrDvsOTGOZ9lUbfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g6cBZTAN; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g6cBZTAN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39C60C4FDF3;
	Thu, 31 Oct 2024 16:25:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730391924;
	bh=w4+RQpinZdRF9psv6pDw5AfOuRFuCeuVgW2hScBDQ0o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=g6cBZTANwcGP8ULHfVeeJqK1w0nRUDw3iNC/ZZD/uwuLLTUnOrFFI5kOeUIDfpNXf
	 Fl4JfZhWPEWoBLCoxrPnMVPwZYZylvV0AMrNAxhD/CE8wyZvvb7LfVejw744WW/vya
	 pHYxYSf8BxCXQhzbkf+rdGvL2pLaYIlDVAZdmj2ibpmuGWTDs5IIqAlBqt6APiqKHk
	 RG/SoeKCcJex/RENy0UpdJPXizm/NYFak69QSwd1B0NUvYOL025WfrykdzSHckxvkf
	 5DA0wuZnNJ1u7SDcqKcD171nYNC/w/grIHZSUpMOGP2Q+v1nbYcR+DBFD3O75/zuSA
	 GEcX2IxtvG2NQ==
Date: Thu, 31 Oct 2024 09:25:22 -0700
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org
Subject: Re: [BUG] "git describe --match" performance
Message-ID: <20241031162522.3qcolxhgxe4g2zmu@jpoimboe>
References: <20241030044322.b5n3ji2n6gaeo5u6@treble.attlocal.net>
 <20241031114731.GA608553@coredump.intra.peff.net>
 <20241031151000.svsa7d2ogcdz7hf6@jpoimboe>
 <20241031153143.GA2275115@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241031153143.GA2275115@coredump.intra.peff.net>

On Thu, Oct 31, 2024 at 11:31:43AM -0400, Jeff King wrote:
> On Thu, Oct 31, 2024 at 08:10:00AM -0700, Josh Poimboeuf wrote:
> 
> > > I think we'll build the commit graph file by default these days when you
> > > run "git gc". But we don't build it immediately after cloning. Perhaps
> > > we should change that.
> > 
> > Hm... I actually ran "git gc" and it didn't seem to help at all.
> 
> What version of Git are you running? I think gc enabled it by default in
> 31b1de6a09 (commit-graph: turn on commit-graph by default, 2019-08-13),
> which is v2.24.0.
> 
> You could also try "git commit-graph write --reachable" and see if that
> improves things. If it doesn't, then maybe you have the reading side
> turned off explicitly for some reason? Try "git config core.commitgraph"
> to see if you have that set to "false".

Actually, I take that back.  You're right, in the freshly cloned repo,
"git gc" did help ~10x:

  $ git describe --match=v6.10-rc7
  v6.10-rc7-1844-gc61e41121036
  
  real	0m10.681s
  user	0m9.442s
  sys	0m0.507s
  
  $ git gc
  Enumerating objects: 10460179, done.
  Counting objects: 100% (10460179/10460179), done.
  Delta compression using up to 12 threads
  Compressing objects: 100% (1886458/1886458), done.
  Writing objects: 100% (10460179/10460179), done.
  Total 10460179 (delta 8517403), reused 10460179 (delta 8517403), pack-reused 0 (from 0)
  Expanding reachable commits in commit graph: 1310355, done.
  Writing out commit graph in 5 passes: 100% (6551775/6551775), done.
  
  $ time git describe --match=v6.10-rc7
  v6.10-rc7-1844-gc61e41121036
  
  real	0m1.173s
  user	0m1.002s
  sys	0m0.136s


But my real development repo, which has many branches and remotes plus
the historical git repo grafted, still takes 10+ seconds.

  $ git --version
  git version 2.47.0

  $ git gc
  Enumerating objects: 14656254, done.
  Counting objects: 100% (12534942/12534942), done.
  Delta compression using up to 12 threads
  Compressing objects: 100% (1829918/1829918), done.
  Writing objects: 100% (12534942/12534942), done.
  Total 12534942 (delta 10652548), reused 12534853 (delta 10652487), pack-reused 0 (from 0)
  Enumerating cruft objects: 6133, done.
  Traversing cruft objects: 14736, done.
  Counting objects: 100% (6133/6133), done.
  Delta compression using up to 12 threads
  Compressing objects: 100% (1179/1179), done.
  Writing objects: 100% (6133/6133), done.
  Total 6133 (delta 4876), reused 6117 (delta 4865), pack-reused 0 (from 0)

  $ git commit-graph write --reachable
  Expanding reachable commits in commit graph: 1941353, done.
  Finding extra edges in commit graph: 100% (1941353/1941353), done.
  Writing out commit graph in 5 passes: 100% (9706765/9706765), done.

  $ git config core.commitgraph
  $

  $ git describe --match=v6.12-rc5 --debug
  describe HEAD
  No exact match on refs or tags, searching to describe
  finished search at d8470b7c13e11c18cf14a7e3180f0b00e715e4f0
   annotated        297 v6.12-rc5
  traversed 1310258 commits
  v6.12-rc5-297-ge7427640278f
  
  real	0m11.626s
  user	0m11.298s
  sys	0m0.289s


Note the commit it finishes at is from almost 20 years ago (I have
historical Linux git history grafted in which goes back to 1991):

commit d8470b7c13e11c18cf14a7e3180f0b00e715e4f0
Author: Karsten Keil <kkeil@suse.de>
Date:   Thu Apr 21 08:30:30 2005 -0700

    [PATCH] fix for ISDN ippp filtering

    We do not longer use DLT_LINUX_SLL for activ/pass filters but
    DLT_PPP_WITHDIRECTION witch need 1 as outbound flag.

    Signed-off-by: Karsten Keil <kkeil@suse.de>
    Signed-off-by: Linus Torvalds <torvalds@osdl.org>


Presumably only one candidate matches the "v6.12-rc5" glob (which is an
exact string, not a wildcard) so it tries to find 9 more but never finds
any?

Since it's not a wildcard pattern, I would expect it to stop immediately
when it reaches the exact match.

-- 
Josh
