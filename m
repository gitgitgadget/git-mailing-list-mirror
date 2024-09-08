Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA32E191
	for <git@vger.kernel.org>; Sun,  8 Sep 2024 21:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725830190; cv=none; b=RFJsQTRynIKYDSl8CCBxTgLYZr6tQofMqBdWz9kof5rhgZAGZN5YMDzZZLBVcZX+5se7t7xa+l5ZNpPn29QD1YWq/q4s2wpnRxKEqho1mNA0AxN+4Vt7y5QQkQo8Qk3az+Fu1qFLC4pfVwvE9UjIXQoGT2HaaO+266mKuDBHUqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725830190; c=relaxed/simple;
	bh=Py1pFIoiNyYP/i/UhDRCR0crlokEueu6gFBd8qbZJrU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=oZ7C+Z+EmiOFnMGdbr1PjcVZctc62mVwB1l4M4YMKYg6LFXoQu1M6kGSP1N6O5Nmk0NIdcTkRU/j7OJCCYsftNtY7Rnat2I8bzZuEiJSdvEDVuRg8dfAtiPNBvWapux0n+LgsEZ/sobhLMYxBa1kowg9ihKi/zVKCXwW6zjbSb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=f5mt12Ne; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="f5mt12Ne"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id A717631F83;
	Sun,  8 Sep 2024 17:16:22 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=Py1pFIoiNyYP/i/UhDRCR0crlokEueu6gFBd8q
	bZJrU=; b=f5mt12Nee2juPuayRGYERK/cJ6yEV1U4pC7c7M4gDzrIiLftE4ujZm
	tj8DqZZR4U9aaFUGTHdYTKLJEjcNdSMMPhr5OqjQ35K6339+N49Qaga1AOPnVJr4
	YAp73bIDkid88YJBKVJjoBTVBxB/6DJ3GOW0vgnNoZfm79s913QGU=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 9F11E31F82;
	Sun,  8 Sep 2024 17:16:22 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.108.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 1252B31F81;
	Sun,  8 Sep 2024 17:16:22 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Elijah Newren <newren@gmail.com>
Cc: git@vger.kernel.org,  blanet <bupt_xingxin@163.com>,  Xing Xin
 <xingxin.xx@bytedance.com>
Subject: Re: [PATCH 2/2] remerge-diff: clean up temporary objdir at a
 central place
In-Reply-To: <CABPp-BGmeg3x-F2ZjLzqcDYzSMOfz8Q3BDKUtB=vMO90yJRb3A@mail.gmail.com>
	(Elijah Newren's message of "Thu, 15 Aug 2024 23:19:37 -0700")
References: <xmqqv8099vms.fsf@gitster.g> <xmqqr0ax9vlk.fsf@gitster.g>
	<xmqqbk1y8gm1.fsf@gitster.g>
	<CABPp-BGmeg3x-F2ZjLzqcDYzSMOfz8Q3BDKUtB=vMO90yJRb3A@mail.gmail.com>
Date: Sun, 08 Sep 2024 14:16:20 -0700
Message-ID: <xmqqed5tx2vv.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 98F79D28-6E27-11EF-AEDA-2BAEEB2EC81B-77302942!pb-smtp1.pobox.com

Elijah Newren <newren@gmail.com> writes:

>> I forgot to add that I am not happy with this "centralized tear
>> down" step, even though I am reasonably happy with the "lazy set-up"
>> step.  I wonder why the remerge-diff related members have to exist
>> in the rev_info structure in the first place, instead of being in
>> the diffopt structure?  Moving them to diffopt may make the end
>> result much more pleasant to read.
>
> I'm not sure they need to exist in the rev_info structure.  I was
> probably thinking that e.g. log --remerge-diff would "need to do lots
> of diffs" but I only needed the temporary store setup once, and once
> in my mind matched better with rev_info.  I wasn't aware of
> diff_options.no_free or anything surrounding it.  If we can do the
> temporary store setup in diffopt and only do it once for all N diffs
> in a `git log --remerge-diff` run, then we could move this stuff from
> rev_info to diffopt.

After staring at the data structure around this area for a while, I
think these two patches are OK, especially within the current
structure.  rev_info structure has a set of bits that are marked as
"Diff flags" (some of which are not about diff at all, though; for
example, verbose_header and no_commit_id belong more to the "Format
info" group), and those related to merges do belong there, as they
need more than "here are two tree-like things I want to compare".

So, I'll mark these two patches for 'next' now.

Thanks.

