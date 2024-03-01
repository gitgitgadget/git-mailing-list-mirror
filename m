Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C94318464
	for <git@vger.kernel.org>; Fri,  1 Mar 2024 07:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709277044; cv=none; b=ISmKuWdpdCeBWv9/GENjkqapNttO3k18YG4MgADh15YuxWJWm+kPkP02l/BXqAz6luHOC5vFEDXT6bzilFqnvIsp3VODicgncRUL9754tEWZF6B17N9KGda6aslXjmNZ2fukZANIXoLtgLvfdipwHqljO9aRssWRON36AAuVcDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709277044; c=relaxed/simple;
	bh=O9YG4b7Hog74xxaYVSs8BgncfO5d1EC4jWMD5M0ebVI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N4SmNotq2MTUZLlPkY9Dn4r6P5pd8euCMJQVUcUg2ViB7Q3kuB+ieBWbdw5+jlvwHPCmyBa/B/g78WOA6s2GY1do8t5LceDdaFTwb1cAcY6HilI+AxMb1e3mUBw1jY36p7PJrVSuTkz2DulI7Kj527DmzUX73wT+chK3ebTj+b8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 2094 invoked by uid 109); 1 Mar 2024 07:10:41 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 01 Mar 2024 07:10:41 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 10104 invoked by uid 111); 1 Mar 2024 07:10:45 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 01 Mar 2024 02:10:45 -0500
Authentication-Results: peff.net; auth=none
Date: Fri, 1 Mar 2024 02:10:41 -0500
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 4/4] upload-pack: only accept packfile-uris if we
 advertised it
Message-ID: <20240301071041.GA2682168@coredump.intra.peff.net>
References: <20240228224625.GA1158651@coredump.intra.peff.net>
 <20240228225050.GA1159078@coredump.intra.peff.net>
 <20240229054239.GA1669526@coredump.intra.peff.net>
 <xmqqmsrji5zr.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqmsrji5zr.fsf@gitster.g>

On Thu, Feb 29, 2024 at 08:34:48AM -0800, Junio C Hamano wrote:

> > Otherwise the server complains that the other side did not respect its
> > advertised object-format (I sure am glad to have included the final
> > "hey, this input works, right?" test there, as that is what caught it).
> 
> Ah, good finding.  Will use it to amend.
> 
> I wonder if it is still worth testing if the command is happy with
> an input that lacks object-format capability under SHA-1 mode.  This
> test piece is primarily about packfile-uris, so in that sense, we
> are not all that interested in that unspecified client object-format
> defaults to the initial value of serve.c:client_hash_algo (which is
> SHA-1), and not testing that here is perfectly fine, I guess.

Yeah, if we want to test it, I'd prefer to do so separately as its own
test rather than keeping it as a subtle side effect of this one. I
looked around to see if it might exist already, but I didn't find one
(OTOH, it is hard to grep for since we are looking for the _absence_ of
an object-format line in hand-crafted input).

But taking a step back, why do we care about this case? It is because
older clients that speak v2 but do not yet know about object-format will
make a request without it, and they should still work in sha1 mode. So
the more general thing to test here is whether those older versions can
successfully fetch from a newer server.

There are tests in t/interop for cloning and fetching from a different
version. I kind of doubt anybody runs them regularly, though (and
picking the interesting versions to find this case isn't entirely
trivial). So I dunno.

-Peff
