Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92063145B32
	for <git@vger.kernel.org>; Tue,  4 Jun 2024 10:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717497881; cv=none; b=Uz7qRPsr8wCyoJ4lfINdnkQxwDBvma2BJQjpsgE4iRG0U6dmK3BuRBRf0aGOkEjS7dEh2KLKLeg9qzKCb+eXvFnFLY2ZpIQhIh4ZTMkDLF77uwaQmoVk6l5F0XgQiTbEs+/SKjCSDcoN1fLuHk9XrNHm8RRuPB7f9idieIbxI4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717497881; c=relaxed/simple;
	bh=EDMh2x5lwiKtM4TIlpBEvYTBmR/BaXiTZtwj+rVudk4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tPddvCB68GnScqc0IjvZrt5lwPp9IDYog2nASIZAOVF+803p8iKmuc4OfPZzOgD6s/wYeidk9oiH64Qpz36LqoE2zdkEWEuWYI6/76ZULvS7vpMpbfeOdB9vg07pm2PV146voosE20ATo2KX9leUDzOEKHBcFUYOMUBz7jYc6RM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 22052 invoked by uid 109); 4 Jun 2024 10:44:39 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 04 Jun 2024 10:44:39 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 18808 invoked by uid 111); 4 Jun 2024 10:44:35 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 04 Jun 2024 06:44:35 -0400
Authentication-Results: peff.net; auth=none
Date: Tue, 4 Jun 2024 06:44:37 -0400
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: rsbecker@nexbridge.com, 'Curley Joe' <m48cv7wg9w@liamekaens.com>,
	git@vger.kernel.org
Subject: Re: git fetch --prune fails with "fatal: bad object"
Message-ID: <20240604104437.GD1781455@coredump.intra.peff.net>
References: <16919-1717194882-875013@sneakemail.com>
 <xmqqplt1d0k0.fsf@gitster.g>
 <000501dab3b3$51779400$f466bc00$@nexbridge.com>
 <xmqqo78kbqwo.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqo78kbqwo.fsf@gitster.g>

On Sat, Jun 01, 2024 at 08:53:43AM -0700, Junio C Hamano wrote:

> Interesting.  "git fsck" certainly can be used to help you find out
> about them.  In a throw-away repository, after manually crafting
> some "broken refs" (because update-ref will refuse to create a ref
> pointing at a missing object):
> 
>     $ git for-each-ref
>     9e830ad6c4f43159cef50cb1c2205f513c79bc8b commit refs/heads/master
>     $ echo 9e830ad6c4f43159cef50cb1c2205f513c79bc8a >.git/refs/heads/broken-missing
>     $ git rev-parse master: >.git/refs/heads/broken-tree
>     $ git rev-parse "master:foo /baz" >.git/refs/heads/broken-blob
> 
> running "git fsck" does tell you about them, ...
> 
>     $ git fsck
>     Checking object directories: 100% (256/256), done.
>     error: refs/heads/broken-blob: not a commit
>     error: refs/heads/broken-missing: invalid sha1 pointer 9e830ad6c4f43159cef50cb1c2205f513c79bc8a
>     error: refs/heads/broken-tree: not a commit
> 
> ... and using the information, you can
> 
>     $ for r in refs/heads/broken-{blob,missing,tree}
>       do git update-ref -d "$r"
>       done
> 
> to unbreak the repository.

These are good examples. I was going to suggest fsck, as well, just
because I knew it would keep going after seeing bogus results. But more
interesting is that it is finding things in your example that other
programs would _not_ find, because it's being more thorough than just
reading the refs.

Having to manually convert the human-readable fsck output to a cleanup
command is a minor pain. We could provide "git fsck --prune-broken-refs"
or something, but I'm hesitant. Deleting refs in a corrupted repository
is a good way to make recovery even harder, as it opens the door to
removing whatever objects we do still have.

In the case of a refs/remotes entry where you happen to know that you
could re-clone from the other side, it is relatively low stakes. But I
think keeping a human brain in the loop between corruption and deletion
is a good thing. Corruption should not be happening so often that it's a
major pain point.

-Peff
