Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A808C370
	for <git@vger.kernel.org>; Fri, 23 Feb 2024 00:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708646726; cv=none; b=loG98LZRGQXUDf1m3/5ghxUQpn/zO94OBtpriLq82ZguYmFRGP14wWV0+W+Rr60bxi+zzEqkPg+jrSQT6oADbR/m2a2x3/2BnfjoMyMSvo9uejfiTgyLlCdeT5DTz1zUZ6XR5XXtDvALcz9dHJ3uvf/82ENVzcWWo/+sXLvLN5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708646726; c=relaxed/simple;
	bh=pYjmgZ7uU5tZAmCquyek1Xm2w+fduk0eYVAYsKhjE0k=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=e27mWxeoe48uUZ9EDMhQhnBor9gvSc4UWYJQwq0nPmwbKSNB8OhfX7LL3TomyV0XHxnd8gsF0/+BFkgrsrVkSvj+6U5+cEGttnHtlbr5El+ZoMyxgIDq0EB7UByvSY+Mstcb7N+/AXZAXsvoU51ZPlwLfbtj+dDNLQVyYRXgBTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=uiVOyRqZ; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="uiVOyRqZ"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 5A5721CA58;
	Thu, 22 Feb 2024 19:05:22 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=pYjmgZ7uU5tZAmCquyek1Xm2w+fduk0eYVAYsK
	hjE0k=; b=uiVOyRqZMCiYxduWGmhoQmHq8jCehtu63++vY4RvD1fTo8KgBdDMlV
	1zPKM3eZy664fWlKf5Oao5Ql3wTNNKacddws5fgxhLLIwIhdufEc4JvnDX9HygdC
	1Dl7k4u23L0Ts9qsnIO2ntqIAD3bLATWsEC0u27Kp/oJQbhKeFBBs=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 537FA1CA57;
	Thu, 22 Feb 2024 19:05:22 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.176.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id D11B41CA56;
	Thu, 22 Feb 2024 19:05:17 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Josh Steadmon <steadmon@google.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 0/2] commit-graph: suggest deleting corrupt graphs
In-Reply-To: <cover.1708643825.git.steadmon@google.com> (Josh Steadmon's
	message of "Thu, 22 Feb 2024 15:19:05 -0800")
References: <cover.1708643825.git.steadmon@google.com>
Date: Thu, 22 Feb 2024 16:05:16 -0800
Message-ID: <xmqqwmqw82pv.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 3A28CDD8-D1DF-11EE-A61E-A19503B9AAD1-77302942!pb-smtp21.pobox.com

Josh Steadmon <steadmon@google.com> writes:

> At $WORK, we've had a few occasions where someone's commit-graph becomes
> corrupt, and hits various BUG()s that block their day-to-day work. When
> this happens, we advise the user to either disable the commit graph, or
> to delete it and let it be regenerated.
>
> It would be a nicer user experience if we can make this a self-serve
> procedure. To do this, let's add a new `git commit-graph clear`
> subcommand so that users don't need to manually delete files under their
> .git directories. And to make it self-documenting, update various BUG(),
> die(), and error() messages to suggest removing the commit graph to
> recover from the corruption.

I am of two minds.

For one, if we know there is a corruption and if we know that we
will certainly recover cleanly if we removed these files, it would
be fair for an end-user to respond with: instead of telling me to
run "commit-graph clear", you can run it for me, can't you?

The other one is if it hinders debugging the root cause to run
"clear", whether it is done by the end-user or by the mechanism that
detects and dies upon discovery of a corruption.  Do we know how
these commit-graph files become corrupt?  How valuable would these
corrupt files be to help us track down where the corruption comes
from?  If they are not all that useful in debugging, then removing
them ourselves or telling users to remove them may be OK, of course.

Do these BUG()s come from corruption that can be diagnosed upfront
when we "open" the commit-graph files?  I am wondering if it would
be the matter of teaching prepare_commit_graph() to check for
corruption and return without enabling the support.

Thanks.
