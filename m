Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7599653E30
	for <git@vger.kernel.org>; Mon, 13 May 2024 22:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715640154; cv=none; b=miq8GGXThDNQBIs9xDa4KHSaehvwSMA1+JiPfW7ersEeJ/2RxtpHPp9X8AQmHAGO3liBG7OLyxmG+aaFohFXPQVbgAKMeJSiFulEbCrdHJ2lAOX8x8Pmtj7rjo8KAOC/SgAloEuqVgtojfpIw5cy5nyBTwBnctFGniMWSfk9NJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715640154; c=relaxed/simple;
	bh=ZhlpyvdTQXem4lsxtqGQRj3ukupuYRk4GioDjey9p3Y=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Aejucsv5AxDe9N16GNZZxPDcU0aauEHP2URxBJ6ULEwssTdqrPHrxTU3UXuC25LcQjhEgosUIgBZiyMRiCdnrhgGTO25Z2Irl0UZxBShIukW6nvOeo/T2hVrJ1XWO9vKQSsde6Az40psu/8jbYoe5SZTk/9U/UlL1Y576txJKr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=P2gRbOkT; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="P2gRbOkT"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 5045728E34;
	Mon, 13 May 2024 18:42:32 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=ZhlpyvdTQXem4lsxtqGQRj3ukupuYRk4GioDje
	y9p3Y=; b=P2gRbOkTUtWSbEkYc5d2+VpNOgNpTy3A+3VhP8LI4ADjfRiQB4GTyz
	tLMwNi0FRgWho/aVEL35B8sIofGWgHb5GnY7Zn68RrENBYaKOM6BYzeUxfazwbbR
	T5gtYySSCEZkyX8M1j/B02sAxkA7xkT0AoNTT+LdIIMJt0shclynk=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 466FC28E33;
	Mon, 13 May 2024 18:42:32 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 40F1F28E32;
	Mon, 13 May 2024 18:42:31 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  Karthik Nayak <karthik.188@gmail.com>,  Justin
 Tobler <jltobler@gmail.com>
Subject: Re: [PATCH v2 05/11] reftable/dump: support dumping a table's block
 structure
In-Reply-To: <ed1c150d909da836a760bc0699f585722d5988e9.1715336798.git.ps@pks.im>
	(Patrick Steinhardt's message of "Fri, 10 May 2024 12:29:40 +0200")
References: <cover.1714630191.git.ps@pks.im> <cover.1715336797.git.ps@pks.im>
	<ed1c150d909da836a760bc0699f585722d5988e9.1715336798.git.ps@pks.im>
Date: Mon, 13 May 2024 15:42:30 -0700
Message-ID: <xmqq34qle3l5.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 154D96F8-117A-11EF-9E99-25B3960A682E-77302942!pb-smtp2.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

> We're about to introduce new configs that will allow users to have more
> control over how exactly reftables are written. To verify that these
> configs are effective we will need to take a peak into the actual blocks
> written by the reftable backend.
>
> Introduce a new mode to the dumping logic that prints out the block
> structure. This logic can be invoked via `test-tool dump-reftables -b`.

This step somehow looks familiar.  Perhaps that is because I read it
more carefully than other steps during the last round.

Looking good to me.
