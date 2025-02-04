Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 582A721420C
	for <git@vger.kernel.org>; Tue,  4 Feb 2025 15:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738682560; cv=none; b=WcmgQKa6TIFCKldsJcgFHpKizve5sVwK7Y+ObqV1nUNDpooFB+bZuW5lrirt275bApUz8V3lKMV+lnLX2wEHWJv0c/INhM3A4azw9NNmUJlxYkwfsAqnyGdpT2VAjp9JfZ2X9W3fhCLvSSLOfuH0kEmfZ1+b5asnWFEmKrr64d8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738682560; c=relaxed/simple;
	bh=NSH+9XE3IfQQsZMKwhLa6RzQY7C3guTgDIOTgaN0YV8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RotGwnJcJ9gti+2b8qnVBS0hmziZie7j9hVlGtBmmdqToVFTw/UN81xnbwKS0bSUPtLSP+6PWRu8fk34k1Y5jUWJ82VZTFR6ChelLteqAoKfkj6NCTyARbyKcY8LH7m6oYk9+Q4sUHMoasAECX5v5zB+1FUpHc5mWbl7IVeRFUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=Fx9yU7O9; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="Fx9yU7O9"
Received: (qmail 29085 invoked by uid 109); 4 Feb 2025 15:22:37 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=NSH+9XE3IfQQsZMKwhLa6RzQY7C3guTgDIOTgaN0YV8=; b=Fx9yU7O9WYuBz3l/tabG5TvcGHc+hOA2+nocbv1H0jCjdsAPdrOngc71eWyFCDf3/2UYMRwDUi6nrQekkcEJueLNzAmNA94ufwKK1tK4eWYjXylZgTlK6r6vGAOySYYf3hWOeUcAkzIsQQvnVR0UTq5lPip++dxgWTgCmrV/6aSaaMoUbl58jzfv0kiPJ06qZ4xqFzvKsV+CaQT8Mu6jxoyP+iw2rtev1gV3OuIra75Zqu1IlNu3J4JprzJR2ag5ZgulGfYtbkvsA/0unweHNdpdgFtTR1XP9ZuHjYbiHiuCqbuPwLckZXmUauE/3o/oO9qzVk4mN7nJqHuFv8AFww==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 04 Feb 2025 15:22:37 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 5969 invoked by uid 111); 4 Feb 2025 15:22:37 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 04 Feb 2025 10:22:37 -0500
Authentication-Results: peff.net; auth=none
Date: Tue, 4 Feb 2025 10:22:36 -0500
From: Jeff King <peff@peff.net>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] builtin/repack: fix `--keep-unreachable` when there
 are no packs
Message-ID: <20250204152236.GB620055@coredump.intra.peff.net>
References: <20250203-b4-pks-repack-unreachable-objects-wo-packfiles-v1-0-7c4d69c5072c@pks.im>
 <20250204-b4-pks-repack-unreachable-objects-wo-packfiles-v2-1-1eae23366711@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250204-b4-pks-repack-unreachable-objects-wo-packfiles-v2-1-1eae23366711@pks.im>

On Tue, Feb 04, 2025 at 08:00:41AM +0100, Patrick Steinhardt wrote:

> this small patch series fixes `git repack -ad --keep-unreachable` when
> there aren't any preexisting packfiles.
> 
> Changes in v2:
>   - Merge tests into t7701.
>   - Link to v1: https://lore.kernel.org/r/20250203-b4-pks-repack-unreachable-objects-wo-packfiles-v1-0-7c4d69c5072c@pks.im

This looks good to me.

One interesting thing I did notice:

> +test_expect_success 'repack -k packs unreachable loose objects without existing packfiles' '
> +	test_when_finished "rm -rf repo" &&
> +	git init repo &&
> +	(
> +		cd repo &&
> +
> +		oid=$(echo would-be-deleted-loose | git hash-object -w --stdin) &&
> +		objpath=.git/objects/$(echo $sha1 | sed "s,..,&/,") &&
> +		test_path_is_file $objpath &&
> +
> +		git repack -ad --keep-unreachable &&
> +		test_path_is_missing $objpath &&
> +		git cat-file -p $oid
> +	)
> +'

In the test in v1, we had reachable commits to pack. And here we don't.
So before your patch, the behavior in the v1 test was that we'd create a
new pack, but it wouldn't pick up the loose object. But the behavior of
this test is that we say "Nothing new to pack".

I originally thought that output meant that we were not running
pack-objects at all. But looking at builtin/repack.c, we do run it, and
it simply chooses not to make a pack (which makes sense; how would
repack even realize if there was stuff to pack, since pack-objects is
what does the traversal).

So the two outcomes are both the result of the same bug. In both cases
we do not correctly pack the loose objects, so whether we make a pack is
just a question of whether there was other reachable stuff to pack. And
since your patch is fixing the bug at its root, both outcomes are fixed.

And when I suggested in my response to v1 that "Nothing new to pack" in
an empty repo was a separate bug, I was just wrong. ;) There is nothing
else to fix after your patch.

Thanks for finding and fixing.

-Peff
