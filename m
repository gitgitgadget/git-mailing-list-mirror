Received: from bsmtp5.bon.at (bsmtp5.bon.at [195.3.86.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29675190477
	for <git@vger.kernel.org>; Wed, 22 Oct 2025 05:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.3.86.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761112547; cv=none; b=sSYiQ8Vj1gnFvQgjPKQ2aIsaVWY0cqBojBG8dCDLigy0gE/wTMorkJDCVT1kbuEsmXWLlDog816xPNUcXJhyJgwE9vgWHBFtM7CI+0ItXMM/roYUJLCll7mte4A70mROtn+t0HxSTShXd+O0iXkys/7jZepah66s0czcZSwepus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761112547; c=relaxed/simple;
	bh=6qVdNjDxM5DYeP0ZA90MwdEpmob1AmpVuLtfbvaLTpY=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:Cc:
	 In-Reply-To:Content-Type; b=FqPUEnc27eHJFEfs9jOBbFEqyZxVKbuXGoFaZzOKtKKlac90GOO05UgfNToRE8zmMWNpbKB3dDbTymiyyCC41XQQDDrzHy0KXGAkWWS//ig6p95udSbV96Fvw3nAczj8JHvxcISDyGFEIaxdS6sbOUTM13kOb8RKGi2lxE/fo0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org; spf=pass smtp.mailfrom=kdbg.org; arc=none smtp.client-ip=195.3.86.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kdbg.org
Received: from bsmtp.bon.at (unknown [192.168.181.101])
	by bsmtp5.bon.at (Postfix) with ESMTPS id 4crz0H6qFjz7QSv4
	for <git@vger.kernel.org>; Wed, 22 Oct 2025 07:55:11 +0200 (CEST)
Received: from [192.168.0.104] (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTPSA id 4crz064wdSzRpKP;
	Wed, 22 Oct 2025 07:55:02 +0200 (CEST)
Message-ID: <bec27479-c53f-472c-87c7-374321108ad5@kdbg.org>
Date: Wed, 22 Oct 2025 07:55:02 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [rfc] flip rerere.enabled default to be "on" at Git 3.0 boundary?
To: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
References: <xmqqldl4und1.fsf@gitster.g>
 <ecf21e8d-acff-47fb-b972-59cd7b8f3146@app.fastmail.com>
Content-Language: en-US
From: Johannes Sixt <j6t@kdbg.org>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
In-Reply-To: <ecf21e8d-acff-47fb-b972-59cd7b8f3146@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Am 21.10.25 um 20:55 schrieb Kristoffer Haugsbakk:
> On Tue, Oct 21, 2025, at 20:21, Junio C Hamano wrote:
>> A good default matters, and people who find out how useful a rerere
>> database is would say "gee, that sounds great but why they do not
>> enable it by default?  It is too buggy and they wanted to reduce the
>> number of support requests?"  Yes, the reason it is not enabled by
>> default initially was exactly that, i.e. those opt into the feature
>> was used as guinea pigs to polish the feature.  But we forgot to set
>> the graduation criteria and never said "ok it is mature enough, so
>> let's turn it on for everybody".
>>
>> Perhaps Git 3.0 boundary is a good occasion to do so?
> 
> This sounds nice.

While I agree that the rerere cache is a very valuable tool to have, it
has the very sharp edge that a cached wrong resolution is extremely
difficult to get rid of.

Merge conflicts and how to resolve them correctly is a skill that needs
to be trained. Giving a novice who is still tipping their toes into the
waters of merge resolution the advice to "just enable rerere" exposes
them to a behavior whose results (the reuse of incorrect merge
resolutions that they thought they had already corrected) are
inexplicable without the help of an expert.

I think I'm saying that I am mildly opposed to enable rerere by default
as long as it has this sharp edge.

> 1. I did the wrong thing for `file`
> 2. I reset the merge back
> 3. I did the merge
> 4. *While resolving conflicts*: `git rerere forget <file>`
> 5. `git merge --abort`
> 6. Do merge again
> 7. Now I can redo the merge conflict for `<file>` while keeping the rest
>    of the resolutions
> 
> I don’t know if all of that was necessary but that’s what I did to make
> it work for me.

Instead of 5.+6., do `git checkout --merge <file>`.

> In short I guess I’m saying that git-rerere(1) isn’t that
> straightforward if you want to figure out what is in the cache, if you
> can delete things from it in your current state, things like that.

Could rerere perhaps update the cache even after a resolution has been
reused? Then a reused and then modified resolution would enter the
cache, and the updated resolution would be reused if and when the merge
is repeated.

-- Hannes

