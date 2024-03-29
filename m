Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CAF61096F
	for <git@vger.kernel.org>; Fri, 29 Mar 2024 11:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711711662; cv=none; b=qFXQle4h9EP33UrseUrpguLh7H4rcWnAjTwOqs4cJhFBGZV65kPmY85Hc1g4gSN3VFAM30O4hopJz7QC0I48vJVjGciit2or6oS/oP/4kduvrq+e314SM2wiMJ5R5XRbPZ6QdkH82osZAYb7dcM54oQ/axj57WfFRNtHDajMiog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711711662; c=relaxed/simple;
	bh=3GXuyvRyscrTiQroZYbdxKKlP1D7Es3dYiYHVgxagtQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U809+xYNeXt3lkPnrxElw3zPM9GHkenga4XGcGLYG3D7pi3uMNruJE2oeGRIrUbvxUVWfDuq2Rcp3hm4/bT7k3Q0ArZH13oRk4VB5wXshGsbRXwO6UbZdViknvuBZxTut3ZYQ20ymmQfuhGksl8NJQZBrusiYECxUyJmTTV43Lw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 17940 invoked by uid 109); 29 Mar 2024 11:27:32 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 29 Mar 2024 11:27:32 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 18308 invoked by uid 111); 29 Mar 2024 11:27:31 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 29 Mar 2024 07:27:31 -0400
Authentication-Results: peff.net; auth=none
Date: Fri, 29 Mar 2024 07:27:30 -0400
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
	Han Young <hanyang.tony@bytedance.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v2] t4126: make sure a directory with SP at the end is
 usable
Message-ID: <20240329112730.GA15842@coredump.intra.peff.net>
References: <20240319095212.42332-1-hanyang.tony@bytedance.com>
 <xmqqttl2qml9.fsf@gitster.g>
 <xmqqfrwlltjn.fsf@gitster.g>
 <xmqqsf0bz5oj.fsf@gitster.g>
 <20240328103254.GA898963@coredump.intra.peff.net>
 <20240328114038.GA1394725@coredump.intra.peff.net>
 <CAPig+cQe1rAN2MUFTwo7JoCt3sO2eCk_psnJL9D=Rs=Q9MWO9A@mail.gmail.com>
 <xmqqa5miuutd.fsf@gitster.g>
 <xmqqh6gqt674.fsf_-_@gitster.g>
 <xmqqil15srub.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqil15srub.fsf@gitster.g>

On Thu, Mar 28, 2024 at 07:18:52PM -0700, Junio C Hamano wrote:

> Junio C Hamano <gitster@pobox.com> writes:
> 
> > +test_expect_success 'parsing a patch with no-contents and a funny pathname' '
> >  	git reset --hard &&
> > +	empty_blob=$(test_oid empty_blob) &&
> > +	echo "$empty_blob" >expect &&
> >  
> > +	git update-index --add --cacheinfo "100644,$empty_blob,funny /empty" &&
> 
> It seems that on Windows, this step fails with "funny /empty" as
> "invalid path".
> 
> https://github.com/git/git/actions/runs/8475098601/job/23222724707#step:6:244

Ah, sorry, I didn't actually try my suggestion on Windows. I guess we
are falling afoul of verify_path(), which calls is_valid_path(). That is
a noop on most platforms, but is_valid_win32_path() has:

                  switch (c) {
                  case '\0':
                  case '/': case '\\':
                          /* cannot end in ` ` or `.`, except for `.` and `..` */
                          if (preceding_space_or_period &&
                              (i != periods || periods > 2))
                                  return 0;

I'm mildly surprised that we did not hit the same problem via "git add".
But I think it does indeed call verify_path(). It's just that the
filesystem confusion prevented us from even seeing the path in the first
place, and we never got that far.

It's interesting that there is no way to override this check via
update-index, etc (like we have "--literally" for hash-object when you
want to do something stupid). I think it would be sufficient to make
things work everywhere for this test case. On the other hand, if you
have to resort to "please add this index entry which is broken on my
filesystem" to run the test, maybe that is a good sign it should just be
skipped on that platform. ;)

-Peff
