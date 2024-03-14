Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A313C73533
	for <git@vger.kernel.org>; Thu, 14 Mar 2024 16:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710433674; cv=none; b=Yvx/hUatgh84pcl61a80mILMseyzUs94mQH1vLeP6b7ELgiPB20tPh1X5LFophXQ9tzr2eYwsG9RZM0xPcq4iA5C2fNafPcjtjW49yaXB9rqQddeaA4ahjH2UjBsJNM8Kqfxm86QMounLO2blgaR1VtBu9ZG8wdOnB+PBQK8ly8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710433674; c=relaxed/simple;
	bh=9EL7wimUxaBpBBOhqKil0im4vKnlr+DGztHma3X+PcE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Xc9eB7lH5I1C7EycMF9+Fq5T082LpYJR7/HwTX3Y3Dj4yQ7c0LzHXNH7alfkgwM0Zpira1Y5wW9D+CZ3gCGssNa+G3ubrF6VVAc+4gIOhu86rjLlbznpKfeJ6w4Arv9YBbNSCQ7z5WuL3kXFPi0k9+S/k2bT+Oa1eil93schFf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=nef8XBy0; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="nef8XBy0"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id EB639295DC;
	Thu, 14 Mar 2024 12:27:51 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=9EL7wimUxaBpBBOhqKil0im4vKnlr+DGztHma3
	X+PcE=; b=nef8XBy0Jx2nz9LjaOwWGONJzu6EBX88WezEwWBmOiFFQXCWNkdR5I
	yD5LLdzn642tXR1YDuq1kJFtInDMRTYwDoG6QmmTiy2oyqwzKTZMJkj6m3FRaq93
	I+nYvzAKPXapLOG+P4bbhOPASs8puWYb6UM/zI5VWyQpqIa69lSrs=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id E3EE6295DB;
	Thu, 14 Mar 2024 12:27:51 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.185.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 869A9295DA;
	Thu, 14 Mar 2024 12:27:48 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "barroit via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  barroit <barroit@linux.com>
Subject: Re: [PATCH v2 0/2] bugreport.c: fix a crash in git bugreport with
 --no-suffix option
In-Reply-To: <pull.1693.v2.git.1710388817.gitgitgadget@gmail.com> (barroit via
	GitGitGadget's message of "Thu, 14 Mar 2024 04:00:15 +0000")
References: <pull.1693.git.1710260812280.gitgitgadget@gmail.com>
	<pull.1693.v2.git.1710388817.gitgitgadget@gmail.com>
Date: Thu, 14 Mar 2024 09:27:47 -0700
Message-ID: <xmqqbk7gye0s.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 CBC57C82-E21F-11EE-9E41-A19503B9AAD1-77302942!pb-smtp21.pobox.com

"barroit via GitGitGadget" <gitgitgadget@gmail.com> writes:

> executing git bugreport --no-suffix led to a segmentation fault due to
> strbuf_addftime() being called with a NULL option_suffix variable. This
> occurs because negating the "--[no-]suffix" option causes the parser to set
> option_suffix to NULL, which is not handled prior to calling
> strbuf_addftime().
>
> Jiamu Sun (2):
>   bugreport.c: fix a crash in `git bugreport` with `--no-suffix` option
>   doc: update doc file and usage for git-bugreport

Squash them together into a single patch.  As you didn't have any
meaningful log message in [2/2], unless there are other things that
need to be updated and v3 is needed, I can squash them into one
commit, though.

Thanks for updating.
