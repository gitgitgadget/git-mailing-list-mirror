Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64DF819F460
	for <git@vger.kernel.org>; Tue, 17 Sep 2024 15:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726585417; cv=none; b=miEghqw5UZx8RFZsvO4JlOHc/wN457OpnJ0fU5dmaKWkcZtwUS9Lv/tOGC3yJh6HrvESTs9BHAWjZIoscqlO9cRfa4oPp9jmBWHjF/H7uiMFeW6gF+T4PeX4YPYy0cD3mIDrtNjQuvfJIB+/JdSy9EmeKCgdGKzQ7BbIY6n5ouM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726585417; c=relaxed/simple;
	bh=Wwdo+g4AInSg8LeeIOPjcZJNrwHt3NTcJf/7uD9AQDM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=u0m0MOyAc8h9OAlbMvj3Gl4lKUqvDM+ihEUzEcX47MVeKF+dMEphzoB+zEUyA21USsxINf3WcoLxprIGu5ZysqPyFRT11OOiSFZY9Z0gzQzgSiT/tpc0oRdutiOcdH662E7j/UJd4iSW4AzqnLRCPB8XZQNK48BUq/RCGtsg9UI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=Z6plI8Vz; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Z6plI8Vz"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 1860F2350E;
	Tue, 17 Sep 2024 11:03:35 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=Wwdo+g4AInSg8LeeIOPjcZJNrwHt3NTcJf/7uD
	9AQDM=; b=Z6plI8VzO4CHIp4d/+B8EMTk/EyjcEAPEPvBCRdovGEcoVmnd4EAid
	/iXeZuVGcZnkccGxnRK80M11opaDnFQe0Jz8uaQ/HCFi++1kFGaEHYb1WqW5wMXu
	PeALX699JfDSwPKN9zWJH5tKo7dRBY9aLcUyrrMIfPcrY9+Vpr5/w=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 110DF2350D;
	Tue, 17 Sep 2024 11:03:35 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.108.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 738102350B;
	Tue, 17 Sep 2024 11:03:34 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Taylor Blau <me@ttaylorr.com>
Cc: Jeff King <peff@peff.net>,  git@vger.kernel.org
Subject: Re: [PATCH 2/2] git-jump: ignore deleted files in diff mode
In-Reply-To: <ZulEwjnNQet6th8w@nand.local> (Taylor Blau's message of "Tue, 17
	Sep 2024 04:58:42 -0400")
References: <20240915111119.GA2017770@coredump.intra.peff.net>
	<20240915112024.GB2017851@coredump.intra.peff.net>
	<ZulEwjnNQet6th8w@nand.local>
Date: Tue, 17 Sep 2024 08:03:33 -0700
Message-ID: <xmqqed5il3ui.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 028E6CC8-7506-11EF-B1E5-9B0F950A682E-77302942!pb-smtp2.pobox.com

Taylor Blau <me@ttaylorr.com> writes:

> On Sun, Sep 15, 2024 at 07:20:24AM -0400, Jeff King wrote:
>> diff --git a/contrib/git-jump/git-jump b/contrib/git-jump/git-jump
>> index 78e7394406..3f69675961 100755
>> --- a/contrib/git-jump/git-jump
>> +++ b/contrib/git-jump/git-jump
>> @@ -44,7 +44,7 @@ open_editor() {
>>  mode_diff() {
>>  	git diff --no-prefix --relative "$@" |
>>  	perl -ne '
>> -	if (m{^\+\+\+ (.*)}) { $file = $1; next }
>> +	if (m{^\+\+\+ (.*)}) { $file = $1 eq "/dev/null" ? undef : $1; next }
>
> I was surprised to not see you use `--diff-filter` here, but I think
> that that makes sense. You only would want to exclude deletions, since
> that would be the only time the post-image is /dev/null AFAICT.

So "--diff-filter=d" (lowercase)?
