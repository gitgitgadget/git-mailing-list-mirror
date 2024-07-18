Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80B8A145B00
	for <git@vger.kernel.org>; Thu, 18 Jul 2024 21:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721339881; cv=none; b=j58Tc17jCaZWZLUsnnaPKgW6TnlcRkqKvNaI2ONfYRiA9akw6IpT82+uj2PcKm4foA3QhT7up9coFHZ+GqHdQeM9kqjAHio6hDGEcp/WEsUnbH1Ag7AE0J8IW6IzU8QcO3m+BLteWS3JAYviMKevqdXvSe+ZJG1EdW7rILj7Zr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721339881; c=relaxed/simple;
	bh=6XhxOzoNH6CWJhmob+a1rwlKEJZzX5oP9qG01dvS2F4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=l8wz51/ydJMGU2cLvnWNiZkq/qXQhwOjTYyPT/isrFxzE0KQoWFGwc3xTsI14nB231iEt7xiec7f0PfXKvKRVpc0xhZMxoKeCD839IRia7ljCq/GFC5pxpxR7HJXwLtfrY8C/LhoZy+h9F6OXPQyWs3reKt5XNxV78WmyH8iRTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=XJA8xJOk; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="XJA8xJOk"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 0156E2E260;
	Thu, 18 Jul 2024 17:58:00 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=6XhxOzoNH6CWJhmob+a1rwlKEJZzX5oP9qG01d
	vS2F4=; b=XJA8xJOkNtg1pk62U1brv0+nNe6XUZUuvTVadMbOEssFghKVDTugBn
	+u/LPQ2yjsqPiqEBCgNwCm7Y1NTzSeU0g0UDWKK2iyztA493L4tqOF7DBaZNikYu
	lr6s8npTVrKEvhnh8N32Gsfw2vX4QU7bTQfVEN+lWeqcCjLgLukKg=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id EDB7C2E25F;
	Thu, 18 Jul 2024 17:57:59 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 798012E25E;
	Thu, 18 Jul 2024 17:57:56 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  me@ttayllorr.com,  Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH 0/2] Fix background maintenance regression in Git 2.45.0
In-Reply-To: <pull.1764.git.1721332546.gitgitgadget@gmail.com> (Derrick Stolee
	via GitGitGadget's message of "Thu, 18 Jul 2024 19:55:44 +0000")
References: <pull.1764.git.1721332546.gitgitgadget@gmail.com>
Date: Thu, 18 Jul 2024 14:57:55 -0700
Message-ID: <xmqqle1ynz18.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 CA47306E-4550-11EF-8C70-92D9AF168FA5-77302942!pb-smtp20.pobox.com

"Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

> Here is an issue I noticed while exploring issues with my local copy of a
> large monorepo. I was intending to show some engineers how nice the objects
> were maintained by background maintenance, but saw hundreds of small
> pack-files that were up to two months old. This time matched when I upgraded
> to the microsoft/git fork that included the 2.45.0 release of Git.

I almost said "wow, perfect timing on the -rc1 day", but then
realized that this is not a regression during _this_ cycle, but a
cycle ago.

You already Cc'ed Taylor, whom I would have asked for help if I were
the one who found this issue, which is good.

Will queue.

Thanks.
