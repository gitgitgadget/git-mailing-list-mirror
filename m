Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3099E28E7
	for <git@vger.kernel.org>; Tue, 21 May 2024 16:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716309406; cv=none; b=rMObpHv3mN3aBN1bufotlP1Z+NvJQ4SaQUXrmF4wGOV3JUjDXTMKvs3X5pDcemo8UWsoc2wsf9Cg5G0mfbrKkLDgjEkMgu4sQoiy+U7S+jjNUnp1p9aZX3rS+dyLZgdl9BBPapAeTpsa9/6KaJ8+0rkOoQxmDB7OQLHQkoj5yM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716309406; c=relaxed/simple;
	bh=f733Zz82dAXrUXG4E345D6Wj5a5W1RnSFYihE9qbhT4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ZtZmyCUMFZqOg5teYlX6PkTBhenXZsufJZ4OB1c9UeTYduHz91shnIaZ+7J3WJSRha0aie+DnYV8QKcDCft6SZmQy5QZqe5eBWOpOdbbmOn4KhaWgIrny78lbSfkMjONW8KVzWFnk07Yg3nxBeh4+qaeOVjbrnagSoHszpmLjqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=u/UAG6kx; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="u/UAG6kx"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 2053F2FD63;
	Tue, 21 May 2024 12:36:44 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=f733Zz82dAXrUXG4E345D6Wj5a5W1RnSFYihE9
	qbhT4=; b=u/UAG6kxaaFA3NMl97agXnIZgBaAgI3Vr3nXusHjQ3EcnTjNBcxo7J
	eP9xb+2xSFSs7JbmTz83gGoD5knuyu97KiCrjNri6pJDeQhIwn26jsgKXJQ31Nw/
	XsukRrANTh02AgScsq2Dq7qweR6xN3635pWXRPHl7ru1kqeX9hSks=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 18CC02FD62;
	Tue, 21 May 2024 12:36:44 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.173.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 6E1572FD61;
	Tue, 21 May 2024 12:36:43 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Heghedus Razvan <heghedus.razvan@protonmail.com>
Subject: Re: git init BUG when gitconfig has includeIf
In-Reply-To: <D1F5SJ52H4Z0.1NR7M8APRFTOB@protonmail.com> (Heghedus Razvan's
	message of "Tue, 21 May 2024 07:54:11 +0000")
References: <D1F5SJ52H4Z0.1NR7M8APRFTOB@protonmail.com>
Date: Tue, 21 May 2024 09:36:42 -0700
Message-ID: <xmqqbk4zazqd.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 4EB094C4-1790-11EF-BF79-78DCEB2EC81B-77302942!pb-smtp1.pobox.com

Heghedus Razvan <heghedus.razvan@protonmail.com> writes:

> Yesterday I stumble upon a bug when doing git init. I didn't
> find any references to it, so I don't know if is a known problem
> or not.
>
> Steps to reproduce:
> # git init .
> BUG: refs.c:2123: reference backend is unknown

Patrick, this looks similar to an earlier one during "git clone"
that was discussed at

https://lore.kernel.org/git/72771da0-a0ef-4fd9-8071-6467cd7b6a6b@kernel-space.org/

that was fixed with 199f44cb (builtin/clone: allow remote helpers to
detect repo, 2024-02-27)?  The fix was about "git clone", but the
crux of the fix went to setup.c:initialize_repository_version()
which is also called by setup.c:init_db() that is the workhorse of
"git init", so it may already have been fixed (I didn't try).

Even if it is already fixed in the current version by the same
199f44cb, we may want to follow up 0eab85b9 (t5601: exercise clones
with "includeIf.*.onbranch", 2024-03-12) with an additional test to
cover "git init".

Thanks.
