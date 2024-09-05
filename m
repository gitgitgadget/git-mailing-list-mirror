Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15DA7757FC
	for <git@vger.kernel.org>; Thu,  5 Sep 2024 15:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725549520; cv=none; b=UGeYEfrHmNeIiNYazOnVcaeYIg4+RRJoGds0raCZoCNvnwYGtMspE1OGfjbvaBEz5IPnbsjH3EjlE65x9SWBIaemiqPXS++fnEdWJMAZs4oqpF5gn/FplR6D/n6wx+Wg6fIwhhiK4syyuK9awf4ODNnmhp9YuBlJN/OI11zFWe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725549520; c=relaxed/simple;
	bh=XO1b+tVt4+Pj7CFkHBqQVNOY2ZnTDEDVOW2v/AkldlA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=EdGldXJsmufoI5WLHEObcLkVrJsRk5mTzBhbJQUblGCJCb91ChWL8Jjhmha63cBi+KHDmPHvQ8fzNiWYke4xFaYcgVZAeGOmFEAszjjc7XssE4Mr2mfdWPXMkjQpGcnEWzB3Yq01i66xYSQGfWU8Zb937cla4BlFrarnfjzFork=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=jg4ZamxR; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="jg4ZamxR"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id E13DD2B965;
	Thu,  5 Sep 2024 11:18:37 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=XO1b+tVt4+Pj7CFkHBqQVNOY2ZnTDEDVOW2v/A
	kldlA=; b=jg4ZamxRKyaS8jR13/IVFiLGdJRgwvEvYakLdIV3+z/GHPynGLExXC
	lC/rQ5VFE5xgHuHfxYTdyWwxs0jx/cIp3RFJ7whDWVt0ntEmz65a2D4ulyaYsMiy
	5Vq1qnWe98xK2nOG67ZWBwjCYGHegNWWGItqGjh4mQMQZABvdHr+M=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id D98C32B964;
	Thu,  5 Sep 2024 11:18:37 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.94.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 454122B961;
	Thu,  5 Sep 2024 11:18:37 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] drop trailing newline from warning/error/die messages
In-Reply-To: <20240905085149.GA2340826@coredump.intra.peff.net> (Jeff King's
	message of "Thu, 5 Sep 2024 04:51:49 -0400")
References: <20240905085149.GA2340826@coredump.intra.peff.net>
Date: Thu, 05 Sep 2024 08:18:36 -0700
Message-ID: <xmqqfrqe5dtf.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 1FB7A3DE-6B9A-11EF-95F0-9B0F950A682E-77302942!pb-smtp2.pobox.com

Jeff King <peff@peff.net> writes:

> Our error reporting routines append a trailing newline, and the strings
> we pass to them should not include them (otherwise we get an extra blank
> line after the message).
>
> These cases were all found by looking at the results of:
>
>   git grep -P '[^_](error|error_errno|warning|die|die_errno)\(.*\\n"[,)]' '*.c'
>
> Note that we _do_ sometimes include a newline in the middle of such
> messages, to create multiline output (hence our grep matching "," or ")"
> after we see the newline, so we know we're at the end of the string).
>
> It's possible that one or more of these cases could intentionally be
> including a blank line at the end, but having looked at them all
> manually, I think these are all just mistakes.
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
> I just happened to notice one of these, so I grepped for more.

Just like what a good developer would do ;-)  Thanks.

I am a bit surprised (and feel somewhat relieved) that no tests try
to match the messages exactly (with test_cmp, not with test_grep).
