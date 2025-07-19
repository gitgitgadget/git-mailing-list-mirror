Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49A0C225A3B
	for <git@vger.kernel.org>; Sat, 19 Jul 2025 06:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752907520; cv=none; b=mGXPj0+TDXk7h8GDaq6XzJ5eH4wr0eFAb2LAcB87H6LsvxktGMe3BEs46NHsuIQdqMNBBhb0ZQKdCyX1pl9R2cJD0nX1LcEcJxRGrJPh+R9E50FunA4VajwiYJQoK/v85LodmPy4z77zhefSB0B5m4L9O2C08N2wuk2AXMshxq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752907520; c=relaxed/simple;
	bh=IAAq3n/YArMWwlwCtcPdkQT8vjMeX8XjRgPNRdZfTHg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HqjJb94DUjQ8YBtXeBccL99ih17kz0aphwZF/lPhDn33XLLUogphgxhYWEw5f4uDsx/osGmaq+fAIANJlhwStAmqHEeD3MKhqfLoQp4o+BGbxv+nOo1inAeEZKgow7ri1GWagQsDwtv6eP+bfWA7sZxCPx0AEy4Eftt9BxgxcAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=eYPhyboA; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="eYPhyboA"
Received: (qmail 27162 invoked by uid 109); 19 Jul 2025 06:45:17 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:content-transfer-encoding:in-reply-to; s=20240930; bh=IAAq3n/YArMWwlwCtcPdkQT8vjMeX8XjRgPNRdZfTHg=; b=eYPhyboA+UJSWR4JAywolEK+PUDg6iuKRzS43gy+18KmJmRT7YN9Q/RQ7deyiC5co1OG8gzG2tyZmTKfuIYsHLAYA9q1NG+XQdkLKPTlqijeswyGjVp2e0KNAV+DVJYylru+EXKk/69OyxMpunsTCmivli5Z0621tZbYH2SFcUAEUfYKiQhHRsmKrY4wotIiq9z93Qu3HwUXfhWNlRP2g6Ni/cFAaSTLoX+OTMZyZXOewSWUVDmy18HSIH8Mx5yuAA18VUL1t+76Toqn93sG+Oqc1e5C9kQzdJWjoBkDX2X7zKpD8dEQkXbGaSpbUvSFuXJK21SIsk1KibCp9DWX7w==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 19 Jul 2025 06:45:17 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 4424 invoked by uid 111); 19 Jul 2025 06:45:21 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 19 Jul 2025 02:45:21 -0400
Authentication-Results: peff.net; auth=none
Date: Sat, 19 Jul 2025 02:45:16 -0400
From: Jeff King <peff@peff.net>
To: =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
Subject: Re: [PATCH 0/3] commit: convert pop_most_recent_commit() to
 prio_queue
Message-ID: <20250719064516.GC705356@coredump.intra.peff.net>
References: <bc079b3c-a472-4f5d-95ca-390f9de25196@web.de>
 <xmqqv7ntdmlx.fsf@gitster.g>
 <20250716051533.GD1396022@coredump.intra.peff.net>
 <5a25d830-0825-4b28-8763-2be342d2b6a3@web.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5a25d830-0825-4b28-8763-2be342d2b6a3@web.de>

On Wed, Jul 16, 2025 at 11:38:39AM +0200, René Scharfe wrote:

> Yes, commit_list_insert_by_date() is stable, as it inserts commits after
> ones with the same date.  Items are popped from the top, so this ensures
> FIFO behavior for commits with the same date.
> 
> prio_queue ensures stability using an ID and favors lower ones, so it
> provides the same order.
> 
> We should add unit tests for that, no?

Probably wouldn't hurt to do so, but I don't think doing so needs to
hold up your series.

-Peff
