Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC8222BF016
	for <git@vger.kernel.org>; Wed, 12 Nov 2025 07:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762931880; cv=none; b=KhwSXOtchFWag97PajMX+khvBu+HOgoW4VNc9Ho2i3Buz1Yi380ibmqsOtPoqdFu0+hmkuS6++qI8GNdUORYRyXS/CCC/QSzNe/9yhXAPXIewVtPaL1roBkNjWiXtYOtIMm240n3ydioC4w8UFmCxvIZvBF27JgXAWw0snbXGnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762931880; c=relaxed/simple;
	bh=ESs0P6nNC3sNbVYtyc8GVF7ENHwT+n+oqjwnzCcUiag=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qm4OKUvTVepm+BxAPFdU1XpwH5FITKV2B3f0nIqQKUX0ED7KJ/E4fy5xSANYK8Lvp0r5PLXnDG7NRiragih/8jkOXssP6Cw+LMIeL4jQjeRSO4DC8kRgIwzLv+nr7pxAp5b60Da7imwHKeABUWRwaDfjmSorHM9g/oT5/mJo7Oc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=GfQzT6Zi; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="GfQzT6Zi"
Received: (qmail 494987 invoked by uid 109); 12 Nov 2025 07:17:57 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=ESs0P6nNC3sNbVYtyc8GVF7ENHwT+n+oqjwnzCcUiag=; b=GfQzT6Zin0d3tYup0Q95jFqwbaX2xUdcY85DrSnFco4/TttagtevY414o0y6iNtNhkEt8OO8SlorC4JdGH0Ppoh6M7fF/cNaR3VcyfUc5oFwWxYZnfb/fycxyzk5FICJPiWG+EbfgrhugrcdeIng75pNMWdfb4uzlb8h3axSikhkcpqKNT9s8BSmB2ACBD0BgFJbru5jr6GCF9lVGdfdP/TSQ9gJJS+grabOfFV6qJT0SoBD4czfmQ30huLkLmyYGRzNmbxfUO1JgCi5a3xJoEnYL4ktsTHmWmFyU9ja9+XJS7pA6fvgSrYyBUYgs+/5peIC2dPLEXlRWaJYQS88Hw==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 12 Nov 2025 07:17:57 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 785879 invoked by uid 111); 12 Nov 2025 07:17:57 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 12 Nov 2025 02:17:57 -0500
Authentication-Results: peff.net; auth=none
Date: Wed, 12 Nov 2025 02:17:57 -0500
From: Jeff King <peff@peff.net>
To: Ben Knoble <ben.knoble@gmail.com>
Cc: git@vger.kernel.org, Ben Stav <benstav@miggo.io>
Subject: Re: [PATCH] attr: avoid recursion when expanding attribute macros
Message-ID: <20251112071757.GC431661@coredump.intra.peff.net>
References: <20251111223647.GA4055973@coredump.intra.peff.net>
 <F6B66286-64B0-47AB-A31D-50A253F001D5@gmail.com>
 <20251112070907.GA431661@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251112070907.GA431661@coredump.intra.peff.net>

On Wed, Nov 12, 2025 at 02:09:07AM -0500, Jeff King wrote:

> Though I think you might be able to chain macros across files (so
> ".gitattributes" introduces macro "foo", and the "sub/.gitattributes"
> introduces "bar" which resolves to "foo", and so on). In which case your
> total size is larger, and only eventually limited by how deep a tree
> we'll accept (another place where we recurse, but there is a
> configurable depth limit).

I did poke at this briefly, and the answer is: no, you can't do that. We
allow macro definitions only at the top-level. Which makes sense, as
otherwise you get into confusing dependencies between files.

-Peff
