Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28DAC747F
	for <git@vger.kernel.org>; Tue, 31 Dec 2024 01:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735609351; cv=none; b=SFV5l1GWiX5ks+qFgS4syHuTRdMwYvizNxgTQ1N9uSGYVaIDExC8p51AK8O8DTeaSwQdR8IV9Axw25v9IjB3lL3o6vOrXA0JA4suQ30K3agjb5OT2Qs1L9GB+DH4/D9LlgFcrJPvo1j0j7TgT8SbaVv5SQWdlGHvoypukV5P2ms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735609351; c=relaxed/simple;
	bh=0XKLDiaXUakgJhATWEWPcXveReIu/LMNmOePMWf4PG4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UECruyPD7nTf/O3bVYYlRPfs1W6/F8bmur/vZsxWV1AZILEYQKdEnbf1197hzuxw72ZIZe/ZvkwW25Gt+3TPSRdb9ywC4I1ino25xDQeBmUthqfy2H6rdpVZ42c2RsKQcpvX/UNikP6kNpBw6IxyRop7VbPjeffRuzQfjaXlfmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=MMWO9Msg; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="MMWO9Msg"
Received: (qmail 29865 invoked by uid 109); 31 Dec 2024 01:42:22 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=0XKLDiaXUakgJhATWEWPcXveReIu/LMNmOePMWf4PG4=; b=MMWO9MsgToJxF78ZLiGkGf1OHRllJxTtZkbKHp+I7lfaZf8d5bP3t30pROdsSfa4sRAAsLQXKKs/32yI5rYMfBLJ5J+ygTo/tRAnObOANfYZ7FPyUjMMkaL8i0X2XfEghSuei01siF/tS8lkv1Hl8gzQsYWyQd/mS2FyA2b191TyaNYjw+BL6tcmkJBKHkfFc0sws9k2/0bvqxtHtZuyzp0Kxlx5wlqMX2Xbz5QkiIRl4c3Z7DOagoyLF/O2TABgPIqQq99x3/+EcRygstboRF0Q/XQCblnc/3Xu4r3Y9+mw63/fJquJlBaF7eVD3GkKs4NA285/SSCNCiZ+J94ePg==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 31 Dec 2024 01:42:22 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 24821 invoked by uid 111); 31 Dec 2024 01:42:21 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 30 Dec 2024 20:42:21 -0500
Authentication-Results: peff.net; auth=none
Date: Mon, 30 Dec 2024 20:42:20 -0500
From: Jeff King <peff@peff.net>
To: Patrick Steinhardt <ps@pks.im>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH] object-file: fix race in object collision check
Message-ID: <20241231014220.GA225521@coredump.intra.peff.net>
References: <20241230-b4-pks-object-file-racy-collision-check-v1-1-11571294e60a@pks.im>
 <xmqqy0zxz11m.fsf@gitster.g>
 <Z3KzHJagr_3Fkz67@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Z3KzHJagr_3Fkz67@pks.im>

On Mon, Dec 30, 2024 at 03:50:04PM +0100, Patrick Steinhardt wrote:

> On Mon, Dec 30, 2024 at 06:40:53AM -0800, Junio C Hamano wrote:
> > Patrick Steinhardt <ps@pks.im> writes:
> > 
> > > By definition, two files cannot collide with each other when one of them
> > > has been removed. We can thus trivially fix the issue by ignoring ENOENT
> > > when opening either of the files we're about to check for collision.
> > 
> > Thanks for digging it down to the cause.
> > 
> > It is more like even if these two files collided (i.e. have the same
> > name based on what the hash function says, with different contents),
> > when one of them has been removed, we have no way to check if the
> > collision is benign, and even if it were not, we cannot do anything
> > about it, isn't it?
> 
> Depends on what "benign" means in this context, I guess. We can only
> assert the most trivial case of it being "benign", namely that we have
> computed a packfile that actually is the exact same. This is also going
> to be the most common case, as everything else would depend on a
> cryptographic collision of the packfile contents. And in that case... we
> cannot do anything about it, yes.

There is one gotcha here, though. We call this collision check only if
we got EEXIST trying to move the tempfile into place. If the destination
file then goes away, we can't do the collision check. But is it right to
quietly return success?

If the contents of the two were the same, that's fine. We don't need the
extra copy.

But if the contents were not the same, we'd prefer either to actually
copy the contents into place, or to return an error.

Of course we can't know, because the destination file has gone away. In
the common case they will be the same, but the whole point of this check
is to allow loosening the cryptographic collision of the packfile
contents. So the safest thing would be to retain the tempfile, copying
it into the destination file. That errs on the side of keeping data when
we cannot make a determination.

IOW, if we see ENOENT on filename_b, should we then loop back in the
caller to try the link() again?

> > I do like the simplicity of the solution.  I wonder given bad enough
> > race, we could fall into a case where both files are missing?
> 
> I was wondering about that, too, but it would very much feel like a bug
> to me if that were ever to happen. So I briefly considered whether I
> should treat the passed-in filenames differently: 
> 
>   - One that must exist non-racily. This is our temporary object or
>     packfile that we want to move into place.
> 
>   - And one that may have been removed racily. This is our target file
>     path that we want to overwrite, unless there is a collision.
> 
> The idea would be to only handle ENOENT for the second case. But in the
> end I don't think it's worth the complexity because `check_collision()`
> is used before rename(3p)ing the former into place, and that function
> would already notice ENOENT anyway. So we would eventually just die the
> same.

I think check_collision() is used _after_ the attempt to rename() into
place. So there's a race when the tempfile goes away, but I think the
outcome is made a bit worse by your patch.

Consider a sequence like this:

  a. Process A writes tmp_pack_foo.

  b. Process A tries to link tmp_pack_foo to pack-<hash> but finds it
     already exists.

  c. Process A opens both tmp_pack_foo and pack-<hash>.

  d. Process A compares the two byte-for-byte, and then returns
     success/failure based on whether they were actually identical.

Now imagine there is a process B that deletes the file (maybe an
over-zealous "gc --prune=now" deletes the in-use temporary file):

 - if process B deletes it between steps (a) and (b), process A returns
   an error (there is nothing to link). The caller knows that the data
   was not stored.

 - if process B deletes it between (b) and (c), then before your patch
   we see an error (because we can't compare the files). After your
   patch, we continue on and return success. The caller knows the data
   was stored (via the original file, not our new copy).

 - if process B deletes it between (c) and (d), then process A has no
   idea. But at this point it does not matter. If the files were
   identical, we return success (and in fact, process A deletes the file
   itself). And if not identical, then we return error, and the callers
   knows the data was not stored.

So even though the exact behavior may depend on where we hit the race, I
think ignoring an ENOENT open() error on the tempfile meaningfully
changes what happens in the middle case.

In practice I don't really expect this to happen, and "gc --prune=now"
is inherently risky in a live repository. But I think we're probably
better off to continue treating it as an error if we can't open our own
tempfile.

-Peff
