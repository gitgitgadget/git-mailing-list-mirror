Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C9621FDA90
	for <git@vger.kernel.org>; Fri, 21 Feb 2025 07:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740124138; cv=none; b=jbTy5us1y5okyGyhkhWzzHOu9pguRxPcH8UaOtUkChvnywTjjNPKIxs1H+mL7tPkjjOklVQug7YAfnqCVsz3osWIDSgjYDRvV4jVmgI/kG0OwrIx5TW8htn/I2qOeSsZ0vG6gGZ8uBAHr2nFFxgpInsHPXAIMgnK67tNtO8NNRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740124138; c=relaxed/simple;
	bh=/pui4Dbkb/cSl3ZKgN+k+a6L53RsM4Vf9u0RjdEkjEo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qKY5FYAT9Pb9IA2WdaEXrdjIpfWCxlfeCNcV9nzDmtuC/8hUs5AqLDn5E/KBAwbpKTsx4e/Q1zJYS4CArrNnGyS8xK8KGa8Ieo2v7ecDacZ4WIUR2UptKOEd2yzPIog2bcCs3UV+DoVnHSmdXKrjg8S8t9BGeYD/CwifZyeNDFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=NSC7n2Hf; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="NSC7n2Hf"
Received: (qmail 3319 invoked by uid 109); 21 Feb 2025 07:48:55 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=/pui4Dbkb/cSl3ZKgN+k+a6L53RsM4Vf9u0RjdEkjEo=; b=NSC7n2HfdXheBWzTIYXpFKyRij/rF6jqZXBa+9o81ndG7su+zQxGfiOTilJZ9eRuT7rC7Omb7/HC0MZ2KuXDHlIyqyVsGprZRRS9oy77mu5qCS6AehTTmFTXYknc0OU4Z+6AwDlou/j/bn84FpMEm/lcpQw4jrwHk/lshvJmlmDkqyLknCmDxBv4RYlko+h3jRCuLjlfIMQ+stpXqy/1FgE62BtGGjqTnQs844cII9tHPkdiJPVaJzmlOiAMqSNGTJsUm791lbQMqcV6WAatWUIYMREpNAsaRNvad9xN9kOf544xkEqKY3diifeD+3bsge0H5Xd4hYxP95K6415JdQ==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 21 Feb 2025 07:48:55 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 31008 invoked by uid 111); 21 Feb 2025 07:48:55 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 21 Feb 2025 02:48:55 -0500
Authentication-Results: peff.net; auth=none
Date: Fri, 21 Feb 2025 02:48:54 -0500
From: Jeff King <peff@peff.net>
To: Toon Claes <toon@iotcl.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v2 7/7] http: silence stderr when progress is enabled
Message-ID: <20250221074854.GC1988395@coredump.intra.peff.net>
References: <20250219-toon-bundleuri-progress-v2-0-a84e7ffa921a@iotcl.com>
 <20250219-toon-bundleuri-progress-v2-7-a84e7ffa921a@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250219-toon-bundleuri-progress-v2-7-a84e7ffa921a@iotcl.com>

On Wed, Feb 19, 2025 at 03:30:25PM +0100, Toon Claes wrote:

> diff --git a/http.c b/http.c
> index 5517863808..5c0c6ef204 100644
> --- a/http.c
> +++ b/http.c
> @@ -2133,7 +2133,10 @@ static int http_request(const char *url,
>  	    http_follow_config == HTTP_FOLLOW_INITIAL)
>  		curl_easy_setopt(slot->curl, CURLOPT_FOLLOWLOCATION, 1);
>  	if (options && options->progress) {
> -		progress = start_progress(the_repository, _("Downloading via HTTP"), 0);
> +		progress = start_progress(the_repository,
> +					  _("Downloading via HTTP"), 0);
> +		progress_set_fd(progress, fileno(stderr));
> +		freopen("/dev/null", "w", stderr);

Hmm. I can't think of any reason this wouldn't work, and it certainly is
less ugly than overriding die() and friends.

It does still feel a bit hacky to me. For one thing, asking for progress
does not necessarily mean you _also_ want to suppress errors. So it
would have to be a separate option.

But mostly the more I think about it, the more the "send progress data
back to the caller over stdout" thing makes sense. I think we probably
do eventually want to support parallel fetches, which would require
coordination in the caller.

-Peff
