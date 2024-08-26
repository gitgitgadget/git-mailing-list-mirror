Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A62F1199242
	for <git@vger.kernel.org>; Mon, 26 Aug 2024 22:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724712755; cv=none; b=oE7HDpMjrgC6RrwbPjkmZW0QqqiR0uniVkbhhpSToPesTRwAk3nJuUYI1FNK1a1FiLma9NGkpi2LPpNkQB5UZ7dOl504ZBPqGgqjI6oJ5OoK/c2ErG8ErDEwjVGIdu6Of5VFjZ9Y0A1YDFCp4Zk4hwUpmBm1RaTuiSuT6OpAaDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724712755; c=relaxed/simple;
	bh=DDp77SLQ79Am3ptsggOAR5dEbTvB2avqDnvIT5a0ulw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=MSwYHvqmur/ozKzh63uYdJTukFn9sOBKuxFxsfmaxjz2EvYt9qHnPKDj3u8JS2PYFbo6TYgH7fvPuI1gBlw+bj8Nj2ww+xvLjcxT9ErTXgKacihDAHc0yQEsrrHoIxRHJdk8qE2g400yMnzVYtbtrP+DZb3LmS26/XKcfeRxTJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=TPyuHJ9S; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="TPyuHJ9S"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 6A4D33BA0B;
	Mon, 26 Aug 2024 18:52:32 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=DDp77SLQ79Am3ptsggOAR5dEbTvB2avqDnvIT5
	a0ulw=; b=TPyuHJ9SMeG0a3ppv3i675Kys8BSsw7XZNQ2I+zGWUDav/OKTNaF8b
	AO3A3uicPkeSDqL/HD9D/F07gvxyaBNXOLDEs246ZXSRgCW5f3T852N4fVvUneGY
	XWp0bNW4j06iV39XKlF8M62fd/7CTpKOprBpO59dRAXcpdFMBsBcE=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 624653BA0A;
	Mon, 26 Aug 2024 18:52:32 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.94.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id BA3BF3BA09;
	Mon, 26 Aug 2024 18:52:31 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Tao Klerks <tao@klerks.biz>
Cc: git <git@vger.kernel.org>,  Derrick Stolee <stolee@gmail.com>
Subject: Re: Can git log be made to "follow" in the same way as git blame?
 Why / in what way is "--follow" broken or limited?
In-Reply-To: <xmqqa5gzhxxg.fsf@gitster.g> (Junio C. Hamano's message of "Mon,
	26 Aug 2024 12:43:55 -0700")
References: <CAPMMpogApZ6VN9sYxgmtHCickkstM6HZq1teeAa+a2t1_BY0sQ@mail.gmail.com>
	<xmqqa5gzhxxg.fsf@gitster.g>
Date: Mon, 26 Aug 2024 15:52:30 -0700
Message-ID: <xmqqjzg2gamp.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 E099C4DC-63FD-11EF-8C7F-9B0F950A682E-77302942!pb-smtp2.pobox.com

Junio C Hamano <gitster@pobox.com> writes:

> Unlike the above checkbox hack, "git blame" uses a real data
> structure to keep track of what came from where.  Instead of a
> global "this single path is what interests us now", it knows "in
> this commit, this is the path we are looking at", and when it looks
> at the parents of that commit, it checks where that path the child
> was interested in came from each different parent, and records a
> similar "in this commit (which is parent of the commit we were
> looking at), this path is what we are interested in".

FWIW, the above is greatly simplified.  For "git blame" to correctly
handle a case like "This commit created file F by taking pieces from
files A, B, C, D, and E", and annotating the lines in file F, we
need to keep track of the set of "lines n..m of path A", "lines l..k
of path B", etc., at commit X as the targets of interest, and as we
dig down the history, figure out where in the parent commits of X
each of these range of lines come from.  So what "blame" uses is
much richer than just a single path per commit being traversed (once
the traversal passes through from a commit to all of its parents,
this list of "line ranges per path" can be released, so that is not
a huge memory burden even for a deep history).

Now "git log --follow" does not have to keep track of range of
lines, but if you start following from file F that was created by
concatenating pieces of multiple existing files A, B, ..., and E,
you either want to pick one of these 5 and follow it, or you replace
F with all five of these files and follow them from that point.  In
any case, you need a richer data structure than the current (ab)use
of the .pathspec member during the traversal.
