Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 203DF4688
	for <git@vger.kernel.org>; Thu, 16 May 2024 18:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715884489; cv=none; b=bIJCDW0SLk8tbhejowvb/662XVKOsKgaic1ExpYiZi9qFJ0vAXBF8K38Igc0enJRafUpHuoKQQPH7f9pKsrw+qeWdzSm+7/LXVsK99HxF1s2ofWx+7HBr27vgQ88oikGSXBffV+Sf/pcL/xGSzAKck/UKmBD6tpZqmlAHAkQIbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715884489; c=relaxed/simple;
	bh=qcfG91MlR77uMh8iQ9PtmESHd2OZjHKllN8X5VxqPSY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=erE73wha8J0bTcp8+cqvGhIdtkIU6grAwDMYvWbSqb1wCWJZRwADba1aWMS6pX/bgWwGHdhxq8y/+I6srM45UYjmlpf4NU1h9cKgLNvq/TA4mrcUPkZcoR6s8FpqCqV84TttmzVqrmYVRMyQHJJ7ilMZzQgxYvy0u8zEp+Xv1J0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=mrYneNgL; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="mrYneNgL"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 0DEBE214FF;
	Thu, 16 May 2024 14:34:47 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=qcfG91MlR77uMh8iQ9PtmESHd2OZjHKllN8X5V
	xqPSY=; b=mrYneNgL2wjksmBXKvg31i/0g4+qHAnh9fBq0zDSV4HAiBPmz4AX60
	qvjBaPr2Rv2wGYiDh+GDIa4Oj/kWjTj2X13nxg3e42nq1PMy8KxBtwpelm6hxAeP
	2Mf95Temsskj0EctDHb/29OxW5KP20+EAcVbyw6y1rVd67ZmwkOGU=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 051F4214FE;
	Thu, 16 May 2024 14:34:47 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 6D4B2214FD;
	Thu, 16 May 2024 14:34:46 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 04/16] refs: track ref stores via strmap
In-Reply-To: <52798936a290ffa64b244f9bbd1c5f17d1b24db3.1715836916.git.ps@pks.im>
	(Patrick Steinhardt's message of "Thu, 16 May 2024 10:04:28 +0200")
References: <cover.1715836916.git.ps@pks.im>
	<52798936a290ffa64b244f9bbd1c5f17d1b24db3.1715836916.git.ps@pks.im>
Date: Thu, 16 May 2024 11:34:45 -0700
Message-ID: <xmqq5xvdr4fu.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 F86AF50E-13B2-11EF-AB58-25B3960A682E-77302942!pb-smtp2.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

> Refactor the code to use `struct strmap`s instead to reduce complexity.
> It's unlikely that this will have any real-world impact on performance
> given that most repositories likely won't have all that many ref stores.
> ...
>  refs.c | 71 ++++++++++++----------------------------------------------
>  1 file changed, 14 insertions(+), 57 deletions(-)

Nice.
