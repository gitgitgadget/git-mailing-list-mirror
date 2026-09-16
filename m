Received: from bsmtp5.bon.at (bsmtp5.bon.at [195.3.86.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4CC03F327C
	for <git@vger.kernel.org>; Wed, 16 Sep 2026 06:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.3.86.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789539215; cv=none; b=fg5SMuEs0/zS3K9Q2AzfT+IGPxA737MuGsCWPLFIeC8kjNSEdu2VkdhX0wNRuZbjr//cXJDzbBGc1sW7LzWN7Ig1WtaCyPboyxLscqUVsrqndle9KsZse+u/taFZ+xGGF/OcwSv0sY3wHN/d8XBk+jPlJrLxbylYaYiv1ZAuLYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789539215; c=relaxed/simple;
	bh=sd5mZ8XftFAKalKgPe06uJO+KjlE8OJxXKYk9tabG08=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=STsIJSuti2puxmrI+xjeFYef6vWZ9u8yahTlRop8gfax+xhVM133VIz+8RYifthekx/WPoBrvwmAZpf5ALuNHBwm0g7SbZ9KpiXh4hRYves7ULMu3ugPLtQJnCy1bFxnwZMYtJb28T6MkTkX0dxcVJEJptI5NDjbGqNoEp2dL9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org; spf=pass smtp.mailfrom=kdbg.org; arc=none smtp.client-ip=195.3.86.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kdbg.org
Received: from bsmtp3.bon.at (unknown [192.168.181.108])
	by bsmtp5.bon.at (Postfix) with ESMTPS id 4hl7qS5xwhz7QZXH
	for <git@vger.kernel.org>; Wed, 16 Sep 2026 08:13:24 +0200 (CEST)
Received: from [192.168.0.100] (unknown [93.83.142.38])
	by bsmtp3.bon.at (Postfix) with ESMTPSA id 4hl7qH5dwHzRnlL;
	Wed, 16 Sep 2026 08:13:15 +0200 (CEST)
Message-ID: <1cb6ad12-27bc-458e-b8f5-4b7eb44356fe@kdbg.org>
Date: Wed, 16 Sep 2026 08:13:15 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] compat/winansi: fix die_lasterr() argument formatting
To: Yongqiang Tian <yqtian668@gmail.com>
Cc: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
References: <20260916042312.35891-1-yqtian668@gmail.com>
Content-Language: en-US
From: Johannes Sixt <j6t@kdbg.org>
In-Reply-To: <20260916042312.35891-1-yqtian668@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Am 16.09.26 um 06:23 schrieb Yongqiang Tian:
> During WinANSI initialization, duplicate_handle() reports the handle
> when DuplicateHandle() fails:
> 
>     die_lasterr("DuplicateHandle(%li) failed", ...);

The full call is more like

	die_lasterr("DuplicateHandle(%li) failed",
                        (long) (intptr_t) hnd);

This attempts to format the Windows handle value into the error message.
That's a pointless exercise, becaues AFAIK the value is totally opaque
and unhelpful as a debugging aid.

For this reason, I'd suggest to go the simpler route to remove the
formatting from the above call (the only one that passes more than just
a string) and have die_lasterr take just a single string and no variable
argument list.

-- Hannes

