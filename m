Received: from mout.web.de (mout.web.de [212.227.15.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE7AA2797BE
	for <git@vger.kernel.org>; Thu, 17 Jul 2025 08:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752740562; cv=none; b=a7Pr2ZAiqB6lbEHhi6uDQ5ninm+46O2txiV2s6ylJ6751FI6V2aLDuGM73ArfE4Z0kA7XzM4jR0kcip9AMyVuAZl/iT2MOlfYfldz/sNdH+tdsJAs2IaKkoipUdYu5yM5J7SfsOZHYy0fAx5dAqS0dOSl+J9ZcJfsCMYa9077lY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752740562; c=relaxed/simple;
	bh=/WNKG7aFrcOnd3S7S9fr0f6kuF/zusdDg3rNQtX9nh0=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=ZAEleVdI4txC4yPXs++R/CjyS13zvLefo7qp81+1qLdA9THEB9RACMKy5OAxxwDpKzcAeGy5tFAmx7V/iVIE052us2lNpUroimfCHM7LvWH5ryV3nAZozX6MgjpMPijzPQZNBLz/oaewaWYCbRuoLZ0A7cV48AuVc6X3HScTwaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=CNgQLWOX; arc=none smtp.client-ip=212.227.15.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="CNgQLWOX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1752740557; x=1753345357; i=l.s.r@web.de;
	bh=+aZXdivfO4oeZD7w3o8XfSDUfpqlUQkvHNHT26vr80I=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:From:To:
	 Cc:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=CNgQLWOXzm90UNkGga+uzX1So0lsZeyewZt0Q4f1/HQhTH9BRDVg7tTLa9ebW3YW
	 42VGr0qGKJ4Rz3h1Px27fXxgkfzX7aJXRlxes6BJzmZPkWnI7Cm/g/3pEWMSm/cVf
	 JVafd937PIy28z/+zk7jV6GQm9pcf2qOlYNMReK3cz/7i4PmXioSnjucHSLjHe96u
	 uO0JTqbakqlsKX8Af8lvEdDu3yL94OR4IgOgIHeQIKoQJg6SdHm8pXM04w4c6VbxJ
	 6g+BtwSjU9ZHiq9IOavHWEfoHua7lqwZijPKuUm6HrJ75baJNOaJVbqv+PWaQixOa
	 0a81gdCtG2IXAgykew==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.2.31] ([79.203.28.103]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MumNL-1uufmg1sjD-016Xj4; Thu, 17
 Jul 2025 10:22:37 +0200
Message-ID: <03b2e5db-1fb8-4c38-8448-ad320ab7f70f@web.de>
Date: Thu, 17 Jul 2025 10:22:36 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] commit: convert pop_most_recent_commit() to
 prio_queue
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
To: Jeff King <peff@peff.net>
Cc: Git List <git@vger.kernel.org>
References: <bc079b3c-a472-4f5d-95ca-390f9de25196@web.de>
 <bfb0a65d-c9dd-47d9-a88d-9fec43538b0c@web.de>
 <20250716050540.GB1396022@coredump.intra.peff.net>
 <b0950e32-b4fa-4aff-8b5c-58c734b880b2@web.de>
Content-Language: en-US
In-Reply-To: <b0950e32-b4fa-4aff-8b5c-58c734b880b2@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:EwmBhV5f3ud4LJIzFxjvcbB+UEcUAUwdLlKtxguLv9iChN9ZE/G
 IPXGWvBJt/VGCJ/+Sva92A4ji0hHT+iWWWoXwCmf+/cMyh9tZeuJS5KSk8RGbYbPqUc3Rel
 5c6JgPqYd3Rx6l0AGXxgLCVrMjVYy5ywJbPAyin+NzpEQDPkhxY0OTXqI2hoP2k/dQR8Cc4
 kqfrUGbdfb9PWlWTdv0Kg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:z0S/AVytXRg=;pRMftQbhlzOf17OW4Ho9IQGNaRt
 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
 oga408VWun4H8hcLdjV/rD5jYWVZnwSU1bb

On 7/16/25 11:39 AM, Ren=C3=A9 Scharfe wrote:
> On 7/16/25 7:05 AM, Jeff King wrote:
>=20
>> I actually have a series turning rev_info.commits into a prio_queue
>> which I need to polish up (mostly just writing commit messages; I've
>> been running with it for almost 2 years without trouble). Ironically it
>> does not touch this spot, as these commit lists are formed on their own=
.
>=20
> That is not a coincidence.  I had a look at that series and tried to
> reach its goals while keeping rev_info.commits a commit_list.  Why?
> Mostly being vaguely uncomfortable with prio_queue' memory overhead,
> lack of type safety and dual use as a stack.  I still used it, but only
> as local variable, not in the central struct rev_info.
>=20
> Anyway, I failed; revision.c::get_revision_1() took an 8% performance
> hit in my versions and none in yours, and I couldn't figure out why.
> Perhaps I should revisit it with the new prio_queue_replace() in hand,
> hmm..
Checked now, and it's still slower.  So I don't see an alternative to
making rev_info.commits a prio_queue.

Ren=C3=A9

