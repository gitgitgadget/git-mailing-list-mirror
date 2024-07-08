Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D70B253E22
	for <git@vger.kernel.org>; Mon,  8 Jul 2024 09:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720429829; cv=none; b=BXTuPJb+UGxGyzS4so1BjMgh8jz0Q1+Fiz4gBOsaXQjgSvjMR4CJcTInJpnI0l2Z/vmjLMyUiPM2n0spZIoHH9Fl8yZtyPiBQwWpzOtPAFKWeVekL2V3xJTpKf+0/norEDslnM/ARbfDKkHgHwETRET5LsReNyF3oPqSVVRaYnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720429829; c=relaxed/simple;
	bh=tvf1roaN/NqGxRZDI9xWxJAw0De7PQjyOONgZE9eItI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fVeoIn72bpAQ/6/3jQV7Ivoi9tLWBTLUK+E+CcQv51ClCm6oUP+jGJ6mhskTExlSNd6dfrhGxNF7ewavo++AJt+fTdz/u/fWCVHK5t/xz9EvLYHm5W3EtzAMDvM7wE7t5p2680KOnksGW3/KIPkREaqcMJm+j0N/xPExq+o9Z5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 14186 invoked by uid 109); 8 Jul 2024 09:10:27 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 08 Jul 2024 09:10:27 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 20731 invoked by uid 111); 8 Jul 2024 09:10:24 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 08 Jul 2024 05:10:24 -0400
Authentication-Results: peff.net; auth=none
Date: Mon, 8 Jul 2024 05:10:26 -0400
From: Jeff King <peff@peff.net>
To: Eric Sunshine <sunshine@sunshineco.com>
Cc: Eric Sunshine <ericsunshine@charter.net>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>,
	=?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Subject: Re: [PATCH 1/3] chainlint.pl: fix line number reporting
Message-ID: <20240708091026.GE819809@coredump.intra.peff.net>
References: <20240706060143.GD698153@coredump.intra.peff.net>
 <20240706060515.GA700151@coredump.intra.peff.net>
 <CAPig+cRxnpG9Yfix09EnJAbnzwN=yoUtSeYxt7S-Od+xBgfaYQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAPig+cRxnpG9Yfix09EnJAbnzwN=yoUtSeYxt7S-Od+xBgfaYQ@mail.gmail.com>

On Mon, Jul 08, 2024 at 01:08:02AM -0400, Eric Sunshine wrote:

> > I actually suspect the "record the heredoc line number" thing would not
> > be too hard. I.e., turn ShellParser's "heredoc" hash to point to
> > hashrefs like: "{ content => ..., lineno => ... }". And that would give
> > us a good spot to stick an "interpolate" boolean later if we want.
> 
> It turned out to be quite easy. See below for an implementation atop
> your patch [1/3] (modulo Gmail whitespace damage). Given how simple
> this ended up being, it probably makes sense to squash this change in,
> as well.

Very nice! I was hoping it would be something like this. I've squashed
this in, and confirmed that it fixes the line numbers in my "double"
case:

  test_expect_success "$(cat <<END_OF_PREREQS)" 'here-doc-double' - <<\EOT
  SOME
  PREREQS
  END_OF_PREREQS
  	echo "actual test commands"
  	echo "that should be checked"
  EOT

The bogus line was incorrectly reported as line 2, because we did not
account for the first here-doc.

-Peff
