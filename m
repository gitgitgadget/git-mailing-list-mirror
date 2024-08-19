Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7290D2941B
	for <git@vger.kernel.org>; Mon, 19 Aug 2024 15:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724082645; cv=none; b=r3YZeB+tIrWTfw/jqoueOadx3MbMPf6cTQEC0NQgrk/E3zP54vCtwMd2QT/ZQ7kWwnOIniveQyQwN1DDaCt1OoPiaqbbWcRKL+DX/dm6VsklXcOdtVm3UJLvx8rQEJOGWNiIzbtUuxi9fwb9BIUVOeGZDlAXJ5vYX8dfcuSNnoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724082645; c=relaxed/simple;
	bh=kenqeMumVsBvBqWGGXz6ipF4gYSl4BBHRcihBR5U5ck=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=l+QOfvdwv1moTPQYRDdKbcKE4JS4Tf8xpFAdq9RPq+8qhRRRl3Qx8jFyQg7mNoxpXU1oIbd/IU/0FM0n5/zmUoz+l+li5I7ebawFnAT56v0AjWkJOxUjfnC/IuBFB5lYgIiWlDPakFPJfgIDBMp377z4KdjjiAomC2YX+0CvbP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=uIGYSGrS; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="uIGYSGrS"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 35C522135E;
	Mon, 19 Aug 2024 11:50:43 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=kenqeMumVsBvBqWGGXz6ipF4gYSl4BBHRcihBR
	5U5ck=; b=uIGYSGrSfC1Y/dSk4sGs/RagyaiNz81skiutySQg/jxNj4OhuOlUQ3
	SGKZF57NjqjsCg+wLCETEIuhJWpjRZDRT8fALg0NhgH+uiq8heKutJlDPa8YbIYW
	sOEfUvnxbFv9MYiLOLYjFGXVrmUcuzUbzNbtz40uBvlV1ytMXpkNQ=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 2D8E62135D;
	Mon, 19 Aug 2024 11:50:43 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.94.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 68BDE2135C;
	Mon, 19 Aug 2024 11:50:42 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Eric Wong <e@80x24.org>
Cc: Patrick Steinhardt <ps@pks.im>,  git@vger.kernel.org,  Jeff King
 <peff@peff.net>
Subject: Re: assert vs BUG [was: [PATCH v1 05/10] cat-file: use
 delta_base_cache entries directly]
In-Reply-To: <20240818173637.M96307@dcvr> (Eric Wong's message of "Sun, 18 Aug
	2024 17:36:37 +0000")
References: <20240715003519.2671385-1-e@80x24.org>
	<20240715003519.2671385-6-e@80x24.org> <ZqC872ExETzRH60Z@tanuki>
	<20240726074201.M876490@dcvr> <20240818173637.M96307@dcvr>
Date: Mon, 19 Aug 2024 08:50:41 -0700
Message-ID: <xmqqr0akfr5a.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 CA2B0D8E-5E42-11EF-AB1C-2BAEEB2EC81B-77302942!pb-smtp1.pobox.com

Eric Wong <e@80x24.org> writes:

> Eric Wong <e@80x24.org> wrote:
>> Patrick Steinhardt <ps@pks.im> wrote:
>> > We shouldn't use asserts, but rather use `BUG()` statements in our
>> > codebase. `assert()`s don't help users that run production builds.
>> 
>> OK.
>
> Thinking about this more, I still favor assert() in common code
> paths since it's only meant to be used during development and
> later removed or neutralized (via -DNDEBUG).

I have a mixed feeling.

I agree that assert() is only meant to be used during development,
but we only want code that is polished enough to be added to the
system, so there is no place for assert() in the code in 'master'.

The point of BUG() is that it is not easily "neutralized", so it can
help safeguarding the production code from harming the end-user data
due to doing nonsense things without noticing that the precondition
is not satisfied for it to perform correctly.  It makes sense to
have it in both during development and after deployment.

