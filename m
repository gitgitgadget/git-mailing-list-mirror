Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B70A167D96
	for <git@vger.kernel.org>; Fri, 31 May 2024 15:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717168222; cv=none; b=sBCNmikt1ye/lybgdncG0y9iYPPNiqQWheE3pa+i8uOuz4bSGWZjkpRLkRWV9Gu91BOPMiN/FJxFymmaGAnvT/RQF7wiNEZac3WVouhtit8mb2VrATQgGQrJFrLs/SfR7XJxhjnI8Tah8JBf4VPQLDXXPtjhioDl6o2RjuMkQTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717168222; c=relaxed/simple;
	bh=/doo2wWTmYCj8g2wHHWthjeWgrnCBhJUhgHiUYWj3zI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=s2Wm3hAT934cuXD67T8jriNZX7YUHa3E0dF7uDZ0Z5h8iYijCo7K4DWSY3Z62BszNWP6UeIja5cn+p+VzeXUgUfTf7YDvpPGgXiEWMb1rfHMSM9XUuRpCBUOF7DJrQUg8yjDAkV/pX+z/6fMuNMXPiqRhKWY5/nt6WnRrgTb9w0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=o6FEWDv9; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="o6FEWDv9"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 635A63B36D;
	Fri, 31 May 2024 11:10:19 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=/doo2wWTmYCj8g2wHHWthjeWgrnCBhJUhgHiUY
	Wj3zI=; b=o6FEWDv991we3G0Kq5faRXnk73QbXZoj/VbO/5sgiGeIIfY5SaRJld
	4j5u5TrpKcyMIkGUmE1gGxFIs30AmPqIrCXb7gNxtHvtjmx0tg++4K+QueVw4rsn
	XvFcCTmTlKfru/USVQTCESX0KE5k+ygnXnNGVn5kDw/mj5bZAM7fA=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 5CA4D3B36C;
	Fri, 31 May 2024 11:10:19 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.173.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 5BDC93B36B;
	Fri, 31 May 2024 11:10:16 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] dir.c: skip .gitignore, etc larger than INT_MAX
In-Reply-To: <20240531120034.GA442032@coredump.intra.peff.net> (Jeff King's
	message of "Fri, 31 May 2024 08:00:34 -0400")
References: <20240531120034.GA442032@coredump.intra.peff.net>
Date: Fri, 31 May 2024 08:10:14 -0700
Message-ID: <xmqqbk4mhvah.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 E314E2C4-1F5F-11EF-B755-ACC938F0AE34-77302942!pb-smtp20.pobox.com

Jeff King <peff@peff.net> writes:

> We use add_patterns() to read .gitignore, .git/info/exclude, etc, as
> well as other pattern-like files like sparse-checkout. The parser for
> these uses an "int" as an index, meaning that files over 2GB will
> generally cause signed integer overflow and out-of-bounds access.

I also wondered if we need similar protection on the attribute side,
but it turns out that we process the files one line at a time
without holding everything in core.  Both exclude and attribute
subsystem are not protected against parseed _result_ consuming too
much memory, but at least with your patch, we are covered on the
input side.

I wonder if it is worth rewriting the exclude side to stream like
attribute parsing, though.  It probalby is not.
