Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5973C137772
	for <git@vger.kernel.org>; Sat, 26 Oct 2024 06:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729922563; cv=none; b=V+jF4/4Jp19nX048SgCX8y9XAY9ZQPNDhc41sqPc/3dUc99QaWWUEz9v4p4fBu8iWbsECFQA34XjyCEbUbO1LNagfdRD9qhcrplYa0UA7Sb3VLaZpaCbTM7+ZEWtJf9yfD3flhdGNaPEgUkD/WV097U6skY8zCoDB27WveT7w9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729922563; c=relaxed/simple;
	bh=S+JzEG7dguqqMETnfGxLOvZwn4fj8JBG8PkHimyuxXE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H79iff48Mg8CuriivxWSauTNA58VCoZWAgnb8MigVts+a/3RtFNBrAB9n8Q1k+ROcb5j0zFH79Z3rRULwd7+Ra2mq3XtKuaLuWkIHN2jLsZIC2QGVH88FG0Q7I/kFDtzhC6ShQJ4tVXGwilGEDOIRK8VjgyONHVrTmy5YlaDoIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=gQ2Ao/CT; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="gQ2Ao/CT"
Received: (qmail 12400 invoked by uid 109); 26 Oct 2024 06:02:39 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=S+JzEG7dguqqMETnfGxLOvZwn4fj8JBG8PkHimyuxXE=; b=gQ2Ao/CTHpTzluDCZkJcCnaK/2VMnRnjLejTDLhK2j7kjCFkx6DAjXqwhfkRjBrDl6yxVkmTewyQlQfZPkGShDmOrVrJ17wvYT8PRaqdiJU2qoHGQZgPiyYB4SX7PA/TjL5KJg+DTKj3zBgAyNlVQOqWwPHSo+m+OWMkpP836dDbngNOJrIvzgvkKxekNMihmI/q1yuCDP8mLkHonr16QOnKOXcOyOQDhBWZvFRNRze8j8cPQI46bLKY4oifwkrMNZVyBk1Qp1mJkFyz0461A+dlcb2U7HZ/VRRaph25SBtUyA9doXk01EzCX8sb0lU1xNRBjRrllsleD6XqCgO6lw==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 26 Oct 2024 06:02:39 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 28447 invoked by uid 111); 26 Oct 2024 06:02:38 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 26 Oct 2024 02:02:38 -0400
Authentication-Results: peff.net; auth=none
Date: Sat, 26 Oct 2024 02:02:38 -0400
From: Jeff King <peff@peff.net>
To: Taylor Blau <me@ttaylorr.com>
Cc: fox <fox.gbr@townlong-yak.com>, Eric Sunshine <sunshine@sunshineco.com>,
	git@vger.kernel.org
Subject: Re: [PATCH 03/11] dumb-http: store downloaded pack idx as tempfile
Message-ID: <20241026060238.GA2227062@coredump.intra.peff.net>
References: <20241025064148.GA2110169@coredump.intra.peff.net>
 <20241025065806.GC2110355@coredump.intra.peff.net>
 <ZxwLOxT17OhLX/Rd@nand.local>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZxwLOxT17OhLX/Rd@nand.local>

On Fri, Oct 25, 2024 at 05:18:51PM -0400, Taylor Blau wrote:

> > -	strbuf_addf(&buf, "%s.temp", sha1_pack_index_name(hash));
> > -	tmp = strbuf_detach(&buf, NULL);
> > +	/*
> > +	 * Don't put this into packs/, since it's just temporary and we don't
> > +	 * want to confuse it with our local .idx files.  We'll generate our
> > +	 * own index if we choose to download the matching packfile.
> 
> I actually think putting it in $GIT_DIR/objects/pack is fine and perhaps
> preferable, since that's where we put existing in-progress temporary
> files. We'll ignore anything that doesn't end with "*.idx", so I think
> it would be fine.

But the new tempfile _does_ end with .idx. And it (kinda) has to,
because that's an assumption made by packed_git: it stores
path/to/foo.pack, and then assumes it can access /path/to/foo.idx as
needed.

I say "kinda" because as I mentioned elsewhere, the prior code cheats a
bit and assumes that we can access the idx file through the original
mmap we made, even if the ".idx" the packed_git mentions does not yet
exist. I _think_ that's pretty foolproof and that we'd never unmap or
close an idx (though we certainly do for packs themselves). But it
doesn't feel like a great thing to rely on.

> I don't feel strongly about it. It just feels a little weird to stick
> these temporary files in one place, and stick other (similar) temporary
> flies in another.

One difference is that these are pure tempfiles. We'll never "finalize"
them by renaming them into place, so there's no chance of having to do a
cross-directory link/rename. They just get created and then deleted[1].

Perhaps something like "objects/temp-remote-index/*.idx" would be a
more descriptive name (and certainly what I'd use if making a more full
caching system), but there are complications:

  1. We don't have good cleanup routines for directories. Would that
     just become a semi-permanent empty directory in a dumb-http repo?

  2. git-prune cleans up tmp_* in objects/ and objects/pack, but would
     have to learn to look there, too.

So just sticking them in objects/ seemed like the path of least
resistance to me.

-Peff

[1] They really could be opened anywhere, like /tmp. Which I was tempted
    to do, but since they're non-trivial in size it seemed like keeping
    them inside the repo directory was the best bet.

    Curiously, if we lean into the "we will never close a mapped idx",
    then we could create them, open and map them, and then delete them
    immediately, which is a somewhat common tempfile idiom. At least on
    Unix systems. I'm not sure how Windows would like that. :)
