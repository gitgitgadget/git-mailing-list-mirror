Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AF212581
	for <git@vger.kernel.org>; Sun, 22 Sep 2024 16:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727023268; cv=none; b=KxFq8YM6ybUYXUlYD2PEHoCfNaFhXWQ6UKsBKKTzln708UvdbEn622BvLQlA4ioEKevtj+e1XBL+L5n5jlI74E0vSIZAlJuXeDb1rU/a8yctu3tC9J4POubUQQMrTXTs2a/ffbpoTmaD9ohmu7R8ZpB4+/pjHjeEh3m8BResTCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727023268; c=relaxed/simple;
	bh=N4J999y69Kyf7sKw0y9KHRJKb5f0FkP7VMLlel86btY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=p85Z3fztmaWT9+BbySQZr20HZWkU+iYIGHt7kRtCOK0PRRBHLawzmWcpKSfEni/Fbqz+MEtyeBKWkxXYAu+FU/2WX30JIHJfVgGOnmWSOpVDyVd+2p1myq4pVsEtGydYpZabHn61die64csGHKUZvzNZOJrgbproXMt53asqgI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=YAZU/LR6; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="YAZU/LR6"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 490FF3D083;
	Sun, 22 Sep 2024 12:41:03 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=N4J999y69Kyf7sKw0y9KHRJKb5f0FkP7VMLlel
	86btY=; b=YAZU/LR6io5RehNrkZQlp0/4uXTlSIaJPzsjWOl046hUR/7Yu+axA3
	Y9TDwhiYEkIwZN0Zfl6yeA+N8t9Lrh6PwCctK0PbgX0fFDuk2SzwsahwQaMCJaLB
	1wUarfGiJeaD3JivmHaT105dh/jPrSGGzjYLkO0ECj8FxxEXPXw9s=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 371683D082;
	Sun, 22 Sep 2024 12:41:03 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.108.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 6996B3D081;
	Sun, 22 Sep 2024 12:41:02 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Calvin Wan <calvinwan@google.com>
Cc: git@vger.kernel.org,  hanyang.tony@bytedance.com,
  jonathantanmy@google.com,  sokcevic@google.com
Subject: Re: [PATCH 2/2] fetch-pack.c: do not declare local commits as
 "have" in partial repos
In-Reply-To: <xmqqr09c89id.fsf@gitster.g> (Junio C. Hamano's message of "Sat,
	21 Sep 2024 23:53:14 -0700")
References: <20240802073143.56731-1-hanyang.tony@bytedance.com>
	<20240919234741.1317946-3-calvinwan@google.com>
	<xmqqr09c89id.fsf@gitster.g>
Date: Sun, 22 Sep 2024 09:41:01 -0700
Message-ID: <xmqqh6a78wv6.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 74472842-7901-11EF-BD90-9B0F950A682E-77302942!pb-smtp2.pobox.com

Junio C Hamano <gitster@pobox.com> writes:

> Calvin Wan <calvinwan@google.com> writes:
>
>> In a partial repository, creating a local commit and then fetching
>> causes the following state to occur:
>>
>> commit  tree  blob
>>  C3 ---- T3 -- B3 (fetched from remote, in promisor pack)
>>  |
>>  C2 ---- T2 -- B2 (created locally, in non-promisor pack)
>>  |
>>  C1 ---- T1 -- B1 (fetched from remote, in promisor pack)
>>
>> During garbage collection, parents of promisor objects are marked as
>> UNINTERESTING and are subsequently garbage collected. In this case, C2
>> would be deleted and attempts to access that commit would result in "bad
>> object" errors (originally reported here[1]).
>
> Understandable.
> ...
>> When promisor objects are fetched, the state of the repository
>> should ensure that the above holds true. Therefore, do not declare local
>> commits as "have" in partial repositores so they can be fetched into a
>> promisor pack.
> ...
> We pretend that C2 and anything it reaches do not exist locally, to
> force them to be fetched from the remote?  We'd end up having two
> copies of C2 (one that we created locally and had before starting
> this fetch, the other we fetched when we fetched C3 from them)?
> This sounds like it is awfully inefficient both network bandwidth-
> and local disk-wise.

One related thing that worries me is what happens after we make a
large push, either directly to the remote, or what we pushed
elsewhere were fetched by the remote, and then we need to fetch what
they created on top.  The history may look like this:

1. we fetch from promisor remote.  C is in promisor packs

 ---C

2. we build on top. 'x' are local.

 ---C---x---x---x---x---x---x---x---x

3. 'x' we created above ends up to be a the promisor side,
   and others build a few commits on top.

 ---C---x---x---x---x---x---x---x---x---o---o

4. Now we try to fetch from them.  I.e. a repository that has
   history illustrated in 2. fetches the history illustrated in 3.

Because this change forbids the fetching side to tell the other side
that it has 'x', the first "have" we are allowed to send is 'C',
even though we only need to fetch two commits 'o' from them.

And 'x' could be numerous in distributed development workflows, as
these "local" commits do not have to be ones you created locally
yourself.  You may have fetched and merged these commits from
elsewhere where the active development is happening.  The only
criterion that qualifies a commit to be "local" (and causes us to
omit them from "have" communication) is that we didn't obtain it
directly from our promisor remote, so you may end up fetching
a large portion of the history you already have from the promisor
remote, just to have them into a promisor pack.

If we cannot change the definition of "is-promisor-object" for the
purpose of "gc" (and it is probably I am missing what you, JTan, and
HanYang thought about that I do not see he reason why), I wonder if
there is a way to somehow avoid the refetching but still "move"
these 'x' objects purely locally into a promisor pack?

That is, the current "git fetch" without this patch would only fetch
two 'o' commits (and its associated trees and blobs) into a new
promisor pack, but because we know that commits 'x' have now become
re-fetchable from the promisor, we can make them promisor objects by
repacking locally them and mark the resulting pack a promisor pack,
without incurring the cost to the remote to prepare and send 'x'
again to us.  That would give us the same protection the patch under
discussion offers, wouldn't it?

I however still think fixing "gc" would give us a lot more intuitive
behaviour, though.

Thanks.

