Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D514E156F45
	for <git@vger.kernel.org>; Fri, 23 May 2025 02:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747965793; cv=none; b=sNzJf/i6SpLWV/Pu3VpRdDZmk8uU05o3fgp6Pcf0qTCPIfoWwCZK0Pwh03c1nxWK8UXtKn0+Da9b6ovoCSgdqMYil1hswVA+Z2zClBaQWv02KRGbLKfZIajjR76CfwfAB7EQ8KpbQGwY4g+cBRQcsQ/6mO2sK6UhQvQv5Ii+0vg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747965793; c=relaxed/simple;
	bh=aI3iT+KflfrlYObWrflo2JLAeownHFSruzssTWCEBak=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V2oWUXKx/03KxZS6upHjl1ejUsn55MK+hUdNMTfG2HDTLLgkNRa/+LtiuYm/UDvmaHnnWw9nmOIDJfDiudusb9gqRIENzVrgIijpGCGPE3IGQUtK42OCsfCUAYtRy72AGioasHqzc18MFK3ujMP/+uZJ4/o1IfOk9TjaD9hyNqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=HN3sv+uR; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="HN3sv+uR"
Received: (qmail 2563 invoked by uid 109); 23 May 2025 02:03:10 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=aI3iT+KflfrlYObWrflo2JLAeownHFSruzssTWCEBak=; b=HN3sv+uRbtKVBLhUtJscTmDhuoru/aNi1fCmNhlaA/ZhzxPcpWRllg7Wr6WtSZa+1RM4AUofFtejZVUOerp55ykSpwpm2rqD+qvh+jVMYqg8uzkWwXxXIHNCKrF8M3m4IKUTLeZhAEp+6ymd4qyXbpdyVRI0tJe02JX7KCed/JxCAuk6LgfOr8LyW95wmDN0k1tDmYDdAiHUZdjPincKd2bq4lO+RNHB5719KCy3+C+cDkVA6ycL/jzzvuUE+eKisCJcKM1+zuUaycPsWYvR64Bmt28no1Fl+SgKzRScKMVGgww3ke4KqLjdN5yKK9LuWtqkRdozeiSMs4p+gqTnyg==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 23 May 2025 02:03:10 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 27997 invoked by uid 111); 23 May 2025 02:03:13 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 22 May 2025 22:03:13 -0400
Authentication-Results: peff.net; auth=none
Date: Thu, 22 May 2025 22:03:08 -0400
From: Jeff King <peff@peff.net>
To: Taylor Blau <me@ttaylorr.com>
Cc: Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>,
	git@vger.kernel.org
Subject: Re: [PATCH] packfile: avoid access(3p) calls for missing packs
Message-ID: <20250523020308.GA559000@coredump.intra.peff.net>
References: <20250516-pks-pack-avoid-stats-on-missing-v1-1-e2ef4d8798a3@pks.im>
 <xmqq7c2gv1zx.fsf@gitster.g>
 <20250519065221.GC102701@coredump.intra.peff.net>
 <aC/JDrF5uJh9XxXj@nand.local>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aC/JDrF5uJh9XxXj@nand.local>

On Thu, May 22, 2025 at 09:02:06PM -0400, Taylor Blau wrote:

> > I don't recall offhand whether reprepare_packed_git() will open the new
> > midx. If it doesn't, we'd still find the object via the actual pack
> > .idx, but we may end up consulting the now-stale midx over and over (so
> > we'll get the right answer, but there may be some room for
> > optimization).
> 
> This all sounds right to me. And we do end up loading a new MIDX via
> reprepare_packed_git(): that function calls prepare_packed_git() (which
> doesn't immediately return, since we just zero'd out the
> r->objects->packed_git_initialized flag). We then enumerate the ODBs,
> calling prepare_multi_pack_index_one() and prepare_packed_git_one() for
> each.
> 
> From there we end up in load_multi_pack_index(), which gets a freshened
> view of the MIDX file. If all goes well there, then
> prepare_multi_pack_index_one() assigns it to
> r->objects->multi_pack_index as expected.

One thing that puzzled me here is how prepare_multi_pack_index_one()
deals with an existing r->objects->multi_pack_index:

          m = load_multi_pack_index(r, object_dir, local);
  
          if (m) {
                  struct multi_pack_index *mp = r->objects->multi_pack_index;
                  if (mp) {
                          m->next = mp->next;
                          mp->next = m;
                  } else
                          r->objects->multi_pack_index = m;
                  return 1;
          }

I don't see reprepare_packed_git() zero-ing out the existing midx
pointer. So would we hit that "if (mp)" block, in which case we seem to
create a loop of next pointers? But the old midx would still be the
first one in the loop. Would we still consult it?

Or am I just reading this totally wrong?

-Peff
