Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4837A168DC
	for <git@vger.kernel.org>; Fri,  9 Aug 2024 15:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723217551; cv=none; b=mcJ2bYDZHdk6BgxVEWub3AJSnU7y0hqgcgfxK/MjV1gKIyHo7xYQ0OF5OVCev2kGycjzH55CM0TqyV0sHQibNzHB+NYT/oCRT5ewsg4BUphiHj+AXEWNJupZYH8JZiVl0GOhHq19jOVhP7P42zBfD0US17btzbIdYDjhL2d0cR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723217551; c=relaxed/simple;
	bh=slmigF85lsFA9jvv1kvRnoDGnrwhLXqeoBbtsz6GcYo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=OzNUMYHbqyjdXUbjdgt0NJf++PsZT1NbyiKWEyIlrbjLrIxPu4sPZ8yZGpHwJqOwmokYqNWUdlIIHc3sxxj1skinXDy7Dm1BO0Oi3LkSTU0jc1BrwUQiB9pdwWzsRlhRdXtUPfuweNptldvsXne5e9FaFMXDOZxq6EbdiKWfY20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=OJvU/hSZ; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="OJvU/hSZ"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 2CBC42C470;
	Fri,  9 Aug 2024 11:32:29 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=slmigF85lsFA9jvv1kvRnoDGnrwhLXqeoBbtsz
	6GcYo=; b=OJvU/hSZwfT39ZiDg1VRIFdqfqHJ+yAqdBSPPLLOKLdzAHQnx0hkYW
	8S0z0yRH7VZfteerlaIUOiKT7y5XGLTwjchkgePXRcBwDKojUUaPcwqV6Cegl9mR
	pJCFrHakKmn5nGkP33etPbzlRrWVOXx7cDudCVAJbn9zY0JQJIFIo=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 232C12C46F;
	Fri,  9 Aug 2024 11:32:29 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.108.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 882EB2C46E;
	Fri,  9 Aug 2024 11:32:28 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "blanet via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Elijah Newren <newren@gmail.com>,  blanet
 <bupt_xingxin@163.com>,  Xing Xin <xingxin.xx@bytedance.com>
Subject: Re: [PATCH v2] diff-tree: fix crash when used with --remerge-diff
In-Reply-To: <pull.1771.v2.git.1723188292498.gitgitgadget@gmail.com> (blanet
	via GitGitGadget's message of "Fri, 09 Aug 2024 07:24:52 +0000")
References: <pull.1771.git.1723123250958.gitgitgadget@gmail.com>
	<pull.1771.v2.git.1723188292498.gitgitgadget@gmail.com>
Date: Fri, 09 Aug 2024 08:32:27 -0700
Message-ID: <xmqq5xs9g19w.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 960AC020-5664-11EF-9046-9B0F950A682E-77302942!pb-smtp2.pobox.com

"blanet via GitGitGadget" <gitgitgadget@gmail.com> writes:

> Elijah Newren, the author of the remerge diff feature, notes that other
> callers of `log-tree.c:log_tree_commit` (the only caller of
> `log-tree.c:do_remerge_diff`) also exist, but:
>
>   `builtin/am.c`: manually sets all flags; remerge_diff is not among them
>   `sequencer.c`: manually sets all flags; remerge_diff is not among them
>
> so `builtin/diff-tree.c` really is the only caller that was overlooked
> when remerge-diff functionality was added.

That is more than OK as a band-aid, and I'll take the patch as-is,
but I have to wonder if we do even better in a future follow-up
patch.

Any time do_remerge_diff() is entered, we know that either the end
user (from the command line) or the hard-coded caller (like
am/sequencer cited above) wants us to do the remerge-diff, which in
turn requires us to have the temporary object directory rotated into
the status of the primary object store.  And there is nothing in
that object directory rotation code that requires caller-specific
customization---it is the same "create remerge-diff directory as
tmp-objdir, rotate it into the alt object store chain as the
primary" regardless of the actual caller).

So wouldn't it work well if we

 (1) at the beginning of do_remerge_diff(), only once for a rev_info
     structure:
   (1-a) lazily do the "object directory rotation"
   (1-b) set up an atexit handler to clear the temporary object
         store
 (2) remove all the "ah, we need to prepare and tear down the
     temporary object store for _this_ operation" we have sprinkled
     in different code paths (including the one added by the fix we
     are looking at).

That way, we won't have to worry about adding future remerge_diff
users, including existing hard-coded callers.

ANyway, thanks for the fix.  It is very pleasing to see contributors
working well together.
