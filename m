Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC3714CDE0
	for <git@vger.kernel.org>; Mon,  5 Aug 2024 15:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722872740; cv=none; b=mq4V5Ca3vz8xYdoCLQjRPVRIfT28ttlFHI5/bKDrTrBkHZzy9Rr2/4lUpFvB2PLZpvgr040KCBa8gieLaXdUPPI4pUfaIA/8jyhA67RGS1Y2iUozLqdlHB9YN9CHyVJr43ZG0JkqtkJLsEmlpWtm18PuNVKdQtNkzFOy/0IbJ+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722872740; c=relaxed/simple;
	bh=SqnFFI/HICpyI3eHYoFEqOqXRVtZkfB5VtWVu/zf7Zo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Igi47bz/xzR0i2HO3TcEC2rF2jHWEPUk2f2NdBVS/rbvHx7Nv9KQH3d9cHK2f+A9zhLelcu07Nv/zpwGUzF6h6tqGWnIfU85VYXgLP15La4o7FO95evs6qK1gdMVyAeGZ1JUS7GgmromVZMPJ0G1AC2G3SO8lTEHMioMADW2TR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=luCahPPg; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="luCahPPg"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 3ADA02E686;
	Mon,  5 Aug 2024 11:45:38 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=SqnFFI/HICpyI3eHYoFEqOqXRVtZkfB5VtWVu/
	zf7Zo=; b=luCahPPgdl5QPt5gCwt0i0ChHyJngVx89YgkB14D7drUMlRVbToM7y
	0D6h6NNjTeGQjgRgNlYtBkS0VlVnpKrvktwPVEkuwmiym/W8W//HpWWhAZZKKH96
	3I0+vp3Wb9mgPJ2sDh1BCMX4hmd6I0fCTIdWUfjFzk3f9gNxXmJtI=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 32D762E685;
	Mon,  5 Aug 2024 11:45:38 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.108.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 1CBF82E684;
	Mon,  5 Aug 2024 11:45:34 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Taylor Blau <me@ttaylorr.com>,  git@vger.kernel.org,  Han Jiang
 <jhcarl0814@gmail.com>,  Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH] config.c: avoid segfault with --fixed-value and
 valueless config
In-Reply-To: <ZrDH3ryOO0wIJIDE@tanuki> (Patrick Steinhardt's message of "Mon,
	5 Aug 2024 14:38:54 +0200")
References: <c78bacfa8fb274fbb48f259b13f4f30253932f69.1722532013.git.me@ttaylorr.com>
	<ZrDH3ryOO0wIJIDE@tanuki>
Date: Mon, 05 Aug 2024 08:45:32 -0700
Message-ID: <xmqqa5hr55yb.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 C09E1ABA-5341-11EF-B564-BF444491E1BC-77302942!pb-smtp20.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

> Edge cases like this really make me wonder what the benefit of implicit
> bools is in our config files.
>
> So... why do we have them in the first place? Is there even a single
> good reason?

There isn't any good reason to introduce such a syntax if we were
desigining the configuration file format from scratch.  It was added
because originally Linus thought it was a cute syntax, and these
days a lot lot more importantly, it is kept working because you will
break a lot of existing configuration files that were hand tweaked
if you remove the support suddenly.

