Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50C973033D8
	for <git@vger.kernel.org>; Wed, 11 Mar 2026 18:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773254531; cv=none; b=naEs9SgnoaIUZ2uST3UqaNC06Cg7jrF4BE7xeWPzV+6RC+97tH1otU+BsyQvEVTyH1+wCMJAWrV2cSXaZcR6kgv4faMWXlt3lSW+NSIpL9coks4BNM5gZVhUoSyV8DoObrnk6yGc02SajIX2RbBsQ3r9jRgKT02bI4pj3jEtr9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773254531; c=relaxed/simple;
	bh=QdxTFX+2cxMOeNmUdBGVutTnaDW2J0f6cHZdOAKsMIE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WYw2BZLFNAD5kQUMjiYTRvfer7njy7HOwS8o0IOafRJHEQJKP016jwrQdkXgJRteze8uCGFwbYfBUDZ5vR/pFkoG0Kt4UFpGePcP2arLOwgyRrsI7w4ZrMXxzAYIlmLeZaf3c1w2rfTE0mTwMWPfynkbj86cVj3d/AMtZnsDDAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=aD0UPrJi; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="aD0UPrJi"
Received: (qmail 79379 invoked by uid 106); 11 Mar 2026 18:42:07 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=QdxTFX+2cxMOeNmUdBGVutTnaDW2J0f6cHZdOAKsMIE=; b=aD0UPrJitwyijR4dihNmk17eg3eLh4Opv5I/8FiCyfLTdQ1p9/f2wdcglcURoZCr7CqoOyisiKdla9eQqAfqpABqCo3jsFQU0B/39AC63cTOhQrDBy2UuTwi/jxIitLQDwtHCYmJEiSMxx1gDkrczWLDnB3To+uHgA0IcbJ8FjX0HvNR0wehCKD/tddW21jNg4Wpf1Ql3YJ9434OC8pilvyK87pMVuVIkVb+bwBnTeohWokzOSb76xO7icufa0wRuVR/5rhr6oIK9Hn1tHCtag2M1eas+mY2RYFK0tkssiO24DkU1B1mUysCZtZSk5wsq4lHBM2FPof7cWI0+gBgHQ==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 11 Mar 2026 18:42:06 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 493911 invoked by uid 111); 11 Mar 2026 18:42:08 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 11 Mar 2026 14:42:08 -0400
Authentication-Results: peff.net; auth=none
Date: Wed, 11 Mar 2026 14:42:06 -0400
From: Jeff King <peff@peff.net>
To: Andrew Au <cshung@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v2] transport-helper, connect: add atexit handler to reap
 children on abnormal exit
Message-ID: <20260311184206.GA1911377@coredump.intra.peff.net>
References: <20260223165147.3294516-1-cshung@gmail.com>
 <20260311142021.3464789-1-cshung@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260311142021.3464789-1-cshung@gmail.com>

On Wed, Mar 11, 2026 at 02:20:21PM +0000, Andrew Au wrote:

> +/*
> + * Ensure the connection child (ssh, proxy, or local git) is reaped on
> + * any exit path, mirroring the transport-helper.c atexit pattern.
> + */
> +static struct child_process *conn_to_reap;
> +
> +static void cleanup_conn_on_exit(void)
> +{
> +	if (conn_to_reap)
> +		finish_command(conn_to_reap);
> +}

This waits for the command to exit. Are we sure it will always do so,
and it won't sometimes be waiting on us to do something (like close a
pipe that is feeding it)? If not, then we can get deadlocks.

I think you actually want to kill(), then wait. There is already support
for this in run-command.[ch]. You just need to set the clean_on_exit
flag of the child_process struct.

I actually wonder if clean_on_exit should become the default behavior.
It should be rare for our subprocesses to outlive us. Commit afe19ff7b5
(run-command: optionally kill children on exit, 2012-01-07) mentions the
pager, but I don't think that was true even back then (we wait around
for the pager to finish). There are a few cases where we spawn daemon
programs, which would need to be marked as survivable. I think mostly we
have not looked into it because somebody would have to look at each
run_command() callsite.

Anyway, that is a bit of a tangent. I think it would be safe to mark the
spots in this patch as clean_on_exit.

-Peff
