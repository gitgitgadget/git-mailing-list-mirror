Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDF0283CA3
	for <git@vger.kernel.org>; Thu,  7 Mar 2024 09:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709804832; cv=none; b=SAbrK4FS8/QQkSgyRi+b+pRCrV4cxqxfQDLuzdwnyTchAupu9CvIWNgwUzy34eTqY1FiiVC66FQkUNZEO077ZMEQe/HJP9tS8I09qMxiptYq2sYd9Z1PnBcBMwh5iWPNfCkz3OAw6BYsXfDKmPlPl6M4UJy/+MBCGQ/tYLCiTN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709804832; c=relaxed/simple;
	bh=flE/lqYoGJiC5UNaTdcOM606vdmUeeSOBuMWoJY0qVk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tJCWfTPhGzfW4ezTiaeMxpLAqp6dMuCR4ooXmGDWln6gCcLQkJW84a3NJurBaQmll4hoYmCaXcORSdStuugNJkLaMTMaN2Jmp0f6VKJgU+hXhUYHEKPZIrvVetX96l6aje7MpwXfyCarSL4nIu2hHuSiMbqQC0NuVibv44BZtAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 7163 invoked by uid 109); 7 Mar 2024 09:47:09 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 07 Mar 2024 09:47:09 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 12871 invoked by uid 111); 7 Mar 2024 09:47:14 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 07 Mar 2024 04:47:14 -0500
Authentication-Results: peff.net; auth=none
Date: Thu, 7 Mar 2024 04:47:08 -0500
From: Jeff King <peff@peff.net>
To: M Hickford <mirth.hickford@gmail.com>
Cc: Bo Anderson <mail@boanderson.me>,
	Bo Anderson via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org
Subject: Re: [PATCH 0/4] osxkeychain: bring in line with other credential
 helpers
Message-ID: <20240307094708.GA2650063@coredump.intra.peff.net>
References: <pull.1667.git.1708212896.gitgitgadget@gmail.com>
 <20240218204044.11365-1-mirth.hickford@gmail.com>
 <CFC1A507-A9EF-4330-8C98-34C2B73BC036@boanderson.me>
 <CAGJzqs=wQA=t4CMVu-kap1ga4DX+KnaVMGy71ewmZ7QkFHF8sg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAGJzqs=wQA=t4CMVu-kap1ga4DX+KnaVMGy71ewmZ7QkFHF8sg@mail.gmail.com>

On Mon, Mar 04, 2024 at 08:00:00AM +0000, M Hickford wrote:

> > It definitely makes sense in principle. Though the concern perhaps
> > will be that any new features added to the credential helpers and
> > thus its test suite would need adding to each credential helper
> > simultaneously to avoid failing CI. Ideally we would do exactly
> > that, though that requires knowledge on each of the keystore APIs
> > used in each of the credential helpers.
> 
> Good point.

I think we suffer from that somewhat already. You cannot run t0303
successfully against credential-store anymore, as of 0ce02e2fec
(credential/libsecret: store new attributes, 2023-06-16).

There is some prior art in the GIT_TEST_CREDENTIAL_HELPER_TIMEOUT
variable, as time is not a concept to every helper (like store, for
example). Other new tests like the password-expiry and oauth features
could be gated on similar variables. That would help non-CI users
testing helpers manually, and then CI jobs could set the appropriate
switches for each helper that they cover.

All that said, I'd be surprised if testing osxkeychain in the CI
environment worked. Back when I worked on it in 2011, I found that I had
to actually run the tests in a local terminal; even a remote ssh login
could not access the keychain. It's possible that things have changed
since then, though, or perhaps I was imply ignorant of how to configure
things correctly.

-Peff
