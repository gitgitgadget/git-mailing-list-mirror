Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87D1541F7EC
	for <git@vger.kernel.org>; Thu, 30 Jul 2026 11:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785412669; cv=none; b=GhxveyZ88o4o+d4lrptBg3QtbEbzIQbVmVlfgtEiZPJ4YdlbR42xZ2RHLUQ5bgX4mD0pk3lgHO9BA6KPLm7kV2rU91s1gvuVh0YfqRWwCUxaDLNmU2kOIe8YeBUSVnDD0qmdJEXfc1/zOe74oeMwvWMWuzbVU/my+a8vZ6DcgSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785412669; c=relaxed/simple;
	bh=dSQ1BGR31zVokgTUQhKkPwJES/08nVZocbccMz4QZsU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gpd9MDZbaIiNobh1ZIZ57Aw64mjOk8leH63UJz8yMar4kvh7FSNtbGn9UAa8qsfEwd6q0J54a3qAS2hLBl2t+drAkc3GRe9CMo3NRWu9M5eJF+KpfcaP3uvVSfirngHGyLnTNiHuVKUaaWA8e4bMFfS3a383VSZAdumQ59dXbrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=D4MTXWHB; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="D4MTXWHB"
Received: (qmail 10915 invoked by uid 106); 30 Jul 2026 11:57:46 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=dSQ1BGR31zVokgTUQhKkPwJES/08nVZocbccMz4QZsU=; b=D4MTXWHB2mfNaaK+78LM/PAsZilekRjJAy6208nDcpJXUE0ig++De+rys33EJ8s6CGf/mX+NMiMw9a65eqHcLD8d2BlaeEuIf8RNk50aBjSHGlOQM7BuB785XuHr00nqoyUDu5K50ecN8xv5ig13VyvKLyyceD8EeYNXPy/2cZGvOPVvhUBc2T/uf4wHvpr+JfR3jQgbKgl9jAh/ztPP9k0i8tjPshSXwfdq1pDB9c+LcbKTTql2hyUhnTqAoosufaHQTXEZhhSsPZ5//QOFJq4Dsez11rt/eP+RZxMSfa1cq1S23KSUtOIVsjHzHhXdxnxVZ4Zki9SioofKUlaCvg==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 30 Jul 2026 11:57:46 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 19240 invoked by uid 111); 30 Jul 2026 11:57:46 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 30 Jul 2026 07:57:46 -0400
Authentication-Results: peff.net; auth=none
Date: Thu, 30 Jul 2026 07:57:45 -0400
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>, git@vger.kernel.org
Subject: Re: [PATCH] Makefile: read configuration earlier
Message-ID: <20260730115745.GB1871609@coredump.intra.peff.net>
References: <20260728135532.GA11894@coredump.intra.peff.net>
 <20260729225944.1364947-1-sandals@crustytoothpaste.net>
 <xmqqh5lhm82g.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqh5lhm82g.fsf@gitster.g>

On Wed, Jul 29, 2026 at 09:10:15PM -0700, Junio C Hamano wrote:

> This is a scary patch because its correctness depends on what is
> between lines 780-1050.  It turns out that this now lets config.mak*
> to set quite a lot of symbols to affect the outcome:
> 
>  * PROGRAM_OBJS, BUILT_INS, TEST_BUILTIN_OBJS
>  * WITH_BREAKING_CHANGES
>  * SHELL_PATH
>  * PERL_PATH
>  * PYTHON_PATH
>  * NO_RUST
>  * DEBUG
>  * uname_S?????
>  * SPARSE_FLAGS
>  * SPATCH_INCLUDE_FLAGS

Yes, though to some degree config.mak can already manipulate those after
the fact. There are other breakages, though (see the CFLAGS one I showed
elsewhere in the thread).

> Especially curious is that currently there is this bit:
> 
> 	ifeq ($(uname_S),Windows)
> 	RUST_LIB_NAME = gitcore.lib
> 	else
> 	RUST_LIB_NAME = libgitcore.a
> 	endif
> 
> that comes WAY BEFORE config.mak.uname is included.  If the location
> to include these files matter, then how could this bit have been
> working?  I have no idea and since I have no access to Windows
> development box so I wouldn't know.

Yeah, that seems totally wrong to me. Likewise this bit right above it:

  ifndef NO_RUST
  ifdef DEBUG
  RUST_BUILD_CONFIG = debug
  else
  RUST_BUILD_CONFIG = release
  endif

has the same problem brian is fixing for BREAKING_CHANGES. It will work
for "make NO_RUST=1", but not if you put NO_RUST into config.mak. That
said, I don't know why that NO_RUST check is there at all. It is not a
problem to set a flag that nobody looks at. So it may be a bug without a
visible effect. ;)

-Peff
