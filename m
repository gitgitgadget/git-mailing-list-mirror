Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E2502DE6F5
	for <git@vger.kernel.org>; Thu,  3 Jul 2025 15:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751557251; cv=none; b=fcA1fZqnnUo4+/LCQ/ODNIojqGWfJIljP7uklwdLl/useRu+zoJ2fU6mwExrdDeP1X7JVP+jQl1aiF1DOkCfXpKHiF25O1VO7SmGpKHqFlzaS0YxW+zCRrXQJ68WIIgT2NQ9etz87Ol9XZm5IEaeN/wqjggslpuaPVJ/iL1pK3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751557251; c=relaxed/simple;
	bh=vIp/7mkD9zScRw2Ku2n9BQosF73CUaDv6pgXkJcX8j0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c8wFGp48MJym20CQP/2R6F/r1IptkwuXR2TwWPCA2OES5itjYEiO+jgAAYprGtnOJEKuw0Am3MLlyi/ogGWapHmrGa1cvrpRpqNIL4WQaw5Js3ywi5s7ZPZ2OQtPT/NagWXfQfcg7b8WPaBijJChWkF8gYRJbQNDx6b6bE080E4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=gy/5z3qA; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="gy/5z3qA"
Received: (qmail 5659 invoked by uid 109); 3 Jul 2025 15:40:48 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=vIp/7mkD9zScRw2Ku2n9BQosF73CUaDv6pgXkJcX8j0=; b=gy/5z3qA14xkGTNIbALqzF94KjIPMOvXmPyjlY/O9O/vjrsWqzmldy7XwGTGkgSXtHNcMb1JX+zDZNBxTJGBPA8jKpd5XESAhBdXCgTarOOzt4LCXvzSeTX02KIkxmSHBXFQQAe0zj7JjVYXhfs7iDs3yTo2WEcwg5AVbyR2uC4kOSWhS7+NxFvIa7V8VpUAO+kOsYmi6t4irgBBDQswgyNuhSnVC5bBbwyTmq0EJ80An5mt5LUCxaU1/U/IBsSYAjfNeatjuo1pq//i9CYpRp+QB3YCmW0iUkYaZziIqXEFnpXdSBQvrlbE3nhMcmMMzjOyDDWBfYBS8nSkPZCP5A==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 03 Jul 2025 15:40:48 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 1107 invoked by uid 111); 3 Jul 2025 15:40:48 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 03 Jul 2025 11:40:48 -0400
Authentication-Results: peff.net; auth=none
Date: Thu, 3 Jul 2025 11:40:47 -0400
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: Jacob Keller <jacob.e.keller@intel.com>, git@vger.kernel.org,
	Jacob Keller <jacob.keller@gmail.com>
Subject: Re: [PATCH] send-pack: clean up extra_have oid array
Message-ID: <20250703154047.GD1309870@coredump.intra.peff.net>
References: <20250627-jk-fix-leak-send-pack-v1-1-aadcf0ed8a4b@gmail.com>
 <xmqqzfdnkdx6.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqzfdnkdx6.fsf@gitster.g>

On Tue, Jul 01, 2025 at 10:40:21AM -0700, Junio C Hamano wrote:

> There is an early exit from the function that would bypass these
> clean-up.  Perhaps something like this on top?
> 
>  builtin/send-pack.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git c/builtin/send-pack.c w/builtin/send-pack.c
> index b28da7ddd7..6ce9f6665a 100644
> --- c/builtin/send-pack.c
> +++ w/builtin/send-pack.c
> @@ -305,9 +305,10 @@ int cmd_send_pack(int argc,
>  		flags |= MATCH_REFS_MIRROR;
>  
>  	/* match them up */
> -	if (match_push_refs(local_refs, &remote_refs, &rs, flags))
> -		return -1;
> -
> +	if (match_push_refs(local_refs, &remote_refs, &rs, flags)) {
> +		ret = -1;
> +		goto cleanup;
> +	}
>  	if (!is_empty_cas(&cas))
>  		apply_push_cas(&cas, remote, remote_refs);
>  
> @@ -340,6 +341,7 @@ int cmd_send_pack(int argc,
>  		/* stable plumbing output; do not modify or localize */
>  		fprintf(stderr, "Everything up-to-date\n");
>  
> +cleanup:
>  	string_list_clear(&push_options, 0);
>  	free_refs(remote_refs);
>  	free_refs(local_refs);

This made me wonder if the remote_refs out-parameter is valid after
match_push_refs() returns failure (especially since we do not initialize
it at the top of the function).

I think the answer is "yes"; it is both an in-parameter and an
out-parameter, and will have been earlier set up via get_remote_heads().
So even on the failure case, match_push_refs() will leave it untouched
and it is still valid (and needs to be cleaned up).

-Peff
