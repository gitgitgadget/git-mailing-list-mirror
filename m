Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2E895786D
	for <git@vger.kernel.org>; Tue, 20 Feb 2024 02:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708397845; cv=none; b=sL8WAJ+Jv+hYRZhQh6Ve/vhsj7O+ksqwo0QWSpk0neFhivE8J6+b9oUfaABOnOms/rp1a+qyWpLa11AWvEJci4/L14xeIk+dxJWmHikzCeuOyfxUvJPrE/3mJYzoAjH8UQRN92XNp1WjAYpz+/PQiRmKcUT8GeR8vh64vHSxAGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708397845; c=relaxed/simple;
	bh=Ypshan5Qy11ShtlMmsxWLZraCKujbLICi23Ae6XGElY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qb/0s0y6h+MSKdY6d+eM3rJmTcBtaZTEX6xuw+TflbWf+i6zS1hRBYqEqQhL7aBdesp0hSSizIZBN4BtKGvI4ioZtIyzAQI//AqEEhM/iqz7GnzUy4KD2rAOx8OHutc982nENK7YllS/LGGSGNgIfhIgCs3uBxAmJJ0DRARK4ik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 23501 invoked by uid 109); 20 Feb 2024 02:57:23 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 20 Feb 2024 02:57:23 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 19077 invoked by uid 111); 20 Feb 2024 02:57:25 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 19 Feb 2024 21:57:25 -0500
Authentication-Results: peff.net; auth=none
Date: Mon, 19 Feb 2024 21:57:22 -0500
From: Jeff King <peff@peff.net>
To: phillip.wood@dunelm.org.uk
Cc: Philip Peterson via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Emily Shaffer <nasamuffin@google.com>,
	Philip Peterson <philip.c.peterson@gmail.com>
Subject: Re: [PATCH 0/5] promise: introduce promises to track success or error
Message-ID: <20240220025722.GE2713741@coredump.intra.peff.net>
References: <pull.1666.git.git.1708241612.gitgitgadget@gmail.com>
 <bd340a27-bfb4-41b2-a1fa-356ab7dbbd36@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <bd340a27-bfb4-41b2-a1fa-356ab7dbbd36@gmail.com>

On Mon, Feb 19, 2024 at 02:25:29PM +0000, Phillip Wood wrote:

> I think we'd be better served by some kind of structured error type like the
> failure_result in this patch series that is allocated on the stack by the
> caller at the entry point to the library and passed down the call chain.
> That avoids the need for lots of dynamic allocations and allows us to
> continue allocating "out" parameters on the stack. For example
> 
>     int f(struct repository *r) {
> 	struct object_id oid;
> 
> 	if (repo_get_oid(r, "HEAD", &oid))
> 		return error(_("could not parse HEAD"))
> 
> 	/* use oid here */
>     }
> 
> would become
>     int f(struct repository *r, struct error *err) {
> 	struct object_id oid;
> 
> 	if (repo_get_oid(r, "HEAD", &oid))
> 		return error(&err, _("could not parse HEAD"))
> 
> 	/* use oid here */
>     }
> 
> I'm sure this has been discussed in the past but I didn't manage to turn
> anything up with a quick search of the archive on lore.kernel.org.

There's some discussion in this sub-thread:

  https://lore.kernel.org/git/20171103191309.sth4zjokgcupvk2e@sigill.intra.peff.net/

that also references this earlier thread:

  https://lore.kernel.org/git/20160927191955.mympqgylrxhkp24n@sigill.intra.peff.net/

I still think this is a reasonable way to go. At one point I had a
proof-of-concept conversion of some of the ref code, but I don't think I
have it any more.

-Peff
