Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 934C2C125
	for <git@vger.kernel.org>; Sat,  1 Feb 2025 02:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738375690; cv=none; b=PjPubaZgooPWqfQfZRL6e5KmpiQZ7QgkXFLNTsWFqbdFPnqWc/62v3ttwcu7/EUVUTe60bg1aQU79O3m10ixm8CqEIIjAOfdlGdMHbPqSfCfWQ73Q3bfZXHe21sq32a+qAoZ99gNdoJeDRtCMoAGU3dYVACVJiK2NRJ8pN00NV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738375690; c=relaxed/simple;
	bh=pO8r5Cl19ojZeDFysfBET2cCS4Jda9SqxbkZH68VoMA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vic57lbfmy6H3IRqGJavMM4BD14eTmdPBAPqCe93gRIlJLAoaJhElinxdF7e5sAgUgXHhb60e226oa4bU5mLirCklCD7MJcsbNLUQx7jm0uNGujEFyyXRGbqzCyIgPBUOcAbdia2KGbE//xv6YvMiNjjCDW6iiEMGpT+WMHhTnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=QTn07uGx; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="QTn07uGx"
Received: (qmail 9746 invoked by uid 109); 1 Feb 2025 02:08:07 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=pO8r5Cl19ojZeDFysfBET2cCS4Jda9SqxbkZH68VoMA=; b=QTn07uGx9ykpU1BieYjaleqJE9LHKluZyXL1W9fGUrivdZTw4YcIpTBeOwxR8oCgt9x3DDl3ybxZsMkfqzE2qYDTbN5OTUJaM8pSvwxDDjuM6UpiMNo0jc7Rs6vdIE0VQdtkuq30JM7SaIJIi6dKTKnNdsepILPv2bcSLhv5ahlt9Mv+yIHdrsUGSU/9jxp9yX3JiWfJbt9MAVkrgzWulO2hQcIt4ohI2+w/97rLpjcspuqxNYilQ/uy1Og6qYR2rwu+Kqk6Vo73YcSfsHgjtkg5+B/4vXxqdIHX1FEnh3ZAXZgbDdG4wFbUQ5nP4CzfOpGFOvDPR6BWptxOli0iww==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 01 Feb 2025 02:08:07 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 7949 invoked by uid 111); 1 Feb 2025 02:08:10 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 31 Jan 2025 21:08:10 -0500
Authentication-Results: peff.net; auth=none
Date: Fri, 31 Jan 2025 21:08:06 -0500
From: Jeff King <peff@peff.net>
To: Eric Ju <eric.peijian@gmail.com>
Cc: git@vger.kernel.org, calvinwan@google.com, jonathantanmy@google.com,
	chriscool@tuxfamily.org, karthik.188@gmail.com, toon@iotcl.com,
	jltobler@gmail.com
Subject: Re: [PATCH v10 7/8] transport: add client support for object-info
Message-ID: <20250201020806.GA4081995@coredump.intra.peff.net>
References: <20240628190503.67389-1-eric.peijian@gmail.com>
 <20250114021502.41499-1-eric.peijian@gmail.com>
 <20250114021502.41499-8-eric.peijian@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250114021502.41499-8-eric.peijian@gmail.com>

On Mon, Jan 13, 2025 at 09:14:59PM -0500, Eric Ju wrote:

> @@ -464,8 +465,33 @@ static int fetch_refs_via_pack(struct transport *transport,
>  	args.server_options = transport->server_options;
>  	args.negotiation_tips = data->options.negotiation_tips;
>  	args.reject_shallow_remote = transport->smart_options->reject_shallow;
> +	args.object_info = transport->smart_options->object_info;
> +
> +	if (transport->smart_options && transport->smart_options->object_info

Coverity complains about the check for a NULL transport->smart_options
here. If it's NULL we'd already have segfaulted a few lines above when
we look at the reject_shallow flag.

Not sure if that's an existing bug in the earlier code or not. ;) Your
extra check can't hurt anything, in the sense that it's just being
overly defensive, but it does make puzzling out the expected value of
smart_options harder.

-Peff
