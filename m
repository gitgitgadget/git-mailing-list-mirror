Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AD784206B
	for <git@vger.kernel.org>; Wed, 21 Aug 2024 17:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724262417; cv=none; b=URZIBLd4M5UXlKQKzFIgDOJbVKztrIRZKZGEiG9fkOdds0aDGZ251Dr2naQbqxfkT36NfSLw++EcBR1nzvfs1kX70Cj92IYEij2aafUucRXm2JmOM7nBKS0uK6bfD/dyra3iVsQD1d2jZsun7QzkM8AKwawLU/dWdqzK0k39faA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724262417; c=relaxed/simple;
	bh=FxY2dBL2g+eFPEVbCRcBSz2V3nnhQnCervdGbcEJ0Dk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=KA8xG88pBi26DIVhNpQUcB4KyTwovK11HqtC+V2jongp1P1KQq+UQh8z3dG3Wh8b1wpuf559jEnyjxHkaXyQqBSAT6z06kvx6P2ryHNEDQX2dIFGEP5XEv4gwDZXJzh6PAjQpRFafEkTTg1zbAzKBehKl8f5FimJ+6Di3KeuAPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=aXB9goDf; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="aXB9goDf"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id A691B37846;
	Wed, 21 Aug 2024 13:46:49 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=FxY2dBL2g+eFPEVbCRcBSz2V3nnhQnCervdGbc
	EJ0Dk=; b=aXB9goDfUt1yxFBwmjqGb2K0MWEzkbr1PtmkzZ877jk3NsM9GsquLi
	GSUmYpO6qfRsSO9APDaOG9xGm13sSbC96YKn2+Q3JUXCTwkiZdxn5S9O590wf/PI
	7xg38yey++VrkyeHW+t1qUOJqYhKdtCRuHX1k1LXCTQcU8+q5pchs=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 9EF8637845;
	Wed, 21 Aug 2024 13:46:49 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.94.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 1669437844;
	Wed, 21 Aug 2024 13:46:49 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 14/20] builtin/fetch-pack: fix leaking refs
In-Reply-To: <1c94195488d2db8ba169368a6c28171d5a2640f3.1724159575.git.ps@pks.im>
	(Patrick Steinhardt's message of "Tue, 20 Aug 2024 16:05:44 +0200")
References: <cover.1724159575.git.ps@pks.im>
	<1c94195488d2db8ba169368a6c28171d5a2640f3.1724159575.git.ps@pks.im>
Date: Wed, 21 Aug 2024 10:46:47 -0700
Message-ID: <xmqq5xrtzs3c.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 5772AF82-5FE5-11EF-8868-2BAEEB2EC81B-77302942!pb-smtp1.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

> We build several ref lists in git-fetch-pack(1), but never free them.
> Fix those leaks.
>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  builtin/fetch-pack.c | 20 ++++++++++++--------
>  1 file changed, 12 insertions(+), 8 deletions(-)

Quite straight-forward.  In addition to plugging leaks, the
resulting code is much easier to reason about by avoiding the reuse
of the variable.
