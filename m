Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9A071714BB
	for <git@vger.kernel.org>; Thu, 15 Aug 2024 16:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723740112; cv=none; b=d7HOXCPVoR/i99NqGCtlvD1IwJhYi2e5lK3KWD7TLoRUXcp7nKkLstkTyZmNQwH2UNFkGzGjtYLsbIXqmucsgGPYL5xzPscN6aS+q9nUcwch1OT1TnnWlluXMetKDpnCWDaI7nGX6BLXO/yVDOx8ST8KMEo0w6xPX3o6KtKAPEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723740112; c=relaxed/simple;
	bh=3cmgAczmIf4S1WfHmXS5zPeDJ4D3j7Ia6TQix+3cFp8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=lgpRg2bjSy+INkBgsmUbTGLTNrCwdKWiUmWjJRwXoJw8h9fpUvp9VZ06TtVON/6Pv5gQXukvLIQniXaEZUp0JpVBuiaKn7+bu46eg8B9mIwoTBIZr222yUwl6uirMWmv500ay/YZGDrZaoRenTr4PlFa6fCIwE1Tn3R+NW9fxLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=xQTR/9tX; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="xQTR/9tX"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 289D63358D;
	Thu, 15 Aug 2024 12:41:44 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=3cmgAczmIf4S1WfHmXS5zPeDJ4D3j7Ia6TQix+
	3cFp8=; b=xQTR/9tXxbNgsC+qs4T+TAyWBh0uxCH6KI3xK6pGYFKbvcXaODKdM6
	9s4w5yWGhQTYRgntutGgRkjPqckKab+sqePbaKFq4TFpGPqtVqGZqAVYjZwJO99d
	TcSgnU/gxfx6dI1Fmy23J/CgLeA+utQsbPNCjiAv+MjJA5ZNgZN4E=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 21C5A3358C;
	Thu, 15 Aug 2024 12:41:44 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.108.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id B033C3358B;
	Thu, 15 Aug 2024 12:41:40 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] t4129: fix racy index when calling chmod after git-add
In-Reply-To: <20240815153007.GA1477220@coredump.intra.peff.net> (Jeff King's
	message of "Thu, 15 Aug 2024 11:30:07 -0400")
References: <20240801155702.70242c31d476c46c84ee11a3@linux-foundation.org>
	<xmqqed77hifn.fsf@gitster.g>
	<20240801180706.933d797b0ae5744fdcdf47d2@linux-foundation.org>
	<20240802035121.GB1246312@coredump.intra.peff.net>
	<xmqq7cczgefh.fsf@gitster.g>
	<20240805060010.GA120016@coredump.intra.peff.net>
	<xmqqcym9vnwg.fsf@gitster.g>
	<20240815153007.GA1477220@coredump.intra.peff.net>
Date: Thu, 15 Aug 2024 09:41:39 -0700
Message-ID: <xmqqcym9u4ak.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 3F667122-5B25-11EF-8996-E92ED1CD468F-77302942!pb-smtp21.pobox.com

Jeff King <peff@peff.net> writes:

> Ah, thanks. I saw this fail once in CI, and then later succeed. But for
> some reason I wrote it off as CI flakiness rather than trying --stress
> locally. It's easy to reproduce the issue.

Thanks.  Will queue.
