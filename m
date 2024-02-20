Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE04F2E63B
	for <git@vger.kernel.org>; Tue, 20 Feb 2024 03:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708398214; cv=none; b=AzApPKm4B4H54Rxch2XGmJ3dPmiSONV5LUwRzonoPaZR37d+qTY2Uv1RKP1k5lsmYI/briRElmNPce+Y3qydEnINek4+PGZ7oowaJIuTjNrvuWAqOAk2eSu6zeYpuNfHe7CA2qdaV1i7Pvmx8J02jv21MQ0xfDkQI4uok4ZJ2ho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708398214; c=relaxed/simple;
	bh=W3+E/HIQNm61CkHdMUbU0YxR2AieVhg0HiJ47q/22io=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=saJjxjaBGq/2BG1lMh9MuEufqnCLBdn4ZbgX2plPGxvtJIFfDviUUrQjOe4WYfzrVZKwjjqKMDa+XcoazjRUKrU4ZJ3ORhcOESNZoFx7uxBhuo/UZVd1oiWuGqrbX+iU0ZOUOUN9plag9XEbESVrVDuih43yNWUcbix0VY1SJYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=UJrCXScj; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="UJrCXScj"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 3760F27A75;
	Mon, 19 Feb 2024 22:03:31 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=W3+E/HIQNm61CkHdMUbU0YxR2AieVhg0HiJ47q
	/22io=; b=UJrCXScj9djyA5dA+Eh1pASfSlLEQWLMLDUgJvvbg+nipyD/E2gUQ9
	FxZzmjuwiaFzbhZdhXOCIcFAaonWaQff8d3KcvFCFvMn3nJ0kURxXsa5CEqQCWks
	IA88yvH5X0mG63JgcIvma+VB1rG2xxzQLPmvnL5gcuf0JIH8StI6o=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 2FF3F27A74;
	Mon, 19 Feb 2024 22:03:31 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.165.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 9407727A73;
	Mon, 19 Feb 2024 22:03:27 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: Maarten Bosmans <mkbosmans@gmail.com>,  git@vger.kernel.org,  Maarten
 Bosmans <maarten.bosmans@vortech.nl>
Subject: Re: [PATCH v2 1/5] log: Move show_blob_object() to log.c
In-Reply-To: <20240220015928.GB2713741@coredump.intra.peff.net> (Jeff King's
	message of "Mon, 19 Feb 2024 20:59:28 -0500")
References: <20240205204932.16653-1-maarten.bosmans@vortech.nl>
	<20240218195938.6253-1-maarten.bosmans@vortech.nl>
	<20240218195938.6253-2-maarten.bosmans@vortech.nl>
	<xmqqjzn0x72z.fsf@gitster.g>
	<20240220015928.GB2713741@coredump.intra.peff.net>
Date: Mon, 19 Feb 2024 19:03:26 -0800
Message-ID: <xmqqy1bfx2f5.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 9E820D8E-CF9C-11EE-87E1-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

Jeff King <peff@peff.net> writes:

> All that said, I'm not sure based on our previous discussion why we
> can't just call stream_blob_to_fd(). Looking at show_blob_object(), most
> of the logic is about recording the tree-context of the given name and
> using it for textconv. But since we know we are feeding a bare oid,
> that would never kick in. So I don't know if there's any value in
> sharing this function more widely in the first place.

It is very nice that we do not need to touch this code move at all.
Thanks, as usual, for a dose of sanity.
