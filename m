Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BD5E16BE0D
	for <git@vger.kernel.org>; Fri,  2 Aug 2024 16:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722617139; cv=none; b=uzyZkD+sFgmXUTmrqv6WcEwRUmKy8xiVsSkpYDdOMoWPvYVgQ5M2/FZeB3xLY0t/+ZNdg6++uOy6ikGWeB2OmNlSf++cN/1dGSgwhuV2xb6m2YEyZxvJR52KYkYZeLo2My9U7wQX2dbajCfvyyjh01AMDZm9Eh0Q8lZrG1o72tU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722617139; c=relaxed/simple;
	bh=Z9G6Ce0n3ILyQOXIpHknX09grbNYlAu/jfJI4RXuqZw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=c1RQZ2urzMR+gR5DKgknXT5iivuZPwByxknt+2A++0/y+8VCZ+NGb3nVhQW/C5eaHzFcbR3Rak6nIFvvcDnBeJsJCV6e/i5bAWgPpLbw6bCsCwcBznm2ohTm3JiUqvLZHHIo2e9D2w1W5l51EiH5c3P8spgh5Ee82xuppETuKiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=L5NHLXwd; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="L5NHLXwd"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 9735535A17;
	Fri,  2 Aug 2024 12:45:30 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=Z9G6Ce0n3ILyQOXIpHknX09grbNYlAu/jfJI4R
	XuqZw=; b=L5NHLXwdEr8M+rUlR9yyFcYNWe759TYxSTsPu0D4gUsmfiYbeiyq5G
	3Xzl4S7Nw9g9DYe5tA8+gQn6J/oz7+rNWWklbsupIXdw5+gtnd9O8QvGvH1fQwD+
	MUD70PCeGXqT4Lv/YodEGV/gELhT691anCnwXc5aNDkWKOijqpokc=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 8FC3C35A16;
	Fri,  2 Aug 2024 12:45:30 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.108.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 0570A35A15;
	Fri,  2 Aug 2024 12:45:29 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Han Young <hanyang.tony@bytedance.com>
Cc: git@vger.kernel.org,  C O Xing Xin <xingxin.xx@bytedance.com>,
    Jonathan Tan <jonathantanmy@google.com>,
    Jeff Hostetler <jeffhostetler@github.com>
Subject: Re: [PATCH 1/1] revision: don't set parents as uninteresting if
 exclude promisor objects
In-Reply-To: <20240802073143.56731-2-hanyang.tony@bytedance.com> (Han Young's
	message of "Fri, 2 Aug 2024 15:31:43 +0800")
References: <20240802073143.56731-1-hanyang.tony@bytedance.com>
	<20240802073143.56731-2-hanyang.tony@bytedance.com>
Date: Fri, 02 Aug 2024 09:45:28 -0700
Message-ID: <xmqq4j82euvr.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 A0B496C0-50EE-11EF-A090-34EEED2EC81B-77302942!pb-smtp1.pobox.com

Han Young <hanyang.tony@bytedance.com> writes:

> In revision.c, `process_parents()` recursively marks commit parents 
> as UNINTERESTING if the commit itself is UNINTERESTING.

Makes sense.

> `--exclude-promisor-objects` is implemented as 
> "iterate all objects in promisor packfiles, mark them as UNINTERESTING".

Also makes sense.

> So when we find a commit object in a promisor packfile, we also set its ancestors 
> as UNINTERESTING, whether the ancestor is a promisor object or not.
> This causes normal objects to be falsely marked as promisor objects 
> and removed by `git repack`.

Ahh, that is not desirable.  So the need to do something to fix it
is well established here.

> Signed-off-by: Han Young <hanyang.tony@bytedance.com>
> Helped-by: C O Xing Xin <xingxin.xx@bytedance.com>
> ---

Please order these trailer lines logically in chronological order,
i.e. you get helped by others to complete the change and then seal
it by signing it off at the end.  I'll swap these two while queuing.

> diff --git a/revision.c b/revision.c
> index 1c0192f522..eacb0c909d 100644
> --- a/revision.c
> +++ b/revision.c
> @@ -1164,7 +1164,7 @@ static int process_parents(struct rev_info *revs, struct commit *commit,
>  	 * wasn't uninteresting), in which case we need
>  	 * to mark its parents recursively too..
>  	 */
> -	if (commit->object.flags & UNINTERESTING) {
> +	if (!revs->exclude_promisor_objects && commit->object.flags & UNINTERESTING) {
>  		while (parent) {
>  			struct commit *p = parent->item;
>  			parent = parent->next;

But if the iteration is over all objects in certain packfiles to
mark them all uninteresting, shouldn't the caller avoid the call to
process_parents() in the first place?  Letting process_parents() to
do other things and only refrain from doing the "this commit is
marked uninteresting" part does not quite match what you are trying
to do, at least to me.

Please check "git blame" to find those who are likely to know better
about the code around the area and ask for help from them.  I think
the bulk of the logic related came from the series that led to
f3d618d2 (Merge branch 'jh/fsck-promisors', 2018-02-13), so I added
the authors of the series.

It apepars to me that its approach to exclude the objects that
appear in the promisor packs may be sound, but the design and
implementation of it is dubious.  Shouldn't it be getting the list
of objects with get_object_list() WITHOUT paying any attention to
--exclude-promisor-objects flag, and then filtering objects that
appear in the promisor packs out of that list, without mucking with
the object and commit traversal in revision.c at all?

Thanks.

