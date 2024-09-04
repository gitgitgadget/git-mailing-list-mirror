Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7088C146D7F
	for <git@vger.kernel.org>; Wed,  4 Sep 2024 22:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725489782; cv=none; b=HUYSZfI82H4pmLRr18KREdnRbvp+iWbvO3cLIroxEaZem61kAOJ4sRZzFDC22mDIn9wgxSC0IvcraxcsSo0eowQKOyneS8QVV6wPW0szh4o9I+k3E46qHPRC5raHrcnD2hi0cn3uTsm71BoPVN1eImPGHH8gkHwhLZhonkkl2Nc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725489782; c=relaxed/simple;
	bh=GvoPLVJIwuLQsml3kAilYp8pRxvEDr8VpsGv1uO41tA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=l1sWyZZMdt45/9m8OuTZiEyRYWgZdl/Nm/A1kSiqZYEl+FswLhxX4E4IXlX7lJmkK2zATlG8bU/697sKAz/WNt5p3HO90jIXoaH40JmhiusCCFlnxkD8sVereQLienI4v22s4WLfbsSWwBCBXM0LqQnzh0xDdp5yqX+A1ftex28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=p1I/8CTx; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="p1I/8CTx"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 38955218F2;
	Wed,  4 Sep 2024 18:43:00 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=GvoPLVJIwuLQsml3kAilYp8pRxvEDr8VpsGv1u
	O41tA=; b=p1I/8CTx0oq0HXi/2ePOXUUebfq40TkOXP+d/ymadOUKbJ9yyT9CGs
	Lh/dycTqxIr+QL5+/pnqOq5SBv0asQ18Zicwej4DHjuxRxpcXE8GcVLHfn7fGUk/
	SNHMI4JTK5M5ZMS1repdnpQjSDb+c15jCdb1Em6P1IYuolVfJSwjw=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 30F0A218F1;
	Wed,  4 Sep 2024 18:43:00 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.94.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 7862D218ED;
	Wed,  4 Sep 2024 18:42:58 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 20/22] match-trees: fix leaking prefixes in `shift_tree()`
In-Reply-To: <05461e3b1c02488046ef480f20c109b51b9b7691.1724656120.git.ps@pks.im>
	(Patrick Steinhardt's message of "Mon, 26 Aug 2024 09:22:34 +0200")
References: <cover.1724656120.git.ps@pks.im>
	<05461e3b1c02488046ef480f20c109b51b9b7691.1724656120.git.ps@pks.im>
Date: Wed, 04 Sep 2024 15:42:57 -0700
Message-ID: <xmqqa5gn6nwu.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 089EB3BC-6B0F-11EF-8CF7-9B0F950A682E-77302942!pb-smtp2.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

> In `shift_tree()` we allocate two empty strings that we end up
> passing to `match_trees()`. If that function finds a better match it
> will update these pointers to point to a newly allocated strings,
> freeing the old strings. We never free the final results though, neither
> the ones we have allocated ourselves, nor the one that `match_trees()`
> might've returned to us.
>
> Fix the resulting memory leaks by creating a common exit path where we
> free them.
>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  match-trees.c            | 10 +++++++---
>  t/t6409-merge-subtree.sh |  1 +
>  2 files changed, 8 insertions(+), 3 deletions(-)

We are not going to take the "best_match" out of this
function, so somebody ought to free it, and that somebody must be
this function.

Makes sense.
