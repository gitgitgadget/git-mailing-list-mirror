Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B5765C8B
	for <git@vger.kernel.org>; Thu,  8 Feb 2024 01:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707354044; cv=none; b=MjjI5Er7wWDj5xEj3nz3C8mgnX8woeGjz9aZerQhdL0+VUs4W7V0w8/hE39RrpNIb5JdV+sJMjjnRrjat1oZST/qDvp+E29LwLh+v4bwr5qSHP1wXGn/78DBR3EutlszTSIhzEbPX4I3mNq1IE4OEXu0dHtnwpcfabcsA1zfaTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707354044; c=relaxed/simple;
	bh=NgtX2C3R4IifT+H11cgyKcxLjV0q1ejV5j8MUeLW2Fs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mBAOQZcS5JqPBpQlZb0NpX07sBUHgVUvFWVfkYc+sa1edC0ntNgn73CiiPcLMaTBj7cJl1Za17kSUPk46xuuTZcPp1fcVC+Q35egndKKT3TyVAoHYNSJriiAvP2oGJr9DSbEQY5Lx899UhiOqyHWQ+wqa+sFM6DwrYVGDPB2SuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 13215 invoked by uid 109); 8 Feb 2024 01:00:41 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 08 Feb 2024 01:00:41 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 25568 invoked by uid 111); 8 Feb 2024 01:00:42 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 07 Feb 2024 20:00:42 -0500
Authentication-Results: peff.net; auth=none
Date: Wed, 7 Feb 2024 20:00:40 -0500
From: Jeff King <peff@peff.net>
To: =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc: Chandra Pratap via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org, Chandra Pratap <chandrapratap376@gmail.com>,
	Chandra Pratap <chandrapratap3519@gmail.com>
Subject: Re: [PATCH] commit.c: ensure strchrnul() doesn't scan beyond range
Message-ID: <20240208010040.GB1059751@coredump.intra.peff.net>
References: <pull.1652.git.1707153705840.gitgitgadget@gmail.com>
 <ce83bd09-dbd2-4c9e-8197-6e4800935523@web.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ce83bd09-dbd2-4c9e-8197-6e4800935523@web.de>

On Mon, Feb 05, 2024 at 08:57:46PM +0100, René Scharfe wrote:

> If you want to make the code work with buffers that lack a terminating
> NUL then you need to replace the strchrnul() call with something that
> respects buffer lengths.  You could e.g. call memchr().  Don't forget
> to check for NUL to preserve the original behavior.  Or you could roll
> your own custom replacement, perhaps like this:

I'm not sure it is worth retaining the check for NUL. The original
function added by me in fe6eb7f2c5 (commit: provide a function to find a
header in a buffer, 2014-08-27) just took a NUL-terminated string, so
we certainly were not expecting embedded NULs.

In cfc5cf428b (receive-pack.c: consolidate find header logic,
2022-01-06) we switched to taking the "len" parameter, but the new
caller just passes strlen(msg) anyway.

I guess you could argue that before that commit, receive-pack.c's
find_header() which took a length was buggy to use strchrnul(). It gets
fed with a push-cert buffer. I guess it's possible for there to be an
embedded NUL there, but in practice there shouldn't be. If we are
thinking of malformed or malicious input, it's not clear which behavior
(finding or not finding a header past a NUL) is more harmful. So all
things being equal, I would try to reduce the number of special cases
here by not worrying about NULs.

(Though if somebody really wants to dig, it's possible there's a clever
dual-parser attack here where "\nfoo\0bar baz" finds the header "bar
baz" in one parser but not in another).

-Peff
