Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EA0813D53B
	for <git@vger.kernel.org>; Mon,  4 Nov 2024 17:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730742392; cv=none; b=Mb9CZzU8enpZ/pRmMEYNTeamcOIvX6vcSxUUk4ld+xVWrXzTuea0Bure4uwideagO1+iTvl8SrFErF/Y1Wz1NhB2XjCC0ElDN0djCycid+ePH+uNR6C8gm6IRocGi73fWqPzYgP68YDoXAXorN46FDCIT1gj9etNHmW1Ua07NWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730742392; c=relaxed/simple;
	bh=jJ2XiPVObbsNT2tmgHvN8wrBZNMnHN6C+tIG4V9BELM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GrQe0B3GsSXxQf5X90fhhXSlmMbP8z3Hcir/fNV0leinNWlDcCbWm3qNOPMjW9+RlOgAX53nzLP6ZCAvfR62X0xqU7Jc8yeigjmrXT+WwjCF70DfGcWX/AHiMaPgwmMDY+jQKLQYhkOXlwFynKGVTtZiiGp/Qntj5elLOiG6D9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=LpEQFSsD; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="LpEQFSsD"
Received: (qmail 13019 invoked by uid 109); 4 Nov 2024 17:46:29 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=jJ2XiPVObbsNT2tmgHvN8wrBZNMnHN6C+tIG4V9BELM=; b=LpEQFSsDJlgviblYPwl/YU8xc0wh4OFJ3qX1LXDINwC3qVR5gbudeDwG/oYy+N1Dq6yaxNOwPS4Gs4nbpX/tgPnCvybVquPlz1a/Stuoy1GQYHTFdZREPJHZuWDJAy+Lm6dTZ2E033GhP96ivNrnJEVwpjHC+YyXki/8cY5pdE/q7m8nFi7ehNx1k+9IxI5hbhnPZOxGj66I4/tlKXBGSUW6apy6K9gbpIV6ieJGlAkTSuAfY9f3SZ5JRzF6m33s9Q+g+WQSme3m0vic0OLquH7xp++rKfZ50Z7q0eL0mRRv7aMKpPivAjlyhZkByMZ8eP6KCDkb8+dYj6W34d1jdQ==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 04 Nov 2024 17:46:29 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 14731 invoked by uid 111); 4 Nov 2024 17:46:29 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 04 Nov 2024 12:46:29 -0500
Authentication-Results: peff.net; auth=none
Date: Mon, 4 Nov 2024 12:46:28 -0500
From: Jeff King <peff@peff.net>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] rev-list: skip bitmap traversal for --left-right
Message-ID: <20241104174628.GA2990236@coredump.intra.peff.net>
References: <20241101121606.GA2327410@coredump.intra.peff.net>
 <ZyToaRxR7upLg0IE@nand.local>
 <20241104174126.GB2985568@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241104174126.GB2985568@coredump.intra.peff.net>

On Mon, Nov 04, 2024 at 12:41:27PM -0500, Jeff King wrote:

> On Fri, Nov 01, 2024 at 10:40:41AM -0400, Taylor Blau wrote:
> 
> > Nice find, and well explained (not just why it doesn't work today but
> > could in the future, but why making it work in the future with bitmaps
> > does not necessarily a clear performance improvement).
> > 
> > Probably you and I should think more about other rev-list options that
> > *don't* work with --use-bitmap-index. I share your feeling there that
> > there probably exist such options which silently do nothing (or the
> > wrong thing) in the presence of '--use-bitmap-index'.
> 
> I'm pretty sure --cherry-pick and --cherry-mark are examples, but I
> suspect it's the tip of the iceberg. I don't know if it's worth spending
> much effort on this. It's certainly a wart, but there's a certain amount
> of "if it hurts, don't do it". The --left-right one bugged me so much
> just because I thought it _would_ work. ;)

Actually, I wonder if this could be an interesting #leftoverbits or
intern mini-project:

  1. Look at the set of rev-list options and pick one.

  2. Repack a repo (say, git.git) with reachability bitmaps using "git
     repack -adb".

  3. Compare output of "rev-list --your-option" with and without
     --use-bitmap-index. If the outputs do not reasonably match, add
     code to try_bitmap_traversal() to forbid it and bail to the
     non-bitmap path. Maybe also other try_bitmap_*() functions, as
     well.

It's a little more involved than other miniprojects just because there
may be some judgement needed for "reasonably match". Being byte-for-byte
identical is good, but in some cases the output will be different (e.g.,
bitmap output is in a different order, lacks path annotations, etc). So
it would help in step (1) if you understand what the option is supposed
to do and how you'd expect it to work with bitmaps. ;)

-Peff
