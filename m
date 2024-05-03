Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FE23BA55
	for <git@vger.kernel.org>; Fri,  3 May 2024 17:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714757763; cv=none; b=Qczu8KCtrGHXFkIEBCS0NIu9gMtBz6VKga2IqH0nviBB1AURodYbOVC56DmR/9lWsko0FsXj/2CBkj27+uDUhLJCrbuBjew6735tfYG/uybTA7KezyBV2CX3q69Y1kp/rhq/hP1K+5WopSDojOfjWhjB3SAQEmdsDlHgogTUCPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714757763; c=relaxed/simple;
	bh=rGbus2CbNBJdSyeAYPg0+LvhiLt2He+syKlQMxEhxII=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kvAPBkyNjXIdsanuO7YVz/UIYxiBtQyDi8hKjybl3psRmYfRd14J1iUjNPVndX6yklieyThVtfvu0o5G6JwmdXBiWvLmxO+jYWM+kUIFvDoLC4bBnknQ3cNzdmm/R+eOIwHfRsIP5/yiYNia40rG20PbJNOaxSSajeUYtWQJy2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 11697 invoked by uid 109); 3 May 2024 17:35:54 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 03 May 2024 17:35:54 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 17401 invoked by uid 111); 3 May 2024 17:35:55 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 03 May 2024 13:35:55 -0400
Authentication-Results: peff.net; auth=none
Date: Fri, 3 May 2024 13:35:53 -0400
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Subject: Re: [PATCH 0/5] refs: remove functions without ref store
Message-ID: <20240503173553.GC3631237@coredump.intra.peff.net>
References: <cover.1714717057.git.ps@pks.im>
 <xmqqikzu95cf.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqikzu95cf.fsf@gitster.g>

On Fri, May 03, 2024 at 10:24:00AM -0700, Junio C Hamano wrote:

> Patrick Steinhardt <ps@pks.im> writes:
> 
> > It is quite likely that this patch series will impact in-flight patch
> > series. I'd be quite happy to drop the last patch that removes the old
> > interfaces to make this a bit less painful.
> 
> The last step could replace these deprecated-to-be-removed functions
> with a stub that BUG()s out [*], with a comment to instruct how a
> caller can be rewritten to use the corresponding refs_ variant with
> a call to get_main_ref_store(the_repository) as the first parameter,
> which would help out of tree and in-flight series to migrate.
> 
> [Footnote]
> 
>  * The exact mechanism to cause an attempted use of an old function
>    fail is immaterial.  We can remove the definition of these
>    functions while retaining the old implementation as comments, or
>    wrap them in an #ifdef USE_REF_STORE_LESS_FUNCTIONS .. #endif
>    pair _without_ defining USE_REF_STORE_LESS_FUNCTIONS, purely for
>    the documentation value to help us migration.

I prefer strict removal, as then the problem is caught by the compiler,
rather than runtime/tests. The error message does not point the user in
the right direction, but IMHO that is trumped by finding it sooner in
the edit-compile-test cycle.

Though maybe an even more radical proposal: now that read_ref_full(),
etc, are gone, and we have only refs_read_ref_full(), could/should we
shorten the latter to drop the "refs_" prefix? Its original purpose of
distinguishing the "takes a ref store vs using the_repository" variants
is now done, and shorter names are less annoying. But:
 
  - maybe there is value in having ref-related functions namespaced? We
    certainly don't cover all ref functions here, though, and aside from
    tight OO-ish APIs (e.g. strbuf) we don't usually do so at all.

  - the error message for in-flight callers of the "old" names will be
    even more confusing (it will not be "foo() does not exist" but
    rather "you did not pass enough arguments to foo()").

-Peff
