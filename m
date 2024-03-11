Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85F8B29A9
	for <git@vger.kernel.org>; Mon, 11 Mar 2024 17:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710178408; cv=none; b=lpG1bfSFIvREe7extmnGdLAC55iBttZoD8IvWst8fEHKemTC06h86VFH3EPyseenEJMOTcl6iF2Ym1jXt/Nn8vHs/4n/P3TWRmBwXe30HnVJoW2/bJI4scLu8InwbiLSKc5mtgpxaC7jJ1eHSXj3v6k563hZe4crXIefI+BWEuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710178408; c=relaxed/simple;
	bh=OvTH5xN5E6HI1CMiJ5HJlhF6rimv5AJH+yzROi1ZREE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=OcljsZQTjSNRbFIIAto89HqbAYB7i6lL7U8d3PpFvn8LZhkpAkaA4r8A1zpuQUfoBc0DNjfkyWCOOQYuc6tnA9hOr7PEXEPKAd3atfZW+bAWwb3+aC5TWhKo/0GIJcgNtAnnM3hc5XzgxXh5FLZkGK36Tzw7pNSoDjFD5ICP4DQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=YxCx8mqu; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="YxCx8mqu"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 2617725FDD;
	Mon, 11 Mar 2024 13:33:27 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=OvTH5xN5E6HI1CMiJ5HJlhF6rimv5AJH+yzROi
	1ZREE=; b=YxCx8mquINfwRw0BHhpBobdOduT6gZChsfo5c9kMtlp+7Xxxs0MCBy
	RendP+Twc0wiqIuWtOZ1R7KNj2/vdXh/+H6d4X14/++59kzWYsSbdc9n3j3Yjc58
	VmuWsFXk29yj8ZqkRhT/b8KAYmRts+PpbLbWhW6Xwtq9ND8eJdv/E=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 1E5EE25FDC;
	Mon, 11 Mar 2024 13:33:27 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.185.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id B9A5525FDA;
	Mon, 11 Mar 2024 13:33:23 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v2 2/2] reftable/block: fix binary search over restart
 counter
In-Reply-To: <Ze6UDkipgNsDVCwf@tanuki> (Patrick Steinhardt's message of "Mon,
	11 Mar 2024 06:18:06 +0100")
References: <a4312698cceab5f2438c9dd34465da21d719e256.1709825186.git.ps@pks.im>
	<cover.1709843663.git.ps@pks.im>
	<370b608f9007abe9c0562d76894e2475d19867a1.1709843663.git.ps@pks.im>
	<xmqq7cidk4e4.fsf@gitster.g> <xmqq34t1k12p.fsf@gitster.g>
	<Ze6UDkipgNsDVCwf@tanuki>
Date: Mon, 11 Mar 2024 10:33:22 -0700
Message-ID: <xmqqmsr4smfx.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 7619E074-DFCD-11EE-9F74-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

> But we do know to bubble the error up via the pasesd-in args by setting
> `args->error = -1`. Funny thing though: I just now noticed that we check
> for `args.error` _before_ we call `binsearch()`. Oops.
>
> I will send a follow-up patch that addresses these issues.

Thanks, that is doubly amusing ;-)
