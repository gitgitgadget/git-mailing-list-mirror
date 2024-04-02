Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21CDC15AAA1
	for <git@vger.kernel.org>; Tue,  2 Apr 2024 20:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712088184; cv=none; b=mE2TwP0vim89aJ0dQGCeeK6RbXEtICFdu/t2FwM0HjPh9iu+bfyCfVqQbOUUyDEq5xn/W4hJKwhXBy63iL2xC+By5S7tZRJsUTftH7VGF530WZhjmXIJycU7Fm9miqlqHGybNIIo+e0XOucs3udU7l0yu9Kfb6qwR5XhEBvx5A0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712088184; c=relaxed/simple;
	bh=Bkwf42Ig+32X65e4gyEp0fLHm7PUVd5ypAcghbbjLCA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PnElHrFa48pdY4wA7ph7q6FptzwabLL7KpreaUdsOJND8xY6N0PcDUUajR3Ig0c6hyAYKsv6Fp9FuF2LWVTuzkmcVe+Lq0V57eKUP/VlJ4gtm9TnV3xjlv3gzw0ArpOKrC6Jz2yKGTFwQ3aFyTUO/nsAAO78pJkSVuZIpWR/r48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 7274 invoked by uid 109); 2 Apr 2024 20:02:55 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 02 Apr 2024 20:02:55 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 1057 invoked by uid 111); 2 Apr 2024 20:02:56 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 02 Apr 2024 16:02:56 -0400
Authentication-Results: peff.net; auth=none
Date: Tue, 2 Apr 2024 16:02:54 -0400
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Cc: Daniel Stenberg <daniel@haxx.se>
Subject: [PATCH 0/2] git+curl 8.7.0 workaround
Message-ID: <20240402200254.GA874754@coredump.intra.peff.net>
References: <20240330000212.GA1261238@coredump.intra.peff.net>
 <2n7sn76-p413-5632-4o2s-o5n2p1rqnr5@unkk.fr>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2n7sn76-p413-5632-4o2s-o5n2p1rqnr5@unkk.fr>

On Sat, Mar 30, 2024 at 09:54:02AM +0100, Daniel Stenberg wrote:

> On Fri, 29 Mar 2024, Jeff King wrote:
> 
> > I noticed some http-related failures in the test suite on my Debian
> > unstable system, which recently got an upgraded curl package. It looks
> > like it's related to cases where we use the remote-curl helper in
> > "connect" mode (i.e., protocol v2) and the http buffer is small
> > (requiring us to stream the data to curl). Besides just running t5551,
> > an easy reproduction is:
> 
> This smells like a libcurl regression to me. I "imported" this into our
> issue tracker here: https://github.com/curl/curl/issues/13229

This was all resolved in that issue, but just to summarize for the list
here: it was a regression in curl and there's a fix already. Thanks
Daniel for your (as usual) prompt digging into the problem (and likewise
to Stefan for the actual fix).

Ultimately the issue will be fixed by moving to a different version of
libcurl, but here's an easy workaround in the meantime, with a small doc
cleanup I found along the way.

  [1/2]: http: reset POSTFIELDSIZE when clearing curl handle
  [2/2]: INSTALL: bump libcurl version to 7.21.3

 INSTALL | 2 +-
 http.c  | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

-Peff
