Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0B7F548FE
	for <git@vger.kernel.org>; Thu,  4 Apr 2024 23:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712272104; cv=none; b=AjOBR8xL5qmXenRxhGJaSqdSTTMieij7A68vjtO2Z9R9Lrp7WvEFeTucZKR4HGFGsRqNYeCDY0dKmhGgS9TInczfmMadBfWViiHMpczwC+fuieZU0FKXECTKN3UAtdjP8TjHiSTNajKkrQeRkwGFv7coRZB+AjaLhga5zQOBSCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712272104; c=relaxed/simple;
	bh=/a38fxVc/QFWkMvR4oqaCA7KuuGulC3wd91PRXTvTS4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=PKwQD7N8rPxhYzB5XS6FjQKxVLiD25qhVlSbIidWYVohDZ8qSqtU8G9HU5xKUFPvFkb7gVokdVkSAHj4YjsBkC85S5R9TvSU1mutW1LLt5FzQq++MK4KkHfpAx7SgRMT7eFcdqRh/yionKSKKqxED/e5FzvJReQCSMUzu5F0Hdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=mMi7GxJG; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="mMi7GxJG"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 7A6781F7ED7;
	Thu,  4 Apr 2024 19:08:21 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=/a38fxVc/QFWkMvR4oqaCA7KuuGulC3wd91PRX
	TvTS4=; b=mMi7GxJGHtSEKU8OV7SJGfrzxOls0qKtk1U+TktquR8fGHnXNOjr65
	2XR9+sRXRlHQcBkBZjCi9pbHHVFtad865LcHVh1vixqdZu0dlukVkpRuiiy/TUKN
	xHub90760rrDlozOMN/ErEoQ878psqjnov1R+zavf/I00xXc+dwic=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 727451F7ED6;
	Thu,  4 Apr 2024 19:08:21 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.229.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id CEBEA1F7ED5;
	Thu,  4 Apr 2024 19:08:20 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,  Git List
 <git@vger.kernel.org>
Subject: Re: free and errno, was Re: [PATCH] apply: replace mksnpath() with
 a mkpathdup() call
In-Reply-To: <20240404225313.GA2512966@coredump.intra.peff.net> (Jeff King's
	message of "Thu, 4 Apr 2024 18:53:13 -0400")
References: <df774306-f29b-4a75-a282-59db89812b9a@web.de>
	<20240404225313.GA2512966@coredump.intra.peff.net>
Date: Thu, 04 Apr 2024 16:08:19 -0700
Message-ID: <xmqqv84wybdo.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 3AD01880-F2D8-11EE-AB75-25B3960A682E-77302942!pb-smtp2.pobox.com

Jeff King <peff@peff.net> writes:

>> +			free(newpath);
>>  			if (errno != EEXIST)
>>  				break;
>>  			++nr;
>
> At any rate, you can probably see the places where free() clobbering
> errno would be a problem here. Our return when "res < 0" (though I don't
> think any of the callers actually care about errno after that), the
> check for EEXIST at the bottom of the loop, and after we break out of
> the loop, we use error_errno() to report it.

Yeah, a failing free() is unlikely to set errno to EEXIST ;-)
