Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BB3C604A7
	for <git@vger.kernel.org>; Mon, 26 Feb 2024 16:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708965335; cv=none; b=M8+DEEwDvCEbN/yGtXXRl+m3DNlYpgGBa/UsEpuu2l1BMTRAhFNQNO862BrHA1kjPLjVCGXL1YOnjedM4sODZlEMGbqo1UbXAhHrhvCdGIqguY2OS0stpyAG4MMqdwM517fW//H8irC4EpoYb8aMFV88fvwxZOe1bwiCMJyo9eY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708965335; c=relaxed/simple;
	bh=MbxhSfzZFGQyWkkH7+EVOdkzmmEFGzYs0V/3stG8H1Y=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=VVqdAO1Qj46z8aQSrYK8+uWkL9mKb8YeFnSXXmZJsMI1kYhjlNjz+EnJMtU0WC45Qbb9UXC2mpbHJbsDgKdejAL93tLQtjjV9opcGWWzBKeT87g0QURFl9z8vexYZzBd3p2vK0NxEDaccqH7uDAu5XHuAZlu7wQqK2D/qLt+8r4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=Z9hX+38E; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Z9hX+38E"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 598131A911;
	Mon, 26 Feb 2024 11:35:33 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=MbxhSfzZFGQyWkkH7+EVOdkzmmEFGzYs0V/3st
	G8H1Y=; b=Z9hX+38EonEyKiv+rIf8pq2j1Z9nvDYwuNVupxS1CAR/jD5wE96ReB
	SjAnXo+MDevj7ZJaRSSIhzW1CHPegLO2YU2SiuQLecfY7jIiMlcNluYefPUgYtQ4
	88yyHypG8ff0qS3XJQsqV9DxaXdE9od9SO+v5dUFoAA9RRivxREfo=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 373511A910;
	Mon, 26 Feb 2024 11:35:33 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.176.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id D0A381A90F;
	Mon, 26 Feb 2024 11:35:29 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: =?utf-8?Q?Pawe=C5=82?= Dominiak <dominiak.pawel@gmail.com>,
  git@vger.kernel.org
Subject: Re: [PATCH] userdiff: skip textconv caching when not in a repository
In-Reply-To: <20240226102729.GB2685773@coredump.intra.peff.net> (Jeff King's
	message of "Mon, 26 Feb 2024 05:27:29 -0500")
References: <CACeVQwQ4MELjB8nZyeu9QDTtgwhhw0oOsL8BHdm_rxTj1vMy+A@mail.gmail.com>
	<20240226072248.GC780982@coredump.intra.peff.net>
	<CACeVQwRkoJejrWvym_BAZE-OWi+q3RZfyEpwAwA+0hGUBCeD=Q@mail.gmail.com>
	<20240226102729.GB2685773@coredump.intra.peff.net>
Date: Mon, 26 Feb 2024 08:35:28 -0800
Message-ID: <xmqqle77dvzj.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 0DB519A8-D4C5-11EE-9D80-A19503B9AAD1-77302942!pb-smtp21.pobox.com

Jeff King <peff@peff.net> writes:

> Subject: userdiff: skip textconv caching when not in a repository
>
> The textconv caching system uses git-notes to store its cache entries.
> But if you're using "diff --no-index" outside of a repository, then
> obviously that isn't going to work.
>
> Since caching is just an optimization, it's OK for us to skip it.
> However, the current behavior is much worse: we call notes_cache_init()
> which tries to look up the ref, and the low-level ref code hits a BUG(),
> killing the program. Instead, we should notice before setting up the
> cache that it there's no repository, and just silently skip it.

Makes sense.

Will queue.  Thanks.
