Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A510D137B
	for <git@vger.kernel.org>; Wed, 24 Jan 2024 01:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706058567; cv=none; b=gde7FvNBvgfJTqWJkzeoTNPcJOPdQkfBm6kKiDbLZddgD/PVrEvs1zeqksPQ4j1GC+9YvnKJU2LiP0BFsaaN5PHk2ZtZg5GPYE4LSkSlQ6cJp1uPDA6/iOnJbncImCLfIY/06THlQdjpAQnbHx3Alkdq277fmzyh8VjjxwoSzgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706058567; c=relaxed/simple;
	bh=CSEIreKD83lB/rTt3H2uFWGzLfnJ+RON/ONpHyz2lOw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r2R9kXBT8CmKINQJlrMMNNIrOIfSpBsWNqntf+Y0SHZqQmZs2Xffocrzxo3CdrAOn2UwZqbkvvrnJ8hhXckD1aLnyzdMPOzyg/S1gajiDEiP5OUBj938vcauDQsibphYazssgPdbAMuNnd/s4folzQ3t4QiJQu9EUPRH9VnCOgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 25777 invoked by uid 109); 24 Jan 2024 01:09:25 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 24 Jan 2024 01:09:25 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 22448 invoked by uid 111); 24 Jan 2024 01:09:25 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 23 Jan 2024 20:09:25 -0500
Authentication-Results: peff.net; auth=none
Date: Tue, 23 Jan 2024 20:09:24 -0500
From: Jeff King <peff@peff.net>
To: =?utf-8?B?UmHDumwgTsO6w7Fleg==?= de Arenas Coronado <raulnac@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: Fwd: Unexpected behavior of ls-files command when using --others
 --exclude-from, and a .gitignore file which resides in a subdirectory
Message-ID: <20240124010924.GB2603087@coredump.intra.peff.net>
References: <CAGF1KhWNaO_TUuCPo2L_HzNnR+FnB1Q4H6_xQ2owoH+SnynzEg@mail.gmail.com>
 <CAGF1KhWiYX=3R01Odj2yCNgvx=f5+HRCjRJogWf5eBikuATCcg@mail.gmail.com>
 <20240122213410.GA811766@coredump.intra.peff.net>
 <CAGF1KhWaOrnV8d2f_vajOT0hFK2N_8m7-p_vnZhw92ZdhXfsag@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGF1KhWaOrnV8d2f_vajOT0hFK2N_8m7-p_vnZhw92ZdhXfsag@mail.gmail.com>

On Tue, Jan 23, 2024 at 06:40:10AM +0100, Raúl Núñez de Arenas Coronado wrote:

> > Do you get different results from that toy repo? If not, then what is
> > different about your main repo? Do you perhaps have a stray "*" match
> > somewhere in .git/info/exclude, etc? Or are you still providing
> > --exclude-from in addition to --exclude-standard?
> 
> The difference lies in how I deal in my computer with ignored files. I
> have some files in all my repos which have to be ignored always, so I
> have that pattern in my core.excludes file. BUT those files have to be
> backed up on my system, just in case my local copy of the repo is lost
> for some reason, as they are files I need for development in my
> personal machine.
> 
> If I use --exclude-standard, no matter if those files are being
> ignored by core.excludes OR .git/info/exclude, they won't appear in
> that 'list other files' command output.

Ah, OK. I understand your case better now. Then yes, I think
--exclude-per-directory is the right thing for you, since it lets you
just trigger parts of the exclusion mechanism, and not all. I would say
to ignore the deprecation mention in the manpage. ;)

(I think this also gives an interesting use case arguing for continuing
to support those more-specific exclusion options for ls-files).

If you are mostly just using core.excludesFile (and not
.git/info/exclude), then I suspect:

  git -c core.excludesFile /dev/null ls-files -o --exclude-standard

would work for you, too (but it sounds like you might also be using
.git/info/exclude).

-Peff
