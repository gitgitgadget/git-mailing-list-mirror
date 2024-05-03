Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91A2C158877
	for <git@vger.kernel.org>; Fri,  3 May 2024 18:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714760662; cv=none; b=EsV5i3FIdDK5AgORHZmvH8YHm7GrdyOQLktkZj11v1VWLunZowJF7ctx/C7+l99ngYNHh4aMpB8buGPKRCWv/FhbVYoZY8vth6npsvrFY6JbW7LEvwD22fUt7Us16bf9rFy8tIJDE0Ig0SJYi77qaW14NYJ71vfH6HVMSawYPUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714760662; c=relaxed/simple;
	bh=qq+dTWAAP5I4E1YmWhyNIAWunHyp8SBe6k1X2YcCIHI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=pNZjulRowA+tzkvh7t7BXP+HGPCVC/8uxy0LM6qHgRCscDzjR61MNM36fizVbjdVZP9dtuEHW/xNVbOeMRgSfXTcd91UxCVfg2EDbRQgk+sDSmgwT+X7cr588g1DaOLG1hXuWJ/zFl20v4o9dguLtH2Tg4URH2p7ntd7EUed6DQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=ABESwdCq; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="ABESwdCq"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id BA6631A06B;
	Fri,  3 May 2024 14:24:16 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=qq+dTWAAP5I4E1YmWhyNIAWunHyp8SBe6k1X2Y
	cCIHI=; b=ABESwdCq4qIusi21IXjOVWUFkmF2avmoTmcPZ0vJMk5vSf1wWuWrq0
	C+974EBS1Ru7s5XyE/ZBo+RhkUHZYldAH187ZBMwOnqQQQxG3a3maBUlznjok6Cx
	0NiLOOSthIhQ4A0Vr6Zyuij+6R7pxCkPya2AspWlGezddNyz3BKjY=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id B40751A06A;
	Fri,  3 May 2024 14:24:16 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.120.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 3BB771A064;
	Fri,  3 May 2024 14:24:13 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: Patrick Steinhardt <ps@pks.im>,  git@vger.kernel.org
Subject: Re: [PATCH 0/5] refs: remove functions without ref store
In-Reply-To: <20240503173553.GC3631237@coredump.intra.peff.net> (Jeff King's
	message of "Fri, 3 May 2024 13:35:53 -0400")
References: <cover.1714717057.git.ps@pks.im> <xmqqikzu95cf.fsf@gitster.g>
	<20240503173553.GC3631237@coredump.intra.peff.net>
Date: Fri, 03 May 2024 11:24:11 -0700
Message-ID: <xmqq7cga7nzo.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 57A04292-097A-11EF-BF26-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

Jeff King <peff@peff.net> writes:

> Though maybe an even more radical proposal: now that read_ref_full(),
> etc, are gone, and we have only refs_read_ref_full(), could/should we
> shorten the latter to drop the "refs_" prefix?

I view it as a good longer-term goal.  But I also view it as an
orthogonal issue to the transition.

We need a smooth migration path for remaining callers of these older
functions.  We could do the USE_THE_INDEX_MACROS like compatibility
layer during transition period.

Thanks.
