Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B917107B3
	for <git@vger.kernel.org>; Thu, 25 Apr 2024 01:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714009482; cv=none; b=MIiSHCAkazttDPPgiCvwkJTvG7afisQdqd0UWDL/5czoRf70k/yqZGyv5AkF30Os2R/C9SHHiFVS2WHcWNp1a4riM1uKaLEfNHiQBQVWnRCZ9WaBi1FH7yhpfhbLibZHHTBAIpRAYweC4Lph98tfxNdDK9hB0ZrzbA/WBxiECOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714009482; c=relaxed/simple;
	bh=zmDcAykbhUjcQPs00npCOMpMzE5qnB9KQRTR7oZEXu8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ez6wf7RlfBOUss2/NehfJ8oC9ySJsQ3eEeqNiT3DaWy2lZtXKwRRT2rBJR2TTlrWXf7ypuHLHnaGfcXEVBfyy9P9fPr3GwgCwBF2xFJEMHmpgXe64ZOudSFmtMnnLhWLw+zG5LOBeNz62xDXcJHvM8jMv507DL2faO08WOvS1jM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 22750 invoked by uid 109); 25 Apr 2024 01:44:34 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 25 Apr 2024 01:44:34 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 16908 invoked by uid 111); 25 Apr 2024 01:44:36 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 24 Apr 2024 21:44:36 -0400
Authentication-Results: peff.net; auth=none
Date: Wed, 24 Apr 2024 21:44:32 -0400
From: Jeff King <peff@peff.net>
To: =?utf-8?B?UnViw6lu?= Justo <rjusto@gmail.com>
Cc: Git List <git@vger.kernel.org>,
	Phillip Wood <phillip.wood@dunelm.org.uk>,
	Patrick Steinhardt <ps@pks.im>, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4] add-patch: response to unknown command
Message-ID: <20240425014432.GA1768914@coredump.intra.peff.net>
References: <4e2bc660-ee33-4641-aca5-783d0cefcd23@gmail.com>
 <6d421c67-9e10-4a7b-9782-38ba8e9da915@gmail.com>
 <db1d540f-30ae-4d4c-883b-088bcfe68140@gmail.com>
 <b209a2b8-f98f-4f14-a687-9022d30968dd@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b209a2b8-f98f-4f14-a687-9022d30968dd@gmail.com>

On Sun, Apr 21, 2024 at 11:52:33PM +0200, Rubén Justo wrote:

> +test_expect_success 'unknown command' '
> +	test_when_finished "git reset --hard; rm -f command" &&
> +	echo W >command &&
> +	git add -N command &&
> +	git diff command >expect &&
> +	cat >>expect <<-EOF &&
> +	(1/1) Stage addition [y,n,q,a,d,e,p,?]? Unknown command ${SQ}W${SQ} (use ${SQ}?${SQ} for help)
> +	(1/1) Stage addition [y,n,q,a,d,e,p,?]?$SP
> +	EOF
> +	git add -p -- command <command >actual 2>&1 &&
> +	test_cmp expect actual
> +'

I got a test failure on Windows CI from this. The test_cmp output looks
like this:

  -(1/1) Stage addition [y,n,q,a,d,e,p,?]? Unknown command 'W' (use '?' for help)
  -(1/1) Stage addition [y,n,q,a,d,e,p,?]?
  +(1/1) Stage addition [y,n,q,a,d,e,p,?]? (1/1) Stage addition [y,n,q,a,d,e,p,?]?
  +Unknown command 'W' (use '?' for help)

which makes me suspect a race. Perhaps because the prompt is going to
stdout, but the "Unknown command" message goes to stderr? Maybe we
should keep stdout and stderr separate and check them independently.

-Peff
