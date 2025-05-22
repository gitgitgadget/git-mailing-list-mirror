Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 358F12914
	for <git@vger.kernel.org>; Thu, 22 May 2025 05:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747891711; cv=none; b=YBdPVdPqaUVhBvIl/vQadUAK5tanTSVAngUfXkEpKbM4D0d7wlbv7PY8i+WnkShw76NizgL2pzTRXrYH32766NuPcqXveiqII01rs4cz5nWgO0LDvrX+DsA326Zy3i4tjgOJZly6fFqKYojACfq4e24oFY8jtselWG6F1BcfLaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747891711; c=relaxed/simple;
	bh=Pzpn7zmB6pkCRQFA2deWqRn36gk2b+RC6InvuxwG5Oo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ENesup/2Sx0iqbvuI0GGLrVYPDUeFLBdyYBggZM9QuAE6ipChxrTER/D39MRCEUZcsVGcRI4/m4dFzNoTLWNaFcU+QHUngPfY+WEF9RpE9uXE1Ev0hcG9B03XVH78B3zZyKrGhKlsj6q2uHykS+h1YyEMNVmwn5u9v6WUlxwy6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=GMcu3Naj; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="GMcu3Naj"
Received: (qmail 31228 invoked by uid 109); 22 May 2025 05:28:23 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=Pzpn7zmB6pkCRQFA2deWqRn36gk2b+RC6InvuxwG5Oo=; b=GMcu3NajUzGaIgebRqorSwgqMfy6x3uzFRYM2ZylbHyVLOIh1N1+geepIGJ1lDrDCa66fdjUwrDMnolrYOjS/cZ/5fQ9QjJYmoFnEreLdroEvNqgX3dGSAhoEQI4ATFexi70d0yIDCI6sxbczirf2AK10g/RYFng+fUJKFCq1+jxGb+eFsKVlMyFeD8pxb33bbguzrlEdaycrFdKdajwIKIr+Gm3xG+q6Tb5PNr/3AfgS9yu5bI0w4dXC6XKTi/l4mg1h8hGR/KCRvh24Ut+4WublQxX5kvtYE1Xkzr95Drmf31yQMvRh1XTrQIf9u0+dXnZDWbEoJASNR6cwjESFw==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 22 May 2025 05:28:23 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 12201 invoked by uid 111); 22 May 2025 05:28:26 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 22 May 2025 01:28:26 -0400
Authentication-Results: peff.net; auth=none
Date: Thu, 22 May 2025 01:28:21 -0400
From: Jeff King <peff@peff.net>
To: Patrick Steinhardt <ps@pks.im>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH] packfile: avoid access(3p) calls for missing packs
Message-ID: <20250522052821.GA1134267@coredump.intra.peff.net>
References: <20250516-pks-pack-avoid-stats-on-missing-v1-1-e2ef4d8798a3@pks.im>
 <xmqq7c2gv1zx.fsf@gitster.g>
 <20250519065221.GC102701@coredump.intra.peff.net>
 <aCwk8vnK-QCtp9Bo@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aCwk8vnK-QCtp9Bo@pks.im>

On Tue, May 20, 2025 at 08:45:06AM +0200, Patrick Steinhardt wrote:

> Taking a step back though: do we always ensure the order in which we
> those auxiliary files are created and deleted? If we know that those are
> always:
> 
>   - Moved into place before their ".idx" file.
> 
>   - Deleted after deleting their ".pack" file.
> 
> Then reordering may cause us to race indeed so that we see the packfile,
> but miss the auxiliary data structures. `unlink_pack_path()` does seem
> to ensure the latter property, as both ".idx" and ".pack" are deleted
> first. I'm not quite sure about the former, but it seems like we also do
> this.
> 
> So I think that the proposed patch is wrong. There should definitely be
> a comment in that function though to say that this order is intentional
> and not merely an optimization.

Hmm, interesting. Yes, I agree that deleting the .pack before any other
auxiliary files should catch the race, given the ordering on the read
side in add_packed_git().

But I don't think we ever discussed that ordering or its implications.
So I assumed all bets were off with respect to racing.

However, it seems we lucked into doing the correct thing by virtue of
adding to the end of the list in unlink_pack_path() repeatedly (though I
think if you dig all the way back into git-repack.sh, when there were
just .keep files, there were periods where we did it in the wrong
order).

But if we are doing it in the best order, whether correct or not, I
agree we should not disrupt that.

> > [1] There probably are optimization opportunities in add_packed_git(). I
> >     don't think re-ordering will help much in the common case that we
> >     actually do have the pack. But really, most callers do not care
> >     about these auxiliary files at all! We could simply skip them during
> >     the initial setup and lazy-load them via accessor functions.
> > 
> >     I _think_ that should be OK with respect to races. For a newly added
> >     pack, we know they will always be in place before the matching .idx
> >     file (per the logic I outlined above). For a pack that goes away, we
> >     might racily fail to see its auxiliary file. But that is mostly true
> >     now (we might see its .idx, and then the .promisor file is deleted
> >     before we call access()). It does increase the size of that window,
> >     though (and in particular lets it happen even if the pack has
> >     actually been opened).
> 
> I'm not sure it would be okay, as mentioned above. The current ordering
> ensures that we always see auxiliary data structures in case the ".pack"
> file exists. If we started to cache then that wouldn't be the case
> anymore.

Yeah, you're right. I thought it was already racy, but it luckily is
not. It does still feel unfortunate that we have to spend syscalls
loading information that won't be used by most commands, but it may not
be a measurable performance issue. I think if we did want to lazy-load
that information, we'd probably need to do an extra stat() of .pack
afterwards to check for the deletion race (so repack and pack-objects
would pay the penalty, but most other commands would not).

Anyway, that can be explored another day.

-Peff
