Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADE98F9F0
	for <git@vger.kernel.org>; Mon, 22 Jan 2024 22:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705963349; cv=none; b=Ny4lX24jENrXO+4VQsG5hdf2hbi98UTj7yTjj3jYj+96+YZRnbhq2JiBVzUiiY622TgJaViIogpuls9evNRZcueayXHPYsTXJGaKkakwr0yLvyRQwg8LVBX1k+uVX+sF9M6rKSlKdpwTjJQb90U5OX8yTAjetgr5WwawlOBhBHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705963349; c=relaxed/simple;
	bh=CYTXxuz7pwHnXKuzGxZVNU0FL8lA0OlAkd2H3kpfklw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J7+tkIFkwHSUqpm16+JJ47DQIV0CA0f9rYTL/kyun4QVgHfTnQ+QyxtGylgNzDOhNVhXF/4c3+wVzGGVRI0o3uxR4j00vPrJ3JZMAPR8fNE8Ld/2RZbLToRcawb1gNl+4WgLwjCNHKwKbmjI64bNhP8YidDW9JF4eUPPflsznEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 11961 invoked by uid 109); 22 Jan 2024 22:42:26 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 22 Jan 2024 22:42:26 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 10106 invoked by uid 111); 22 Jan 2024 22:42:25 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 22 Jan 2024 17:42:25 -0500
Authentication-Results: peff.net; auth=none
Date: Mon, 22 Jan 2024 17:42:23 -0500
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: Chandra Pratap via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org, Chandra Pratap <chandrapratap3519@gmail.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Chandra Pratap <chandrapratap376@gmail.com>
Subject: Re: [PATCH v4] tests: move t0009-prio-queue.sh to the new unit
 testing framework
Message-ID: <20240122224223.GA814674@coredump.intra.peff.net>
References: <pull.1642.v3.git.1705502304219.gitgitgadget@gmail.com>
 <pull.1642.v4.git.1705865326185.gitgitgadget@gmail.com>
 <xmqqwms1tcb0.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqwms1tcb0.fsf@gitster.g>

On Mon, Jan 22, 2024 at 11:09:39AM -0800, Junio C Hamano wrote:

> > +		case DUMP:
> > +			while ((peek = prio_queue_peek(&pq))) {
> > +				get = prio_queue_get(&pq);
> > +				if (!check(peek == get))
> > +					return;
> > +				if(!check_int(result[j++], ==, show(get)))
> > +					test_msg("failed at result[] index %d", j-1);
> > +			}
> > +			break;
> 
> OK.  So this one checks as we go.  I am not sure how easy to grok a
> breakage diagnosis with these giving the same message, without
> giving any context of the failure (e.g. when we are fed
> 
> 	INPUT  = 6 2 4 GET 5 3 GET GET 1 DUMP
> 	EXPECT = 2 3 4 1 5 6
> 
> and for some reason if the first GET did not yield expected 2 but
> gave us, say, 6, we only see "left: 2, right: 6" followed by "failed
> at result[] index 0", and nothing else.  
> 
> If it said something like "We pushed 6, 2, 4 and then did GET" to
> give the reader a bit more context, it would make it easier to see
> why we were complaining, i.e. expecting to see 2, instead getting 6.
> But perhaps that is too much to ask to this code?
> 
> I dunno.  Those who wanted to see an easier-to-diagnose output may
> have better ideas.

I don't have any bright ideas, but here are some dumb ones.

The big issue is that storing and manipulating data in C is tricky and
requires code to do correctly. And the whole idea of these tests is to
avoid having a ton of special code. That's why I actually think that the
existing strategy used in t0009 and elsewhere is pretty good. It pawns
off output handling and such to existing programs.

But if we really want to keep it all in C, some options are:

  1. We could log what is happening verbosely to stderr (or maybe stdout
     with a TAP "#" prefix?). That lets it go nowhere most of the time,
     but you can see it if you are investigating a failure (like the way
     our current "-v" works).

     Obviously by that same argument you can fire up a debugger to look
     at the problem more closely when you have a failure. But failures
     aren't always easy to reproduce. Sometimes they're racy, sometimes
     CI fails but local runs don't (I've found CI's use of "-v -x"
     especially helpful there), etc.

  2. We can rely on a dynamic-growth array of ints to store the result,
     and then a check_int_array() to compare/output them. That's custom
     code for the test harness, but in theory it's reusable across many
     tests.

  3. In the same direction, we could simply output to a strbuf or
     similar, and then compare the strbufs. We could even show a diff
     when they are not the same. ;) That is reimplementing what scripts
     like t0009 are doing already, but maybe people think there is other
     value in shoving it all into a single C program (as I've said, I
     remain a bit skeptical).

-Peff
