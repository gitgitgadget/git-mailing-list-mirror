Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4154225791
	for <git@vger.kernel.org>; Thu,  5 Mar 2026 01:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772673402; cv=none; b=PQIUhDkxkHt6vN7WtW+i/tfOCdHrsOSpZxUrpe0podS5smypWBBDzIGbJTC2Jgb/bMauz1CvlILNcCy4bunTCB495wsCH+GoqEux62gQQl6xZLTmSDvvxMuz9JyXlggvlAxOyfW/1VJ8YaQ3QSRUOlaBRyephql2qBTBPJPODU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772673402; c=relaxed/simple;
	bh=fmO4NoWxV6wSMxr61Wb0fBrpFwwO0Sm4nZkCTVtLhto=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HLRuJDJORvKNMj0YFUmVfNnyKvxX6+OMGs7YTL8hILbvA3yQMQSUIjFs4GvxxTh7gfS6zuk84sFS9Renhg+N8490NSBGwVYjlsuBf4wuZy19iCxJw8+4Jjk6qzxYAIW8sH91yGDlKrwlvwoOiXsa1h6C0a5laKnW351nTrUrLiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=Ev8zie60; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="Ev8zie60"
Received: (qmail 1858 invoked by uid 106); 5 Mar 2026 01:16:39 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=fmO4NoWxV6wSMxr61Wb0fBrpFwwO0Sm4nZkCTVtLhto=; b=Ev8zie609duAifn3UEFGDH/zq47TnXHLd07QSHQbMDS6Ots6aclw7ePoha1/Ropf91noSjTPQd2qsEK0ruAHOc1oXn9ooQDfg6toAtAljPC9uc53T9seDehdF9jOk3dBN7kzOzQL+Y/mp053C7UCbdMfOPl5PLeBZZTtXGRoBoMhJIwfrfqh0TmvMshijT0wmARbxvxWCk/YxrYF7Ryi7/zRS+AKfdkG9xtpLv4ECGYyfmupnXF14CTnfwQnX2pkpIdop58CF4VAnWCUFvvboiRYH8bj7LqvdeGcvBf4433igO5/YkCKO2h/9P09qq+IGPxbDWKPdNEF6+FC2vcfOw==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 05 Mar 2026 01:16:39 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 376273 invoked by uid 111); 5 Mar 2026 01:16:40 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 04 Mar 2026 20:16:40 -0500
Authentication-Results: peff.net; auth=none
Date: Wed, 4 Mar 2026 20:16:38 -0500
From: Jeff King <peff@peff.net>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Matt Smiley <msmiley@gitlab.com>,
	"brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH v2 03/10] upload-pack: reduce lock contention when
 writing packfile data
Message-ID: <20260305011638.GC4943@coredump.intra.peff.net>
References: <20260303-pks-upload-pack-write-contention-v2-0-7321830f08fe@pks.im>
 <20260303-pks-upload-pack-write-contention-v2-3-7321830f08fe@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260303-pks-upload-pack-write-contention-v2-3-7321830f08fe@pks.im>

On Tue, Mar 03, 2026 at 04:00:18PM +0100, Patrick Steinhardt wrote:

> Extend our use of the buffering infrastructure so that we soak up bytes
> until the buffer is filled up at least 2/3rds of its capacity. The
> change is relatively simple to implement as we already know to flush the
> buffer in `create_pack_file()` after git-pack-objects(1) has finished.

This 2/3rds feels kind of arbitrary. Isn't our best bet to try to fill
pkt-lines? Later you say:

> Now we could of course go even further and make sure that we always fill
> up the whole buffer. But this might cause an increase in read(3p)
> syscalls, and some tests show that this only reduces the number of
> write(3p) syscalls from 130,000 to 100,000. So overall this doesn't seem
> worth it.

But I am not clear how it increases the number of read() calls. I guess
you are concerned that we'll get 50k, and then do a read for the
remaining 14k, and then read 50k, and then 14k, and so on. But I'm
unconvinced that 2/3 is really any better here, as it depends on the
buffering patterns of the upstream writer. They could be writing 1 byte
less than 2/3, and we'd wait to buffer, then read half their next
packet, write it, then read the second of of their next packet, wait to
buffer, and so on.

Even just doing:

  git clone --upload-pack='strace -e write git-upload-pack' --bare --no-local . foo.git

with this patch (and not the later one to increase the buffer size of
pack-objects), I see an interesting flip-flop between packets of size
65515 and 61461. But we never send a single full-size one, even though
pack-objects should be outpacing us (because we're slowed by running
under strace). That's probably an OK loss of efficiency in practice, but
it's very dependent on pack-objects buffering.

I'm still a little bit negative on the whole concept of buffering in
upload-pack, just because the interactions between buffering layers can
be so subtle. But I guess I'm not really making any argument that I
didn't make in v1, and you kept this in v2, so I suppose you are not
swayed by it. ;)


If we are going to buffer in upload-pack, there is an obvious
optimization that I didn't see in your series. When we send a keepalive,
we should just send whatever we have in os->buffer (even if it is
nothing).  If we are wasting 5 bytes of pkt-line header and a write()
call to send the keepalive, we may as well send what data we do have.

I don't know how much it would help in practice, though. Most keepalives
will come before the pack data starts, as once pack-objects starts
producing data, it tends to do so pretty consistently. And of course we
can't send os->buffer before we see the PACK header, because the whole
point is to buffer the early bit waiting for packfile uris.

So it might not be worth adding.

-Peff
