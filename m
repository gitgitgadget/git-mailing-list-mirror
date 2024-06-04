Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B6E838B
	for <git@vger.kernel.org>; Tue,  4 Jun 2024 10:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717495305; cv=none; b=JAmXaBgX6B0sf4Eto1ly2+peVvhHOSWdYytijetJqs69xxxSaUu2qJE9MGD7HT7y42BwLogeaqd8TPtJhCiCxlZcr8G8Oyectdvj69Q/l5kZy4gyo6OQHUJrA0DoNWm2yxp7exfbX8BLc7Cg6TszqmO231096ssxFPRDaMpuE38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717495305; c=relaxed/simple;
	bh=BivEHOvu1wVvU+jW1V66b1SHVP8TQ30MzbvMspa70j0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hYKrlMWxHtPtdRdds2QpxoDcuWvWhgv1NSaJzlRkGNtcYuJU66hyg5nD5zbABvTlzXsS+5quTewyhMD6Brlvsc7igsXVWFWNyx43nV+vj+XhX0+z74VGWPXvzMrznS8WFtTsWHX/2XRH1Zdd61FBmTZfuUzLif4uPo8y8+YsmJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 21239 invoked by uid 109); 4 Jun 2024 10:01:43 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 04 Jun 2024 10:01:43 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 18240 invoked by uid 111); 4 Jun 2024 10:01:40 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 04 Jun 2024 06:01:40 -0400
Authentication-Results: peff.net; auth=none
Date: Tue, 4 Jun 2024 06:01:42 -0400
From: Jeff King <peff@peff.net>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 10/13] sparse-checkout: free sparse_filename after use
Message-ID: <20240604100142.GC1298378@coredump.intra.peff.net>
References: <20240531112433.GA428583@coredump.intra.peff.net>
 <20240531113545.GJ428814@coredump.intra.peff.net>
 <Zl7FgVPHGiXJYSah@framework>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Zl7FgVPHGiXJYSah@framework>

On Tue, Jun 04, 2024 at 09:42:57AM +0200, Patrick Steinhardt wrote:

> > diff --git a/builtin/sparse-checkout.c b/builtin/sparse-checkout.c
> > index 356b7349f9..3af9fec1fb 100644
> > --- a/builtin/sparse-checkout.c
> > +++ b/builtin/sparse-checkout.c
> > @@ -500,6 +500,8 @@ static int sparse_checkout_init(int argc, const char **argv, const char *prefix)
> >  		return 0;
> >  	}
> >  
> > +	free(sparse_filename);
> > +
> 
> I wonder whether it would make sense to merge this patch and patch 4
> and then refactor the code to have a common exit path.

I thought about that, too, but it doesn't quite work. In the non-error
exit path we _don't_ clean up the pattern_list, because we tail-call
into write_patterns_and_update(), which frees it itself.

If we refactored that function to _not_ free, and then switched here to
a "ret" variable, like:

	...
	ret = write_patterns_and_update(&pl);
  out:
	clear_pattern_list(&pl);
	free(sparse_filename);
	return ret;

it could work. I mostly tried to err on the side of minimizing
refactoring, though.

-Peff
