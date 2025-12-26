Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E58CC8CE
	for <git@vger.kernel.org>; Fri, 26 Dec 2025 04:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766724322; cv=none; b=TqVeYhrdoNoTd+EaK7K3ieeZohVmKPngSspJmVWW/ligYXOVPWSGJELUo2B91NB/6UCM69kZImFISpu2Uw2FrXa3IY6e+6TWmbiL8tt3AffR9TbZMFL2AB3iJP8rsmLtPQaaOdii0JMuExVlTx+85FGNyyaoDNxufVu4kQBMo68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766724322; c=relaxed/simple;
	bh=+eqL15wiP3wmwTOtllxpWs7oTtRgPs6w9UTwDJitI4w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QacK6/rzXgCBXnB/6rU80MZupEU1EXLxKiJmki0ljicXXP4kGB2gHrvdiR0yP/lcBK5xt0yD/9IhjXyhe22DYavqy57CjOCV14Ljd09WdDhFdLluUvuEXQtrB7u44CLjBp38V9MZkuujCUrf0L1lODlcq/dR8cpuP1VgAwE7wEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=gdHRysUb; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="gdHRysUb"
Received: (qmail 455767 invoked by uid 109); 26 Dec 2025 04:45:13 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=+eqL15wiP3wmwTOtllxpWs7oTtRgPs6w9UTwDJitI4w=; b=gdHRysUb4+3/HLHdnYhJln+lTsHaomPEIuDSDFZ4A5o/F8QFsiHAJaCyIY33VjJhs6xD7OYdxFPaLyZwa4OZXHeMt/3q+VE8Y14gdAP4Ddpb8U1ky0Sev/461rwxQpdAd0KvUAAU2juNrr5XmXhLl16j1ZmtS2aegDqsQNK32wfF1pvxjmksfzwmxGIaWjDAZ0kmB251v18POcKeEN6r+mfQ5n8hGXAJM3xdch0nxqXRkBq1X2FUu42C3qvRpyYmSGMBYcn3cy5QjLCWK5kMHuWXfaShX4nfdSq+QGWGDTKzHHCuZ/3zciqCEKDmBlezY941GB3q7RVnEOj8LhT4mQ==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 26 Dec 2025 04:45:12 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 628439 invoked by uid 111); 26 Dec 2025 04:45:11 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 25 Dec 2025 23:45:11 -0500
Authentication-Results: peff.net; auth=none
Date: Thu, 25 Dec 2025 23:45:07 -0500
From: Jeff King <peff@peff.net>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
Cc: Martin Fick <mfick@nvidia.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Slow git pack-refs --all
Message-ID: <20251226044507.GA1971832@coredump.intra.peff.net>
References: <CH3PR12MB9026B5872FD42F031970074BC2B3A@CH3PR12MB9026.namprd12.prod.outlook.com>
 <aU3K9lGbHw68Vv5U@fruit.crustytoothpaste.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aU3K9lGbHw68Vv5U@fruit.crustytoothpaste.net>

On Thu, Dec 25, 2025 at 11:38:30PM +0000, brian m. carlson wrote:

> I think this is from `should_pack_ref`:
> 
>     /* Do not pack broken refs: */
>     if (!ref_resolves_to_object(ref->name, refs->base.repo, ref->oid, ref->flags))
>     	return 0;
> 
> So Git is going to need to verify that the object at least exists.  I
> don't know why we would need to _open_ them, however.  Perhaps someone
> else has ideas.

The packed-refs file stores tag-peeling information. So pack-refs opens
the object for any newly written ref via peel_object(), which has to at
least read the header to get the type. That call happens via
write_with_updates() in packed-backend.c.

  If we wanted to be really pedantic, anything in refs/heads/ should not
  point to a non-commit and thus should never need to be peeled. I'm not
  sure if we want to embed that assumption in this code path, though
  (nor would it necessarily help Martin's case if the refs are not in
  refs/heads anyway).

-Peff
