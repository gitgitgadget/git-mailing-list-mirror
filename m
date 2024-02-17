Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85DD4149DE0
	for <git@vger.kernel.org>; Sat, 17 Feb 2024 06:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708150175; cv=none; b=NeNgDvKvv3Z+1VssO/MlGvjfTjB5c/EfDoQU1bbiaxND9g1WRAU5IA7bWnZcjJ2+xOJk5LcOZe11a2U2VGxolxszrrJE6hf+0fNw41EMTAFHLaddvambZ8jTBQjmsOj3m3rOyGfEsXFu+5kjC+1nKugWs7Vo48Rp4F2VVQ5ywfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708150175; c=relaxed/simple;
	bh=/zeFRdlL3r5/6zKTio/22ADjA+YHP1k61xgvgVIB1AQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YNlTE0dz93vaBWRWHO3va27KvgDxxE92KCdtq+oi/y28/gfexXX6rOsjHfkttG+7qzhdDMtL9Y8HqqQ+2zm5dxvkUbofssUlAO3NnRjHM6H6zgQe0I5NXJRZvUwnTxEMkjVYYRDtfepiyQjkra5aSJqqqQTciPnzPxre3n0fQ/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 2307 invoked by uid 109); 17 Feb 2024 06:09:33 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 17 Feb 2024 06:09:33 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 21035 invoked by uid 111); 17 Feb 2024 06:09:36 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 17 Feb 2024 01:09:36 -0500
Authentication-Results: peff.net; auth=none
Date: Sat, 17 Feb 2024 01:09:31 -0500
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: Maarten Bosmans <mkbosmans@gmail.com>, git@vger.kernel.org,
	Teng Long <dyroneteng@gmail.com>,
	Maarten Bosmans <maarten.bosmans@vortech.nl>
Subject: Re: [PATCH 1/4] notes: print note blob to stdout directly
Message-ID: <20240217060931.GF539459@coredump.intra.peff.net>
References: <20240205204932.16653-2-maarten.bosmans@vortech.nl>
 <xmqqil32l0i6.fsf@gitster.g>
 <CA+CvcKTtcHCCKucQ0h1dnaDAMNfErJ+a1CXEVi=ZE5dv57Tb3A@mail.gmail.com>
 <xmqqy1bxiiop.fsf@gitster.g>
 <20240213080014.GB2225494@coredump.intra.peff.net>
 <xmqq5xys6zdr.fsf@gitster.g>
 <20240215052640.GC2821179@coredump.intra.peff.net>
 <xmqqcysxkjrq.fsf@gitster.g>
 <20240217051650.GB539459@coredump.intra.peff.net>
 <xmqqwmr3fxc1.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqwmr3fxc1.fsf@gitster.g>

On Fri, Feb 16, 2024 at 09:56:14PM -0800, Junio C Hamano wrote:

> > Hmm, good question. I can't think offhand of a way that the user could
> > convince "git show <oid>" to do anything different than just dumping the
> > literal contents. It is not even handed a path that could trigger
> > .gitattributes or similar.
> 
> show_blob_object() directly calls stream_blob_to_fd() without any
> filter, as the hardcoded invocation of "git show <oid>" in the note
> codepath does not allow --textconv at all, so we probably are safe
> to assume that the contents will appear as-is, not even going
> through EOL conversion (which is a bit puzzling, to be honest,
> though).  Lack of path I am not worried about, as you can easily
> declare with '*' wildcard that everything in the notes tree is of
> the same type.  But if the stream_blob_to_fd() interface does not
> have anywhere smudge filters or textconv filters can hook into
> without some command line option, we do not have to worry about it.

I think we are mostly on the same page, but just to be pedantic: I do
not think even adding a "*" attribute in the notes tree could ever do
anything. The "git show" invocation is not "git show notes_ref:<path>".
We resolve the note blob to an oid, and then pass that oid's hex to "git
show".

So the "git show" command itself has no context at all, and does not
even know this blob came from a tree in the first place.

-Peff
