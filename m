Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C746383CC1
	for <git@vger.kernel.org>; Mon, 29 Jul 2024 20:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722283423; cv=none; b=KjWpvMiV9+04bmqYQchSfb0TyR3Q3GtXI+PNH/HlRbPSbyizx+Lkw0V7FU+LsMFvTj8e78h/i0aCKTGLyC/30GtC3RQJOp6jIHTH925iGNNAWHYkvqGdi7a0Zdxr3DtX+Cko5PfvK9RXgnw+w85eVXLRSGH5VwDlZnDGe09gmeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722283423; c=relaxed/simple;
	bh=OnYglvENTt/nm4m/wFUH86zsZG0C4TVl+ebBXCnM4tA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=AKC55FqjPNnAmvw6dKxVlhB3tLMdyeYUGVxST25BnxbiQhtG4JNy/uoB0VkIS+Gq25O77hle4zf2xLCCru/Z/Qx+7DPd2VB6McOEIheeAD085byicqIgVp2V4gkqYO153fzb2MHmvtUhEvuDNLXWeVgHO0K+EI6wCg/OujU+N1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=qBb1WzPy; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="qBb1WzPy"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 3570838A64;
	Mon, 29 Jul 2024 16:03:41 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=OnYglvENTt/nm4m/wFUH86zsZG0C4TVl+ebBXC
	nM4tA=; b=qBb1WzPyscHWQAXuaTUPFuDgyr29MtzsBOMysEAwNpF7WVX7CEysqX
	2/+fLuZeFXfkJP7QenUurZY8lMkXMQI9TbbQ/MUUCjRvulstCWPWe3npXmMbzofP
	8AbfrMLw3Lx5BfXmCZYCRvEPfrzlgs/MrAsjaGjrfUHiw7q4MHBEk=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 2E76638A63;
	Mon, 29 Jul 2024 16:03:41 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 3FF0238A60;
	Mon, 29 Jul 2024 16:03:37 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 3/5] patch-id: make get_one_patchid() more extensible
In-Reply-To: <ZqeE2IaIhiWmpVM4@tanuki> (Patrick Steinhardt's message of "Mon,
	29 Jul 2024 14:02:32 +0200")
References: <20240621231826.3280338-1-gitster@pobox.com>
	<20240621231826.3280338-4-gitster@pobox.com> <ZqeE2IaIhiWmpVM4@tanuki>
Date: Mon, 29 Jul 2024 13:03:35 -0700
Message-ID: <xmqq34nshso8.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 A465D5E2-4DE5-11EF-8051-9625FCCAB05B-77302942!pb-smtp21.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

>> No changes in behaviour.  Just a trivial interface change.
>> 
>> Signed-off-by: Junio C Hamano <gitster@pobox.com>
>> ...
>> +#define GOPID_STABLE   01
>> +#define GOPID_VERBATIM 02
>> +
>
> This certainly is a worthwhile change. I have to wonder about code style
> though:
>
>   - Using 01 and 02 as constants feels somewhat weird to me. Don't we
>     typically use `(1 << 0)` and `(1 << 1)` for such binary flags?
>
>   - What is our preferred style nowadays? Do we prefer defines over
>     enums? I rather had the feeling that enums are the go-to style for
>     things like this nowadays.
>
> It would also be nice to have documentation for the flags.

For an internal implementation detail that does not even cross file
boundaries with descriptive _STABLE and _VERBATIM that corresponds
to the member names of config structure?  I doubt it.

> In any case, all of these are really just smallish nits and I think that
> this is a strict improvement regardless of whether we massage the style
> or not.
> ...
> I was wondering whether we could use `OPT_BIT()` here to set those as
> flags directly. I guess that would require a bit more refactoring, but
> if we also converted `struct patch_id_opts` to have a `flags` field then
> this might overall be easier to read than the weird massaging of opts
> that we did before and after your change.

As a longer direction, I envision that most of the implementation we
see in this file and what diff.c:diff_get_patch_id() does should be
refactored and one of them should just go.  So until that happens, I
am inclined to keep the changes to this file to an absolute minimum.
