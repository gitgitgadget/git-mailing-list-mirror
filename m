Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2146A23CE
	for <git@vger.kernel.org>; Thu, 15 Feb 2024 05:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707975545; cv=none; b=BOzVu+PU657XftcPsoYR+F1R+hm6fiDN+Kq97rQDlZq+FRvu+/jwoEl6MszbU+7ay3Nye9QJp/b73M0aTvWmj4ZqwwyHEnv+nstOJNisSEt+CmSadN18d5oFT9iTtTOU0otgNv3a+d2vMZChS3a7qEAICp9CPPEw1xjO5fhzeZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707975545; c=relaxed/simple;
	bh=amw6YLMncNlkd1McBPQWoebDj48VNsJ4RYzuhGVLuik=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T7CAYfDjT+BtevAcbHNBG39m+rGRAB2W056EJmbzFVkdilJWawD0H6/NGnZzDv27ZvZ0uskCfGVzRANm2bKkhrFPpcQTfD1evI1G3j4kbGPQmv3SpVZP0dnIyz55M42zsCsjc2En6SwTgpyiJDG4kRAdN+eccZCL2ZvpOKP6PnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 18321 invoked by uid 109); 15 Feb 2024 05:39:03 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 15 Feb 2024 05:39:03 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 11954 invoked by uid 111); 15 Feb 2024 05:39:05 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 15 Feb 2024 00:39:05 -0500
Authentication-Results: peff.net; auth=none
Date: Thu, 15 Feb 2024 00:39:02 -0500
From: Jeff King <peff@peff.net>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Han-Wen Nienhuys <hanwen@google.com>,
	Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v4 1/2] refs: introduce reftable backend
Message-ID: <20240215053902.GF2821179@coredump.intra.peff.net>
References: <cover.1706601199.git.ps@pks.im>
 <cover.1707288261.git.ps@pks.im>
 <5de60d46bdccbfbf0a923abc2f45eda07f30c110.1707288261.git.ps@pks.im>
 <20240207223120.GA537741@coredump.intra.peff.net>
 <ZcRinffkQJNWyiGZ@tanuki>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZcRinffkQJNWyiGZ@tanuki>

On Thu, Feb 08, 2024 at 06:11:57AM +0100, Patrick Steinhardt wrote:

> > > +	ret = reftable_writer_add_logs(writer, logs, logs_nr);
> > > +	if (ret < 0)
> > > +		goto done;
> > 
> > ...the first thing we do is write over it. I dunno if it's worth keeping
> > as a maintenance precaution, though (if the code after the loop changed
> > to omit that assignment, then setting "ret" would become important).
> 
> Yeah, I think this one we should keep. It's also a repeating pattern
> that we have in many other places, so it helps lower the mental burden
> when it looks similar to all the others.

That sounds quite reasonable to me.

> > Both were noticed by Coverity (along with several other false
> > positives).
> 
> Is the Coverity instance publicly accessible? If not, can you maybe
> invite me so that I get a better feeling for them?

I don't think there's a way to make it publicly accessible. Probably I
could invite you to the project if you sign up for a Coverity account.
But it's a build of next plus my personal in-progress topics, which is
probably not ideal for other people to look at.

There are instructions for setting up your own scan in a56b6230d0 (ci:
add a GitHub workflow to submit Coverity scans, 2023-09-25). The unsaid
part there is signing up for Coverity and registering a project to get
the necessary tokens. Probably start here:

  https://scan.coverity.com/users/sign_up

but I don't remember the details.

The Actions workflow is in "master", so in theory we could register a
project for git.git and get automatic builds when Junio pushes to
'next', etc. In practice I have found that it requires a human looking
over the results, but if people at least had access they could poke
around.

(I suspect it would also be easy to port the workflow over to run on
GitLab CI, as well, if you wanted to).

-Peff
