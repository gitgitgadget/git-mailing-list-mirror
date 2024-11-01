Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F19510F4
	for <git@vger.kernel.org>; Fri,  1 Nov 2024 17:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730483152; cv=none; b=adCYGrkhdCtcXt8pyNlp/UNW/Pmm/gsG18tON/dwYjNuAg/lLkXIjIC2DXk07uxwPcMvuxNkMMGyJwAWjA8LggGss0/DuMQO0saL5heunMuOJE+PTjVhFqi0yvtmSwEYvfs6sPKKxvIp9rCJoPyWb0tibJy2gZncv5wtHTmVi8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730483152; c=relaxed/simple;
	bh=0YqHBWzKIuJ4nxeNw+uRDZpzv6uQS2kMth+DGg0UEfA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l6qSAABubOiOEWq4iFmcpziKsRZGZ5T4bkYFMv5abwnKN4g9SzCPjT3JsISJj5jZj/WPZDfxnBTfHRXcU5wriMHjHzAnCIuB4j2hD5dbAI0cEHk/ltmnzaFEpCbNKSm07dMn0Nva0UQcAtO9cXrFEufeImmmkOSE6wO0VW+tXJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=AVvuor+G; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="AVvuor+G"
Received: (qmail 31350 invoked by uid 109); 1 Nov 2024 17:45:48 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=0YqHBWzKIuJ4nxeNw+uRDZpzv6uQS2kMth+DGg0UEfA=; b=AVvuor+Gjq4XgnSPinm4/grVBFT/SARR9h0MHxCUmORhknZAAMAZE3kHUogj5bERlJWxgyrZ97EYLHXDQR97TYFPYsIpEiowlA+WlF5ueheYVv6uV8u8iYsIwuT3lXkmZLyflQC3XpR09Yjlbs2AD+Kl3DFNdqY5teVCe3Xo1hLmW2Bbi8JnsGuui4MMFWuf4v+AO6ARahRIFl+nw4ybx9IDgf8C29Xn4UMa5dh6DlWQ5KXLWW1OHvpudPMZ92jR7FJsMmqVgOFo1FzvgwEDQCFxvKXK8a9/XqT5rNJvHxSN+nyCB4kkqa2/M5pDL71usZGDfyL8RfNbSpiF5+sjTw==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 01 Nov 2024 17:45:48 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 15493 invoked by uid 111); 1 Nov 2024 17:45:47 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 01 Nov 2024 13:45:47 -0400
Authentication-Results: peff.net; auth=none
Date: Fri, 1 Nov 2024 13:45:47 -0400
From: Jeff King <peff@peff.net>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org, me@ttaylorr.com
Subject: Re: [PATCH v4 8/9] config: make `packed_git_(limit|window_size)`
 non-global variables
Message-ID: <20241101174547.GB2337295@coredump.intra.peff.net>
References: <cover.1730366765.git.karthik.188@gmail.com>
 <5bbdc7124d58526a7a2d7b3bdc807ddd204a6df1.1730366765.git.karthik.188@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5bbdc7124d58526a7a2d7b3bdc807ddd204a6df1.1730366765.git.karthik.188@gmail.com>

On Thu, Oct 31, 2024 at 10:39:51AM +0100, Karthik Nayak wrote:

> @@ -652,20 +688,25 @@ unsigned char *use_pack(struct packed_git *p,
>  				break;
>  		}
>  		if (!win) {
> -			size_t window_align = packed_git_window_size / 2;
> +			struct packfile_config config = PACKFILE_CONFIG_INIT;
> +			size_t window_align;
>  			off_t len;
>  
> +			repo_config(p->repo, packfile_config, &config);
> +			window_align = config.packed_git_window_size / 2;
> +

Parsing config like this is somewhat expensive (remember we're going to
hit your callback for every single config key in the system, user, and
repo-level config files).

And use_pack() is a relatively hot code path, as we call it any time we
need to access bytes from a mapped pack! This "!win" conditional isn't
quite as hot, as it only triggers when we establish a new window for a
pack. But that still happens at least once per pack, more if we need to
move the window around in a big pack, and lots more if we are under
memory pressure and need to open/close windows a lot.

I think we need to parse these values once and then store them somewhere
with cheaper access. Can we grab them in prepare_repo_settings(), for
example, which would cache them? We need a repo struct, but we have one
(the same packed_git->repo you are using to call repo_config()).

-Peff
