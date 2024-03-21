Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54B0E13666D
	for <git@vger.kernel.org>; Thu, 21 Mar 2024 22:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711059779; cv=none; b=ZxnGRpj6qafn1irfVhMSaG8ZfkAYVw8mwwYIGU6qOuUrM93GE0TkQP26wC5P6ACkt3HlWOYWmv9qRYzQUB41MAFZlkQ4tWiMeTWTJLF+dtrAAfFJ8x7+ta6kdZqUALgTHtvIuTYbc3Hgq5wsad8c8HhW2JxOGao5CjY/SHtQD4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711059779; c=relaxed/simple;
	bh=T3ECKaQx3bUJGuLBB6j7pzPWEcgzvxW4NXsnwiRVT2E=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=VmMQM5PpSObxz7bCJBghi8+EHO89mB6BywXKDk4BKcXPScSQPu0QJafaZUMFGubpWT+A4kg+fBUoZav/gfX9b1aBJF4/wJDJZT/8fYNePWNngOLNToXKIighFc8GBs6W1pPfJLPmNnSXeC4wVMnkV65h5pAHtlq38kSPQyeBOvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=vs02pEAH; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="vs02pEAH"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 780203B77D;
	Thu, 21 Mar 2024 18:22:50 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=T3ECKaQx3bUJGuLBB6j7pzPWEcgzvxW4NXsnwi
	RVT2E=; b=vs02pEAHvLt4NDAGv/AKaM0elSEsaHVHHNLOh5NtglMpNwBtfiQZvT
	46d7csoQXNfYVf1PuFstX1Z4ZSnSuCNZgWAGaFSWZAiJHDRa3hDJJABHyij968W/
	1JGPMEj6SzstZ3zoWcHloheiD7y0xDvSkWKLJuTmPYZZ33VlBlLjA=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 7049D3B77C;
	Thu, 21 Mar 2024 18:22:50 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id E690D3B77B;
	Thu, 21 Mar 2024 18:22:46 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org,  Jeff King <peff@peff.net>,  Elijah Newren
 <newren@gmail.com>
Subject: Re: [PATCH 01/24] Documentation/technical: describe pseudo-merge
 bitmaps format
In-Reply-To: <ZfyxCLpjbaScIdWA@nand.local> (Taylor Blau's message of "Thu, 21
	Mar 2024 18:13:28 -0400")
References: <cover.1710972293.git.me@ttaylorr.com>
	<76e7e3b9cca7fb957384ed98f2cd32cf11ff8488.1710972293.git.me@ttaylorr.com>
	<xmqqcyrn6zyd.fsf@gitster.g> <ZfyxCLpjbaScIdWA@nand.local>
Date: Thu, 21 Mar 2024 15:22:45 -0700
Message-ID: <xmqq5xxf6x8q.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 8B7F7256-E7D1-11EE-A734-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

Taylor Blau <me@ttaylorr.com> writes:

>    The pack-bitmap machinery has been extended to write bitmaps for
>    pseudo-merges, which are imaginary commits which act as octopus
>    merges covering groups of the un-bitmapped parts of history at
>    reference tips.

That is "what the topic does", and does not cover "why does it do
so" and/or "for what effect".

I can sort-of see that allowing us to record a pre-combined bitmap
for octopus merges that do not exist, we have more flexibility
compared to the original bitmap machinery where we can only put
bitmap to commits that exist.  What is not clear is what this
additional flexibility is used for.

Does the approach takes advantage of that additional flexibility to
reduce redundancy, allowing us to have the same bitmap coverage with
smaller number of bitmaps?

Thanks.
