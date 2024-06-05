Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8BF815350D
	for <git@vger.kernel.org>; Wed,  5 Jun 2024 16:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717606357; cv=none; b=f/Kh3hBNRL/ej60NKJX+Gu+vKZ+b9/iJZwt1tlYak1hITTxpwUIbJmyy8WRyNKJ9v0if/2dUHRkyC0zge5i/VgIJrOiU+dG0BV4a83/tbfF1ByH4RC2q22dj+Je3En4hARvRKwrfg+tdY0lmvCV2hn2kKJD8f6ecEHaXDmvFQKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717606357; c=relaxed/simple;
	bh=Z7BaO4GSHqhdFm6OsuuoBhs45ZTC+c0XCnQUePiMyHk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=hHMU8Atvm4MdyYGgHhUAecIypyycQ26FcRsIeFeK6gAiUoaOPrAarPKWIGd69YozzE+7IPXYPklonfLl6VbfpDA1nlSCSh+HCt6KvTZrXzJBR/IYdVbx6Fcnj536zCoajFJ9I+D4hliV5RcmdAVVcnAYq4p9/H8Qg/EtTxG5HLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=gpQkrjzw; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="gpQkrjzw"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id A6FBA25DBB;
	Wed,  5 Jun 2024 12:52:34 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=Z7BaO4GSHqhdFm6OsuuoBhs45ZTC+c0XCnQUeP
	iMyHk=; b=gpQkrjzwOPNg1aiWJ1l2ZkBE2W14v/n6LYS5wxOvzLCGQm5byg9yRT
	aBCzXcKDxoOxme/pbzbgEJAzueXF/3UIoSXJZm6s4BJqBWAg69ucfoK3rcUgZvYB
	zfIILr9rXhFzxlAyzFUgmBzTXdv/66AaLKR+DClzBgbHCOVJp+SNY=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 9DEB525DBA;
	Wed,  5 Jun 2024 12:52:34 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.204.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 129D225DB9;
	Wed,  5 Jun 2024 12:52:34 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,  git@vger.kernel.org,
  Patrick Steinhardt
 <ps@pks.im>
Subject: Re: [PATCH v2 06/13] dir.c: always copy input to add_pattern()
In-Reply-To: <20240605091850.GG2345232@coredump.intra.peff.net> (Jeff King's
	message of "Wed, 5 Jun 2024 05:18:50 -0400")
References: <20240604100814.GA1304520@coredump.intra.peff.net>
	<20240604101322.GF1304593@coredump.intra.peff.net>
	<f6951a8e-ab88-42f1-8c23-acc65d2d5646@web.de>
	<20240605091850.GG2345232@coredump.intra.peff.net>
Date: Wed, 05 Jun 2024 09:52:32 -0700
Message-ID: <xmqqa5jzuyb3.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 0180A73E-235C-11EF-8490-B84BEB2EC81B-77302942!pb-smtp1.pobox.com

Jeff King <peff@peff.net> writes:

> It looks like the topic hasn't hit next yet. Rather than send a v3 with
> this tiny change, Junio, do you mind squashing this into patch 6 (it's
> d465adca6d in your tree)?

Done.  Thanks, both, for being careful.
