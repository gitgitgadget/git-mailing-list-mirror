Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C113282F3C
	for <git@vger.kernel.org>; Sun, 26 Jul 2026 10:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785061636; cv=none; b=uCVp24R513iOQ5uBYdVsD4LafWCipD9MT/xACWrULpwNR9RaNKrvl8LqN3V9llBG4w+0ZiKLflAggxW/R14bXRmwZ6PnuwP9JX/lK1oIKZNppvlhOlEzNGK+B24wCoc+PADpUtA9S5TVCDtu1o48YAivYfE5yw1uK94NO4J9Fn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785061636; c=relaxed/simple;
	bh=qOPYEufIRwSaOubbjpMciF7Iux3ioOhauwjI51uJPmQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g94O4kbIwuabJ1J/W1wSC0lYon3DgdfrJWG1wm7cXslfRwgp7vzz2CJrWVZ9zJA0nRS9stRptZ1nnh63TQs3kp1EYOLAJpSIvuCeZgM8vN3KeF1RkzSQX+s3DLHEHTvXIWZ5GFIrN4EoE15xGbz6ir0/PobmH5xJjSCXdVrPDVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=HMqixY5h; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="HMqixY5h"
Received: (qmail 57808 invoked by uid 106); 26 Jul 2026 10:27:13 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=qOPYEufIRwSaOubbjpMciF7Iux3ioOhauwjI51uJPmQ=; b=HMqixY5hTG1ovLFLDQQUEYXxrw08HVLquGw/Dkt1mHgJX157bPZaLJBPaT5dvSkWlgKlHks7aPJ+OaNd4+N/o7XdjsDmNJyhC2bd76pUDnY6QmFmbk/vC5FZ2JQqtZjUG3JUuEl+hc7jI1YRjokyF/Bj8ZqU59aZ4iVAQWq3lvNTXpdfFssW+4NAcX5NxV5mhzNWIDMEv3hQDZ96Uk3T4TW+deV76pkk7OdMfwa7Fq44+rWfI4zF4ztlgObGxnCkdkZ+zLFQ9UpcwTyzSiB+uBaVjlCyZAFxWu5qlpWI6aGZSpfM+DnBjYXSdi4sRcHX2Qx3gTfDAeAF/5G+LkJuzg==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sun, 26 Jul 2026 10:27:13 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 59119 invoked by uid 111); 26 Jul 2026 10:27:18 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sun, 26 Jul 2026 06:27:18 -0400
Authentication-Results: peff.net; auth=none
Date: Sun, 26 Jul 2026 06:27:12 -0400
From: Jeff King <peff@peff.net>
To: Ted Nyman <tnyman@openai.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v5 2/3] http: avoid concurrent appends to partial packs
Message-ID: <20260726102712.GA3535709@coredump.intra.peff.net>
References: <20260726092027.GA3529827@coredump.intra.peff.net>
 <20260726100421.12648-1-tnyman@openai.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260726100421.12648-1-tnyman@openai.com>

On Sun, Jul 26, 2026 at 03:04:21AM -0700, Ted Nyman wrote:

> On Sun, Jul 26, 2026 at 05:20:27AM -0400, Jeff King wrote:
> > I wonder if we still need this or not.
> 
> I think so, but wouldn't bet the farm on it. A concurrent downloader can
> complete the staging file before another downloader issues its Range
> request. That request then starts exactly at EOF, so the server can
> respond with 416. The existing regression test exercises that case, and
> we still need to let index-pack validate the completed local pack.

Yeah, the big question there for me is whether a server would return a
416 in such a case. It seems reasonable that a client might know it has
N bytes but not the full size, and ask for "N-", expecting to get some
equivalent of a 0-byte read(). Whereas a 416 does not make it clear at
all whether the range is nonsense, or if you happened to be at EOF.

But sadly we do not seem to live in that world, based on a few tests. So
I agree we do need it to cover that edge case.

If you are splitting things out of the patch, can we do the same for
this 416 handling? It is already a problem even without concurrency if
you happen to get the full file but then fail for other reasons before
indexing the pack (transient system errors, etc).

To be clear, I can live with things as they are and I don't want to make
too much work for you in splitting. But I'm hoping that feeding it to an
electronic friend could do that split without much effort.

> > That is...subtle as hell. I really wonder if it would be worth
> > introducing the basic form of this (just opening once with O_RDWR) and
> > then doing the Windows hackery on top as a separate commit.
> 
> I'm certainly not an expert on the Windows side, so I had to track this
> down in the MinGW open() wrapper. The existing-file O_RDWR path includes
> FILE_SHARE_DELETE, while creating a new file falls back to _wopen()
> without it. The loop creates the file with O_EXCL if needed, closes that
> descriptor, and retries through the existing-file path; a racing creator
> that sees EEXIST also retries.

Yeah, I understand it now after reading the commit message and the code
several times. The loop is what I think is subtle, but I can't see a
more obvious way of writing it that deals with all of the possible
combinations and races.

> I kept those pieces together to avoid an intermediate state without the
> required sharing behavior on MinGW, but I'm happy to split them if you
> think it would be clearer.

IMHO it is the lesser of two evils. Not because we won't eventually end
up with the subtle loop, but because it helps make the desired change in
the "simpler" version much easier to see. IOW, the Windows patch is
always going to be confusing, but we can at least salvage the original.

> > Hopefully this perl script (and the accompanying fifo monstrosities)
> > can sit here for eternity un-looked-at by human eyes, just quietly
> > doing their job until the heat death of the universe.
> 
> I thought you, of all people, might appreciate a little more Perl. ;-)

Well, if we have to write something like that, obviously Perl is the
right choice. ;) It's more the custom socket handling. E.g., there are
sometimes subtle issues around listen-port allocation, especially when
we run the same test concurrently with --stress. Your script solves it
by asking for a dynamic port and then passing that back to the caller
over the fifo. That should work reliably, I think, it's just not our
usual solution (but usually we are constrained to having to tell apache
the correct port up front, which means we need to pick an unambiguous
one ourselves).

-Peff
