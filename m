Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 935D73A9D9F
	for <git@vger.kernel.org>; Wed, 13 May 2026 18:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778698709; cv=none; b=XQOurzfD28kTkqZHdgSCyhPZdW0cHzuKqyFbpmHednh0e9E9aEBSV+JgeRXtSIJjpnPmNiYe3hpPNwRXctkbOTKe4sfRxKfbKVGS3WhqwA84zX7PRBTrOiTwMEJRLWy0/k0TLf9Tf5zPsAaQ2m3tyEZb3a+P0EvNQ7chmBbSs3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778698709; c=relaxed/simple;
	bh=VazroKMAuA3T6PdySgStDpIN8W7DphmyS2BnjdntplU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Lfk48V8AU/xH5HIFtUlremol4/hR8cbn2xanBUUzFiuXIXi/OCLo3+AS+mIBjvWN+eHs7MRyTpM1/IpYGEoO8DoCOD5sh7U2F1/h3pgexbyjvjuasxUTExIAkWf09qTQ/7LWCN10fLbw3RtFEG1ouBddC8NoHUzJ7Gv2SqNjE+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=Ka0KoiTg; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="Ka0KoiTg"
Received: (qmail 40181 invoked by uid 106); 13 May 2026 18:58:26 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=VazroKMAuA3T6PdySgStDpIN8W7DphmyS2BnjdntplU=; b=Ka0KoiTglQEf2ks1skK4pojrz7cvgynMpD3epJHjlt9F7bSQ2um5lKkoaYjgHye3ydOFLwVsjyACFNl+kB8MEys0zz+CGiwPz4DjE9ihgP3CpmQjyWX2uuUMGQeSNwvab0LHeR0hzSXRuo3/AugMNa1WlPYEYbCOMFbmd1S99NZKqbibmJPNHHtFm1S+ov0npajvTNhS2rAwDJnqCMCV5Wna0XvkyXnnIM9cvmzq5h9tQMCoLpolQrerp0eSKf/cBzxzY01pAM2Sg4wPMW16F0/D2kLkGsaVvB1cgJ6T5r02JSir4Nj6jjbDar9vsy7w5qKa636edl8FPNlyID38Zw==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 13 May 2026 18:58:26 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 68721 invoked by uid 111); 13 May 2026 18:58:26 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 13 May 2026 14:58:26 -0400
Authentication-Results: peff.net; auth=none
Date: Wed, 13 May 2026 14:58:25 -0400
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, slonkazoid <slonkazoid@slonk.ing>
Subject: Re: [PATCH] http: handle absolute-path alternates from server root
Message-ID: <20260513185825.GB147423@coredump.intra.peff.net>
References: <20260512162619.GA69813@coredump.intra.peff.net>
 <xmqqo6ikjeqp.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqo6ikjeqp.fsf@gitster.g>

On Wed, May 13, 2026 at 10:10:54AM +0900, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> >           ... Probably in a way that makes it totally invalid, but
> >           if you were very unlucky you could turn something like:
> >
> >              http://victim.com.evil.domain:8000
> >
> >           into:
> >
> >             http://victim.com
> >
> > 	  Which looks like the start of a redirect attack, except that
> > 	  the attacker could just have written "http://victim.com" in
> > 	  the first place! Either way we feed it to
> > 	  is_alternate_allowed(), which is where we check redirect and
> > 	  protocol rules.
> 
> Yuck.  I know I am the guilty party who introduced the dumb HTTP
> walker but I wish we could kill it off after all these years. I did
> not even recall that we supported the alternate object store in the
> "protocol" until I saw this patch X-<.

Me too. It's been the source of many obscure bugs, and I think a couple
of vulnerabilities (even though clients never intend to use dumb clones
in the first place).

We talked about dropping it a few years ago, but Eric countered that
dumb clones are easier on the server in some cases (like gigantic
public-inbox repos that are packed to keep most of the old history in
one big pack that is never updated). The verbatim pack-reuse feature
tries to get smart clones closer to that, but it's hard to beat serving
a static file from the server's perspective. I haven't measured anything
in that area in a while, though.

-Peff
