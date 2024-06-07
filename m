Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 763B214F9D8
	for <git@vger.kernel.org>; Fri,  7 Jun 2024 21:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717796976; cv=none; b=VFiZFZjwZWXZpac9JKELAF4aIt/j6N1TxzZg6lucGiw0CL3vv+nvY3tGNZUI6rbUqgl4f20jH8lDT03gY6uuKQ7CQO9rBeskNcw23sqZXTXmzrI1DHh0sT2mYyuqZutYuqa+eRY4R5y9F9F2hitgiV2yjGgjSIWmgTIp1VXWVq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717796976; c=relaxed/simple;
	bh=yZKtnUJuTcCAc4EHagk6G0Cx0rHGP2GlzPbSVTi/VZM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=NaT7d4Tr0UVI0gKm30KWLNrAbEEsiP3/TQRtPTSI4vMBSqd/n5dpv0OeAMxGBZl2gfTWdQs4/xvYYsdE4Jo/niXW3QIJpQQCIhr9+KAn/Q88B+hGUgytjlNEwYkhBW1umdTyHPMhMEOhqnHxMvUtFSL8qxkVnzfmGpGoI7dC0Zs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=ZosaUdC+; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="ZosaUdC+"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 2BBB71983D;
	Fri,  7 Jun 2024 17:49:34 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=yZKtnUJuTcCAc4EHagk6G0Cx0rHGP2GlzPbSVT
	i/VZM=; b=ZosaUdC+96hNz+I2MXaWSQyinv2a0FIJ8+kmbLtFJLrmWMcltd9q7a
	h4zJxnhdeXF/iA7Seo5B6JdS9ewWyFeY0hRG2g/kX1POGtaRMDMKs3/xK2ua5Ouc
	5DzatqMV3+33EKCY0uu4JUWC4d/GvzaQxa/24pssI+ZqAufR7ank4=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 234301983C;
	Fri,  7 Jun 2024 17:49:34 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.204.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 924C61983B;
	Fri,  7 Jun 2024 17:49:33 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org,  Jeff King <peff@peff.net>,  Elijah Newren
 <newren@gmail.com>
Subject: Re: [PATCH 1/2] commit-graph.c: remove temporary graph layers on exit
In-Reply-To: <ZmN+crXyZOze122U@nand.local> (Taylor Blau's message of "Fri, 7
	Jun 2024 17:41:06 -0400")
References: <cover.1717712358.git.me@ttaylorr.com>
	<25324fea5b7c7f748d7f4e1e40299c0af04006e8.1717712358.git.me@ttaylorr.com>
	<xmqqa5jwg1aj.fsf@gitster.g> <ZmN+crXyZOze122U@nand.local>
Date: Fri, 07 Jun 2024 14:49:32 -0700
Message-ID: <xmqqfrtoe843.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 D398184E-2517-11EF-AE56-B84BEB2EC81B-77302942!pb-smtp1.pobox.com

Taylor Blau <me@ttaylorr.com> writes:

>> Before this rename, after the close(fd) we saw in the previous hunk,
>> there is one early error return when we fail to rename the base
>> graph file.  Do we need to do anything there, or an unfinished
>> tempfile getting removed at the process termination is sufficient
>> for cleaning up the mess?
>
> We could explicitly clean it up, but we'll do so implicitly upon exit,
> so I think it's fine to leave it as-is.

OK.  That sounds good.
