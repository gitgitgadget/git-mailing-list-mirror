Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AB3EEAD4
	for <git@vger.kernel.org>; Sat, 16 Mar 2024 06:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710569071; cv=none; b=WXonnUFTyqWjBuY22Soqp/32e2Vuckuut+T6Z1cBjqIwOdRvhvY4SXQZ3sLwFXfagfyaqEX/D25A2Q9HrbX08KijertwT9VRyCSLPwbH+jwXd2Bywmmvd/ZuAK9hrY5h7vL6VPhHgaRJXJvYXJEP51HdTULI2y1Zp57p1Eh6Qqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710569071; c=relaxed/simple;
	bh=Cx2uw1GYrZgFVQi5Nun9HwFIt2Ho5iy8w7d/TXJvr5E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UJSnLvvLKCnVAyx1LaM/uuzJTBMh0/kivf69NhS8ySzSu4C0JpaI/TLzqin5YHtDr9GSrTrrCOs2tGPBHk2O23P6vZYuxcOtJCQZ4Rdxh4hATBGm05cs2I9ytcinoeI9kNKvEgxatQvfwGcP3yUDHC0bXvRaYyQM0YGzluGtB6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 5457 invoked by uid 109); 16 Mar 2024 06:04:28 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 16 Mar 2024 06:04:28 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 7138 invoked by uid 111); 16 Mar 2024 06:04:32 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 16 Mar 2024 02:04:32 -0400
Authentication-Results: peff.net; auth=none
Date: Sat, 16 Mar 2024 02:04:27 -0400
From: Jeff King <peff@peff.net>
To: "Eric W. Biederman" <ebiederm@gmail.com>
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>, git@vger.kernel.org
Subject: Re: [PATCH 2/2] doc/gitremote-helpers: match object-format option
 docs to code
Message-ID: <20240316060427.GB32145@coredump.intra.peff.net>
References: <20240307084735.GA2072130@coredump.intra.peff.net>
 <20240307085632.GB2072294@coredump.intra.peff.net>
 <Zeo9oAkL6kxZRugN@tapette.crustytoothpaste.net>
 <20240312074513.GA47852@coredump.intra.peff.net>
 <ZfIWkJieqcPv5jA8@tapette.crustytoothpaste.net>
 <87ttl99e0b.fsf@gmail.froward.int.ebiederm.org>
 <ZfNqVowQBy47_92m@tapette.crustytoothpaste.net>
 <87msqzo63f.fsf@gmail.froward.int.ebiederm.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87msqzo63f.fsf@gmail.froward.int.ebiederm.org>

On Fri, Mar 15, 2024 at 10:41:24AM -0500, Eric W. Biederman wrote:

> I see you saying and a quick grep through the code supports that the
> object-format extension is implemented, and that the primary problem
> is that the Documentation varies slightly from what is implemented.
> 
> 
> Looking at the code I am left with the question:
>  Is the object-format extension properly implemented in all cases?
> 
> 
> If the object-format extension is properly implemented such that a
> client and server mismatch can be detected I am for just Documenting
> what is currently implemented and calling it good.
> 
> The reason for that is
> Documentation/technical/hash-function-transition.txt does not expect
> servers to support more than hash function.  I don't have a perspective
> that differs.  So detecting what the client and server support and
> failing if they differ should be good enough.

AFAIK the code all works correctly, and there are no cases where we fail
to notice a mismatch. The two code/doc inconsistencies (and bearing in
mind this is for the transport-helper protocol, not the v2 protocol
itself) are:

  - the docs say "object-format true", but the code just says
    "object-format". They're semantically equivalent, so it's just a
    minor syntax issue.

  - the docs say that Git may write "object-format sha256" to the
    helper, but the code will never do that.

So my big question is for the second case: is that something that we'll
need to be able to do (possibly to support interop, but possibly for
some other case)? If not, we should probably just fix the docs. If so,
then we need to either fix the code, or accept that we'll need to add a
new capability/extension later.

> I am concerned that the current code may not report it's hash function
> in all of the cases it needs to, to be able to detect a mismatch.
> 
> I look at commit 8b85ee4f47aa ("transport-helper: implement
> object-format extensions") and I don't see anything that generates
> ":object-format=" after it has been asked for except the code
> in remote-curl.c added in commit 7f60501775b2 ("remote-curl: implement
> object-format extensions").
> 
> Maybe I am mistaken but a name like remote-curl has me strongly
> suspecting that it does not cover all of the cases that git supports
> that implement protocol v2.

That all sounds right. We are talking just about the transport-helper
protocol here, where Git speaks to a separate program that actually
contacts the remote server. And the main helper we ship is remote-curl
(which handles https, http, etc). Everything else is linked directly and
does not need to use a separate process (we use a separate process to
avoid linking curl, openssl, etc into the main Git binary).

We do ship remote-fd and remote-ext, but they don't support most options
(and probably don't need to, because they're mostly pass-throughs that
just use the "connect" feature).

The other major helpers people tend to use are adapters to other version
control systems (e.g., remote-hg, cinnabar). We don't ship any of those
ourselves. They'll obviously need to learn about the transport-helper
object-format capability before they're ready to handle sha256 repos,
but I suspect that works has not really started.

> I think I see some omissions in updating the protocol v2 Documentation.

If you mean from the commits listed above, I don't think so; they are
just touching the transport-helper protocol, not the v2 wire protocol.

-Peff
