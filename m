Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B40E3209
	for <git@vger.kernel.org>; Wed,  1 Jan 2025 18:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735755604; cv=none; b=FlKySH9BrPNvJ1TOzEQppL2sB2rgFDbygNDjJRY/9e+ffMeAaAp9cbDj89xPIYzvXHbXDxXLyuvy8WTFH1I2dRsj7uaHFTHgSjaKKCFHFqf7/xjm3fMsOBPMaAAF9BvsG878yphMjO3yY0hG7JtUyULWjGo0+DXDV85efDYa6Os=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735755604; c=relaxed/simple;
	bh=dW7OwkM4AG2GrvskayQ7s6Xgdin3zyOaNwObX1DaNCw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oBnbo/gF7y/o3acxciWtcZyNC07Rsb0F8eUs7u764ZfOlgKGsNwxGyTI00JxSQGkxPgrMFlCKSIER7EKL41lQzAw3hGMMUg1r9q9tsroEUU93axRx6Wz5CzdSCl7KsR/324cRCVTY0+k388EMj0L1G8tKZlzZNsCDQSqL8Ddv0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=gPInF1et; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="gPInF1et"
Received: (qmail 20760 invoked by uid 109); 1 Jan 2025 18:19:55 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=dW7OwkM4AG2GrvskayQ7s6Xgdin3zyOaNwObX1DaNCw=; b=gPInF1etIF++gF1jHWHy6oZV138n0yYG7fs/tGhSo59mS+TbxLRl1JMexwrwTBxi15a4YusuujhqP9etEs8DL/T/piqVDnySqR3i1gZ9JwIYe3VrCFSH+h8XA+iBHpQqrBPIBK1nNyJCWpgkB/SdtneqnN7jYwXztcFRtM3mofAj3ReeKJ/FqFKG9+xkgB2rHnApUowonpj/9X5DLpeF6YWgCbMsYlKjF7VdU/Vf6G2Ba5FtF1JLkuhfCQYKYwEMDvAReTFQsEBDDDByFdQBeu6yfIkI9TvWWs/c6E+l6bstJRhJsJZLDTxSDrbRGcHDynZRNofOiuaddEpID0rKig==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 01 Jan 2025 18:19:55 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 10474 invoked by uid 111); 1 Jan 2025 18:19:52 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 01 Jan 2025 13:19:52 -0500
Authentication-Results: peff.net; auth=none
Date: Wed, 1 Jan 2025 13:19:52 -0500
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org,
	Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH] object-file: fix race in object collision check
Message-ID: <20250101181952.GA1391912@coredump.intra.peff.net>
References: <20241230-b4-pks-object-file-racy-collision-check-v1-1-11571294e60a@pks.im>
 <xmqqy0zxz11m.fsf@gitster.g>
 <Z3KzHJagr_3Fkz67@pks.im>
 <20241231014220.GA225521@coredump.intra.peff.net>
 <xmqq7c7exytw.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq7c7exytw.fsf@gitster.g>

On Wed, Jan 01, 2025 at 08:50:51AM -0800, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > There is one gotcha here, though. We call this collision check only if
> > we got EEXIST trying to move the tempfile into place. If the destination
> > file then goes away, we can't do the collision check. But is it right to
> > quietly return success?
> >
> > If the contents of the two were the same, that's fine. We don't need the
> > extra copy.
> >
> > But if the contents were not the same, we'd prefer either to actually
> > copy the contents into place, or to return an error.
> >
> > Of course we can't know, because the destination file has gone away. In
> > the common case they will be the same, but the whole point of this check
> > is to allow loosening the cryptographic collision of the packfile
> > contents. So the safest thing would be to retain the tempfile, copying
> > it into the destination file. That errs on the side of keeping data when
> > we cannot make a determination.
> >
> > IOW, if we see ENOENT on filename_b, should we then loop back in the
> > caller to try the link() again?
> 
> Yuck, I think you're absolutely right.

So I think this part, if adjusted as I suggested, would fix the race in
the tests without making anything worse (it's just more code).

And then this...

> > I think check_collision() is used _after_ the attempt to rename() into
> > place. So there's a race when the tempfile goes away, but I think the
> > outcome is made a bit worse by your patch.
> >
> > Consider a sequence like this:
> >
> >   a. Process A writes tmp_pack_foo.
> >
> >   b. Process A tries to link tmp_pack_foo to pack-<hash> but finds it
> >      already exists.
> >
> >   c. Process A opens both tmp_pack_foo and pack-<hash>.
> >
> >   d. Process A compares the two byte-for-byte, and then returns
> >      success/failure based on whether they were actually identical.
> >
> > Now imagine there is a process B that deletes the file (maybe an
> > over-zealous "gc --prune=now" deletes the in-use temporary file):
> >
> >  - if process B deletes it between steps (a) and (b), process A returns
> >    an error (there is nothing to link). The caller knows that the data
> >    was not stored.
> >
> >  - if process B deletes it between (b) and (c), then before your patch
> >    we see an error (because we can't compare the files). After your
> >    patch, we continue on and return success. The caller knows the data
> >    was stored (via the original file, not our new copy).
> >
> >  - if process B deletes it between (c) and (d), then process A has no
> >    idea. But at this point it does not matter. If the files were
> >    identical, we return success (and in fact, process A deletes the file
> >    itself). And if not identical, then we return error, and the callers
> >    knows the data was not stored.
> >
> > So even though the exact behavior may depend on where we hit the race, I
> > think ignoring an ENOENT open() error on the tempfile meaningfully
> > changes what happens in the middle case.
> >
> > In practice I don't really expect this to happen, and "gc --prune=now"
> > is inherently risky in a live repository. But I think we're probably
> > better off to continue treating it as an error if we can't open our own
> > tempfile.
> 
> So we'd ignore the racy and flaky tests, as hiding the flake by
> ignoring the error would only hurt the real world users.

...is all about ignoring ENOENT on the tmpfile itself. And I think we
can just drop that hunk entirely. The tests do not care here (they are
running simultaneous gc, but _not_ a simultaneous "--prune=now" gc).

-Peff
