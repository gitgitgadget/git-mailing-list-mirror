Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 580F71946BE
	for <git@vger.kernel.org>; Wed,  5 Jun 2024 08:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717577121; cv=none; b=gduzxK8uDP4O4GL514hDKR0yWI7tFJ9u6ayRpIYnh3N6kFKjS0z8vyX+1l9vmlMVKXqK3q3jkji8JF/RX+EySn86EkcJvUXIpATT6UMha1zHvWjIFOKQYGdN7MsRZj0iaeFOrzsV9dCnirfAFc62dnfODiCg0LjXUo0y3kDX0y8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717577121; c=relaxed/simple;
	bh=uKvYsbtziON8O1vxnryGmNBp0BFijtttqLqcoPMbgNA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z3hG6rxfU6cSy+teH6laQuDyv/gO8o/3g37Pv/wVNc3RQd13JYYxdcgdnvMI2GqAsGcrrcvSojpKA45W53MyMr7Bc8cOrJNi1tLugcqElMgvZdxoS1d9VP9B80xghBoXmw6ocaCsj1COjpoe+ixxQvuRL5q4VqIOXf9Yrl+lyAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 24278 invoked by uid 109); 5 Jun 2024 08:45:18 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 05 Jun 2024 08:45:18 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 27976 invoked by uid 111); 5 Jun 2024 08:45:15 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 05 Jun 2024 04:45:15 -0400
Authentication-Results: peff.net; auth=none
Date: Wed, 5 Jun 2024 04:45:17 -0400
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: rsbecker@nexbridge.com, 'Curley Joe' <m48cv7wg9w@liamekaens.com>,
	git@vger.kernel.org
Subject: Re: git fetch --prune fails with "fatal: bad object"
Message-ID: <20240605084517.GC2345232@coredump.intra.peff.net>
References: <16919-1717194882-875013@sneakemail.com>
 <xmqqplt1d0k0.fsf@gitster.g>
 <000501dab3b3$51779400$f466bc00$@nexbridge.com>
 <xmqqo78kbqwo.fsf@gitster.g>
 <20240604104437.GD1781455@coredump.intra.peff.net>
 <xmqqcyowwqah.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqcyowwqah.fsf@gitster.g>

On Tue, Jun 04, 2024 at 10:50:30AM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > These are good examples. I was going to suggest fsck, as well, just
> > because I knew it would keep going after seeing bogus results. But more
> > interesting is that it is finding things in your example that other
> > programs would _not_ find, because it's being more thorough than just
> > reading the refs.
> 
> True.
> 
> I wish for-each-ref and friends had an optional mode that lets them
> keep going, but since so many features in them access objects
> pointed at by the refs (e.g., "--format='%(objectname:short)'" and
> "--no-merged HEAD"), it would be very cumbersome to retrofit such a
> mode to the underlying machinery, I suspect.

We try to read as little as possible in for-each-ref for efficiency
purposes. The side effect is that if you don't ask for any details of
the object, we won't try to read it and notice that it's gone. ;)

So you can do:

  git for-each-ref --format='%(objectname) %(refname)'

which will show even broken refs. Of course you still don't know which
ones are broken! For that, I'd rely on something like cat-file, where it
will reliably tell you about missing objects and continue (even if we
just print the object name, it does an existence check). So naively I'd
want something like this to work:

  git for-each-ref --format='%(objectname) %(refname)' |
  git cat-file --batch-check='%(objectname) %(rest)' |
  grep ^missing

But annoyingly, when it encounters a missing object it, cat-file ditches
the whole format string and just prints "$oid missing". You can work
around it with a little shell magic:

  git for-each-ref --format='%(objectname) %(refname)' >both
  cut -d' ' -f1 <both | git cat-file --batch-check='%(objectname)' >exists
  paste -d' ' both exists | cut -d' ' -f2,4

which yields lines like:

  refs/heads/ok
  refs/heads/broken missing

and so on. Turning that into "update-ref --stdin" input is left as an
exercise for the reader.

I suspect it's too late to change the default behavior for a plumbing
tool like cat-file. But we could probably teach it an option like
"--missing=foo" to expand the format but use "foo" for object-related
placeholders that can't be expanded. And then:

  git for-each-ref --format='%(objectname) %(refname)' |
  git cat-file --batch-check='%(objectname) %(rest)' --missing=MISSING |
  grep ^MISSING

would work. I still think it's inferior to fsck, though, as it's a very
shallow check of validity.

-Peff
