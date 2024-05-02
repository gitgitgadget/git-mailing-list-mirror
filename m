Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB8A015AAC5
	for <git@vger.kernel.org>; Thu,  2 May 2024 16:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714665619; cv=none; b=mtjBLUdBkZuv4pvRgcXtK26JrcOyDuqw94OBV18RlwPe6tVN/eb7qUYjoiwbwFv0gKpvoYMG2vExmZPok7Imz4WEJNl172vIRARnslVBghFt/BJlzF1LgiGumOqjSEjSWSIqwlaUc7MKJ2ZETjAmSQtq4gIXfcqmi7qUAUVE/iA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714665619; c=relaxed/simple;
	bh=ZbWU6tj/SLETqeNGRVSd+Ww5nA64O36GlnRIZuwUo4c=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=PFbDfHTcGdLAe0dQ/xXhCSXvupjueOFrQHRzw53Yn1tj4KIbh2VpwRRzYnEfT/yVzqcjNCW3uNZ57UqvETpkYv9Shh7HE1Lr4Jo5yKoALwEUkM2vkJAJHPuF1qlPom5siOMI5zxoXxFawJFX7zpWRsMWnkbSBUYoCTwkEP/vKH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=N3Yf5P0Y; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="N3Yf5P0Y"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 91194216F7;
	Thu,  2 May 2024 12:00:16 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=ZbWU6tj/SLETqeNGRVSd+Ww5nA64O36GlnRIZu
	wUo4c=; b=N3Yf5P0YOFw0Pwby26WS0pmKo4/TWVoFi7+OvPSWCyRhcHs0Pf45cn
	nBmLYNGdzjaYCir169ZljfIMwySow9nX8ZOEnZwQdfaprisjjtP32ELXOmABiREE
	Fq3ClAqOpc40F/c3Mp5zg0PUu/zWeqFqAp7CnuPLUbLaGpxLwl7WA=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 89BB1216F4;
	Thu,  2 May 2024 12:00:16 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.120.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id CCC59216F0;
	Thu,  2 May 2024 12:00:15 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: christian.couder@gmail.com,  git@vger.kernel.org,  ps@pks.im
Subject: Re: [PATCH v5 4/7] refs: add support for transactional symref updates
In-Reply-To: <CAOLa=ZQkTM26wmGgj3=Pz9p7-nFAWQdxCA=RjaJVSm2m8zn7jQ@mail.gmail.com>
	(Karthik Nayak's message of "Thu, 2 May 2024 05:50:47 +0000")
References: <20240426152449.228860-1-knayak@gitlab.com>
	<20240501202229.2695774-1-knayak@gitlab.com>
	<20240501202229.2695774-5-knayak@gitlab.com>
	<xmqqbk5pgke0.fsf@gitster.g>
	<CAOLa=ZQkTM26wmGgj3=Pz9p7-nFAWQdxCA=RjaJVSm2m8zn7jQ@mail.gmail.com>
Date: Thu, 02 May 2024 09:00:14 -0700
Message-ID: <xmqqwmocfbld.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 10EBEB9A-089D-11EF-AD3F-78DCEB2EC81B-77302942!pb-smtp1.pobox.com

Karthik Nayak <karthik.188@gmail.com> writes:

> ... By
> having zero-oid for the new and old value in the reflog. But seems like
> we can't do that either.

Even if you could, the transition from refs/heads/main to refs/heads/next
would not be captured.

In any case, that is not something this step changes.  My assumption
is that for most of developers it would be unexpected for the theme
to "allow symbolic updates to be transactional" to change it, hence
"we do not explain what we did not change".

Thanks.
