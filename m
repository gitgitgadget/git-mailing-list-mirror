Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53F16EC5
	for <git@vger.kernel.org>; Sun,  7 Apr 2024 01:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712453927; cv=none; b=JBXFcC+4XhM0Nagrj5/y2pbUHlKDVWfG7OQSqX1fT/wDZuCzRgvr0abIMcK5msxBkCFxRXp3wjzhkB0OEqQriCIPIwwjfjfalEVLZpspmJ0uu1EYtM8sxs5AAx16XCof1ywSJUvNnDXIXX5Npn9WwDEZA0VM9RELsopp+LRdd+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712453927; c=relaxed/simple;
	bh=euNDnv7f34fr+Ii4mwg9oNLRJ7lMwgz2spaUcwVNX2I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hLx25yxOZC1BVfiNNShybfRkEXORga68EVVlss9JBJe0XWSXe3Fj6njs9iQ2vxXH9L3VOLRtSZ9as2QrvYcvVSD6w6InsRpNUO+Lpzb2FK1DrOH4pUlaEuvtGOrt4Mv4RADQIhRL3bvqTqalJl4FTAI8IY7TtP400hZYE0YN0pk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 8697 invoked by uid 109); 7 Apr 2024 01:38:44 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sun, 07 Apr 2024 01:38:44 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 11645 invoked by uid 111); 7 Apr 2024 01:38:47 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 06 Apr 2024 21:38:47 -0400
Authentication-Results: peff.net; auth=none
Date: Sat, 6 Apr 2024 21:38:43 -0400
From: Jeff King <peff@peff.net>
To: Dragan Simic <dsimic@manjaro.org>
Cc: prpr 19xx <prpr19xx@gmail.com>, git@vger.kernel.org
Subject: Re: Warning message in remote.c when compiling
Message-ID: <20240407013843.GE1085004@coredump.intra.peff.net>
References: <CAA1Aqdvj6Eyp9jGaAxTf8p0Eh_rCPydOpin3D5QYHy8sqOoOsw@mail.gmail.com>
 <7f0da057773d39add4ede71667e9ff70@manjaro.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <7f0da057773d39add4ede71667e9ff70@manjaro.org>

On Sat, Apr 06, 2024 at 06:12:34PM +0200, Dragan Simic wrote:

> Hello,
> 
> On 2024-04-06 16:21, prpr 19xx wrote:
> > I get this warning message when compiling remote.c:
> > 
> > ...
> >     CC remote.o
> > remote.c:596: warning: 'remotes_remote_get' declared inline after being
> > called
> > remote.c:596: warning: previous declaration of 'remotes_remote_get' was
> > here
> >     CC replace-object.o
> > ...
> 
> Could you, please, provide more details about your environment,
> i.e. the operating system and compiler?

I'm also curious about which compiler, but I think it's a reasonable
complaint. We forward-declare the static function, use it, and then
later declare it inline. I didn't check to see what the standard says,
but it seems like a funny thing to do in general.

It has been that way for a while; since 56eed3422c (remote: remove
the_repository->remote_state from static methods, 2021-11-17), I think.

I don't really see any need to mark the wrapper as inline. It's one
basic function call (on top of an interface which requires a callback
anyway!), and I suspect many compilers would consider inlining anyway,
since it's a static function.

Ditto for remotes_pushremote_get(), though it doesn't have a forward
declaration.

-Peff
