Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86E393BBC7
	for <git@vger.kernel.org>; Tue, 19 Mar 2024 20:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710881800; cv=none; b=DgXOxvsFVDPLy6dhx8JTM41Aj02b6RVmQ3AVTadJLCOIXw6pzIfsKq3AqQOH5cVpdSg/smkIps98N8BMOHpqPtbJzB8SSaXh3HxQZzJJ0TQeATO+KIPx6JYZTDB0MHE7U/037tOjBA2R/ek7CLAFBKPk8GplX2aug0F6JyAcAak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710881800; c=relaxed/simple;
	bh=gcQOOrd+Bf7WJxq5szfh4+MmOt+2yXpyvHR7gh+1ZNM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kUCHhsKI9hfY4U59DdpOCX+ytBdeJ4yuA9ghkUzDLM3HBwnGH1x8N6lxCuFKVr6bGf8ti8W97dw+wnI7dKrThk0S0xgW2mNH3KyFnivtM7bGQ3B3DAZRvF7uHztQvP0Vn+nQ6L3i3c1Ay440DF9tmN89j5opYyK0JdH7vUVKGAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 3223 invoked by uid 109); 19 Mar 2024 20:56:31 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 19 Mar 2024 20:56:31 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 11373 invoked by uid 111); 19 Mar 2024 20:56:33 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 19 Mar 2024 16:56:33 -0400
Authentication-Results: peff.net; auth=none
Date: Tue, 19 Mar 2024 16:56:30 -0400
From: Jeff King <peff@peff.net>
To: Ignacio Encinas <ignacio@iencinas.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v3 1/2] t: add a test helper for getting hostname
Message-ID: <20240319205630.GA1159535@coredump.intra.peff.net>
References: <20240309181828.45496-1-ignacio@iencinas.com>
 <20240319183722.211300-1-ignacio@iencinas.com>
 <20240319183722.211300-2-ignacio@iencinas.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240319183722.211300-2-ignacio@iencinas.com>

On Tue, Mar 19, 2024 at 07:37:21PM +0100, Ignacio Encinas wrote:

> diff --git a/t/t6500-gc.sh b/t/t6500-gc.sh
> index 18fe1c25e6a0..613c766e2bb4 100755
> --- a/t/t6500-gc.sh
> +++ b/t/t6500-gc.sh
> @@ -395,7 +395,6 @@ test_expect_success 'background auto gc respects lock for all operations' '
>  
>  	# now fake a concurrent gc that holds the lock; we can use our
>  	# shell pid so that it looks valid.
> -	hostname=$(hostname || echo unknown) &&
>  	shell_pid=$$ &&
>  	if test_have_prereq MINGW && test -f /proc/$shell_pid/winpid
>  	then
> @@ -404,7 +403,7 @@ test_expect_success 'background auto gc respects lock for all operations' '
>  		# the Windows PID in this case.
>  		shell_pid=$(cat /proc/$shell_pid/winpid)
>  	fi &&
> -	printf "%d %s" "$shell_pid" "$hostname" >.git/gc.pid &&
> +	printf "%d %s" "$shell_pid" "$(test-tool xgethostname)" >.git/gc.pid &&

Hmm. Before, we were compensating for a failure to run "hostname" by
putting in the string "unknown". But I wonder if there were platforms
where gethostname() simply fails (e.g., because the hostname is too
long). In that case your test-tool returns the empty string, but git-gc
internally will use the string "unknown".

I think it may be OK, though. The failing exit code from test-tool will
be ignored, and we'll end up with a file containing "123 " or similar.
Normally we'd use kill() to check that the pid is valid, but with a
mis-matched hostname we'll just assume the process is still around, and
the outcome is the same.

-Peff
