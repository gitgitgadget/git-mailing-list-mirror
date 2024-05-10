Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5313A46444
	for <git@vger.kernel.org>; Fri, 10 May 2024 20:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715373633; cv=none; b=NEEt++OzlSMXvAaIpFA97IiB/WD4EjI0t9yfg3FFUrCflo8xmLtsQwTRL5vfiJmhj9NWzAY9dmhF67Q3x8FtdsM7HLaI7AkSsrhXqpNDS4d4Fi7vXehx+ACRyB/e1ZmajfLUzo5vMq/iobxHVHJBJ3UqDlf/YMUnOHWCFh9NuNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715373633; c=relaxed/simple;
	bh=H0UrJRBkkLDyolWuw++2HzGfe4mGcQwTdgk/r4d+kEc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=VpNYJBlyxxnBJbHzWAwyzbWk06IM09E7C+BoSZ19uEIkD/XZs3sdwEqg/xKI7rOPw+uY98k2fYrJKk7OpDxWo1eDt9mgtWAmSfzjGJ57CwUJNj2BKcXmPB30o7hR3LJ6G/8eWjHf82tfSbHoujkVwweGIgRHymUp/ff7+1cj7N8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=pQ4UcOqF; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="pQ4UcOqF"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 2DAF233844;
	Fri, 10 May 2024 16:40:31 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=H0UrJRBkkLDyolWuw++2HzGfe4mGcQwTdgk/r4
	d+kEc=; b=pQ4UcOqFyAsZ1kvU73R4Q2KyLBlYLv3kDPUM5whrcJSUIl8KJzHdDw
	ZciTk/z80T9GbQ5nbJQ0wKXUW/DsSH5PJ0WaIBK/VPQ1MaPUaOgyVPdFVzcRsgrd
	wjlwMbLKLIWGH5mBciXWM700hPvrJQn8OCkmZDnDNUkHHbSOQi3EQ=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 1F3B833843;
	Fri, 10 May 2024 16:40:31 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 7B1F333842;
	Fri, 10 May 2024 16:40:30 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: Bo Anderson <mail@boanderson.me>,  Koji Nakamaru via GitGitGadget
 <gitgitgadget@gmail.com>,  git@vger.kernel.org
Subject: Re: [PATCH] osxkeychain: lock for exclusive execution
In-Reply-To: <20240510200114.GC1954863@coredump.intra.peff.net> (Jeff King's
	message of "Fri, 10 May 2024 16:01:14 -0400")
References: <pull.1729.git.1715328467099.gitgitgadget@gmail.com>
	<D7A8539F-E33C-44F3-A7BF-5F5D4A26F2A4@boanderson.me>
	<20240510200114.GC1954863@coredump.intra.peff.net>
Date: Fri, 10 May 2024 13:40:29 -0700
Message-ID: <xmqqh6f54czm.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 8A8C88B2-0F0D-11EF-AE31-78DCEB2EC81B-77302942!pb-smtp1.pobox.com

Jeff King <peff@peff.net> writes:

>   - we could remember _which_ helper we got the credential from, and
>     avoid invoking it again.
>
>   - we could record a bit saying that the credential came from a helper,
>     and then feed that back to helpers when storing. So osxkeychain
>     could then decide not to store it.
>
> Both of those solve the repeated stores, but still let credentials
> populate across helpers (which I still think is a questionable thing to
> do by default, per the discussion in that thread, but is the very thing
> that some people rely on).

Would "refreshing the last-time-used record" a valid use case for
the behaviour that feeds the successful one back to where the
credential came from?  Such a helper could instead log the last-time
the credential was asked for, and assume that the lack of an explicit
"reject" call signals that the use of the value it returned earlier
was auccessfully used, but it is a less obvious way to implement
such a "this hasn't been successfully used for a long time, perhaps
we should expire/ask again/do something else?" logic.
