Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A54156458
	for <git@vger.kernel.org>; Mon, 26 Aug 2024 19:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724701442; cv=none; b=HnJE6odi7Yc0tGwtJsBD0d4yG63XoRbgftOGx52tUQ+VSJm1asnVWWmP4rSXp+PEbKBN6npAAr+k8RxGU7/QnImdF8T1yU1hCdXLJP6DbWzqT5VArU2BaDbnNt3q2IAemtkAF2R6riT/pbmG2OSVWPmsJodOcvliEN3CYAkVMX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724701442; c=relaxed/simple;
	bh=rBw0o3SCoOgT8zPENz+INkYpKjVBqW11foS/AkOH1LQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=FnKoLbMkx2cQyv1laWP21zZzKM/J4kluVKxNvJEroCVQdioYonJRfdeMxwpJ9n0alrM9s0FdvgzvYFPGonac4W5c8gY7BCiz28t/+AUhPeC6Das97BhbC9TaG3ECelyZRV/y0ffQx/c90wzcyJH3jeh7ZMZk9VFymmRP4/47QuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=AJcrq7HJ; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="AJcrq7HJ"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 609E328EB3;
	Mon, 26 Aug 2024 15:44:00 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=rBw0o3SCoOgT8zPENz+INkYpKjVBqW11foS/Ak
	OH1LQ=; b=AJcrq7HJIhe3k/Zi/dJMcDn8lWCZcTyPpiVmILRi3k1/JeKNLb2RDK
	JjcHnN+TFwul9WKZVIxmVbHO0jMVywtku5enJxjiK/A188UFCdgI0Yikmtk85ub6
	s9bcPGi5PUdhchFyrbRlaWP+w9Ef4RIaQ5SHJixhBCbDQwQCy/xbo=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 592C728EB2;
	Mon, 26 Aug 2024 15:44:00 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.94.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id DA2C528EB1;
	Mon, 26 Aug 2024 15:43:56 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Tao Klerks <tao@klerks.biz>
Cc: git <git@vger.kernel.org>,  Derrick Stolee <stolee@gmail.com>
Subject: Re: Can git log be made to "follow" in the same way as git blame?
 Why / in what way is "--follow" broken or limited?
In-Reply-To: <CAPMMpogApZ6VN9sYxgmtHCickkstM6HZq1teeAa+a2t1_BY0sQ@mail.gmail.com>
	(Tao Klerks's message of "Mon, 26 Aug 2024 21:00:24 +0200")
References: <CAPMMpogApZ6VN9sYxgmtHCickkstM6HZq1teeAa+a2t1_BY0sQ@mail.gmail.com>
Date: Mon, 26 Aug 2024 12:43:55 -0700
Message-ID: <xmqqa5gzhxxg.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 8869076A-63E3-11EF-8776-BF444491E1BC-77302942!pb-smtp20.pobox.com

Tao Klerks <tao@klerks.biz> writes:

> What seems weird and interesting to me, is that whatever is going
> "wrong" in "git log --follow" doesn't happen in "git blame".

Yes, because log.follow was done as a checkbox item but blame was
done as a real feature ;-)

In tree-diff.c:try_to_follow_renames(), you'll notice that it only
has a space to remember a single path in .single_follow member in
the diff_opts.  That member is the hack.

Imagine that the original commit had paths A and B, and over time,
the history diverged and in one fork A got renamed to C while
another fork B got renamed to C.  Eventually these two forks merge.
Now you want to "follow" C, so .single_follow member will have C.


  ----1----3----5(rename A to C)----7---9---10---11
       \                               /
        2----4----6(rename B to C)----8

You follow the history of one fork and notice that C came from A at
commit #5.  Great.  Your .pathspec member will be _switched_ to A
and you keep following the history of A.

Imagine further that your history traversal didn't follow one fork
fully before following the other fork, but dug commits from newer to
older, so your traversal jumps around between two forks.  What
happens when your "git log --follow HEAD -- C" that has internally
switched to follow A already jumps back to follow the other fork at
this point?  It does see that A exists (maybe unchanged), and you
see A's history, but that is not a releavant history---what ended up
in the final C from that fork was in B, not A.

Unlike the above checkbox hack, "git blame" uses a real data
structure to keep track of what came from where.  Instead of a
global "this single path is what interests us now", it knows "in
this commit, this is the path we are looking at", and when it looks
at the parents of that commit, it checks where that path the child
was interested in came from each different parent, and records a
similar "in this commit (which is parent of the commit we were
looking at), this path is what we are interested in".

To equip "git log --follow" with similar "correctness" as "git
blame", you'd need to somehow stop using that single .pathspec thing
for the purpose of keeping track of "which path are we following
now?" and instead use "this is the path we are following" that is
per history traversal path.
