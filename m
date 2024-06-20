Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D8441B3727
	for <git@vger.kernel.org>; Thu, 20 Jun 2024 16:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718900449; cv=none; b=Gtr1Q+MVnxwgJY7S3NMTy5BL7TYq/z95Nm8EeC8qJaGVtk3SrealhgzXyfOhlA0/W3eyE+4wn+ESGoBaaWJeZ5YB74B3uZ/8RB2pCuzle89f3rVBIZnM68wn390jhMYq6wAzARMu0Ml9y8JqLNfyHqxLvCNQEoY/OzNtkBlewFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718900449; c=relaxed/simple;
	bh=Gs3uL2y0Vt6STAYkLxGChoaqBxWbuSlMbwVB4vtZpRM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=rjfX/nswABFLga8jrNauVJry9ESkfgcZYDd3pwhNXF8SzBc5wVsC7TsIBX/+Eq5j0TNv/hm6egXwc3ItSPDa7HivHku7HwboruPK9hx40R+cPxsCKdOIhD5qxDKV2bamUG8f1Kl3QmL8WKPR/+SHujfgrati/K/hGfmmUXm1ZLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=gvWmZn/s; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="gvWmZn/s"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id A741A1CA31;
	Thu, 20 Jun 2024 12:20:41 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=Gs3uL2y0Vt6STAYkLxGChoaqBxWbuSlMbwVB4v
	tZpRM=; b=gvWmZn/sRuxBTLraFa9hPqGBDrNLUcUWIkdQGuIdmySvwCvjU0cOav
	V+80oheCPJ0OFmpIQsCP3TWtE8iw096tGs6KmL23S642H0F8S47lLFReMonkPl5o
	KlCL6z4WD6d6kwxKcklSSBZVS30lUyWMY7gvdyVOVKkufGy2q8zyo=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id A00041CA30;
	Thu, 20 Jun 2024 12:20:41 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.204.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 191001CA2F;
	Thu, 20 Jun 2024 12:20:41 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 2/4] attr: notice and report read failure of
 .gitattributes files
In-Reply-To: <20240619135754.GB943023@coredump.intra.peff.net> (Jeff King's
	message of "Wed, 19 Jun 2024 09:57:54 -0400")
References: <20240618233303.GA188880@coredump.intra.peff.net>
	<20240618234436.4107855-1-gitster@pobox.com>
	<20240618234436.4107855-3-gitster@pobox.com>
	<20240619135754.GB943023@coredump.intra.peff.net>
Date: Thu, 20 Jun 2024 09:20:39 -0700
Message-ID: <xmqqjzijy4a0.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 09799600-2F21-11EF-BE39-5B6DE52EC81B-77302942!pb-smtp1.pobox.com

Jeff King <peff@peff.net> writes:

> I don't know that this is really consistent with callers of fopen(),
> since they tend to complain noisily. Usually via warn_on_fopen_errors(),
> which we ourselves call above.

Argh, you're right.  I thought the guard in warn_on_fopen_errors()
would catch the artificial error code we give when we found that we
opened a directory (by mistake), but the error we use is EISDIR, so
it will be shown.

OK, let's scrap the whole thing.  It does not look like it is
solving any real-world problems.

Thanks.

