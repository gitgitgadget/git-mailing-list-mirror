Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A078158A35
	for <git@vger.kernel.org>; Fri,  3 May 2024 19:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714765543; cv=none; b=dZRAO7winPd2cOmW5Bm4U+d1vL2sr8gqToKBk7sIpLoYkqV5gwJMNUUU59pHEGC5IYPL4N8KTycrr5Km/5Io9CS7BbzEVUiZ0O9l8T5XNY2L6M2p+LSZ9LrsNvvJAPoA79BpiGRZh9IMHow4VezWOxGYOW119rdRSQJDoJbsG/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714765543; c=relaxed/simple;
	bh=ky1wY+UepjV1baixXgzeuFUYz+5NYZq98sFmxpia4xo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=IMIJuagRl3I61Q32B22Z4os+OaQX21ltKGX+axjP/OGFPoYTDgbBeU2ikgtFyfhqmAvGq0dkCGnqlKEwG3pLr/YFPdKjVeiCLcVGF4jN+omY1/oyEv+wiiAT4pU3Hev9rUlgKy2DTbmNXFlfPfx+xRc+rakmxRIqo4XAPfSzD84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=eFK87i3B; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="eFK87i3B"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 7BB6C2B61D;
	Fri,  3 May 2024 15:45:40 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=ky1wY+UepjV1baixXgzeuFUYz+5NYZq98sFmxp
	ia4xo=; b=eFK87i3Bw7pTiCmqVfVEn+kYMLCdCRfq3Hav0My32A6UbS6eCWV5ml
	N7/NAFVh8ktnbT5IoL69FLt6FsLqfCULTqqskrJDMlNBcWBm9tfJyzhac1trluKa
	5Yrvz5WtIZIl1RtBYxpp1bW0JjrK/Ga657ckx6TcUlsmV9234U0NI=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 737A62B61C;
	Fri,  3 May 2024 15:45:40 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.120.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id C2DA32B61A;
	Fri,  3 May 2024 15:45:39 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org,  Jeff King <peff@peff.net>,  Patrick Steinhardt
 <ps@pks.im>
Subject: Re: [PATCH] attr.c: move ATTR_MAX_FILE_SIZE check into
 read_attr_from_buf()
In-Reply-To: <28f6267709db78ba526d7ed9fc4a734674697c70.1714763555.git.me@ttaylorr.com>
	(Taylor Blau's message of "Fri, 3 May 2024 15:12:36 -0400")
References: <28f6267709db78ba526d7ed9fc4a734674697c70.1714763555.git.me@ttaylorr.com>
Date: Fri, 03 May 2024 12:45:38 -0700
Message-ID: <xmqqfruy65nh.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 B83E74BA-0985-11EF-83F6-78DCEB2EC81B-77302942!pb-smtp1.pobox.com

Taylor Blau <me@ttaylorr.com> writes:

> Ensure that we refuse to process a .gitattributes blob exceeding
> ATTR_MAX_FILE_SIZE when reading from either an arbitrary tree object or
> a sparse directory. This is done by pushing the ATTR_MAX_FILE_SIZE check
> down into the low-level `read_attr_from_buf()`.
>
> In doing so, plug a leak in `read_attr_from_index()` where we would
> accidentally leak the large buffer upon detecting it is too large to
> process.
>
> (Since `read_attr_from_buf()` handles a NULL buffer input, we can remove
> a NULL check before calling it in `read_attr_from_index()` as well).
>
> Co-authored-by: Jeff King <peff@peff.net>
> Signed-off-by: Jeff King <peff@peff.net>
> Signed-off-by: Taylor Blau <me@ttaylorr.com>
> ---

Makes sense.  Will queue.  Thanks.
