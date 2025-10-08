Received: from mail.lohmann.sh (mail.lohmann.sh [23.88.42.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 146F41E25F9
	for <git@vger.kernel.org>; Wed,  8 Oct 2025 22:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.42.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759962345; cv=none; b=osRgg4bderFLZQ79wceNr5bZxceMbKjsn5UT4eFY2Mow1n6KNPcxvYs/duoEnu6CPlzvcJZ4wHK6vlBMEumu1/g4qkGwklEeKPHN0ra6FpR1TO3vZ4H3zissUsm0YPLHD6LKOYtBtJrGJbfN1Z6cAl6YWa9dXJsEUcqDzR8ZHzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759962345; c=relaxed/simple;
	bh=ZWbGPOQyEkS6SzYrd6rgiVhXVu1bW2Nei4N4pVTEc2k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QUc9G3Wpa7DT6bT29EGGDg4Dy0pKbzfM4azqAoPi9Izn7fEKWvNwKjLKxVol+PDAZhZnGe5entQOU4vjSabuk4O3KGaxDthN07arUwpNL0vQBK79gSt9VC96SMN05JdlNYJRuaxVNfvjV61i1EiWBNT7AD1UvD80gWlU6/61M1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lohmann.sh; spf=pass smtp.mailfrom=lohmann.sh; dkim=pass (2048-bit key) header.d=lohmann.sh header.i=@lohmann.sh header.b=ElegJwuA; arc=none smtp.client-ip=23.88.42.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lohmann.sh
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lohmann.sh
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lohmann.sh header.i=@lohmann.sh header.b="ElegJwuA"
From: Michael Lohmann <git@lohmann.sh>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lohmann.sh; s=mail3;
	t=1759962340;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+GW5FpJjRbqJZNQPpYJZz7i7Ch2/D5pl4vpZCF/X8OE=;
	b=ElegJwuADPSrtk2+UXFuD+ksSS6PTPSyyh8RvNtB99UrV4itJmN+rtlyVrenz4NGv6feCK
	ziOhGmHlFi6LagAjfRYnn5WKDjVS0UFqqqLZclltEb2Pq+GbkBAQl79kzvTQscFpMr+0YR
	Ax55oBAsXuS7Ay95Yd1g83j4DkBQP4h3o1eC9jrfBYiHAQ+5qUoeJzCSLz7Gf7VqBflYfR
	UaoOf69yQ5VSihcTjT+eTD/f9nHaqm87/uII6ZRQ26wPrAg3B/kuNsIUxmMs91l8RQDUKa
	d8RkLxamkw9p+FuKwfGacrZlsaPyg7l/86lReu+MsYmdk3v9Rfjj7KETfEQ0Uw==
To: sandals@crustytoothpaste.net
Cc: git@lohmann.sh,
	git@vger.kernel.org
Subject: Re: Re: [RCF] Secure git against involuntary arb. code execution without feature loss
Date: Thu,  9 Oct 2025 00:25:12 +0200
Message-ID: <20251008222512.70500-1-git@lohmann.sh>
In-Reply-To: <aObZPJ3JK-YVI-g7@fruit.crustytoothpaste.net>
References: <aObZPJ3JK-YVI-g7@fruit.crustytoothpaste.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

(Sorry @Brian, the first time I forgot to add the mailing list in cc,
and the second time I didn't have my mail client under control adding
HTML... Now trying with send-mail again in order to try and reduce the
possible errors. I am sorry, I am still quite inexperienced with the
mailing list and you need to suffer from my stupid mistakes!)

On Wed, 8 Oct 2025 21:35:56, brian m. carlson wrote:
> This has all of the downsides of our existing per-Unix user approach and
> is also more complicated.  You'll notice that when we changed to the
> per-Unix user approach, that broke containers, shared repositories, and
> even the detection of whether a directory _is_ a repository, and this
> would do the same thing.  It would be even worse for containers because
> if you copied a token into the container from the container user, you'd
> end up polluting that directory with lots of useless tokens that never
> get cleaned up.

Since I never worked in such a scenario, I think I am missing the full
implications. Instead of always requiring that, you could simply set
something like GIT_ALLOW=true or pass `--allow` (or maybe even a _global
only_ config `safe.allow = *` and then you explicitly opt out of this
protection for cases like this.

> It is also easy to bypass, since if we share multiple repositories as
> collaborators, as soon as I can read the secret from one of them, I can
> then write it into any other location.

Then instead of having a single file with all the tokens of users,
create different files with the respective user as the only one allowed
to read.

> It would even be sufficient if we were users on the same system (such
> as is common in universities or some businesses) and I could read the
> repository.  Many websites even accidentally expose their `.git`
> directories, which would not only expose their repository but also
> allow attacks against all of the administrator's repositories.

What is different to the current situation then, apart from that you
specifically have to leak that secret and you now have to be targeted
individually and if you notice it being compromised you can rotate it?

Maybe instead of a shared global secret, create individuals you can
revoke independently?

> What would be better to see instead is a config option that restricts
> which external commands (via config options or hooks) can be executed
> from local config.  Then it would be possible to say, "Never honour
> local config to execute code."  With `includeIf`, this can allowlist
> certain repositories to do that and leave the rest disabled.
> 
> Maybe something like this:
> 
> [safe]
>  config = core.editor
>  config = core.fsmonitor
>  hook = pre-receive

Interesting idea!
