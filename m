Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6522384
	for <git@vger.kernel.org>; Wed, 20 Mar 2024 00:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710893979; cv=none; b=LzAYMVEPpUsyqunUoTaJfHg95XuwjAHypdoCpui7Ja+HKU6ZROlqTXewwfl8QAY9PgCQV5PhW6Q0eMuM7VqCmYqg4YVJY+JrKMHQbR0dOwhqsaDbUW7Rapy8u1nTPXR3A+FVEGlETGHk80mSIaReFN7ZlP5yFHkoTCAWsMhFYDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710893979; c=relaxed/simple;
	bh=F4oN2qxB8RHsNDViTLg7mYelxoGctuPRvnwd+nw7crQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=to3j4IDv3Pv1z97aWF5FEbYiPbSoRtoU36+vmM1AKYN+xnfhUwZgX3B553QWwlb4tx6eTuvJE3nLGD+5ASFgl2QcnksMInWnPtgxx/iHiGG3Nq2LIzgRCCrCivQslWEadJRksPxSnd+2ApUmNmznnHK4bTSZ8vnprW92p/HNr54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 5606 invoked by uid 109); 20 Mar 2024 00:19:35 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 20 Mar 2024 00:19:35 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 13256 invoked by uid 111); 20 Mar 2024 00:19:37 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 19 Mar 2024 20:19:37 -0400
Authentication-Results: peff.net; auth=none
Date: Tue, 19 Mar 2024 20:19:34 -0400
From: Jeff King <peff@peff.net>
To: Eric Sunshine <sunshine@sunshineco.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Ignacio Encinas <ignacio@iencinas.com>, git@vger.kernel.org,
	Taylor Blau <me@ttaylorr.com>, rsbecker@nexbridge.com
Subject: Re: [PATCH v3 0/2] Add hostname condition to includeIf
Message-ID: <20240320001934.GA903718@coredump.intra.peff.net>
References: <20240309181828.45496-1-ignacio@iencinas.com>
 <20240319183722.211300-1-ignacio@iencinas.com>
 <CAPig+cT4fpX7Kczu0+H5TZnmpVqqq0h8nBafj4UqDs7Xv2Nf4A@mail.gmail.com>
 <xmqqa5mulycz.fsf@gitster.g>
 <CAPig+cTFRAmzBGiJv2F-k1XWvGSbT8UeAG57T+XpB-1w66HRkQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPig+cTFRAmzBGiJv2F-k1XWvGSbT8UeAG57T+XpB-1w66HRkQ@mail.gmail.com>

On Tue, Mar 19, 2024 at 05:13:47PM -0400, Eric Sunshine wrote:

> On Tue, Mar 19, 2024 at 5:12 PM Junio C Hamano <gitster@pobox.com> wrote:
> > Eric Sunshine <sunshine@sunshineco.com> writes:
> > > Peff felt that adding `git config --show-hostname-for-includes` was
> > > probably overkill, but I'd argue that it is necessary to enable users
> > > to deterministically figure out the value to use in their
> > > configuration rather than having to grope around in the dark via
> > > guesswork and trial-and-error to figure out exactly what works.
> > >
> > > And the option name doesn't necessarily have to be so verbose; a
> > > shorter name, such as `git config --show-hostname` may be good enough.
> > > Implementing this option would also obviate the need to implement
> > > `test-tool xgethostname` (though, I agree with Junio that `test-tool
> > > gethostname` would have been a better, less implementation-revealing
> > > name).
> >
> > Yeah, I like that show-hostname thing (which I do not know if "config"
> > is a good home for, though).
> 
> The other possibility which came to mind was adding a GIT_HOSTNAME
> variable to the output of `git var -l`.

That strikes me as a more appropriate spot than an option to git-config.
Even if config is the only thing _now_ which cares about the hostname,
it may be something that other parts of the system care about in the
future.

Some care may need to be taken for error handling, though. For "git var
GIT_HOSTNAME" it is OK to exit non-zero, but "git var -l" should not
bail on a system where gethostname() doesn't work (it is still not clear
to me if that is a real case to worry about or not).

-Peff
