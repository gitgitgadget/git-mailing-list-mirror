Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DA1A15AD99
	for <git@vger.kernel.org>; Thu, 29 Aug 2024 20:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724964377; cv=none; b=Wr9oVMIl6KI7wH0Xks0ICQbI5+g2RXXWGBuOMyB6KIGOJh6mE5tcgm2bRoaIR/HxsorNpOl9/61YfwQf9fHEGR1jW6j+FFH6WXcZafG3unMIrxKHnqM3KZR0VmX29vuEL9lZVjDe4FodbJ7kTnlq2FNnU9JZ4zN5rnXWqprpoGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724964377; c=relaxed/simple;
	bh=7f1IEEkjr2nwn4qUntYQN79BWnZRhodo82nlb+9LKLs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=t949DeFHC//vtXwAgzeLoLuAn2UtssAby9EmrZKsMUyYnRz/ZKVWvGC/F8j/+tSR8LbUuVcff6ut0bcKUwnKxS6OE2vF7Jh68/gchagYWeung2SkxJS5sjv8gx+uhYKUOuw4YD6BjUQeEO8LWKr9qH6EX585Ei+FtGa025Ltt4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=Q5D1nvGd; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Q5D1nvGd"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 0F48D35145;
	Thu, 29 Aug 2024 16:46:15 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=7f1IEEkjr2nwn4qUntYQN79BWnZRhodo82nlb+
	9LKLs=; b=Q5D1nvGd5eZGjLG+FQwfkASVxyqsZ5FqP0OMMFMTAEcomVa2Nsevv/
	xUcPclFnKfwGnk2Z9g2/ktxzDKtE42PTqc2EqaPd+26J62FTeWQvZjV2mXt9YV58
	LYjBtjAGf5yYg7dbYxBudH9wVpOgoonFMy6FwQplNOtP13utQHqZw=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 0775F35144;
	Thu, 29 Aug 2024 16:46:15 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.94.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 5DFB235142;
	Thu, 29 Aug 2024 16:46:14 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 0/2] clean up some MAYBE_UNUSED cases
In-Reply-To: <20240829200807.GA430283@coredump.intra.peff.net> (Jeff King's
	message of "Thu, 29 Aug 2024 16:08:07 -0400")
References: <20240829200807.GA430283@coredump.intra.peff.net>
Date: Thu, 29 Aug 2024 13:46:12 -0700
Message-ID: <xmqq34mnukff.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 BB5E5826-6647-11EF-AF39-9B0F950A682E-77302942!pb-smtp2.pobox.com

Jeff King <peff@peff.net> writes:

>   - builtin/gc.c's check_crontab_process(). The whole function is marked
>     as MAYBE_UNUSED here, which is a little funny. It's because
>     is_crontab_available() may or may not call us based on __APPLE__.
>     Should we conditionally define the function, too, in that case? It
>     would mean repeating the #ifdef. Alternatively, we could define it
>     like this:
>
>       #ifdef __APPLE__
>       static int check_crontab_process(const char *cmd UNUSED)
>       {
>               return 0;
>       }
>       #else
>       static int check_crontab_process(const char *cmd UNUSED)
>       {
>               [...the real function...]
>       }
>       #endif

Or inline the body of check_crontab_process() at its sole callsite
(the other side of "#ifdef APPLE") in is_crontab_available() and get
rid of check_crontab_process().

>     But I think we're getting into "well, this is how I would have
>     written it" territory, and it doesn't matter much either way in
>     practice. It's probably better to just leave it alone.

OK.
