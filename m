Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51D811EB2A
	for <git@vger.kernel.org>; Tue,  6 Aug 2024 15:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722959071; cv=none; b=tW00j7wKq/XH87SKnp9+hNotY7DwXsUsoAXESwvEunpR+/5kMu7yK6P9/8wmaRLFxO2IgRAvM0GQOY1Igp7mh4pSeCukD/xitRYbg2lCyMiDf9A3M2bdYK1t88F+LxdTwME3YnUrXxcXkv5to9mYo4gBBebpnXr7M5IAdf/2SCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722959071; c=relaxed/simple;
	bh=yyLwDSoWgzjR/oy1cSBNpZpx6aNen43D6KTR3JF6Paw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=C3eXurQRANXh6mv8+n8CUEfPvV7qHA83lgEUjUv1e4Crnuetx75phf/lhHKeUdQk4ufN+GQDf1uX3z4v62znkcGRB81hdPRC2XrGAt4bDozmZUaYbWGFl0c9Ai3MHhuYc9n7BSNcIiR7UF5+ByDh5aCDyGcd0BWmpnAsyZgsNug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=MYnUsRzP; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="MYnUsRzP"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 48EA32E6CE;
	Tue,  6 Aug 2024 11:44:29 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=yyLwDSoWgzjR/oy1cSBNpZpx6aNen43D6KTR3J
	F6Paw=; b=MYnUsRzPULBINBUhhaJzrTbYY7YjZGEpBLxjSjm2o3tTWbkyU7sM2N
	Fg9K0nw9ZVa5p6vj43aAv3VqBGM9+hmylJoOUdHFnz9iHIGuyvSihtcL+amTXDyU
	1Ogr3wQx9JWF8c8dNItPoMpOv2EsLcMpMUnqunUDVMGakNHa4TPZw=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 40E2F2E6CD;
	Tue,  6 Aug 2024 11:44:29 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.108.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id A738E2E6CC;
	Tue,  6 Aug 2024 11:44:28 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Sven Strickroth via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Sven Strickroth <email@cs-ware.de>
Subject: Re: [PATCH] repository: prevent memory leak when releasing ref stores
In-Reply-To: <ZrHAu0wfipR6CShS@tanuki> (Patrick Steinhardt's message of "Tue,
	6 Aug 2024 08:20:43 +0200")
References: <pull.1758.git.git.1722855364436.gitgitgadget@gmail.com>
	<xmqq34nj3pez.fsf@gitster.g> <xmqqed723mth.fsf@gitster.g>
	<ZrHAu0wfipR6CShS@tanuki>
Date: Tue, 06 Aug 2024 08:44:27 -0700
Message-ID: <xmqqcymlzmec.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 C4077632-540A-11EF-A2EF-9B0F950A682E-77302942!pb-smtp2.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

>> Something along the following line (caution: totally untested) that
>> allows your two patches to become empty, and also allows a few
>> callers to lose their existing explicit free()s immediately after
>> they call _release(), perhaps?
>
> I don't really know whether it's worth the churn, but if somebody wants
> to pull through with this I'm game :) But: if we are going to do this,
> we should rename the function to be called `ref_store_free()` instead of
> `ref_store_release()` according to our recent coding style update :)

Yes, we had "what is release, clear, and free?" discussion recently.

>> If this were to become a real patch, I think debug backend should
>> learn to use the same _downcast() to become more like the real ones
>> before it happens in a preliminary clean-up patch.
>
> That certainly wouldn't hurt, yeah.

I am not short of (other) things to do, and expect that I will not
touching this for a while, but in case somebody finds #leftoverbits
here, I'll leave a note here.  

There are "hidden" freeing that we have to adjust, if we were to
follow through this approach.  For example, those free()'s added in
the patch in the message that started the thread are introduing
double free---after the strmap_for_each_entry() loop, a
strmap_clear() callis done with free_values=1.  If we freed inside
ref_store_release(), we'd need to adjust the call to strmap_clear()
to pass free_values=0 to compensate.
