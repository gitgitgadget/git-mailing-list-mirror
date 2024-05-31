Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B2701CF9B
	for <git@vger.kernel.org>; Fri, 31 May 2024 14:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717167395; cv=none; b=LgSMT8Zc/iy5Aw14QKfMbd9tn6f516MsY9oDDLhjVyAtioegBqy7Js3p84nSCvQK3CYVzYc1tqhFAfRWg8TK5EdxADY0oMY+OYxVSSRkiv5OhW3AA1V+QdB6MAZoJj5H8GYqX3slk7sWMJTlH5xIkKkep9stjldO4lRqeNBnh/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717167395; c=relaxed/simple;
	bh=J1l8TFv/nPypcTaHlhr2yO1GIY1so+EvfZ7DlrvhQqo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=f+FC9mNC8bolMsjspbNS7HSBQonTw15qvob4ELa+00HuaVpwrjcf1EzfxDwmYGu67b7CE2q+raudC5WOirX/LFjhKyJj++1HtBRAt7ry2eru+/LHY69L3PrfRQBMtRY2R81DkaOgr+wwsYIw1W8n2AFJFMzmZQg8djSKZ5YSQyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=TFEFf6Gm; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="TFEFf6Gm"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 229081A6D7;
	Fri, 31 May 2024 10:56:34 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=J1l8TFv/nPypcTaHlhr2yO1GIY1so+EvfZ7Dlr
	vhQqo=; b=TFEFf6GmtTrT/7se0zlztCyAqmebXRo3EDtlyce5dV/Lbd0ASYitRJ
	+QUZizuj1SIyDjIaEGeSB04GvFUEYoSZuftsDjmD5WRteT/O23SEkq1gOe1P9PQ1
	vt26lFXdvGCKUJm+0J/8nkQ7z7gA4B/15G7TefCkr5/iqRcrDU8T8=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 1BAAD1A6D6;
	Fri, 31 May 2024 10:56:34 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.173.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 39FE21A6D5;
	Fri, 31 May 2024 10:56:31 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: Patrick Steinhardt <ps@pks.im>,  git@vger.kernel.org,  Eric Sunshine
 <sunshine@sunshineco.com>,  Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH 5/5] mv: replace src_dir with a strvec
In-Reply-To: <20240531111205.GA3608259@coredump.intra.peff.net> (Jeff King's
	message of "Fri, 31 May 2024 07:12:05 -0400")
References: <20240530063857.GA1942535@coredump.intra.peff.net>
	<20240530064638.GE1949704@coredump.intra.peff.net>
	<xmqqo78nqpl2.fsf@gitster.g>
	<20240531111205.GA3608259@coredump.intra.peff.net>
Date: Fri, 31 May 2024 07:56:29 -0700
Message-ID: <xmqqttiehvxe.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 F742CB3C-1F5D-11EF-9C3D-8F8B087618E4-77302942!pb-smtp21.pobox.com

Jeff King <peff@peff.net> writes:

>> Anyway, that is about somebody else's patch, not this one ;-).
>
> Heh, good digging. I actually wondered if I was making the same mistake
> while writing mine, but double-checked that src_dir is not expanded in
> that way. But I didn't think to check Patrick's original. ;)
>
> IMHO it is probably still OK. We are bounded by the number of entries in
> the index (and we already use proportional memory for other parts of the
> operation).

Yes, I agree it is OK.  We have two arrays whose strings have to be
allocated, source[] and destination[], and used to have another
whose elements borrows from one of these, but with the change
instead of borrowing we now duplicate, but as long as the other
behefit outweigh the cost of additional memory usage, it is an
acceptable trade-off.

Thanks.
