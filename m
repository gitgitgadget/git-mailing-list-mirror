Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27414256C70
	for <git@vger.kernel.org>; Tue, 24 Mar 2026 17:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774373123; cv=none; b=sZ/aAIetHQTq/GB9fZ2mbWQe996wrCLiP8sx1VmsNJynBseWwibeEupBFtgqBg4qw741qoIXsEE3w4Rb87nQ5PnMLSUVaASBcHBJd0Sg3sunEL3RUW5z5hEfUIQmZTckmYkzm2kWWhweF1Hn6GoV4SbCwehzUI9IxjrC2f4/InQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774373123; c=relaxed/simple;
	bh=RqGg8NmqvR8kJw1di7izPjJMgI+DnY3cEb5RLF3dxig=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=dknjdglpmgCQIxjsR/zdSu8tKUEpbcCQ6xP/0RMZBqqqTiTUxLcHiKE7TmnWm1na1fB3oxeo/NS6Ug5Htq0762jtq/uDaKf2NZ1Yjuv/x5R5suiTltZ4iKSIPjjhK+jXGtHO8NoL7p3GB4OOVKHu2nA+8pJliTu2rYbyNFdvpOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=ehgM437z; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="ehgM437z"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1774373118;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=r3bXYD45loOKXx+aG8ZQ9T/jzx1of8agTGIuCuPslrI=;
	b=ehgM437zHPSqpvLxvLPr2JnAAHzzPFCckoGCRfrkDUqjLAOfOUF6IJhxBhUy3Z124gupO9
	xrhdy1AOu7Z2A+W/i0F6UYhbqJ7A7nYWM6CXDuP3UFMkbU1fVTVLldOEB4N+OPi2lyw1/g
	U8y5A5NM+f8rb4WHEnAHbPZHg7WmDZE=
From: Toon Claes <toon@iotcl.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] replay: support replaying down from root commit
In-Reply-To: <xmqqwlzajkha.fsf@gitster.g>
References: <20260317-toon-replay-down-to-root-v1-1-cb5c249e15fd@iotcl.com>
 <xmqqwlzajkha.fsf@gitster.g>
Date: Tue, 24 Mar 2026 18:25:13 +0100
Message-ID: <87qzp916o6.fsf@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT

Junio C Hamano <gitster@pobox.com> writes:

> Toon Claes <toon@iotcl.com> writes:
>
>> git-replay(1) doesn't allow replaying commits all the way down to the
>> root commit. Fix that.
>
> OK.
>
>> -	base = pickme->parents->item;
>> -	replayed_base = mapped_commit(replayed_commits, base, onto);
>> +	if (pickme->parents) {
>> +		base = pickme->parents->item;
>> +		replayed_base = mapped_commit(replayed_commits, base, onto);
>> +		base_tree = repo_get_commit_tree(repo, base);
>
> So, if we are replaying a commit with parent(s), we do the same as
> before (base_tree used to be computed a bit later).  But ...
>
>> +	} else {
>> +		base = NULL;
>> +		replayed_base = onto;
>> +		base_tree = lookup_tree(repo, repo->hash_algo->empty_tree);
>> +	}
>
> ... if we are replaying the root commit, there is no base (in
> contrast to "the first parent of the original commit" used in the
> other branch of this if-else construct).  We use an empty tree for
> the base_tree, which is the natural thing to use to replay for a
> root commit, of course.
>
> I am not sure why replayed_base is computed differently, though?  Is
> it because mapped_commit() would not work when base==NULL?

That's correct, mapped_commit() dereferences commit->object.oid.

> I have to wonder if the handling of that case should also be
> encapsulated inside mapped_commit() helper, just like the helper
> knows to "fallback" when the commit is not yet mapped

I'm fine either way, so I'll do that in v2.

> After all, if we drive that line of thought to the extreme, we would
> end up making repo_get_commit_tree() to return an empty tree object
> for base==NULL, too, which may be logical but it is probably too much.

Well, it's a bit annoying `struct commit::parents` is a `struct
commit_list`, so we have to first check that pointer before we can
dereference `item`, so that guard do we need anyway. So I agree it's too
much.

One other thing, in v2 I'm also fixing the merge ancestor label. For
root commits it will say "empty tree" instead of "parent of <commit>",
so conflict messages aren't misleading.

-- 
Cheers,
Toon
