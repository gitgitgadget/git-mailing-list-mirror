Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBBF9224889
	for <git@vger.kernel.org>; Mon, 19 May 2025 06:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747635476; cv=none; b=jGiT4DQRber2kt68DwaOOuIFbZfi0c9l/o60mKrVSBTIGTsZycdLIxnfKecYw9Km3fT73ABuzveZB5DoQJBPGdUTw2t9WyK4/JNir2zzx6PK+curzTqt9zl4k9kEAyq8M8ywRoBdCAHAROYTHkb9m04UMZVqg7bsdLmhDm4Bx00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747635476; c=relaxed/simple;
	bh=MQByclvnZbKb91wPjfIB2wmgRKipfI7aozaezwvXiuo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f8iaudMkrB6xVs/JTZ3addjR1z3CQbR3IKi2AA7MLMwaocmbZA7OaaM3xeJ5/+HbnytwOeOwKTmFQapvsdfnSeE4uTiW/nu7y+beocQ7/oowoVba2RPCdJRG8bwKHFT3+ny0Dh6da1hkzdHtRSQ9Z5B+8G8USVuY0SfZwB4G2oQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=BtIp8WZ9; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="BtIp8WZ9"
Received: (qmail 14152 invoked by uid 109); 19 May 2025 06:17:54 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=MQByclvnZbKb91wPjfIB2wmgRKipfI7aozaezwvXiuo=; b=BtIp8WZ9ATR3ScphtvXkqFqKku60L5oSoo9KIVvm1X28jT8fgMg99M1XFIau94bItHXFLiCpoylZslmOYR74MfrMIFH+pRPot6JO7ASo2/4p6cMj28SxK4KHy7Rpno5VIHyXR3aUSKtj+OeXrlavtlgbgq8J4k0TZNJkYTaGfn2+fdV3KSNdlm9D8BmXwTPHFdOVdmwkCD4v+MxLUA33pkAjFguWuJBcxeBbsro+m5o59idIedo642PDoitTJ13e2PD7MLdCn2njW2KSTGP8V/haqppN7KPjhW1HeRjqPWMGxfArozQhYraWYAWi+u/9rg6sdOzzIigjd9VCAvc4wg==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 19 May 2025 06:17:54 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 24324 invoked by uid 111); 19 May 2025 06:17:57 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 19 May 2025 02:17:57 -0400
Authentication-Results: peff.net; auth=none
Date: Mon, 19 May 2025 02:17:53 -0400
From: Jeff King <peff@peff.net>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 09/13] t: add lib-loose.sh
Message-ID: <20250519061753.GB102701@coredump.intra.peff.net>
References: <20250516044916.GA21985@coredump.intra.peff.net>
 <20250516045002.GI22242@coredump.intra.peff.net>
 <aCcK4bZVxuO2iTMS@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aCcK4bZVxuO2iTMS@pks.im>

On Fri, May 16, 2025 at 11:52:33AM +0200, Patrick Steinhardt wrote:

> > +++ b/t/lib-loose.sh
> > @@ -0,0 +1,30 @@
> > +# Support routines for hand-crafting loose objects.
> > +
> > +# Write a loose object into the odb at $1, with object type $2 and contents
> > +# from stdin. Writes the oid to stdout. Example:
> > +#
> > +#   oid=$(echo foo | loose_obj .git/objects blob)
> > +#
> > +loose_obj () {
> 
> Nit: I would have called this `write_loose_obj ()` to indicate that it's
> writing an object. But ultimately doesn't matter too much, so please
> feel free to ignore this comment.

I named it this way to match "pack_obj" in lib-pack.sh. But that one is
probably my doing, too, and arguably both should be named
write_foo_obj(). ;)

For such a little corner of the test suite I agree it probably doesn't
matter too much.

-Peff
