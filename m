Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0155BB64C
	for <git@vger.kernel.org>; Wed, 17 Jul 2024 05:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721195752; cv=none; b=he5Q/7HTJ4otDuK0pqhrw+5OoYdCxRB+frmSTDll9S/9VerC5movt7B/la4MT/bQgqt4JMy+pXqtbzIRrFvX8UdeZbn7OV/i+KHmG0ZmqRKwezaL+YkFucdX8VpxE1Kla5YG+s5soR3qVov7oXivMeMSCFhzwisJh6vZb9LljqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721195752; c=relaxed/simple;
	bh=6WW03kfA2Jp4VweakHKiQQnyCMra5079iT35TAbIuQY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XAD1AvrRKmcne9PW6ZAiWTcF5/1JGXiUcEiYi3dq+oWoVE3Vw/nlOCMfSqMIzurhxDHJzOo3tqrlac7doKPWxcJyShEPP5wK0IijntjkuugwmES1rJrT6MCQGfBxjM7uQqfdYOLZGzOyyQNl+Y3XloJs0dzzs9np0PKEw3kNvD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 23438 invoked by uid 109); 17 Jul 2024 05:55:50 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 17 Jul 2024 05:55:50 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 18810 invoked by uid 111); 17 Jul 2024 05:55:47 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 17 Jul 2024 01:55:47 -0400
Authentication-Results: peff.net; auth=none
Date: Wed, 17 Jul 2024 01:55:49 -0400
From: Jeff King <peff@peff.net>
To: Nikolai Zaki <nikolai-waleed.zaki@charite.de>
Cc: git@vger.kernel.org
Subject: Re: bug: `git pull` does not clean up after itself if it fails
Message-ID: <20240717055549.GD547635@coredump.intra.peff.net>
References: <0cc13c53-1d8d-4501-89f2-e8329bc95485@charite.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <0cc13c53-1d8d-4501-89f2-e8329bc95485@charite.de>

On Mon, Jul 15, 2024 at 01:19:32PM +0200, Nikolai Zaki wrote:

> What did you do before the bug happened? (Steps to reproduce your issue)
> In your local repo have a directory that you cannot write to.
> Pull from a remote that has changes/new files in that directory.
> 
> What did you expect to happen? (Expected behavior)
> The pull fails and the local repo in the same state as before.
> 
> What happened instead? (Actual behavior)
> All changes to writeable files are applied and all new files in writeable
> dirs are added.
> The local HEAD however remained the same.
> 
> What's different between what you expected and what actually happened?
> A failed `git pull` inadvertently creates changes and untracked files.

A pull is basically fetch followed by merge. So I'd expect us to fail in
the merge step, at which point pull would generally leave the state
as-is, because merge failures tend to be conflicts.

So I guess doing what you expect would require a merge which hits a
non-conflict error (like an unwriteable directory) to clean up after
itself. That's probably not impossible, but it may be rather tricky,
especially if we are concerned about unrelated changes in the working
tree.

-Peff
