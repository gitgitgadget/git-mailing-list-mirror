Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 913B11EB487
	for <git@vger.kernel.org>; Thu,  1 Aug 2024 06:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722492497; cv=none; b=rUt8cCfnYaMsL9C4HLZWNG3JsbeODN73PppEgguX0W1yYLs3KLfBW9sT5m2CAVartSMuMQj3ZW5xB6Db6/Y1KZ6+OogUtPEhEoJQlvIRXifzNOouj8USF5R8doZ9zu7A3/P1e+PQvXSqM3U5qSQ1MZTdQ/Co3GGvsuebTKm9SbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722492497; c=relaxed/simple;
	bh=yEfwblmB6yzpUu7ov+vlzFXk2Y0ybw42YRTq7bRezoA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XAUOiv9meQMqiZfh5AqhBrmcD77iLeBA7tg78QWshrydDh/Y1BJQyatom1zMRtbjZYntXep8DfFVCuP0SXQYgZ+1Kk1lgI4WupGE69T0rWv4Jv7Pb+NO7FVr5fmoPFm/crErdjr7fIoa0B2eDApaZnI/hagDyT01uaUEMyCB+M0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 14837 invoked by uid 109); 1 Aug 2024 06:08:14 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 01 Aug 2024 06:08:14 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 27548 invoked by uid 111); 1 Aug 2024 06:08:18 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 01 Aug 2024 02:08:18 -0400
Authentication-Results: peff.net; auth=none
Date: Thu, 1 Aug 2024 02:08:13 -0400
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>,
	"W. Michael Petullo" <mike@flyn.org>, git@vger.kernel.org
Subject: Re: Git clone reads safe.directory differently?
Message-ID: <20240801060813.GC621899@coredump.intra.peff.net>
References: <ZqUc8DJ1uKcHYlcy@imp.flyn.org>
 <20240727215845.GA1263246@coredump.intra.peff.net>
 <ZqZjRMqpEV_3WIkD@imp.flyn.org>
 <20240728224807.GA1299337@coredump.intra.peff.net>
 <ZqjQi6i2kiY4gcc1@imp.flyn.org>
 <Zqlo-i8uCb1Yr4Jm@tapette.crustytoothpaste.net>
 <xmqqv80m8pha.fsf@gitster.g>
 <ZqlxtGIyz0G9jlJr@tapette.crustytoothpaste.net>
 <20240731072832.GB595974@coredump.intra.peff.net>
 <xmqqo76d7coa.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqo76d7coa.fsf@gitster.g>

On Wed, Jul 31, 2024 at 09:23:49AM -0700, Junio C Hamano wrote:

> > And then upload-pack
> > could be free to drop the ownership check. Certainly a lot of people
> > have complained about it (I had actually thought we reverted it in
> > v2.45.2, but that was just the extra hooks defense-in-depth; so again, I
> > may be getting confused about the extra value of the enter_repo()
> > ownership check that came at the same time).
> 
> As enter_repo() is about the protocol driver thing and not about
> normal users working inside a repository, calls to it appear only in
> receive-pack, upload-pack, upload-archive, http-backend, and daemon.
> 
> Among them, upload-pack is the only thing we promise that is safe to
> work even in a hostile repository?  If we push into a repository
> over the local transport, we would trigger post-receive hook as
> ourselves, which we would probably not want.  The same story goes
> for daemon, http-backend, and upload-archive.

Yes, upload-pack is the only safe one.

> So we probably need to add another axis to the "strict" parameter
> enter_repo() takes to selectively disable the ownership checks only
> for upload-pack, or something like that.

Agreed.

> We may want to restrict "tar.<format>.command" only to protected
> configuration and then we may be able to loosen the ownership check
> for the upload-archive command.

Yes, though I don't now how valuable that is in practice (versus the
regression for folks who have a custom tar.*.command in their local-repo
config).

-Peff
