Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF78814B95E
	for <git@vger.kernel.org>; Fri, 27 Sep 2024 03:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727409311; cv=none; b=Da9K6FIzWfaInHcr2ogS6TAkGWHNcSeL+vsWh7GKKMPUbrMYqPeTcK30GxN7nT+3xy9c8ei23crUQ2qJ9FhG89ijgGuGUxxrVM4jxaC7ErA1DUfVmtyBtv1M5Ps/bwq+16OBhhnurEpBtHoHNydkIpgPAe1+lnA+4rMMrZnAPlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727409311; c=relaxed/simple;
	bh=HCfk8liQV7uaZMHBar06HvqoZueuSZzfpxF/r8cWfuU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z8nPtD0q0mHSqvj2n0maqmSndisII7J7fKHReAYtZi7rz5iHmCLSLU4Uwolqm19BaYoMzqCvxOd4ns0J1LKv5LNGJCsEW0smFiqL91MgzQ2Qka+sU6w0aFr+NRzpxPt88wJnlWmrAqWCy611DGAR4Qa3KyE8dxyFFvzUgRNrEPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 4875 invoked by uid 109); 27 Sep 2024 03:55:09 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 27 Sep 2024 03:55:09 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 9079 invoked by uid 111); 27 Sep 2024 03:55:08 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 26 Sep 2024 23:55:08 -0400
Authentication-Results: peff.net; auth=none
Date: Thu, 26 Sep 2024 23:55:08 -0400
From: Jeff King <peff@peff.net>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 20/28] http-push: free repo->url string
Message-ID: <20240927035508.GF567395@coredump.intra.peff.net>
References: <20240924214930.GA1143523@coredump.intra.peff.net>
 <20240924220446.GT1143820@coredump.intra.peff.net>
 <ZvVmoARjOAiAqiIz@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZvVmoARjOAiAqiIz@pks.im>

On Thu, Sep 26, 2024 at 03:50:24PM +0200, Patrick Steinhardt wrote:

> > diff --git a/http-push.c b/http-push.c
> > index f60b2ceba5..52c53928a9 100644
> > --- a/http-push.c
> > +++ b/http-push.c
> > @@ -1972,6 +1972,7 @@ int cmd_main(int argc, const char **argv)
> >   cleanup:
> >  	if (info_ref_lock)
> >  		unlock_remote(info_ref_lock);
> > +	free(repo->url);
> >  	free(repo);
> >  
> >  	http_cleanup();
> 
> I was wondering whether we also need to free `repo->path`, which is a
> `char *` as well. But that is only being assigned pointers into command
> line argument strings, and thus we do not have to free it.

Yeah, I think that "path" has the wrong type, and should be "const char
*". I was a little surprised the compiler does not complain, but it is
the old C gotcha: we assign to it via strchr(), which launders away the
const.

It would probably be OK to fix, though in general my dream is still that
we'd delete all of this code in the not too distant future. Even if we
keep dumb-http fetch for its resumability, dumb-http push just seems
like a useless holdover from the early days.

-Peff
