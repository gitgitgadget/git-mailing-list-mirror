Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E2293AC28
	for <git@vger.kernel.org>; Sat,  7 Sep 2024 20:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725739256; cv=none; b=Ye4U11rGADEIX4lH92tVanBY2NUKKNsftiOWwstt7T06fa8XG04Jnonp34a//vY0ehVe/+ko9DGOvTAwFq/J8388M0BF6EuBzU2XDhN6Bj7MpiMBARJjNmPN6YKc0oA2DBFE1z0cX4O0JaEpHOrMJNVnmR5kf0x/aAmuysEW9as=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725739256; c=relaxed/simple;
	bh=MsCtOfhDHYqu36nLbZZti8pm6sHFry2nHQ3qWpqtrpQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=IQvNp/920W8B0U0AbvAmV9PgeEazuiO63xu8Du2ndQsPdkmUVvGK+hcBWGDkGkxGFIoJXhW6f3ojn6SE9t+SLtC97oRSgmvurG1YrhKKhH5G8mHJY3crf/Wfpea9OzSTfXYZ4QSXfSn3eGYjQtwo/M6ZE8IJ3PGCaTFvwXRHr+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=th5kOtwy; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="th5kOtwy"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id D72072120B;
	Sat,  7 Sep 2024 16:00:53 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=MsCtOfhDHYqu36nLbZZti8pm6sHFry2nHQ3qWp
	qtrpQ=; b=th5kOtwyo6dKZ6ZLlaiKr6B3wPj2OrNMePuddD3acTH96z/8i0bZq0
	SsHA/pPk6pAgwY3vZNUPA/R1YLpYXJQgscvtb5fJBhi/xZOv8DFg/MvVB+E7h8E6
	DGptrDgjaHcCu7yiBb9BxpgwNZVwsxs7AINBz/i3yK9cCKULZOY1k=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id CF8342120A;
	Sat,  7 Sep 2024 16:00:53 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.108.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 5054921209;
	Sat,  7 Sep 2024 16:00:53 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Stefan Haller <lists@haller-berlin.de>
Cc: git@vger.kernel.org
Subject: Re: Thoughts on the "branch <b> is not fully merged" error of
 "git-branch -d"
In-Reply-To: <d97a69bc-85f0-46e3-8c99-0e5556ffdc9a@haller-berlin.de> (Stefan
	Haller's message of "Sat, 7 Sep 2024 20:51:42 +0200")
References: <bf6308ce-3914-4b85-a04b-4a9716bac538@haller-berlin.de>
	<xmqqy143wgao.fsf@gitster.g>
	<d97a69bc-85f0-46e3-8c99-0e5556ffdc9a@haller-berlin.de>
Date: Sat, 07 Sep 2024 13:00:52 -0700
Message-ID: <xmqqmskjw7wr.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 E335C02E-6D53-11EF-A8D0-2BAEEB2EC81B-77302942!pb-smtp1.pobox.com

Stefan Haller <lists@haller-berlin.de> writes:

>> Having said all that, I do not mind if somebody wanted to further
>> extend builtin/branch.c:branch_merged() so that users can explicitly
>> configure a set of reference branches.  "The 'master' and 'maint'
>> are the integration branches that are used in this repository.
>> Unless the history of a local branch is fully merged to one of
>> these, 'git branch -d' of such a local branch will stop." may be a
>> reasonable thing to do.
>
> This makes sense to me (if you include the upstreams of master and maint
> in that logic, because the local ones might not be up to date).

I get the idea behind that statement, but I do not think it is
necessary to make Git second guess the end user is warranted in this
case.

If refs/heads/master builds on top of refs/remotes/origin/master,
and if the user is worried about the former being not up to date
relative to the latter, then the user can say "'branch -d' is safe
if the commit is merged in refs/remotes/origin/master", instead of
telling the command to check with 'refs/heads/master'.

