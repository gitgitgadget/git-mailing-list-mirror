Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 706E51EEFD
	for <git@vger.kernel.org>; Wed, 27 Mar 2024 08:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711529911; cv=none; b=GxiizlS5P2cq0DMc9uVe9Q3VUU8SxPnqY+TYuohMXasf4rGmJb3PWm27ebElnkpZ/8YFgI1PesJwFhVfVxfnc1XoceUJ4RFjSyT8ZfkFo4n6CtuwCsWoeowWv/8/uvHnZ55/duvRWI7ByVt8It/jVts2BdIdOl0RKaeE9bdDXuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711529911; c=relaxed/simple;
	bh=rEcuT/9uAwtqzI6lyIU4ZN3hEgd9Ko26pCzhGOaB7bM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gy5W30VoamlESEbkD34GUvHJJ9s+c5ejufrrKpUR0AEP3nKUeFUSfNL8QlY+bag10RJJmk56s8okaNmmzJUVUmHnwBHP6FBaRjL+hq9vvFBHRmvmvPncOkHFzbfrDYOdt//lhw+ddL9tKOvDkb/ZV3WKSFXYK89jjeWnrw/qibQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 22023 invoked by uid 109); 27 Mar 2024 08:58:28 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 27 Mar 2024 08:58:28 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 24704 invoked by uid 111); 27 Mar 2024 08:58:33 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 27 Mar 2024 04:58:33 -0400
Authentication-Results: peff.net; auth=none
Date: Wed, 27 Mar 2024 04:58:27 -0400
From: Jeff King <peff@peff.net>
To: Josh Steadmon <steadmon@google.com>
Cc: git@vger.kernel.org, johannes.schindelin@gmx.de,
	phillip.wood@dunelm.org.uk, gitster@pobox.com
Subject: Re: [PATCH v3 6/7] t/Makefile: run unit tests alongside shell tests
Message-ID: <20240327085827.GA846805@coredump.intra.peff.net>
References: <cover.1705443632.git.steadmon@google.com>
 <cover.1708728717.git.steadmon@google.com>
 <cfcc4bd427318fed1cacc8457381d5a0c408460a.1708728717.git.steadmon@google.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cfcc4bd427318fed1cacc8457381d5a0c408460a.1708728717.git.steadmon@google.com>

On Fri, Feb 23, 2024 at 03:33:55PM -0800, Josh Steadmon wrote:

> diff --git a/t/run-test.sh b/t/run-test.sh
> new file mode 100755
> index 0000000000..c29fef48dc
> --- /dev/null
> +++ b/t/run-test.sh
> @@ -0,0 +1,13 @@
> +#!/bin/sh
> +
> +# A simple wrapper to run shell tests via TEST_SHELL_PATH,
> +# or exec unit tests directly.
> +
> +case "$1" in
> +*.sh)
> +	exec ${TEST_SHELL_PATH:-/bin/sh} "$@"
> +	;;
> +*)
> +	exec "$@"
> +	;;
> +esac

An earlier step required that runs via "test-tool run-command" have
TEST_SHELL_PATH set correctly. So defaulting to /bin/sh here is
pointless, I'd think? This is used only for the in-Makefile "prove"
invocation, so running individual tests or even a manual "prove" outside
of the Makefile (where the user might not have set TEST_SHELL_PATH)
would not apply.

It obviously is not hurting anything, but I wonder if you'd want to have
it complain loudly to catch any instance where your assumption is not
true.

-Peff
