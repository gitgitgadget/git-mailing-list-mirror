Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55A4F139588
	for <git@vger.kernel.org>; Wed, 24 Jul 2024 22:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721859402; cv=none; b=rbB837JD0AH7sh+iD3hCjdXg/SlMc9TUmQcGInOj1OuYuD1BTQ5T1mfF+z5ae1F/Niw26H+UvQPhfZ08fsmvTObr4TzEoIRuXXN1jj0V/Ge+Pfpd3mgqLLC1YNPlbpMp7eEVw8foUSmepPu5JOHBp60xDg5yK08D7aSUpxC0Iww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721859402; c=relaxed/simple;
	bh=vHi3JR6yyPlQeuOp2trnEmm1WDavEVzKu8OAVw3mNZg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jCURtiIm1LzVLYXOY4edxPbLakORb1f/gxeoZSzDrdrZyag83TOxX+K4P5pQKO8nUvgaRfr5nm/7SMHbZVICqCM7VEXBkx02uRrPy17WxHUang5DnQu9/RWrjZ6l7iXZKzzrgWLrW5swpBDVS32BAMFow8oC+JXE+vtibMaSHlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 2385 invoked by uid 109); 24 Jul 2024 22:16:39 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 24 Jul 2024 22:16:39 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 15013 invoked by uid 111); 24 Jul 2024 22:16:41 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 24 Jul 2024 18:16:41 -0400
Authentication-Results: peff.net; auth=none
Date: Wed, 24 Jul 2024 18:16:38 -0400
From: Jeff King <peff@peff.net>
To: Haritha  via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Haritha <harithamma.d@ibm.com>
Subject: Re: [PATCH v2] Fix to avoid high memory footprint
Message-ID: <20240724221638.GA568325@coredump.intra.peff.net>
References: <pull.1744.git.git.1721117039874.gitgitgadget@gmail.com>
 <pull.1744.v2.git.git.1721821503173.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <pull.1744.v2.git.git.1721821503173.gitgitgadget@gmail.com>

On Wed, Jul 24, 2024 at 11:45:03AM +0000, Haritha  via GitGitGadget wrote:

> diff --git a/convert.c b/convert.c
> index d8737fe0f2d..c4ddc4de81b 100644
> --- a/convert.c
> +++ b/convert.c
> @@ -324,6 +324,9 @@ static void trace_encoding(const char *context, const char *path,
>  	struct strbuf trace = STRBUF_INIT;
>  	int i;
>  
> +	if (!trace_want(&coe))
> +		return;
> +
>  	strbuf_addf(&trace, "%s (%s, considered %s):\n", context, path, encoding);
>  	for (i = 0; i < len && buf; ++i) {
>  		strbuf_addf(

The patch itself looks good. I confirmed that running:

  git init
  dd if=/dev/zero of=foo.bin bs=1M count=50
  echo '*.bin working-tree-encoding=UTF-16LE' >.gitattributes
  valgrind --tool=massif git add .

goes from a max heap of 1.7G down to 51MB with your patch (whereas I
think with the previous iteration it would not have, since the old check
did the wrong thing on the first call to trace_encoding()).

-Peff
