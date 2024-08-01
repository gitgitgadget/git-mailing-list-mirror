Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60673170A3E
	for <git@vger.kernel.org>; Thu,  1 Aug 2024 06:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722492861; cv=none; b=s6Sl5fMX7z/u51IZs2UrbcQdzOJ862G72B10j3YPaDSRMVycGfQryx7igE78MLOoOO18V099qol39mvMCyGxitB7PTRB1CQsXm9wQ320gPQb0m2mGZ5HJKyAAzyjHzL0LellGZrWur6MOoICPIOdFv4f6vWSWO3kgo8iQyCXiDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722492861; c=relaxed/simple;
	bh=T1LSMH1AT+udOSd9OEBr6So/avaW5Nls7TzjI/XnFa8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oi1DFOGQPqt834irmryn5oQCByU3p/pn6hy6BUvQWHF1MM0WVZuOMsZkGAn4/ws4FPtKNo+p3mAbmtrkDWS86MFHE7UVTXJ0rLwrR0Cick/Q4YSJAqn73jPc5c/j3UzdEsSq8CwP5V1DRgSIeobErIfhzYhvwmwak66k+vnuRU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 14914 invoked by uid 109); 1 Aug 2024 06:14:18 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 01 Aug 2024 06:14:18 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 27632 invoked by uid 111); 1 Aug 2024 06:14:22 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 01 Aug 2024 02:14:22 -0400
Authentication-Results: peff.net; auth=none
Date: Thu, 1 Aug 2024 02:14:17 -0400
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>, git@vger.kernel.org,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	"W. Michael Petullo" <mike@flyn.org>
Subject: Re: Git clone reads safe.directory differently?
Message-ID: <20240801061417.GD621899@coredump.intra.peff.net>
References: <20240727215845.GA1263246@coredump.intra.peff.net>
 <ZqZjRMqpEV_3WIkD@imp.flyn.org>
 <20240728224807.GA1299337@coredump.intra.peff.net>
 <ZqjQi6i2kiY4gcc1@imp.flyn.org>
 <Zqlo-i8uCb1Yr4Jm@tapette.crustytoothpaste.net>
 <xmqqv80m8pha.fsf@gitster.g>
 <ZqlxtGIyz0G9jlJr@tapette.crustytoothpaste.net>
 <20240731072832.GB595974@coredump.intra.peff.net>
 <xmqqo76d7coa.fsf@gitster.g>
 <xmqq1q391afc.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq1q391afc.fsf@gitster.g>

On Wed, Jul 31, 2024 at 03:08:55PM -0700, Junio C Hamano wrote:

> Junio C Hamano <gitster@pobox.com> writes:
> 
> > So we probably need to add another axis to the "strict" parameter
> > enter_repo() takes to selectively disable the ownership checks only
> > for upload-pack, or something like that.
> 
> So, here is a rough sketch for the above.  Interested parties may
> build on top of it, perhaps by adding separate knobs to loosen or
> tighten the second parameter given to enter_repo() at different
> callsites, by writing tests to make sure they work as intended, and
> by documenting the security story around it none of which I do here
> ;-).

This looks roughly like I'd expect, but...

> diff --git c/builtin/upload-pack.c w/builtin/upload-pack.c
> index 46d93278d9..fe50ce3eed 100644
> --- c/builtin/upload-pack.c
> +++ w/builtin/upload-pack.c
> @@ -36,6 +36,7 @@ int cmd_upload_pack(int argc, const char **argv, const char *prefix)
>  			    N_("interrupt transfer after <n> seconds of inactivity")),
>  		OPT_END()
>  	};
> +	unsigned enter_repo_flags = ENTER_REPO_ANY_OWNER_OK;
>  
>  	packet_trace_identity("upload-pack");
>  	disable_replace_refs();
> @@ -51,7 +52,9 @@ int cmd_upload_pack(int argc, const char **argv, const char *prefix)
>  
>  	dir = argv[0];
>  
> -	if (!enter_repo(dir, strict))
> +	if (strict)
> +		enter_repo_flags |= ENTER_REPO_STRICT;
> +	if (!enter_repo(dir, enter_repo_flags))
>  		die("'%s' does not appear to be a git repository", dir);
>  
>  	switch (determine_protocol_version_server()) {

...this is doing that loosening for upload-pack by default. I'm not sure
if that is OK or not. My mental model has remained "it is OK to run
upload-pack on an untrusted repository", but it would make sense to get
input from folks who looked at this in the past, like Dscho, and/or to
reassess the threat model from scratch.

In particular I did not follow all of the potential issues with linked
local files. Are we good now after other fixes (in which case this patch
is OK)? Are we good only for non-local clones (so this patch is OK only
combined with a fix for clone to check ownership for --local mode)? Or
are there still problems if an attacker controls the repo paths, in
which case upload-pack should remain conservative?

-Peff
