Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 800A0490BE9
	for <git@vger.kernel.org>; Mon, 14 Sep 2026 17:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789405237; cv=none; b=QR9BVB5o+IuRaVn7iNwSTqJlek8cBMqHdCDh42wb1Fh1Xent4BDL1jke9g6gRJLOiBjYzqPt8AQFTJF2t6Wzj52nfkrIonlyM7JPwVXfPDXzOHVL8OTZCZVNFmxhnabFnkxU7ulId1+/1z1HdNHcDYjWjoLp+NEM4+7EUVd484s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789405237; c=relaxed/simple;
	bh=m332G3ZwRiwqcUHMeKtLupPThU4FfcIwbFhWYyXmJ6w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WglXA2SkNS1fbMQAlT1ENk41CPoc+U5CMhtq0GRhc7qGsoWcrUED6OVweDNGdcEnsEJD5YGZbTyGegs+pa9PTa3YecdztX5se8HqxuwxJo3rIAhfV1HRKnoY/93pAIrQB/pkUrZ0h/JEiSjsrP2OOmzJOgeZw4WyqIkKiK5Pv8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=FCl8h7Q6; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="FCl8h7Q6"
Received: (qmail 5779 invoked by uid 106); 14 Sep 2026 17:00:34 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=m332G3ZwRiwqcUHMeKtLupPThU4FfcIwbFhWYyXmJ6w=; b=FCl8h7Q66Hh2qQY2poqYhSNxlBEQknl5Ne2sEFqRKnsNVdPpL0k+RIvUCNvXMDtzdAPbKdnhGDuZl0r2caQXXIBoC6RdIuUOliSBR/KCXa7CreEplU62Kmm3omL2q16eySXtYyh4vuD8bX23uqRBfBJasRN9JwSuG9hH9kFKLK+XbLJqg8jqLWgIWdC1jOk0OHBDuCEWQ4GVYFkgBcvkirfXfQlQyXp7hqXJCD04SEbvzbIBr+c9jtBmUY7BajnyKBCf6PcdKtx14CUGkphYFysMXB4sw94SGLJgLstqe17YQVpvjQdKMDClZzqekVE1IMzEb9DEFvL6gAjWPuC1Ag==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 14 Sep 2026 17:00:34 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 32509 invoked by uid 1000); 14 Sep 2026 17:00:34 -0000
Date: Mon, 14 Sep 2026 13:00:34 -0400
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: Vsevolod Myalitsin <ub4nal@mail.ru>, ben.knoble@gmail.com,
  git@vger.kernel.org, gitster@pobox.net
Subject: Re: [PATCH v4 2/3] advice: introduce advice scoping mechanism
Message-ID: <20260914170034.GE32247@peff.net>
References: <xmqqcxuketuz.fsf@gitster.g>
 <20260912081246.133514-1-ub4nal@mail.ru>
 <xmqq8q55863e.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq8q55863e.fsf@gitster.g>

On Sun, Sep 13, 2026 at 09:32:37AM -0700, Junio C Hamano wrote:

> > I think that since advice.* was originally assumed to be disabled
> > globally (as Jeff mentions, he expected it to be set in the user
> > config), adding "--global" to the hint is a good solution.  It makes
> > the hint actually cut-and-paste ready while still matching the
> > original intent.
> 
> The original intent was more like "the users are intelligent enough
> to be able to decide which scope they want to use", I think.  I
> agree that even with "--global" they can still cut-and-paste and
> tweak if they wanted to, so I am OK with that move, but my point was
> it probably is not even needed to mark each ones for which scope
> they are suggested to be set (iow, we can just change the message to
> always say "--global" without changing anything else).

Yeah, I was hinting that I think suggesting --global for all advice
would be fine. It's possible some particular advice would be better set
within a repo, but I kind of doubt it. And if we do find one, I think it
would be the exception, and then we could introduce a hint flag for that
one bit of advice in the other direction. :)

-Peff
