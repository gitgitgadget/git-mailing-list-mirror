Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E50E2C18C
	for <git@vger.kernel.org>; Tue, 20 Aug 2024 23:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724195958; cv=none; b=uiqHrGIRDnnGQ8xCwc1v5BEPYkRLiBme1ET8peZWk7TnyMUyrGtB+vl9GQKy2oI0bzJ1vy1VLBENuVAul+ngjHuqT+VgvrQaCPjV7Kg2QtVcWlORAcPk6p6vaoQyY4+6xaaPB4a6ywU7nleIaNgKU3UysoBUnEAnQcPFbncD/zs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724195958; c=relaxed/simple;
	bh=6GmciDp31tpztE8Sm8I+xGfWqnRdKeb8iJnsy42AdYU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ipv8ThF3XinDHIRMkNryGeNnw6ATzq4saPnVsIcyEb6Fj+FuBSsjp3xt9eb8dLgSb67zR/dIPxZTyEyUUZdph09eZMTEzdJlV0U8SMgYrIsJdKnTzTSGezc0t07c71dJDnUv3lbuW3l29/5NkpPd21IOwAWgl44BIDVSpq3dhIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=E0feJlKK; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="E0feJlKK"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id C4E042F96D;
	Tue, 20 Aug 2024 19:19:15 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=6GmciDp31tpztE8Sm8I+xGfWqnRdKeb8iJnsy4
	2AdYU=; b=E0feJlKKdhvNhE6aC7vNBGJhmJbsa+sYxA06jorQBHccLXlIZIUNBe
	pSeHFhlzwL63weYHg63+yrMS/UjsCdXEhciuEPyeTR6j44TZOldyvCqt6lByCrsT
	8154ggqTxpR4C/cfmFEb4qXE55vk+XM7jn/yuVNrfXhL7+UuSPcSs=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id BCD902F96C;
	Tue, 20 Aug 2024 19:19:15 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.94.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 2DF9B2F96B;
	Tue, 20 Aug 2024 19:19:15 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 08/20] midx-write: fix leaking hashfile on error cases
In-Reply-To: <5f042ce5098563aa0662026006c356c278dad0b8.1724159575.git.ps@pks.im>
	(Patrick Steinhardt's message of "Tue, 20 Aug 2024 16:05:23 +0200")
References: <cover.1724159575.git.ps@pks.im>
	<5f042ce5098563aa0662026006c356c278dad0b8.1724159575.git.ps@pks.im>
Date: Tue, 20 Aug 2024 16:19:13 -0700
Message-ID: <xmqqed6i4wb2.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 9DD5E41C-5F4A-11EF-A02E-2BAEEB2EC81B-77302942!pb-smtp1.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

> When writing the MIDX file we first create the `struct hashfile` used to
> write the trailer hash, and then afterwards we verify whether we can
> actually write the MIDX in the first place. When we decide that we
> can't, this leads to a memory leak because we never free the hash file
> contents.
>
> We could fix this by freeing the hashfile on the exit path. There is a
> better option though: we can simply move the checks for the error
> condition earlier. As there is no early exit between creating the
> hashfile and finalizing it anymore this is sufficient to fix the memory
> leak.

The above is a good explanation why "are we dropping everything"
block was moved up, but does not explain why the other "if there is
no objects" block has to move (it is however easy to see that the
latter block can be moved without any bad side effect).

In any case, the struct hashfile hashfd() gives us is now associated
with the struct chunkfile cf immediately after it is instanciated,
and there is no early exit while the chunkfile is in use, which is
great.
