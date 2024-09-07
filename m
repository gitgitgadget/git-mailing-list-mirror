Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4731315F40B
	for <git@vger.kernel.org>; Sat,  7 Sep 2024 17:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725728904; cv=none; b=Dxws55Lj9QMlYv90TIWM+Uje6dveVRL+AJk0/VtMHeu2Z3hUUH0Sh9u7lOjB3nJ1L0jv6BG9Skyz33QynUORyCtCMRpg6y4Nio+Xowsjgm2ASfDEgTXUwR8X7HTzEWV3RAch+6o81FrYw4d8U8CCrYQR7BScjmuhUciHT9DwO8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725728904; c=relaxed/simple;
	bh=A9EvP35qmV+TqHCa8rorHUPPtMAGTgiw/vyv3cAqjQs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=WxuTgI1jW8acJGpnznsRrbMmf8klQBUziZ+pyG4BB+FDDL2pyWWj7FZFCtVPwo/ixJXqj82LhnXtUHONSIkp9G0rc0M+52hJQ/BL/arN2n7uB46HHc7n2EeE65qbniBf5Uj53774gpCHJUwKMsBtCb5a49BGP7KJtEaAms8OvHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=mKSNCrCu; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="mKSNCrCu"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 3B7542ACB0;
	Sat,  7 Sep 2024 13:08:22 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=A9EvP35qmV+TqHCa8rorHUPPtMAGTgiw/vyv3c
	AqjQs=; b=mKSNCrCu749r0VmxVj9Z6tv3rMVkAQg38N8ehPxyBkMHtYkgQvm8hm
	h1xQgeXz6ZBWufp5erPFd5J64HIll1SM/8LHcwT1M0cQwPqzPOS3GguvJIPDezIR
	teDQ12XeknZkzHOIYknniql5ND9X8AqRdgmSdhuZfyhVrNGIEA/pE=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 346502ACAF;
	Sat,  7 Sep 2024 13:08:22 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.108.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id A2CF72ACAE;
	Sat,  7 Sep 2024 13:08:21 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Cc: Stefan Haller <lists@haller-berlin.de>
Subject: Re: Thoughts on the "branch <b> is not fully merged" error of
 "git-branch -d"
In-Reply-To: <xmqqy143wgao.fsf@gitster.g> (Junio C. Hamano's message of "Sat,
	07 Sep 2024 09:59:43 -0700")
References: <bf6308ce-3914-4b85-a04b-4a9716bac538@haller-berlin.de>
	<xmqqy143wgao.fsf@gitster.g>
Date: Sat, 07 Sep 2024 10:08:20 -0700
Message-ID: <xmqqtterwfwb.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 C9243778-6D3B-11EF-8E5A-9B0F950A682E-77302942!pb-smtp2.pobox.com

Junio C Hamano <gitster@pobox.com> writes:

> Having said all that, I do not mind if somebody wanted to further
> extend builtin/branch.c:branch_merged() so that users can explicitly
> configure a set of reference branches.  "The 'master' and 'maint'
> are the integration branches that are used in this repository.
> Unless the history of a local branch is fully merged to one of
> these, 'git branch -d' of such a local branch will stop." may be a
> reasonable thing to do.

If anybody is interested in doing this, I think the design should
also make sure these branches that are designated as reference
branches are protected from 'git branch -d'.

