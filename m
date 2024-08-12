Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F4964D8CE
	for <git@vger.kernel.org>; Mon, 12 Aug 2024 05:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723439856; cv=none; b=gWj7IfOY3bMZF+5KKB2RLvZNFMWLwFaga+cFscJpqnmXkc5n/bxFYphL3Eiu2y70krWlWQt5avbEZxzjz02MCxogPEgBkGwllAtiKt9KqHKshPT8B2MiIsFmZWdS7MCZwPNWpd3UVw9RY47X9GCarKAN/RHUlhtlqoyfvoq7t9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723439856; c=relaxed/simple;
	bh=hYRp1dbShvko8tePm9Zv8hoWxFZBDrmn06c4so9/CAE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=LhDYyXmmPCebCRjVTVe6aEKfhKPKLkd99GHJQNBsL3Z7m4xl4Rq00/0GZ3NMsFYd7SVR0dmj+yR5pceAtCfskynbOyQR6XUuuV811LGZF1HTCJhFD4Wlz1kICsau7Esl/H2zHzButprAyS0dtLCQ1/x3Xf4qrXsRGrJjE4jzCwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=Ag26YaM1; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Ag26YaM1"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 0EED0372A7;
	Mon, 12 Aug 2024 01:17:28 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=hYRp1dbShvko8tePm9Zv8hoWxFZBDrmn06c4so
	9/CAE=; b=Ag26YaM1PPJL1uDuKdIDcRLeL/ua1l1+FF8mk66zE2TZGjtLPo6mdk
	qKeEqquvPGPZYmrd/m7KvpHJd+sQBbm4Cb/IlXF3dQcWWFobzPN0LtZBRmPj0fJZ
	TfdXHyRepZmyjcG4KFk7IYX+hhGalcnroHDjNQc79prJztkHI8wHI=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 05747372A6;
	Mon, 12 Aug 2024 01:17:28 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.108.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 5F303372A5;
	Mon, 12 Aug 2024 01:17:27 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Cc: Elijah Newren <newren@gmail.com>,  blanet <bupt_xingxin@163.com>,  Xing
 Xin <xingxin.xx@bytedance.com>
Subject: Re: [PATCH 2/2] remerge-diff: clean up temporary objdir at a
 central place
In-Reply-To: <xmqqr0ax9vlk.fsf@gitster.g> (Junio C. Hamano's message of "Fri,
	09 Aug 2024 15:31:35 -0700")
References: <xmqqv8099vms.fsf@gitster.g> <xmqqr0ax9vlk.fsf@gitster.g>
Date: Sun, 11 Aug 2024 22:17:26 -0700
Message-ID: <xmqqbk1y8gm1.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 2A77DF7A-586A-11EF-BDC8-2BAEEB2EC81B-77302942!pb-smtp1.pobox.com

Junio C Hamano <gitster@pobox.com> writes:

> After running a diff between two things, or a series of diffs while
> walking the history, the diff computation is concluded by a call to
> diff_result_code() to extract the exit status of the diff machinery.
>
> The function can work on "struct diffopt", but all the callers
> historically and currently pass "struct diffopt" that is embedded in
> the "struct rev_info" that is used to hold the remerge_diff bit and
> the remerge_objdir variable that points at the temporary object
> directory in use.
>
> Redefine diff_result_code() to take the whole "struct rev_info" to
> give it an access to these members related to remerge-diff, so that
> it can get rid of the temporary object directory for any and all
> callers that used the feature.  We can lose the equivalent code to
> do so from the code paths for individual commands, diff-tree, diff,
> and log.
>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---

I forgot to add that I am not happy with this "centralized tear
down" step, even though I am reasonably happy with the "lazy set-up"
step.  I wonder why the remerge-diff related members have to exist
in the rev_info structure in the first place, instead of being in
the diffopt structure?  Moving them to diffopt may make the end
result much more pleasant to read.
