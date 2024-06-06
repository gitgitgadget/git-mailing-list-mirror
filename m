Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1CC46CDBA
	for <git@vger.kernel.org>; Thu,  6 Jun 2024 22:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717713358; cv=none; b=gYcsM9tUPvqCfSp5XELjez0dNZaxgPVsjzKNE8/jxas8LkfDogam/+q6uPbCE78XjjicnvRd+lwRM8l/UERzYIINEfQY2WfMObadtxOP3W+YhUKdCPfS7lajd3vDFgUhh17TG7GuuOZT0QdpsgxOWKH6y1QAAh2Fm+7uS0JiAyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717713358; c=relaxed/simple;
	bh=BEmp0zq5LWkSkaTUmyV7Mzr2diWqgkIyi1nbbN3Uhc4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=FojEp1iWjbyCQ4QaMOmJKFGJ6UfYlENoe2uJFwTEobiDVxmVHp9kSVQ/dgjXktEgadRZrm56AQFsontyUJaWDQ/UIzXFYkIFNQI55MWidKeKbjYs4vNmy6bJ7iH37AZmF6zLd5O7pY0dqwiX0JLhGMkQmVGIzgbVPXTP849vy2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=KCSLFbz3; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="KCSLFbz3"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 5413726462;
	Thu,  6 Jun 2024 18:35:56 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=BEmp0zq5LWkSkaTUmyV7Mzr2diWqgkIyi1nbbN
	3Uhc4=; b=KCSLFbz36mJ/oFxhSMEvyKKOMtxUYJma9UMRUIld3HJWiJsg7gCST7
	ApT5tjeMSkXTHOFZpd0d5aTok+w8nY6T/R4UJbYUUR0asaceNFAVjdjLeCOvJNNy
	ssJyr6BKNayuAvgtL5EZtSDYrHXPwbKnNZgMJMEDnSOJqJxbiB8SU=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 4CA0226461;
	Thu,  6 Jun 2024 18:35:56 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.204.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 6B2AC26460;
	Thu,  6 Jun 2024 18:35:53 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org,  Jeff King <peff@peff.net>,  Elijah Newren
 <newren@gmail.com>,  Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH 2/2] pack-bitmap.c: ensure pseudo-merge offset reads are
 bounded
In-Reply-To: <ZmI3RYSsx6VRHdc9@nand.local> (Taylor Blau's message of "Thu, 6
	Jun 2024 18:25:09 -0400")
References: <a71ec05e5dc0c8c40e1cce14a7c5fe946437a24d.1717699237.git.me@ttaylorr.com>
	<0a16399d14afd527f4db63f2a4a3b0a3cbf112f1.1717699237.git.me@ttaylorr.com>
	<xmqqfrtpluws.fsf@gitster.g> <ZmI3RYSsx6VRHdc9@nand.local>
Date: Thu, 06 Jun 2024 15:35:51 -0700
Message-ID: <xmqqjzj1k8c8.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 221748FA-2455-11EF-B162-ACC938F0AE34-77302942!pb-smtp20.pobox.com

Taylor Blau <me@ttaylorr.com> writes:

> On Thu, Jun 06, 2024 at 12:42:59PM -0700, Junio C Hamano wrote:
>> Can table_size at this point be smaller than 24, which will allow
>> (table_size - 24) to be a huge number that st_mult() will
>> comfortably fit?
>
> It could be smaller than 24, but I think we're at the point of
> diminishing returns here.

I only meant to say that we could easily rewrite

	if (st_mult() > table_size - 24)

condition to

	if (st_add(st_mult(), 24) > table_size)

and we do not have to think if we have already checked table_size
before we reach this point of the control flow.
