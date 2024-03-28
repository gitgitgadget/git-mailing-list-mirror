Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4F935F87A
	for <git@vger.kernel.org>; Thu, 28 Mar 2024 10:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711621256; cv=none; b=DXpcG5tFq3lnvC8aKIUR81zcCo1/e3WDgPyU2UNfmoJeGbuv15G+IaGTTIx7CuSeFG+rXH79SxeSkFbjXHlbJEDKOavcOPLtR2yckfD54HrVVp/Hcwd2DGVNQ9qtxSDI8THRIS/5Sv8fwo1c/jCJV7O/2vadqYa03CFjEFoB7cI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711621256; c=relaxed/simple;
	bh=YiysB4zGdZKjnrwN+TuYrfzcaHuDQo7bbepVC2iCZK0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eyWRqYsXu0Uno9fyG61iP+M3KgQM8pPBkOSRKMQnwf0b2A94t/zHsTOFjDjoMoWErERpR3Tqk53KMQUoWcyIcjXjV1b2Z/canxG8/arBVqU5hdP5HGKYrLhR8UkiS+Rys/yIJgEgA9um4cHHs3aL9wE1TxjpP6dwcFohtffv8LQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 3467 invoked by uid 109); 28 Mar 2024 10:20:54 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 28 Mar 2024 10:20:54 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 4606 invoked by uid 111); 28 Mar 2024 10:20:58 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 28 Mar 2024 06:20:58 -0400
Authentication-Results: peff.net; auth=none
Date: Thu, 28 Mar 2024 06:20:53 -0400
From: Jeff King <peff@peff.net>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Matthew John Cheetham <mjcheetham@outlook.com>,
	M Hickford <mirth.hickford@gmail.com>
Subject: Re: [PATCH 05/13] credential: gate new fields on capability
Message-ID: <20240328102053.GA890906@coredump.intra.peff.net>
References: <20240324011301.1553072-1-sandals@crustytoothpaste.net>
 <20240324011301.1553072-6-sandals@crustytoothpaste.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240324011301.1553072-6-sandals@crustytoothpaste.net>

On Sun, Mar 24, 2024 at 01:12:53AM +0000, brian m. carlson wrote:

> @@ -35,6 +41,16 @@ test_expect_success 'setup helper scripts' '
>  	test -z "$pass" || echo password=$pass
>  	EOF
>  
> +	write_script git-credential-verbatim-cred <<-\EOF &&
> +	authtype=$1; shift
> +	credential=$1; shift
> +	. ./dump
> +	echo capability[]=authtype
> +	test -z "${capability##*authtype*}" || return
> +	test -z "$authtype" || echo authtype=$authtype
> +	test -z "$credential" || echo credential=$credential
> +	EOF

I think this "|| return" needs to be "|| exit 0" or similar. The Windows
CI jobs fail with:

  --- a/expect-stderr
  +++ b/stderr
  @@ -2,3 +2,4 @@ verbatim-cred: get
   verbatim-cred: capability[]=authtype
   verbatim-cred: protocol=http
   verbatim-cred: host=example.com
  +D:\a\git\git\t\trash directory.t0300-credentials\git-credential-verbatim-cred: line 10: return: can only `return' from a function or sourced script

(actually if you count the line numbers, I think this particular case is
the similar "|| return" added to the script later, but both should be
fixed).

It doesn't show up elsewhere because only bash complains, but not dash.
Even running the test script with bash isn't enough, because
write_script uses $SHELL_PATH under the hood. But building with "make
SHELL_PATH=/bin/bash test" shows the problem on other platforms.

-Peff
