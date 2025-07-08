Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78CFF1E231E
	for <git@vger.kernel.org>; Tue,  8 Jul 2025 01:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751938576; cv=none; b=GNd1oIcEZ0n7wDBwnzMrNuJDmGiVW35qWKZZ+LXWxzqAqQ2QUAmSScdkuXWEsEEZ6LrDotkIB7ra9BtIGLk70Tj2FDJss4G85Xa2Cj20WpHAGB//knWqcJ5BtYcnuWoTUhmObZKDvnHvs/ESpnitLAcOBIaY+05cY0Qvi0/QSj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751938576; c=relaxed/simple;
	bh=O9avs9WdvPOmLv9kmkyHtboiBNzgjGV6p9Yaf1FDnYo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F2prG2vkAkO033XczqQZqsKE+k5CnDf9iu6b/faZJ4LpZuSEEVyE3rDfqYvUjHnN72B5or4mIzm7Ylwv4VYNH6FjQZ96tzVMBpjsoLNWfV6rTH38ujedUq86G3J0BOWB5mqLjPYi1dOszBwCmhi9elCiglFTcXFexfskDtzPkLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=KlqS7xKS; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="KlqS7xKS"
Received: (qmail 10725 invoked by uid 109); 8 Jul 2025 01:36:13 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=O9avs9WdvPOmLv9kmkyHtboiBNzgjGV6p9Yaf1FDnYo=; b=KlqS7xKSsdi9PhPxBHiMt2hRg1BmU5SEYFAT0hFS0s/bnLG8F5a5+knvO7z9HN1Fc1ri+kD14h+pgUQfXpiU5TGJAk3DqrkVIZ4zh8F4eHg8Ki78F1qTXaH9h4IM4zIfgElFnPi0Cj2bbHxskdWmdej3AIqlUaQrfqOmozNhapiuj2mwHVyX/Mm6wUmFttsfmKchVh4KfD6M3vq19Nz0Hpx6g8rt5LXU7ktHdjzjEqllX66feWY10IUGK1S3crf4xVDo/IEt6taEAIRBsEdGPMo0aU7plFzughB4WFsC3Y2Ruc/32D/6hZve9xC+lc++HrvjyTOTQXXyP02Jt9IlDA==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 08 Jul 2025 01:36:13 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 13952 invoked by uid 111); 8 Jul 2025 01:36:16 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 07 Jul 2025 21:36:16 -0400
Authentication-Results: peff.net; auth=none
Date: Mon, 7 Jul 2025 21:36:12 -0400
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: Phil Hord <phil.hord@gmail.com>, git@vger.kernel.org,
	Jacob Keller <jacob.e.keller@intel.com>
Subject: Re: [PATCH v4 0/3] fetch --prune performance problem
Message-ID: <20250708013612.GB549007@coredump.intra.peff.net>
References: <20250702011214.2835529-2-phil.hord@gmail.com>
 <xmqqtt3n1v27.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqtt3n1v27.fsf@gitster.g>

On Mon, Jul 07, 2025 at 03:43:12PM -0700, Junio C Hamano wrote:

> Phil Hord <phil.hord@gmail.com> writes:
> 
> > From: Phil Hord <phil.hord@gmail.com>
> >
> > `git fetch --prune` runs in O(N^2) time normally. This happens because the code
> > iterates over each ref to be pruned to display its status. In a repo with
> > 174,000 refs, where I was pruning 15,000 refs, the current code made 2.6 billion
> > calls to strcmp and consumed 470 seconds of CPU. After this change, the same
> > operation completes in under 1 second.
> > ...
> > V3 forgot to include the first commit in the series (I forgot it grew).
> > So here's V4.
> >
> > Phil Hord (3):
> >   fetch-prune: optimize dangling-ref reporting
> >   refs: remove old refs_warn_dangling_symref
> >   clean up interface for refs_warn_dangling_symrefs
> 
> It seems that the thread has gone quiet.  What's the status of this
> topic?

v4 looks fine to me. I raised a few questions about the translation
strings, but I don't know if they're meaningful or not.

-Peff
