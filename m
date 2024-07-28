Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB69E2AD29
	for <git@vger.kernel.org>; Sun, 28 Jul 2024 22:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722206898; cv=none; b=o5PL8wnWqVZAhbQdyjnrKfXyQg1uqd/d4TgFxWN1utpJwNoA2YrPDVIcf6d/8IvnZH9eMGIaWbZQr9SKQAFCLpY7/IOByzPZCTXsC3/28/l7k7Ld39AoeuNGrx05s4LLa+bgOyKFXfojGTFbd2hbn11fY3jsAAiyGow8U3Spvw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722206898; c=relaxed/simple;
	bh=QoZOSGQSsBnc4P85IUBG/iPqhMp5x0CCleDEf1ybCKo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eEfnzwJpsy3FtJDlUYYHqitYiom8p5LXjVyeDuVykUVtj1Tyt85AIOqcXSGj43lYoXdy8nMd+/WLinO0p1f1cT4wGSdjxyk8cW2YERqUQVq810kTjbN7VfjJ8OUwcOebWXnYGzBd5ihuqNgXRAKkjr0exuhHVTkcXxjpdHc4/vE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 16492 invoked by uid 109); 28 Jul 2024 22:48:09 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sun, 28 Jul 2024 22:48:09 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 27899 invoked by uid 111); 28 Jul 2024 22:48:10 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sun, 28 Jul 2024 18:48:10 -0400
Authentication-Results: peff.net; auth=none
Date: Sun, 28 Jul 2024 18:48:07 -0400
From: Jeff King <peff@peff.net>
To: "W. Michael Petullo" <mike@flyn.org>
Cc: git@vger.kernel.org
Subject: Re: Git clone reads safe.directory differently?
Message-ID: <20240728224807.GA1299337@coredump.intra.peff.net>
References: <ZqUc8DJ1uKcHYlcy@imp.flyn.org>
 <20240727215845.GA1263246@coredump.intra.peff.net>
 <ZqZjRMqpEV_3WIkD@imp.flyn.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZqZjRMqpEV_3WIkD@imp.flyn.org>

On Sun, Jul 28, 2024 at 10:27:00AM -0500, W. Michael Petullo wrote:

> For completeness, I investigated how to do the same over SSH. Imagine a
> repository user-owned by Bob, but group-owned with r/w/x permissions by
> a group containing Alice. It seems the same trick fails because git-shell
> rejects the custom upload-pack command:
> 
> 	git -c safe.directory="*" clone -u 'git -c safe.directory="*" upload-pack' alice@git.example.com:/shared/repository
> 	Cloning into 'git'...
> 	fatal: unrecognized command 'git -c safe.directory="*" upload-pack '/shared/repository''
> 	fatal: Could not read from remote repository.
> 
> 	Please make sure you have the correct access rights
> 	and the repository exists.

It should work over ssh in the general case, but yes, if you're using
git-shell, the whole idea there is to restrict what the client can
specify. And so there won't be any workaround from the client side (if
there were, it would be a bug!).

> I was able to overcome this by creating /home/alice/git-shell-commands/upload-pack-safe,
> placing the following there
> 
> 	#!/bin/sh
> 
> 	git -c safe.directory="$1" upload-pack $1
> 
> and running:
> 
> 	git -c safe.directory="*" clone -u upload-pack-safe alice@git.example.com:/shared/repository
> 
> This seems to be another interface edge case. Is my solution reasonable,
> or is there something else that would be more consistent?

So yeah, that would work. But it might be simpler still to just put
"[safe]directory = *" into /home/alice/.gitconfig. Then the client side
does not have to do anything differently (or you could even put in a
more limited relaxation of the rules, like "/shared/repository/*" or
whatever).

-Peff
