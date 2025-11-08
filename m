Received: from bsmtp2.bon.at (bsmtp2.bon.at [213.33.87.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ED042D1F7B
	for <git@vger.kernel.org>; Sat,  8 Nov 2025 08:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.33.87.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762590388; cv=none; b=OMI6saw82UPpLL0NZg9Q+ImjTgBVVmoBPWQoymlk01D83CefiGxNVVvlucNT1LtWUECoB+kCpIFs9SKT5jqtS+AI69lo3zfGLmM0l3+FXO957byZH9Sa2DT93PrWpZdOE20M0z0XW7egMV/rLxjCcgDWf5b3EaLurJPquqSSJTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762590388; c=relaxed/simple;
	bh=zkD07hC7ZrWbmmVVvmc5y1VaCNHMHK+YvSm5chlqQPg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GT8s0+yC9RO37eScsyUsuJUyW5xbFZii6f7QRZx8Iuir14FdHjxFU2/zCZZz8EsgvCCW+oXxaou+qQ4cHRUnkxX1J09ktKJE4drVdu2keDsglwXGJNsmuRO1Mwnq5GTa7CCSE/PVNj8ydN18yyDWGO90XDB5UaHcZaOWhhlyTGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org; spf=pass smtp.mailfrom=kdbg.org; arc=none smtp.client-ip=213.33.87.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kdbg.org
Received: from [192.168.0.104] (unknown [93.83.142.38])
	by bsmtp2.bon.at (Postfix) with ESMTPSA id 4d3TXm2vzwzRpLH;
	Sat,  8 Nov 2025 09:26:16 +0100 (CET)
Message-ID: <6f9a0358-4d87-477a-a067-081ce6b2d102@kdbg.org>
Date: Sat, 8 Nov 2025 09:26:15 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Bug report] git cherry-pick silently ignores error whereas git
 apply fails for hunk apply
To: bhavikdbavishi@gmail.com
Cc: git@vger.kernel.org
References: <CAEyHQXWd77_jJachC6FYbWMJ+L=KkKoUqiACQ7z8r-ZwYq8JYw@mail.gmail.com>
 <e1fede83-bed0-49e9-84a0-f026b9df6039@kdbg.org>
 <CAEyHQXWd4kN=ehWh0Y7xNnPGk3ofXEc4=PvSYaZM91TFyLtnpg@mail.gmail.com>
 <CAEyHQXUgzRnT=8Fydn9Ew6V29hfJcjR8i26mdvGOXaWD=agzNA@mail.gmail.com>
Content-Language: en-US
From: Johannes Sixt <j6t@kdbg.org>
In-Reply-To: <CAEyHQXUgzRnT=8Fydn9Ew6V29hfJcjR8i26mdvGOXaWD=agzNA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Am 08.11.25 um 04:44 schrieb Bhavik Bavishi:
>>> If you use `git apply --3way`, does it still fail, or does it succeed
>>> and does it produce the same result as `git cherry-pick` or a different
>>> result?
>> I've compare the file content of `mango/utils/apple_utils.cc` for `git
> apply --3way` and  `git cherry-pick` is same
> 
> If I understand correctly, `git cherry-pick` is processed as expected, but for
> some reason we are not able to follow this behavior because the end result is
> missing content. expectation was to have this content either be applied
> successfully or fail with a conflict (indicating it could not be applied).
> 
> query: is there a way to understand this behavior? Based on that, we can then
> correct or update the file format to avoid such issues in the future, or
> introduce an additional process to run `git apply` (without `--3way`) and check
> if there is any hunk failed to apply and notify for the same.

`git cherry-pick` and `git apply --3wax` use a merge strategy. If this
operation omits a change, then it is usually the case that it was
determined that the change was already applied independently. This in
turn can happen in a situation where there are repeated occurrences of
the same text, and only some of them are changed, like this (and I am
speculating here):

base:   ...ABC...ABC...
theirs: ...ABC...AXC...
ours:   .........AXC...ABC...

Here, the merge strategy thinks that the change of the second "ABC" to
"AXC" on their side matches up with the first "ABC", but that has
already been changed to "AXC" independently on our side, hence, there is
nothing more to do.

-- Hannes

