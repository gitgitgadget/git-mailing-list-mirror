Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03F341635C7
	for <git@vger.kernel.org>; Wed,  1 May 2024 22:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714603254; cv=none; b=HNAn/cGUSwRbZ2uZN8Q3zmg15olAqkuZcmDWcemxn3IOsa7dY9eKlvAQA0KxpIQuVU5h4oFNiU/6ZCdNasGsyxGr3n2y3z3RTdZlr9xZyhWUH7vUoDaTzmeyFPQQadK7PdqF4X+bB3h2c53zShmYpoxClrL0TVfaxK6trt888CI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714603254; c=relaxed/simple;
	bh=VPXzg0XDov0WgLxqHBlGu1LIDVL9kL2gvyU48u72fLs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=plb0b1j1l1AI1QlmmaquyxLWMI2eTEwQiTGD4pwthOnDmuPjUeS3bOmK6otGqX3D6NIgTJGqYndfsd7aRCeliBPVhlxkdDc6EgaaqpZXgqUwtY7ndm7A4bYDSF+m9U9gbO/YCqpWmLUbSP/B/jr3I7BCvW2BnNM5FZtNTwge9wQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=Jaqhp2V4; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Jaqhp2V4"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 462262B7E0;
	Wed,  1 May 2024 18:40:52 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=VPXzg0XDov0WgLxqHBlGu1LIDVL9kL2gvyU48u
	72fLs=; b=Jaqhp2V4VHIS27zKWY+q/O4m/wi0ooZtTEh8JQsg1jNU77DGKtpXq+
	aRn3x7W3RbRcOBYh66kDLT09Vqsu6fRZc+K0Y4dBC3yTGXwmxYpIczbsxoXJkz8L
	TJ3Vlkwkq4vB8YJCQF30JEZ5pvGH0MN40oAZxImeA9l0j66AeeZ6s=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 3E12D2B7DF;
	Wed,  1 May 2024 18:40:52 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.120.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id A54722B7DC;
	Wed,  1 May 2024 18:40:47 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: Dhruva Krishnamurthy <dhruvakm@gmail.com>,  John Cai
 <johncai86@gmail.com>,  Karthik Nayak <karthik.188@gmail.com>,
  git@vger.kernel.org
Subject: Re: using tree as attribute source is slow, was Re: Help
 troubleshoot performance regression cloning with depth: git 2.44 vs git
 2.42
In-Reply-To: <20240501220030.GA1442509@coredump.intra.peff.net> (Jeff King's
	message of "Wed, 1 May 2024 18:00:30 -0400")
References: <CAKOHPAn1btewYTdLYWpW+fOaXMY+JQZsLCQxUSwoUqnnFN_ohA@mail.gmail.com>
	<20240501220030.GA1442509@coredump.intra.peff.net>
Date: Wed, 01 May 2024 15:40:45 -0700
Message-ID: <xmqqikzxi2aa.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 DA9956E0-080B-11EF-B46A-A19503B9AAD1-77302942!pb-smtp21.pobox.com

Jeff King <peff@peff.net> writes:

>   - the cache here is static-local in the function. It should probably
>     at least be predicated on the tree_oid, and maybe attached to the
>     repository object? I think having one per repository at a time would
>     be fine (generally the tree_oid is set once per process, so it's not
>     like you're switching between multiple options).

It should be per tree_oid or you will get a stale and incorrect
result when you read paths from a different tree.  But thanks for
that "something simple and stupid" code to clearly demonstrate
that repeated reading of the attributes data is the problem.

Given a tree with a name, the result of reading a path from that
tree does not depend on the repository the tree appears in, so the
cache does not have a reason to be tied to a particular repository.
Generally we work only inside a single repository, so attaching the
cache to that single repository would be a good way to make it
available globally without adding another global variable, as
the_repository can serve as the starting point for the global state,
but other than that there is no reason.

I agree that the attribute layer may be a better place to cache this
data.  As you pointed out, it already has a caching behaviour in its
attr_stack data structure that is optimized for local walk that
visits every path in a tree in depth first order, but it is likely
that a different caching scheme that is more suitable for random
access may need to be introduced.  The cache eviction strategy may
need some thought (the attr_stack based caching has an obviously
optimal eviction strategy---to evict the attribute data read from a
directory when the traversal leaves that directory) in order to
avoid unbounded bloat of the cached data.

> I've cc'd John as the author of 2386535511. But really, that was just
> enabling by default the attr-tree code added by 47cfc9bd7d (attr: add
> flag `--source` to work with tree-ish, 2023-01-14). Although in that
> original context (git check-attr) the lack of caching would be much less
> important.
>
> -Peff
