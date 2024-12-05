Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B45F621A42B
	for <git@vger.kernel.org>; Thu,  5 Dec 2024 17:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733420030; cv=none; b=L5rMIniXM0LIn3vqlTUAQrWiekm7qkBonhyjb+5H1uFY0P7z+FGrUZob2abhhdLDDshXjXzvbQHI+LPY/A4+3ffIfjVC4GvisDfq6Q2ESc0CJvxjdsv4uSqOFaFKIj0zRr2ONinBURSMwWSAlpYYkaOp2VJc/FFWF1WZWZXUOZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733420030; c=relaxed/simple;
	bh=6k7SrHQbhRPfQ+365hCcaglKqpACWZHJdR5Qw8IJLZ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ia9udnEb0LOqeWOvMXc2WycmxNIRsnQp1Cbibc2M8Y+DqC7Wspy0/oErUtw43Scur9WrI2s1R6OYuKcl4qFSv1Bbfw6JXHQ04NZMST04DByKPrUKi1XJiCp4elykLbI+ZjMAaZVZSoKvQanwRRW+5O/+BOwPcoSTZgATlgiDXqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=IyJKdLmi; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="IyJKdLmi"
Received: (qmail 30096 invoked by uid 109); 5 Dec 2024 17:33:46 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:content-transfer-encoding:in-reply-to; s=20240930; bh=6k7SrHQbhRPfQ+365hCcaglKqpACWZHJdR5Qw8IJLZ4=; b=IyJKdLmiXJjaYcEzhyvuWZKJY3m6l733PiT7ZGPAcj1LMnmOpVLxdqYlaB6/mw4v5sN/2KVINflyNVALiA6o4ysuOYt5KRTGubPwa+tY262WH1rS+QM1g7SDatP1CJazngRWsODp8/S3z4Pp8Z6yGBVkBDzg9+cnqkUPnmBi6EtkPJP2iBDCcU3qL8fbnJDZg8MTWuKxs+5oK+IB7tLBAvHmirtQXFWXmmSgT/cLNkmCidJHTjk3cbWRC+GFPsKB2yOcxe+mGObjlTaUtqtx3Vc/csrhmxtMLBawmJyjIPB1GY9W44eKci6AJmnknGoAxdnY+x1b9rSuKeypx5tXbA==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 05 Dec 2024 17:33:46 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 8157 invoked by uid 111); 5 Dec 2024 17:33:43 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 05 Dec 2024 12:33:43 -0500
Authentication-Results: peff.net; auth=none
Date: Thu, 5 Dec 2024 12:33:42 -0500
From: Jeff King <peff@peff.net>
To: Aarni Koskela <aarni@valohai.com>
Cc: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Subject: Re: Regression in :/ commit selection between 2.43.0 and 2.47.1
Message-ID: <20241205173342.GA2593033@coredump.intra.peff.net>
References: <CAKOEJdcPYn3O01p29rVa+xv=Qr504FQyKJeSB-Moze04ViCGGg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKOEJdcPYn3O01p29rVa+xv=Qr504FQyKJeSB-Moze04ViCGGg@mail.gmail.com>

On Thu, Dec 05, 2024 at 02:22:13PM +0200, Aarni Koskela wrote:

> See below for a reproduction:
> 
> * Initialize a repository
> * Create a commit with message "mystery commit 1"
> * Tag the commit with `git tag -a a-tag -m a-tag`
> * Create another commit with message "mystery commit 2" (which should
> be found from HEAD with `:/mystery`)
> * Show the commit with `git show :/mystery` – it shows the older commit!
> * Delete the tag with `git tag -d a-tag`
> * Show the commit with `git show :/mystery` – it now shows the newer commit.

This bisects to 57fb139b5e (object-name: fix leaking commit list items,
2024-08-01). Looks like an unintended side effect, maybe related to
swapping "list" and "copy" in get_oid_oneline()?

-Peff
