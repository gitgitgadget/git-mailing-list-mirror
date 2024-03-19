Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35D873BBED
	for <git@vger.kernel.org>; Tue, 19 Mar 2024 20:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710881877; cv=none; b=Ctbt3jFQPt4fze58JCigcOLA84ofvI8mohrGkGDHTTmYbGMXD+R70xsXHVENzdsq/qannk9LeRunsr/Zzc+yR3LpV8Z2UTk4qwGoskbAW9DOk+UoUWhj9QBqeh8l2vjcXhRTYePyjwsD46inAClvOC1UCslvNCOytgjD9SvVfiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710881877; c=relaxed/simple;
	bh=AXIteg2zU3uIXjqSHFkceGIXXqhvyt/y0a6UfixxPWE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AU6JLnSEaD0LH0Uk5V/mgc34JYBaReglL6mERlkt3anDAOVOzgcgfkar5elIzJEXFVJyN/UMHtCU18njolSotXjxtLzVSq5Ugq99xhP9/CHfCA82f19EVZiYtp6WcqM48okoPBGojQfNYux0YGf+8zBeUIvrIqOPhEEGEVuQsG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 3242 invoked by uid 109); 19 Mar 2024 20:57:54 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 19 Mar 2024 20:57:54 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 11378 invoked by uid 111); 19 Mar 2024 20:57:56 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 19 Mar 2024 16:57:56 -0400
Authentication-Results: peff.net; auth=none
Date: Tue, 19 Mar 2024 16:57:53 -0400
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: Ignacio Encinas <ignacio@iencinas.com>, git@vger.kernel.org
Subject: Re: [PATCH v3 1/2] t: add a test helper for getting hostname
Message-ID: <20240319205753.GB1159535@coredump.intra.peff.net>
References: <20240309181828.45496-1-ignacio@iencinas.com>
 <20240319183722.211300-1-ignacio@iencinas.com>
 <20240319183722.211300-2-ignacio@iencinas.com>
 <xmqq8r2eneut.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq8r2eneut.fsf@gitster.g>

On Tue, Mar 19, 2024 at 01:31:06PM -0700, Junio C Hamano wrote:

> > diff --git a/t/t6500-gc.sh b/t/t6500-gc.sh
> > index 18fe1c25e6a0..613c766e2bb4 100755
> > --- a/t/t6500-gc.sh
> > +++ b/t/t6500-gc.sh
> > @@ -395,7 +395,6 @@ test_expect_success 'background auto gc respects lock for all operations' '
> >  
> >  	# now fake a concurrent gc that holds the lock; we can use our
> >  	# shell pid so that it looks valid.
> > -	hostname=$(hostname || echo unknown) &&
> >  	shell_pid=$$ &&
> >  	if test_have_prereq MINGW && test -f /proc/$shell_pid/winpid
> >  	then
> > @@ -404,7 +403,7 @@ test_expect_success 'background auto gc respects lock for all operations' '
> >  		# the Windows PID in this case.
> >  		shell_pid=$(cat /proc/$shell_pid/winpid)
> >  	fi &&
> > -	printf "%d %s" "$shell_pid" "$hostname" >.git/gc.pid &&
> > +	printf "%d %s" "$shell_pid" "$(test-tool xgethostname)" >.git/gc.pid &&
> 
> We should replace the "hostname || echo unknown" in the original,
> instead of doing this change, as it loses the exit status from the
> "test-tool xgethostname" command.

I think you need to lose the exit status. Or alternatively do:

  hostname=$(test-tool xgethostname || echo unknown)

See my other reply.

-Peff
