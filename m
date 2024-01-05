Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A081136083
	for <git@vger.kernel.org>; Fri,  5 Jan 2024 19:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="ZMqqX5QO"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 2CD971C8F67;
	Fri,  5 Jan 2024 14:56:17 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=7f0zMneusUxT+QS6dFPz6RENUUXxH85mdLr6Uv
	igQFI=; b=ZMqqX5QOBRuyDiV8m1qB6QFdb/RHC6c8jS+FsGayu1bLKWbYtNapnp
	nryEFTAoNrRPf8PwZ4qxDxQaCrEMqy3HHnYtnAZAoINyQFQh6QD7wcWWkZmPmai7
	KgVN4K55srNhv4VOrgrNRYLDkRzzms2vXPOdInJLvp75LVQjMt/DQ=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 257E61C8F66;
	Fri,  5 Jan 2024 14:56:17 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.200.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 8BDE91C8F65;
	Fri,  5 Jan 2024 14:56:16 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org,  Scott Leggett <scott@sl.id.au>,  Taylor Blau
 <me@ttaylorr.com>
Subject: Re: [PATCH] commit-graph: retain commit slab when closing NULL
 commit_graph
In-Reply-To: <20240105054142.GA2035092@coredump.intra.peff.net> (Jeff King's
	message of "Fri, 5 Jan 2024 00:41:42 -0500")
References: <20240105054142.GA2035092@coredump.intra.peff.net>
Date: Fri, 05 Jan 2024 11:56:15 -0800
Message-ID: <xmqqedevo8ps.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 7CA1E696-AC04-11EE-AC4C-78DCEB2EC81B-77302942!pb-smtp1.pobox.com

Jeff King <peff@peff.net> writes:

> This fixes a regression introduced in ac6d45d11f (commit-graph: move
> slab-clearing to close_commit_graph(), 2023-10-03), in which running:
> ...
> So it happens to work out. But it still seems questionable to me that we
> would clear a global slab (which might still be in use) when closing the
> commit graph. This clearing comes from 957ba814bf (commit-graph: when
> closing the graph, also release the slab, 2021-09-08), and was fixing a
> case where we really did need it to be closed (and in that case we
> presumably call close_object_store() more directly).

Wow, that is nasty.

But anyway, thanks for your usual "3 pages of explanation for 2
lines of change".  The patch does look the best fix in the meantime.
