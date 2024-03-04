Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B27662147
	for <git@vger.kernel.org>; Mon,  4 Mar 2024 18:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709577725; cv=none; b=eHy3PWk+ME2NG15F7Hqk8t9Ig3HqkgIsIuy5tWhEeI6GU3FOhJ46BslHWkrurOgBk2kIyx+/Pwa897xAGyPmYAtP29c6FI0ZRTvaX2SQiJus3u22QwzlGMZTi/4xJPI5U7LO4keZjVoU0C2RLH52V3BAY3whMT/99uBuzHDUZjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709577725; c=relaxed/simple;
	bh=7rul64ssjg7TQ1kXTcnRvCpDfWCZF3a4Ty/wJQF/GgI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=eGIArLyljEYl6kNQb+AdMtB+9CyEn58VfrJ8MiUSvn88b97bZaykRLk3VNeTCmZnS4vUC2ag7H9YxNSIDspQfJByoC376R1Cc9JsprRcXdCYWYtbIuk7oJGwiJRZVMr7pO/SHNXgYQQEV7JTc6QoCIq4fnAwvmeqNi6YNgPzB/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=wcRzEjMj; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="wcRzEjMj"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 499931F3801;
	Mon,  4 Mar 2024 13:42:01 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=7rul64ssjg7TQ1kXTcnRvCpDfWCZF3a4Ty/wJQ
	F/GgI=; b=wcRzEjMjR91njkZ310HqzN2aes6gqhCcYiCBa0KuPXp3Z373/CIJQn
	2pUeWrKNqgweqskVlPcTLCWwc4GxHLiw0PfTtR2iDo9VVtL5aS/IXX1m1MJi/05c
	gdiHt7sXIVYrrOQrDGSN/x0Mh98X2ILGtLYk1kdPQOHw5pfMcttnU=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id A95971F3800;
	Mon,  4 Mar 2024 13:42:00 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.176.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id D5F041F37FF;
	Mon,  4 Mar 2024 13:41:59 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Sergey Organov <sorganov@gmail.com>
Cc: git@vger.kernel.org,  =?utf-8?Q?Jean-No=C3=ABl?= AVILA
 <avila.jn@gmail.com>,  "Kristoffer
 Haugsbakk" <code@khaugsbakk.name>
Subject: Re: [PATCH v2] clean: improve -n and -f implementation and
 documentation
In-Reply-To: <87h6hl96z7.fsf@osv.gnss.ru> (Sergey Organov's message of "Mon,
	04 Mar 2024 21:39:40 +0300")
References: <7le6ziqzb.fsf_-_@osv.gnss.ru>
	<20240303220600.2491792-1-gitster@pobox.com>
	<87h6hl96z7.fsf@osv.gnss.ru>
Date: Mon, 04 Mar 2024 10:41:58 -0800
Message-ID: <xmqqa5ndq1op.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 E29B6CB2-DA56-11EE-827B-25B3960A682E-77302942!pb-smtp2.pobox.com

Sergey Organov <sorganov@gmail.com> writes:

> I wonder do you mean:
> 
> 	/* Dry run won't remove anything, so requiring force makes no
> 	* sense. Interactive has its own means of protection, so don't
> 	* require force as well */
> 	if (dry_run || interactive)
> 		require_force = 0;
>
> 	if (require_force != 0 && !force)
>                 die_();
> ...

That is explained in a few messages after this one, so I'll wait
until you read them all before responding ;-).

Thanks.
