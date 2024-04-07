Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E7ABA47
	for <git@vger.kernel.org>; Sun,  7 Apr 2024 01:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712454228; cv=none; b=riLNTe00xD2TdRYMg8rh6sWmJi79DRIDZx0pvg/4LwM7lqkMNz2jkJpbenGaE7DYrzZ6XHB6+iUN94SoF3/YE2GOGs+FuzCZog4MWGX0Q0IFtEmmHy5TwWpnGrguk3g1l3DjJ+vCDHsuV0r5gU278aDkCg/ncJYqqWI9Jc/HZrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712454228; c=relaxed/simple;
	bh=3nI5HFGFV21RTVTMzwunqDegEoGrnG3omNK626XlvGY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kquXohXkqDsOPzzoZA93vwbV77hzNrs4mgQwTFNe/abUoO5SbplFU5aDpTLX0/PQUXcZENNIz2sTw/Wh3XX0yHzWm0kP50tz2NpuBE3r/Q730jMVvYILuEX/g8pCZU/QWeKMa4ennse5314/zk+JJjG75xh6rrKrJ7cCTuwBqo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 8794 invoked by uid 109); 7 Apr 2024 01:43:45 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sun, 07 Apr 2024 01:43:45 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 11685 invoked by uid 111); 7 Apr 2024 01:43:48 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 06 Apr 2024 21:43:48 -0400
Authentication-Results: peff.net; auth=none
Date: Sat, 6 Apr 2024 21:43:44 -0400
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 6/6] t: teach lint that RHS of 'local VAR=VAL' needs to
 be quoted
Message-ID: <20240407014344.GF1085004@coredump.intra.peff.net>
References: <20240406000902.3082301-1-gitster@pobox.com>
 <20240406000902.3082301-7-gitster@pobox.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240406000902.3082301-7-gitster@pobox.com>

On Fri, Apr 05, 2024 at 05:09:02PM -0700, Junio C Hamano wrote:

> Teach t/check-non-portable-shell.pl that right hand side of the
> assignment done with "local VAR=VAL" need to be quoted.  We
> deliberately target only VAL that begins with $ so that we can catch
> 
>  - $variable_reference and positional parameter reference like $4
>  - $(command substitution)
>  - ${variable_reference-with_magic}
> 
> while excluding
> 
>  - $'\n' that is a bash-ism freely usable in t990[23]
>  - $(( arithmetic )) whose result should be $IFS safe.
>  - $? that also is $IFS safe

Hmm. Just porting over my comment from the other thread (before I
realized you'd written this series), this misses:

  local foo=bar/$1

etc. Should we look for the "$" anywhere on the line? I doubt we can get
things foolproof, but requiring somebody to quote:

  local foo=$((1+2))

does not seem like the worst outcome. I dunno.

-Peff
