Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51A401B3B3B
	for <git@vger.kernel.org>; Thu, 29 Aug 2024 19:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724959637; cv=none; b=K17VpQTkByTv46f2jRAZZsWne4jihKPmZcxkoEbMMQEHJEDNDh2FO/tyxmzsBh3aJ5WQho+7J/OhYnjbHoBhHXNNZDCRB7bNYbByqZvagp4+bU2U5Afj9cxKELVEv/ypLzmnRzxyaowIq5AExtW3TKxh+0vqIFUBau4Gytbq2+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724959637; c=relaxed/simple;
	bh=zyv1vkHnvZHXHuufqKyJe0JJizL7xTN5lo4jyp5wwfk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e1f6Jj3GarUzKbLbsYGrFt+ky9wkDO57YC4G5kBsIJaDnaxDHiAD0E1qgbv3XArU+aqeXK2wL811Qd/BSdhS7q7fsHRpasd2Z68rH/BA0VFJRnw1RmK5Bnh/+KRZmHTyp0vXDsnyCF9UFewK/mWrS1ixV5YmHwrXibWMGe+E+rY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 5815 invoked by uid 109); 29 Aug 2024 19:27:14 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 29 Aug 2024 19:27:14 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 9889 invoked by uid 111); 29 Aug 2024 19:27:15 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 29 Aug 2024 15:27:15 -0400
Authentication-Results: peff.net; auth=none
Date: Thu, 29 Aug 2024 15:27:13 -0400
From: Jeff King <peff@peff.net>
To: Taylor Blau <me@ttaylorr.com>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH] fixup! midx: implement writing incremental MIDX bitmaps
Message-ID: <20240829192713.GA423429@coredump.intra.peff.net>
References: <cover.1723755667.git.me@ttaylorr.com>
 <cover.1723760847.git.me@ttaylorr.com>
 <afefb4555750661ffd2c573a33d92f8fcb9f435a.1723760847.git.me@ttaylorr.com>
 <xmqqseuozg53.fsf_-_@gitster.g>
 <20240828183356.GA4043247@coredump.intra.peff.net>
 <ZtDEhNRfXth63SJs@nand.local>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZtDEhNRfXth63SJs@nand.local>

On Thu, Aug 29, 2024 at 02:57:08PM -0400, Taylor Blau wrote:

> On Wed, Aug 28, 2024 at 02:33:56PM -0400, Jeff King wrote:
> > Is that right, though? It looks like the caller might pass in a
> > tempfile name like .../pack/multi-pack-index.d/tmp_midx_XXXXXX,
> > if we're in incremental mode. But we'll write directly to
> > "multi-pack-index-$hash.bitmap" in the same directory. I'm not sure to
> > what degree it matters, since that's the name we want in the long run.
> > But would we possibly overwrite an active-in-use file rather than doing
> > the atomic rename-into-place if we happened to generate the same midx?
> >
> > It feels like we should still respect the name the caller is using for
> > tempfiles, and then rename it into the correct spot at the end.
> 
> In either case, we're going to write to a temporary file initialized by
> the pack-bitmap machinery and then rename() it into place at the end of
> bitmap_writer_finish().

OK, that addresses my worry, if we're always writing to a tempfile (and
I verified with some recent stracing that this is the case). So renaming
that into tmp_midx_XXXXXX.bitmap would just be a pointless extra layer
of renames.

I do wonder if it's possible for us to generate a new different revindex
and bitmap pair for the same midx hash, and for a reader to see a
mismatched set for a moment. But that's an atomicity problem, and an
extra layer of renames is not going to solve that.

> On the caller side, in the non-incremental mode, we'll pass
> $GIT_DIR/objects/pack/multi-pack-index-$hash.bitmap as the location,
> write its contents into a temporary file, and then rename() it there.
> 
> But in the incremental mode this series introduces, I think it would be
> a bug to pass a tmp_midx_XXXXXX file path there, since nobody would move
> it from tmp_midx_XXXXX-$HASH.bitmap into its final location.
> 
> So I think what's written here with the fixup! patch is right (and
> should be squashed into 13/13 in the next round), but let me know if I'm
> missing something.

What confused me is that write_midx_reverse_index() _does_ still take
midx_name, and respects it. But I think that is a bug!

We do not usually even call that function, since modern midx's have a
RIDX chunk inside them instead of a separate file. But if you do this:

  # generate an extra pack
  git commit --allow-empty -m foo
  git repack -d

  # make an incremental midx with a .rev file; usually this ends up
  # as a RIDX chunk, so we have to force it.
  GIT_TEST_MIDX_WRITE_REV=1 git multi-pack-index write --incremental --bitmap

then you'll end up with a tmp_midx_XXXXXX-*.rev file leftover in
multi-pack-index.d (since, as you note, nobody is moving those into
place).

So probably write_midx_reverse_index() needs the same treatment to
derive its own filenames for the incremental case, and to drop the
midx_name parameter.

Or I wonder if we could simply drop the code to write a separate .rev
file entirely? I don't think there's a reason anybody would want it.

-Peff
