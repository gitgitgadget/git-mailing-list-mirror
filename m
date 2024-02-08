Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAA3C4F611
	for <git@vger.kernel.org>; Thu,  8 Feb 2024 21:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707428500; cv=none; b=rMVgKQ+JmjLlIVsYzDmRp0z5aXNXRlwWHFyj0yvrm8JwXt4kZ6+qMwxH1TLQrqREhljlBei6qxsPuQCWKj23xn8F3+PnUHF9whpmdCWTZg1XbEEoBwKHSVmcXntzSYzFlYgU9dq2I1TtDATPBZuA6ifzsDqLXi2xe3pDjyAgvhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707428500; c=relaxed/simple;
	bh=cKSmqOzsH9G5Ef3pUC1Z3SspODMOccfrie5CJ4ePc1E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=owlEwQ3BmuwYo8/ZIYntg4DTMYW2qwDif4ah7fPdQ4PxH/nVS2E//UpSU8rk8sgQThIyCcltAZB/2QeOnmNzjQl3pOOI0/z+0teKRLn2iVutH7XK4raehsB6YKs/sT+FtcevDVoL/hyFuLENtgrcF+oWGZRG7Vcf9zvQ2N4lkk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 25251 invoked by uid 109); 8 Feb 2024 21:41:38 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 08 Feb 2024 21:41:38 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 3831 invoked by uid 111); 8 Feb 2024 21:41:38 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 08 Feb 2024 16:41:38 -0500
Authentication-Results: peff.net; auth=none
Date: Thu, 8 Feb 2024 16:41:37 -0500
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
	Chandra Pratap via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org, Chandra Pratap <chandrapratap376@gmail.com>,
	Chandra Pratap <chandrapratap3519@gmail.com>
Subject: Re: [PATCH] commit.c: ensure strchrnul() doesn't scan beyond range
Message-ID: <20240208214137.GB1090198@coredump.intra.peff.net>
References: <pull.1652.git.1707153705840.gitgitgadget@gmail.com>
 <ce83bd09-dbd2-4c9e-8197-6e4800935523@web.de>
 <20240208010040.GB1059751@coredump.intra.peff.net>
 <8313d9d6-f6bd-4fae-be9c-e7a8129768eb@web.de>
 <xmqqil2yn3ey.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqqil2yn3ey.fsf@gitster.g>

On Thu, Feb 08, 2024 at 11:48:05AM -0800, Junio C Hamano wrote:

> René Scharfe <l.s.r@web.de> writes:
> 
> > But anyway: If NULs are of no concern and we currently end parsing when
> > we see one in all cases, why do we need a _mem function at all?  The
> > original version of the function, find_commit_header(), should suffice.
> > check_nonce() could be run against the NUL-terminated sigcheck.payload
> > and check_cert_push_options() parses an entire strbuf, so there is no
> > risk of out-of-bounds access.
> 
> If I recall correctly, the caller that does not pass strlen() as the
> payload length gives a length that is shorter than the buffer, i.e.
> "stop the parsing here, do not get confused into thinking the
> garbage after this point contains useful payload" was the reason why
> we have a separate "len".

Yes, check_nonce() passes in a length limited by the start of the actual
signature, as determined by parse_signed_buffer(). Though that generally
comes after a blank line, which would also stop find_header() from
parsing further.

But more interestingly: even though we pass a buf/len pair to
parse_signed_buffer(), it then calls get_format_by_sig() which takes
only a NUL-terminated string. So:

  1. It is not possible for the buf/len pair we pass to check_nonce() to
     contain a NUL. And thus there is no caller of find_header_mem()
     that can contain an embedded NUL. So switching from strchrnul() to
     just memchr() should be OK there.

  2. That raises the question of whether parse_signed_buffer() has a
     similar walk-too-far problem. ;) The answer is no, because we feed
     it from a strbuf. But it's not a great pattern overall.

-Peff
