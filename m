Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3BBCA3D
	for <git@vger.kernel.org>; Sun,  7 Apr 2024 01:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712453328; cv=none; b=hrWp/O/ZIcDW9UKOdPeNDcDnSUqhQ2Q1LwjsdbI/dfTIc+SUowkOZFR9htyjtG05RWboHuDjnSpOqZD7ecpIYK3rop3Ej/SmXYGDDk9SOfPTN3kDroEeTtn3Z5SySk21qh500vTEp5ZJfclITNM3Dk1NRoDpDhpa1fH4tXdCEns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712453328; c=relaxed/simple;
	bh=KoOvAzFc2f01k1QVWchE+JcHltZ+XlBUoRS860fGV/M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E0mVPbLpvVkoYb4jT+R9JT2R+o0SUP1G4o73Y2Jg7tMYL1vD7nXLt42WuW2neT8aP2fhQIkpNpl5/+4i6cvw68Qyj242GiiMoLP4zXe60MkzK9eTH1Q+Mpx/K95+wqYdy0LegS38txV4HzkRsUw7HLbj5E/EdjZxkjCCmajVL+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 8353 invoked by uid 109); 7 Apr 2024 01:28:45 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sun, 07 Apr 2024 01:28:45 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 11564 invoked by uid 111); 7 Apr 2024 01:28:48 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 06 Apr 2024 21:28:48 -0400
Authentication-Results: peff.net; auth=none
Date: Sat, 6 Apr 2024 21:28:44 -0400
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
	Git List <git@vger.kernel.org>,
	Chandra Pratap <chandrapratap3519@gmail.com>
Subject: Re: [RFC][PATCH] t-prio-queue: simplify using compound literals
Message-ID: <20240407012844.GC1085004@coredump.intra.peff.net>
References: <520da361-1b80-4ba3-87b2-86d6fdfc18b5@web.de>
 <20240402204153.GE875182@coredump.intra.peff.net>
 <c6cb255a-72f0-4ac2-81a2-1d8e95570a81@web.de>
 <20240405191714.GA2561807@coredump.intra.peff.net>
 <xmqqedbjtqnr.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqqedbjtqnr.fsf@gitster.g>

On Fri, Apr 05, 2024 at 03:01:44PM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > Yeah, this seems pretty reasonable. I think we've traditionally been
> > hesitant to pass or return structs by value, but that's mostly
> > superstition.
> 
> We should still be hesitant against the practice to the same degree
> that we are hesitant against struct assignment, especially when the
> struct is of nontrivial size, or the struct has a pointer member
> whose memory ownership semantics goes against shallow copying of the
> struct.

Good point. There are really two thresholds: is this something that
should be totally forbidden, and is this something that is generally a
good idea. I think the answers here are "no" and "yes" respectively.

It is an OK solution for "plain old data" types like date_mode that are
essentially just marshalling arguments, but not for more object-oriented
code that might have ownership over pointers.

> In this particular case, I do not know offhand if .strftime_fmt is
> safe to be shallowly copied, but I trust you two know and/or have
> already looked at the implications.

René already went through each caller, but yeah, I think it is fine
here. This whole thing is just a convenience over having callers pass
around a separated (enum, strftime_fmt, local) triple.

-Peff
