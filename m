Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BD5C8174C
	for <git@vger.kernel.org>; Fri, 22 Mar 2024 23:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711150620; cv=none; b=Qo7zSB2qFx/mKb0Zlf+vETSuA40B+avPquliEYugVPlajLnKPBBByNtmgPZAZggvOOUNPVfyt0TkhQtzGAaxsXxNddU2Oi2gNaIPCeOO4kYT2pMEJeBHDXAG4h61LL54IxKn4uWKy24l/VssJJWvPVSdwA+j7ShA2EV2y6S5Kds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711150620; c=relaxed/simple;
	bh=B2LguVmltvhIS6DhrA98gngg4E5V89AZaSbeaOH3qt8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iorjlcGEkA9qqToiKV7bEIKalBbkSkntrHdv1oPI8FsNNLwbTASCMkNuEU7xZ5dXG/VF13P1iTPdOiTaIxTQ91k0UdhNhsJlUPd/OYwnY4AoYBx8q0u3/InHyLgYBCpnmFQsrB1haGJ9D5Pu/y1S80yq2QbkS+3+OUbnzXMOo6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 15528 invoked by uid 109); 22 Mar 2024 23:36:57 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 22 Mar 2024 23:36:57 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 12318 invoked by uid 111); 22 Mar 2024 23:36:59 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 22 Mar 2024 19:36:59 -0400
Authentication-Results: peff.net; auth=none
Date: Fri, 22 Mar 2024 19:36:56 -0400
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] rebase: use child_process_clear() to clean
Message-ID: <20240322233656.GB2049941@coredump.intra.peff.net>
References: <20240322103502.GA2045297@coredump.intra.peff.net>
 <xmqqedc218to.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqedc218to.fsf@gitster.g>

On Fri, Mar 22, 2024 at 10:21:23AM -0700, Junio C Hamano wrote:

> > We should use child_process_clear() instead, which covers both. And more
> > importantly, it future proofs us against the struct ever growing more
> > allocated fields.
> 
> When 21853626 (built-in rebase: call `git am` directly, 2019-01-18)
> started using run_command() API to drive "am", there already was
> child_process API and child_process_clear() did clear both .args and
> .env_array members but we used argv_array_clear() only to clear
> am.args, leaking am.env_array.

Ah, interesting. I didn't bother to dig into the history. Back then,
though, I think that "args" was the only allocated thing. The env call
was added much later in be0d29d301 (rebase --apply: make reflog messages
match rebase --merge, 2022-10-12).

> I wonder what are in .env array at this point, though, but that is
> mere curiosity and not a problem with this patch.

It's $GIT_REFLOG_ACTION for the sub-process.

-Peff
