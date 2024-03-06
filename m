Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F52CF9EB
	for <git@vger.kernel.org>; Wed,  6 Mar 2024 16:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709742990; cv=none; b=HL+O1JOp5Q4qdYMBZSIU+MEnJbWovJLcf7OC/O6p2VgSlJ0UURwsggPeAUdjyNNKCAyOGs/EUsn+kcjz18DQ1fXOfNFqdeQqvKsv20WCaxqbH2Ew5Z9zfEzPJ+8ml7RBtWNwm31Om0clb1t4eVJbsZUG4SEJgVozRfGO0ffUSr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709742990; c=relaxed/simple;
	bh=WB6oiNfWxmhaAaCLZE+HBtya6wr9MxAITnMcOpAjXSA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=t1jD3RgecpjhIpeJneBSw2Qy8Po1aJ+t7d1BgOk9stw3WUthxo+ecEvwth5RwHQz3QDAJl8lQiZSt15xwcwYJ/3ZniJoep+B+D1pIbGq5ix6YJ1uyr4tzO4gl4u3x3g6WxoFgdBDR2aBksVrw7MD8C0CQ8obcOqCON9NaxnL86o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=MITl20DW; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="MITl20DW"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 20F161D8938;
	Wed,  6 Mar 2024 11:36:27 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=WB6oiNfWxmhaAaCLZE+HBtya6wr9MxAITnMcOp
	AjXSA=; b=MITl20DWpmff5lvmwI3pKxEDcbrSiSuvTRV4+TJ1lX7mEbh/0+d6i0
	S6HCcIqHEG865yQLLQ53eLmEHOHDGa8+9g73YT89i9II5tkZBKvf8AkudHPycrJQ
	pkSfuETC/vUmeK2VOzQGw+EQjjfI29/kYm4RpYPw1x7ovyY5gI7XQ=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 1745F1D8937;
	Wed,  6 Mar 2024 11:36:27 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.185.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 7C0B71D8936;
	Wed,  6 Mar 2024 11:36:26 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 2/4] reftable/stack: register new tables as tempfiles
In-Reply-To: <Zehav4V_8GGZG94Q@tanuki> (Patrick Steinhardt's message of "Wed,
	6 Mar 2024 12:59:59 +0100")
References: <cover.1709549619.git.ps@pks.im>
	<02bf41d419efd00e510a89a405e1b046b166ba20.1709549619.git.ps@pks.im>
	<6cw6d3ubo2kbogzdbniyoznij2zfoh5t3htwb4oaghaltcgeqg@kkrw4g6atr2k>
	<Zehav4V_8GGZG94Q@tanuki>
Date: Wed, 06 Mar 2024 08:36:25 -0800
Message-ID: <xmqqedcntj06.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 AD31F58C-DBD7-11EE-9228-25B3960A682E-77302942!pb-smtp2.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

>> Since the tempfile is now being created through the tempfile API, I
>> think the file mode can be set directly through `mks_tempfile_m()`
>> instead of creating the tempfile and then using chmod. Just something I
>> thought to mention.
>
> Unfortunately not. The problem is that `mks_tempfile_m()` will munge
> passed-in permissions via "core.sharedRepository", but we already pre
> calculated the target mode in `config.default_permissions`. Thus, the
> result would have wrong permissions if we used `mks_tempfile_m()`.

I somehow found that default_permissions thing always disturbing.

Even if we keep a separate mechanism for determining the file
permission (perhaps in order to give ourselves a better separation
as "an independent library" from the rest of Git), shouldn't the
permission setting that is computed by the mechanism and stored in
config.default_permissions be consistent with the permission the
rest of git computes based on core.sharedRepository?
