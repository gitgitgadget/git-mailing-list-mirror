Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1661A17C9F1
	for <git@vger.kernel.org>; Sat, 18 Jan 2025 09:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737192235; cv=none; b=OgvRedx4LLmuL75xb57YAI/v/GTfKlaEXVVRBHECfd7EkuiTVN+adzOfnakZxMto3s39ywYV/LOY93OSiqGTmHdyyY8ABRAYbn8JpGusKulqseyUgILD15T/kWD0M2F9QuucKLCXQP3lKofyd7iZXoUCVW/NtyvV4upNXDF906Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737192235; c=relaxed/simple;
	bh=zJFHs98zeKaZpRJk1JLeNpJgO7a75XtlLFcVxneSO6Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DD19/V1Esdjshgde+FWjhLr3Xd3fxG0WPWhMkCjje2MSRt8mFoBVRUC+VFUxnpUBg+niKsgnRGLf7Yj7ch+CmAH/4XjwPGEi6CjMtmwvqOvwE6N+0OoDQ67WiWiMWoJoKY5usrl4CNbchH2KDIKomGbgp2wUiLSK1Xp1n/cXJfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=VdanbXLl; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="VdanbXLl"
Received: (qmail 30152 invoked by uid 109); 18 Jan 2025 09:23:52 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=zJFHs98zeKaZpRJk1JLeNpJgO7a75XtlLFcVxneSO6Q=; b=VdanbXLlRmpAV0mvgbsmy8dalFsAYOJd6dH/1FmS60+zw0amI0D6PezRlYJ1wV3skcw2nGuxh22gYJwmeh3G50IcUePZEne2w1hKlKSRQILBjpHgsJMzVl0ku/wjdaQCEOtubpSyvoU7IdDxesOMqs4pv/hqEbiL0v3jzltKm8EZHhF2cxM2uCP2APc9/vj1Mi9qgT8cMZPovYQQBDW8/XI+6FdYaagnByKLXbpLEY0K8ztsIIhFSBBXkJCLRCllNe7co4UScbCxrzm58eeGGWf4HT/RRFLtDMEbRM3g2VWH97dAU4GeVWCsreiLj67SRP5T5Y6/2H5IZx+fcw9sQg==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 18 Jan 2025 09:23:52 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 18995 invoked by uid 111); 18 Jan 2025 09:23:56 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 18 Jan 2025 04:23:56 -0500
Authentication-Results: peff.net; auth=none
Date: Sat, 18 Jan 2025 04:23:51 -0500
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: Koakuma <koachan@protonmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [PATCH 1/3] packfile: factor out --pack_header argument parsing
Message-ID: <20250118092351.GB3474411@coredump.intra.peff.net>
References: <20250117125207.GB2356599@coredump.intra.peff.net>
 <20250117125459.GA2893666@coredump.intra.peff.net>
 <xmqqo705hxfz.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqo705hxfz.fsf@gitster.g>

On Fri, Jan 17, 2025 at 02:45:04PM -0800, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> >  			} else if (starts_with(arg, "--pack_header=")) {
> > -				struct pack_header *hdr;
> > -				char *c;
> > -
> > -				hdr = (struct pack_header *)input_buffer;
> > -				hdr->hdr_signature = htonl(PACK_SIGNATURE);
> > -				hdr->hdr_version = htonl(strtoul(arg + 14, &c, 10));
> 
> Interesting.  So the file-scope static input_buffer[] sits in the
> BSS and happens to be well aligned not to cause the problem, but ...

I suspect it _is_ a problem, but either:

  - The OP's test case was small enough to trigger unpack-objects, not
    index-pack. Possibly:

      git index-pack --stdin --pack_header=2,2 <no-header.pack

    would fail for them.

  - We simply got lucky with alignment based on the other things in BSS,
    the whim of the compiler, etc. But it is an accident waiting to
    happen.

-Peff
