Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B8E43D0B0
	for <git@vger.kernel.org>; Mon, 22 Jan 2024 20:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705954974; cv=none; b=fJCeNNO9o6QZ7rm/KIyc2pHsctpfDgB6UEwoXeXkqZaye1vpALq9H1/xlUzBcA8xZ/NSNckMWqi0ILHv8ILfFRohN1k0AiJluWlqULbF56ipJo8RhvQoZroqGCjPLul+48pTZJrEfxBoT6SLvyGwyxOc5exqHWsykY4uTyqStUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705954974; c=relaxed/simple;
	bh=71xJBQOF6OPEAHDfMwrZC7BQ+ghVtlRY+yvVn0NYRuw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=prfhhwszeU8Wt9oclrGx0uK5xXiNFACHsXV3QZ0nNnqfj0c1Aq++ZZr0RwaPrdjSqvdyZq2xLFtuRyxnl3ajD8rU17Ok6SVN4UiSUzlR0+8umrrDTwJd8+keTZF+0ZkTTLVDsRsDSZJcvPA/9QqpJytIa630NRWZtTLfqx9RgEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=YL8JTJjb; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="YL8JTJjb"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id BAE791D2B2C;
	Mon, 22 Jan 2024 15:22:51 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=71xJBQOF6OPEAHDfMwrZC7BQ+ghVtlRY+yvVn0
	NYRuw=; b=YL8JTJjbDxaYmAGgR7sA3sDdwPno6+bvCc8G2JiUcnvmXiV+miDlfD
	2AZybpzigXh/v17j+DKmXtUlv5JYwHt4FJQ1iWN5RkPFsVgSCCBW9fu1QpjljN2V
	6A8+OLak3000xWSK2+VhYIqcbYKc/iIRevUu/15UV5p05fBBO4jPQ=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id B1C8E1D2B2B;
	Mon, 22 Jan 2024 15:22:51 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.200.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 082951D2B2A;
	Mon, 22 Jan 2024 15:22:50 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: Karthik Nayak <karthik.188@gmail.com>,  git@vger.kernel.org
Subject: Re: [PATCH 2/5] refs: make `is_pseudoref_syntax()` stricter
In-Reply-To: <ee977173-bc6d-48f6-9bc8-e1d84fe3d95d@gmail.com> (Phillip Wood's
	message of "Mon, 22 Jan 2024 20:13:22 +0000")
References: <20240119142705.139374-1-karthik.188@gmail.com>
	<20240119142705.139374-3-karthik.188@gmail.com>
	<ee977173-bc6d-48f6-9bc8-e1d84fe3d95d@gmail.com>
Date: Mon, 22 Jan 2024 12:22:49 -0800
Message-ID: <xmqqplxtrucm.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 0407378C-B964-11EE-A47D-78DCEB2EC81B-77302942!pb-smtp1.pobox.com

Phillip Wood <phillip.wood123@gmail.com> writes:

> I'm concerned that this change is a regression. is_pseudoref_syntax()
> is used by is_current_worktree_ref() and so scripts that create
> pseudorefs that do not conform to your new rules will break as git
> will no-longer consider the pseudorefs they create to be worktree
> specific.

Ideally, when the exception list in the function becomes more
complete, those "pseudorefs" created by those scripts shouldn't
probably be created either as common or worktree specific thing
if they are not "pseudoref".

> The list of hard coded exceptions also looks quite short, I
> can see MERGE_AUTOSTASH and BISECT_START are missing and there are
> probably others I've not thought of.

I agree that it is something we need to fix.

> The commit message would be a good place to discuss why you're making
> this change, the implications of the change and any alternative
> approaches that you considered. As I understand it you're tying to get
> round the problem that the files backend stores pseudorefs mixed up
> with other non-ref files in $GIT_DIR.

Yup.  The rationale may want to be explained better.

> Another approach would be to
> read all the files whose name matches the pseudoref syntax and see if
> its contents looks like a valid ref skipping names like COMMIT_EDITMSG
> that we know are not pseudorefs.

In the longer term, I'd prefer to see a simpler rule, like "all-caps
or underscore string, ending with _HEAD and nothing else are the
pseudorefs but we have these small number of exceptions that are
grandfathered".

Thanks.
