Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C4A3481D0
	for <git@vger.kernel.org>; Mon, 22 Jan 2024 21:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705959260; cv=none; b=OPAZqhkns5db6Xm/icOrxQoCOMu+ToZ6M4JNTsekwlK1lSYdb32u6P7GAkl19M802QqzcRR6zRsGL7fxbtCbplwI4o/3MaPa3S2i1u2tn41SJGJKNZGjf4xbsi+X4Qn7wodRU1y9wnJ4+gP5oHdxn/2ny/Usw80fh4K73z6EZgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705959260; c=relaxed/simple;
	bh=HtmWJwOVrZAVKrSRF9S4pSwXLAMkdHNznt1s3KyztaA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rFcpRPL3ljsb9tRKrk4ySSWUplQf5NY1CTl6r5pObVUoaHH72S80JS6UOMUk7mBHY17RWuyy0oFKWki5LvtmQr6ZSlKCktbB2u9B9h9HtcH5l1WDupQ7SG8J5kiPSOxcejmvkO1bXy/IUeDLjVEg64/94T9Nu0xQNpbztU0Ngfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 11332 invoked by uid 109); 22 Jan 2024 21:34:11 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 22 Jan 2024 21:34:11 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 9433 invoked by uid 111); 22 Jan 2024 21:34:12 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 22 Jan 2024 16:34:12 -0500
Authentication-Results: peff.net; auth=none
Date: Mon, 22 Jan 2024 16:34:10 -0500
From: Jeff King <peff@peff.net>
To: =?utf-8?B?UmHDumwgTsO6w7Fleg==?= de Arenas Coronado <raulnac@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: Fwd: Unexpected behavior of ls-files command when using --others
 --exclude-from, and a .gitignore file which resides in a subdirectory
Message-ID: <20240122213410.GA811766@coredump.intra.peff.net>
References: <CAGF1KhWNaO_TUuCPo2L_HzNnR+FnB1Q4H6_xQ2owoH+SnynzEg@mail.gmail.com>
 <CAGF1KhWiYX=3R01Odj2yCNgvx=f5+HRCjRJogWf5eBikuATCcg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGF1KhWiYX=3R01Odj2yCNgvx=f5+HRCjRJogWf5eBikuATCcg@mail.gmail.com>

On Mon, Jan 22, 2024 at 09:45:46PM +0100, Raúl Núñez de Arenas Coronado wrote:

> But when using 'git ls-files --others --exclude-from=<file>', when
> <file> is one of those .gitignore files present in a subdir, makes the
> command use the patterns in that .gitgnore (in this case, the "*")
> against ALL files that would otherwise be listed by using '--others'.
>
> In short: using 'git ls-files --others
> --exclude-from=subdir/.gitignore' results in an empty listing if
> subdir/.gitignore contains '*". IMHO that pattern should be applied to
> the subdir contents and not to the contents of the current directory.
> That would be consistent with how git uses .gitignore files in
> subfolders.

I think Junio covered this with his example, and everything is behaving
as intended (my mental model is that "--exclude-from" is something like
.git/info/exclude or the core.excludesFile option).

But...

> The obvious solution is to use --exclude-per-directory but it is
> deprecated in favor of --exclude-standard and --exclude-standard shows
> the same behaviour of --exclude-from=subdir/.gitignore!!!

...I'm not sure what's going on here. I would think that both
--exclude-standard and --exclude-per-directory would do what you want.

For example, I get:

  [setup]
  $ git init
  $ mkdir subdir
  $ echo '*' >subdir/.gitignore
  $ git add -f subdir/.gitignore && git commit -m "add gitignore"
  $ touch subdir/file file

  [no exclusions]
  $ git ls-files -o
  file
  subdir/file

  [use .gitignore]
  $ git ls-files --exclude-per-directory=.gitignore -o
  file

  [using standard excludes]
  $ git ls-files --exclude-standard -o
  file

Do you get different results from that toy repo? If not, then what is
different about your main repo? Do you perhaps have a stray "*" match
somewhere in .git/info/exclude, etc? Or are you still providing
--exclude-from in addition to --exclude-standard?

-Peff

PS I hadn't realized that --exclude-per-directory had been marked as
   deprecated. I do agree with e750951e74 (ls-files: guide folks to
   --exclude-standard over other --exclude* options, 2023-01-13) in its
   goal of guiding people to the easiest option, but I don't know that
   there has been any discussion about removing the other ones.
