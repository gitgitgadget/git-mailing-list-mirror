Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CACB27B4E2
	for <git@vger.kernel.org>; Mon, 19 May 2025 17:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747674037; cv=none; b=RUEQVt9n1WxxIMY3fr6ZBEatjyc6ZpBgZHvPx97OaNVviQvyZ53BmiYhm7rPdy9FBULnmIOsMCSki+Hd8aUZgZy0d4eby9u1QfLbNQ25V4aW0juXznK/sbXNt2LvAKSBRTR8kqYBw29fpvxxjwqLlEfsvdg20anEPRcbfrsTJFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747674037; c=relaxed/simple;
	bh=3AXJf7Kef2J+iGq6D7m9w7ovAHZdaMLv6C5nYgQEYcU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MnI52HC/tCyqqprLXHepEbVrbimCuK4FM5+DIuJcVRr9vqUhCSPAeCAymTdNOsr0rKnQeB85jRpMiINLmfEtaqurEGrpIs7nTsRpF3a2PRtS1gmBV9JA56NU8s3yl84+pNy/3zQCFpCawBwuztxFtWCtI7W16PNhh7yGH5H7Ebo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=iZGBX3pT; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="iZGBX3pT"
Received: (qmail 17541 invoked by uid 109); 19 May 2025 17:00:34 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=3AXJf7Kef2J+iGq6D7m9w7ovAHZdaMLv6C5nYgQEYcU=; b=iZGBX3pTCYI3kpMMp3pVThKW7njW/bnmiT/wfThUem8fxgZkInAYkYYjOERnmtAVx9MIa0e7Ac8CTmcWBfYv6o6sWikC70vR2INj2+G+RtliKHeseBgu3cENokhpLubJ6V68BwuFXxPhAukqJPaZIsUwT0edmdJJ4zhwfZzq+8qvqBDC/HjIHsXYzSoAi+TcXUI/6RdTZRbNlfLX3RWI+Sfh/SgbvCgUqG+bFafY8McyhitfbvGGM0DLZ3mlkmDa9tpdJxnFen4BxTa5dkB9iGuQRiGvvQDNvtUJljDOl6zEetyHpCiiekDPdMCYl9oUoQ7o4yx/wmwQP8CPGCKUcg==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 19 May 2025 17:00:34 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 32025 invoked by uid 111); 19 May 2025 17:00:34 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 19 May 2025 13:00:34 -0400
Authentication-Results: peff.net; auth=none
Date: Mon, 19 May 2025 13:00:32 -0400
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 06/13] fsck: stop using object_info->type_name strbuf
Message-ID: <20250519170032.GA772062@coredump.intra.peff.net>
References: <20250516044916.GA21985@coredump.intra.peff.net>
 <20250516044953.GF22242@coredump.intra.peff.net>
 <xmqqy0uspthe.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqy0uspthe.fsf@gitster.g>

On Mon, May 19, 2025 at 07:26:05AM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > So we can simplify things by bailing immediately in read_loose_object()
> > when we encounter an unknown type. This has a few user-visible effects:
> >
> >   a. Instead of producing a single line of error output like this:
> >
> >        error: 26ed13ce3564fbbb44e35bde42c7da717ea004a6: object is of unknown type 'bogus': .git/objects/26/ed13ce3564fbbb44e35bde42c7da717ea004a6
> >
> >      we'll now issue two lines (the first from read_loose_object() when
> >      we see the unparsable header, and the second from the fsck code,
> >      since we couldn't read the object):
> >
> >        error: unable to parse type from header 'bogus 4' of .git/objects/26/ed13ce3564fbbb44e35bde42c7da717ea004a6
> >        error: 26ed13ce3564fbbb44e35bde42c7da717ea004a6: object corrupt or missing: .git/objects/26/ed13ce3564fbbb44e35bde42c7da717ea004a6
> 
> Just curious; is the difference between 'bogus' and 'bogus 4'
> significant in the above examples?

The "4" is the size of the object. Knowing me, it was almost certainly
"foo\n". ;)

In the original, we had parsed the type name into its own strbuf, so the
error message reported that. Now we just get OBJ_BAD, but we still have
the full header sitting in a buffer (we unpack_loose_header() to zlib
inflate up until the NUL byte, and then we parse_loose_header() to
actually interpret it).

We _could_ do something like:

  p = strchrnul(hdr, ' ');
  *p = '\0'; /* truncate header at end of type */
  error("bad type: %s", hdr);

to just print "bogus". But showing the whole header is less work, and
arguably could be more informative, depending on exactly how it's
malformed.

Note that we _are_ guaranteed to have a NUL byte, or else
unpack_loose_header() would have complained and we'd have said:

  error: unable to unpack header of .git/objects/...

That's what you see if you put in a very long type name (we only inflate
up to MAX_HEADER_LEN, so we never find the NUL).

-Peff
