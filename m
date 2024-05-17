Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F989EED3
	for <git@vger.kernel.org>; Fri, 17 May 2024 23:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715989958; cv=none; b=iWXT0u26qyLqQQPFkuvemk9RouljCIItDzGBw38Sp8j0IuDXAVekEOGupfyn1OSb1Uh7DmYkDf4UKd52/fXIQoR+JjExo0MbGKQ3mdkN8XZhLc5IO1Z1oMxR0qM6CkTKmRfm1BR2qBjG5Ib1W4Czu67TsAGliSWCGCd7OH07lFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715989958; c=relaxed/simple;
	bh=xbp4aaJdh0RfIp2MlobwKVlyHqOfp9Ftd85Wy6KT5H8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=rEugwyRiqwSOb/+rnpPmAlV9Xkh9udYyELtd25jR4aUygkQv4c4EhPHyZ0W4HfyjK6BB9q7SkaEn6eY/JCrzgIicJXGNvBOev4c7H+55UduuednfmDc4ybbeFB4rwZw4Ntm1qll+XRrMBsRv7cgfJFiK74kx9vLuS4Za0G5+O04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=fqg8/mAR; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="fqg8/mAR"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id E242031960;
	Fri, 17 May 2024 19:52:35 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=xbp4aaJdh0RfIp2MlobwKVlyHqOfp9Ftd85Wy6
	KT5H8=; b=fqg8/mARHFszLh7GrsVI/ixUAY3GLGK3sWNZVf8wwfnA8+j72VRLsK
	UAScwYp2uWMG0UIeGYfCkta+QsgiZva3zY4mTL+9rHJVp5Qwwoh2RGfwUrCLirBG
	ixUw939FA8osb4ey2aBMO5kSKVeECsIXSukIHg+9pdKiJKHHVAa4Y=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id D695A3195F;
	Fri, 17 May 2024 19:52:35 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 3F69A3195E;
	Fri, 17 May 2024 19:52:35 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
Cc: git@vger.kernel.org,  Johannes Schindelin <johannes.schindelin@gmx.de>,
    "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: Re: [PATCH 0/8] Various fixes for v2.45.1 and friends
In-Reply-To: <pull.1732.git.1715987756.gitgitgadget@gmail.com> (Johannes
	Schindelin via GitGitGadget's message of "Fri, 17 May 2024 23:15:48
	+0000")
References: <pull.1732.git.1715987756.gitgitgadget@gmail.com>
Date: Fri, 17 May 2024 16:52:34 -0700
Message-ID: <xmqqa5kodmil.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 88BA639C-14A8-11EF-87C8-78DCEB2EC81B-77302942!pb-smtp1.pobox.com

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> There have been a couple of issues that were reported about v2.45.1, and in
> addition I have noticed some myself:
>
>  * a memory leak in the clone protection logic
>  * a missed adjustment in the Makefile that leads to an incorrect templates
>    path in v2.39.4, v2.40.2 and v2.41.1 (but not in v2.42.2, ..., v2.45.1)
>  * an overzealous core.hooksPath check
>  * that Git LFS clone problem where it exits with an error (even if the
>    clone often succeeded...)

I thought brian expressed an interest in the issues these patches
attempt to address, so I thought it is helpful to Cc them to his
attention.

> This patch series is based on maint-2.39 to allow for (relatively) easy
> follow-up versions v2.39.5, ..., v2.45.2.

Thanks for basing them on the oldest version that is relevant.

