Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25E4956B7B
	for <git@vger.kernel.org>; Fri, 19 Jan 2024 23:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705705455; cv=none; b=fVscrOYuGNZCnGOPeQxaD53R9Cr6Z3+E0gH9r0JPmLrCWhfhHMPZkl3OwhOJPqqMMcirjSpSXOLXlAd2ieAJRXomUFtYDuDY2WmUf+WcGraZZaF5Id4X+x5UcJX/VjmSWjGvxe39QckAGGvHXID3Ue/c4Nr5NOY6YPTIa2h5Mh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705705455; c=relaxed/simple;
	bh=Vzg0C0tpjU5Nq3oSXUSVd3u+763ZWQETSnj49sMCr1U=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=F7+3uC3e5QfNQBWj3iLypZpMLQc93MYWmtb4UT8uzvVb5/ZihfqmC0NGYhBvBx6PQn2PCuT7XJVmf/Nat2GQmdwnfFm1j0Xr6cNF5lluLxjnsPxKVRV2U9AOZCfCMe3Sz6LJ5uLMnmSM6vxvnGyEUblMM1NmSOvzGTsssLe9fdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=bnATmTr+; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="bnATmTr+"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 50DE833BE4;
	Fri, 19 Jan 2024 18:04:13 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=Vzg0C0tpjU5Nq3oSXUSVd3u+763ZWQETSnj49s
	MCr1U=; b=bnATmTr+1LvI3wftisNvQgjm1LhMk4KX2qMYuwAbvBEbWzSrjxW1Om
	nHpqSKJ1iVTQb+PMtL6oH67AL/AL1zoj57Zozu/MvXzk3rpOQ8Jj7iOK/6zfFD79
	v+CsfT0pMfCmSGU2Vi5StjbUekDwu3N/p+J38pEPmvs1vzTZ8UB/4=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 4965E33BE3;
	Fri, 19 Jan 2024 18:04:13 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.200.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id D2CC733BE2;
	Fri, 19 Jan 2024 18:04:09 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,  git@vger.kernel.org,
  stolee@gmail.com,  Eric Sunshine <sunshine@sunshineco.com>,  Taylor Blau
 <me@ttaylorr.com>
Subject: Re: [PATCH v2 3/4] config: factor out global config file retrieval
In-Reply-To: <Zaor5zNLKE3UXhHM@tanuki> (Patrick Steinhardt's message of "Fri,
	19 Jan 2024 08:59:35 +0100")
References: <cover.1697660181.git.code@khaugsbakk.name>
	<cover.1705267839.git.code@khaugsbakk.name>
	<32e5ec7d866ff8fd26554b325812c6e19cb65126.1705267839.git.code@khaugsbakk.name>
	<ZaoUOPsze7rhtT2M@tanuki>
	<7f0864ad-c846-42a6-8ddc-85d6be58a4ee@app.fastmail.com>
	<Zaor5zNLKE3UXhHM@tanuki>
Date: Fri, 19 Jan 2024 15:04:08 -0800
Message-ID: <xmqq8r4lhqmv.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 0DD21DE6-B71F-11EE-A128-A19503B9AAD1-77302942!pb-smtp21.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

> Yeah, you're right that `git_system_config()` is bad in the same way. In
> fact I think it's worse here because we have both `git_config_system()`
> and `git_system_config()`, which has certainly confused me multiple
> times in the past. So I'd be happy to see it renamed, as well, either
> now or in a follow-up patch series.

OK, let's make a note #leftoverbits here and merge the topic down to
'next'.  By the time it graduates to 'master', we may have a clean-up
patch to rename them.

Thanks, all.
