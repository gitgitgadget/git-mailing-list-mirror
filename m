Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01505364AB
	for <git@vger.kernel.org>; Sat,  9 Mar 2024 05:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709963604; cv=none; b=mntzJipY7ZkV6BKeQiwrlPdMktQpRDgNmBGr1LUQhX5YXNS5K/Ia5qbx5WzBXEPzmKKYJuMwXQArzdrC0QyIdn0i6xjwm1FB5wclriU5+yaOfy3f0gq7h8RJUw5iDjZW90CWQt6SzRoxqXf68Ncya6Tg8y4jRbSNDiE4daiBuKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709963604; c=relaxed/simple;
	bh=0LZ4dZaMseyRzkUq0hgeBlbWSz9guwun/yQ0WhhGnhY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=FPrhZQpgl0yCII+mQPmPvvYEZwkobwW3jQdgth5VB+1p8CtTvH3rDWTxjR6/fcEjefQQWkwxHYMEyXNvEwN6WLnLdU5yRJBnSTN8pjmjeIYRBZFukcFh5Goq444r4AJgSjEkgTb1FQ+PQi5QymQ9xi0AnF2W8mdu/FR3UflGqzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=Dw3gaKHZ; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Dw3gaKHZ"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 49CC83E5BA;
	Sat,  9 Mar 2024 00:53:22 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=0LZ4dZaMseyRzkUq0hgeBlbWSz9guwun/yQ0Wh
	hGnhY=; b=Dw3gaKHZPT7DOWRwmFsgvq6eTwUTfUCEh0+QG5UkeeVYH5JhzUjxWk
	kheOZxXUJo+DKXRiIIrndTZtHvOA7i2bwYfRArrTIOKQ2RZw/WKqOYXwqoia7iwk
	fXu6FJoCMKqIBzOtFVD5hdw8Ta8Gcgc5DZkc314yRX5EHVdYQy0lg=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 34C803E5B9;
	Sat,  9 Mar 2024 00:53:22 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.185.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id B3C893E5B8;
	Sat,  9 Mar 2024 00:53:18 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Kyle Meyer <kyle@kyleam.com>
Cc: git@vger.kernel.org,  Kyle Lippincott <spectral@google.com>
Subject: Re: [PATCH 2/2] setup: make bareRepository=explicit work in GIT_DIR
 of a secondary worktree
In-Reply-To: <87msr8qef9.fsf@kyleam.com> (Kyle Meyer's message of "Fri, 08 Mar
	2024 22:20:26 -0500")
References: <xmqqv85zqniu.fsf@gitster.g>
	<20240308211957.3758770-1-gitster@pobox.com>
	<20240308211957.3758770-3-gitster@pobox.com>
	<87msr8qef9.fsf@kyleam.com>
Date: Fri, 08 Mar 2024 21:53:17 -0800
Message-ID: <xmqqle6sdk8i.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 545463EC-DDD9-11EE-B2AD-A19503B9AAD1-77302942!pb-smtp21.pobox.com

Kyle Meyer <kyle@kyleam.com> writes:

>> Now, for the same reason, let's allow command execution from within
>> the $GIT_DIR directory of a secondary worktree.  This is useful for
>> tools working with secondary worktrees when the 'bareRepository'
>> setting is set to 'explicit'.
>
> Does the same reason also apply to .git/modules/$name ?

Perhaps.  I do not actively work on submodules so unlike those who
are always thinking about improving the user experience around them,
I did not think of those ".git/modules/$name" things as something
similar to the ".git/worktrees/$name" things.

Often hooks (and probably third-party tools) run after chdir to be
in $GIT_DIR, so the problems they face when their /etc/gitconfig
forces them to use safe.bareRepository=explicit are probably very
similar either way.
