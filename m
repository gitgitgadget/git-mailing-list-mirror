Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 043671BC44
	for <git@vger.kernel.org>; Sat,  6 Jul 2024 07:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720249800; cv=none; b=hiqtfSY4rCUddwEOn7lQGDl8FULgPRRjiKpENVrLFSjh0CwYOFZwkUinxOM6ifVYmExeE/u3RJFVuryY3I1IuOuD1vMSaMJW+8c20GwPJfVSx4DfsZ7CEZvliizaDzwV0cuSF0w8HuJdDYUw7vsEFTxk+5914hLzbDE1gsw4iTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720249800; c=relaxed/simple;
	bh=1TcbKNPRJF7Sd9ZBpYdVW5IT1XC6QdPWJspWO2+3qRI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L1KWa4GPIZLPYeqD5hoDuGhKFtdxTcijQ5dGURrtJPtE8R5NZq4rfbSngZG098XNnJI0XYY2+DzBNdwQ+OhgwmkPC+5zhhcZn7ygvXkTifKqX0GwePj3m2ngW96bHPwggmQ6wsH8GaRPfGK5btgJkdlcz/46PjkhN4pfg6BHbxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 24491 invoked by uid 109); 6 Jul 2024 07:09:58 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 06 Jul 2024 07:09:58 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 31721 invoked by uid 111); 6 Jul 2024 07:09:55 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 06 Jul 2024 03:09:55 -0400
Authentication-Results: peff.net; auth=none
Date: Sat, 6 Jul 2024 03:09:57 -0400
From: Jeff King <peff@peff.net>
To: Stefan Haller <lists@haller-berlin.de>
Cc: git@vger.kernel.org
Subject: Re: branch{u} not working even though upstream configured
Message-ID: <20240706070957.GB702644@coredump.intra.peff.net>
References: <a04b3417-4590-48d1-bc6a-88ca44edb36c@haller-berlin.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a04b3417-4590-48d1-bc6a-88ca44edb36c@haller-berlin.de>

On Wed, Jul 03, 2024 at 01:52:05PM +0200, Stefan Haller wrote:

> What could be a reason why branch@{u} doesn't work even though the
> branch does have a remote tracking branch configured?
> 
> We have a user who reports the following:
> 
> $ git push --set-upstream origin test-456
> branch 'test-456' set up to track 'origin/test-456'.
> Everything up-to-date
> $ git merge-base test-456 test-456@{u}
> fatal: upstream branch 'refs/heads/test-456' not stored as a
>        remote-tracking branch
> 
> Git remote shows that the remote tracking branch is configured as expected:
> 
> $ git remote -v show origin
> * remote origin
>   [...]
>   Local branches configured for 'git pull':
>     test-456          merges with remote test-456
>   Local refs configured for 'git push':
>     test-456          pushes to test-456           (up to date)
> 
> Any ideas?

Hmm, in a simple test this seems to work for me. Can you show us what's
in your local .git/config, especially the relevant remote and branch
sections?  Likewise, can you show us "git for-each-ref" output to see
what refs you have (though from the message I think we are not even
getting as far as looking at the remote tracking branch itself)?

I was able to produce a similar error if "refs/heads/test-456" is not
covered by the remote.origin.fetch refspec. That's usually:

  [remote "origin"]
  fetch = +refs/heads/*:refs/remotes/origin/*

but if I delete that second line, or replace it with something like:

  fetch = +refs/heads/some-specific-branch:refs/remotes/origin/some-specific-branch

then I see the same error you saw.

-Peff
