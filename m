Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EEEB522A
	for <git@vger.kernel.org>; Wed, 29 May 2024 19:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717012319; cv=none; b=SM6iUbtk14vzFXGiE30s/Az0NutgqlXJIFBPhfqZFZexQNGMsJX1IQncFLHK9ZR1fGuaralzLWJ4nUoV3PpE94KuUHOUpyNidXskgsgOitobwPXsg/6Agd8Jjb2KyHd0FvNrOgqD1ykji9UmOy1K/i0rapW/A0taK52X0JIMiHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717012319; c=relaxed/simple;
	bh=O406XPMzGHXc5VLIYvQ0ENz1katr3o2lArJTVuB28kQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=kH3t5ssXm8Myg7pOyO56F2Nzyu3AUzj1MMFqbZmM0ze1qyZz6lOUmh3YBxlPNt4IJru+roC+3fZs7ttOX27VPiduFeYQH8Fy+qoIatkpQq/0mnQ21POd1WB/CF7duvfPAyXreTOLPeH8h+NEQA+/Yr1PAd4YEN1QGDEmtuaOGok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=hTAKVkhn; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="hTAKVkhn"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 2A91D3419F;
	Wed, 29 May 2024 15:51:57 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=O406XPMzGHXc5VLIYvQ0ENz1katr3o2lArJTVu
	B28kQ=; b=hTAKVkhndoue2haqu0vABQZwCIbvMz6WCbdip/OhF/bWxyWjdF/x+r
	oG+FF+/gzRLPlNCYedL5B/zqLPjSTy66Oym+KVwW38TOLgPsLsnq7stxyFJo2+aT
	noeTY7DE5JvFD1Mh1lR3ToLG0pO4CWj43YOQ5DF0abLhStGkuVoiA=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 21DB53419D;
	Wed, 29 May 2024 15:51:57 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.173.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 895B43419C;
	Wed, 29 May 2024 15:51:56 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  Jeff King <peff@peff.net>
Subject: Re: [PATCH 08/19] line-log: always allocate the output prefix
In-Reply-To: <699eeae92c0f58032fc76af68521d8cc60f12031.1716983704.git.ps@pks.im>
	(Patrick Steinhardt's message of "Wed, 29 May 2024 14:44:39 +0200")
References: <cover.1716983704.git.ps@pks.im>
	<699eeae92c0f58032fc76af68521d8cc60f12031.1716983704.git.ps@pks.im>
Date: Wed, 29 May 2024 12:51:55 -0700
Message-ID: <xmqqr0dkwg4k.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 E78D1F2C-1DF4-11EF-90FD-B84BEB2EC81B-77302942!pb-smtp1.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

> The returned string by `output_prefix()` is sometimes a string constant
> and sometimes an allocated string. This has been fine until now because
> we always leak the allocated strings, and thus we never tried to free
> the string constant.
>
> Fix the code to always return an allocated string and free the returned
> value at all callsites.

Yay!

This leak always has bothered me, as it is not just once per process
invocation, but once per each commit that is shown.
