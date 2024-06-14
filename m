Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42D062CCD0
	for <git@vger.kernel.org>; Fri, 14 Jun 2024 18:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718389408; cv=none; b=m2trXerYyVat+5zHSL4deaFFLGAxah0a/Wfn7rqzQDzLv57x7xFWorZpu2awCJOrPiie5hMp3XxjH7xGng8M1pjFod88u1m+gvqQrJES71NtInhnJLWiHlOX0y2X0H3Nczz5T4ffJ5Ly+zXxaxNnPdWF5hw5Lfb7+GXKsM4kQsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718389408; c=relaxed/simple;
	bh=lKuoNH0q2sJNK5FHuurkQ4El5t68D8ZOnk0U/BCyeSM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=WAvIc3IcYXOAk4wE3CVoz7n5x2+oJXFAykOvLwgsfGwXRNa4DgKrxwDQDUT125HZoEZQ0OMRh4LNgL9nN7d+ZN+YTiG0c4xPIBglZ7RH1ArrlRD+1hZeeUqU1sgm5WezMU4arM4jQYi0O6HsYJVa9vI8T1IwnolyjvHlODwmuRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=jbM5hygK; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="jbM5hygK"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 8C1E232D39;
	Fri, 14 Jun 2024 14:23:26 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=lKuoNH0q2sJNK5FHuurkQ4El5t68D8ZOnk0U/B
	CyeSM=; b=jbM5hygKHLjCmucrnBiTgkLxHzmks9GZghvwtK1Us1s3pF0tjtMuSs
	6x6SaGyqb3Z0I+7Ui8zksWycsTmsDDmXa1U4rFWRcNg3m604HKMmgU9uc+XWpyOI
	3Arrx/w8EmDkU3QCcM2b25OKyZRH3Eu34X/b1RVXrg8r5ZISFXlZQ=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 84D9932D36;
	Fri, 14 Jun 2024 14:23:26 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.204.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id B0A9C32D2B;
	Fri, 14 Jun 2024 14:23:22 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org,  Jeff King <peff@peff.net>,  Elijah Newren
 <newren@gmail.com>,  Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH 2/2] pack-bitmap.c: ensure pseudo-merge offset reads are
 bounded
In-Reply-To: <ZmI6SqIFkWz8OPr1@nand.local> (Taylor Blau's message of "Thu, 6
	Jun 2024 18:38:02 -0400")
References: <a71ec05e5dc0c8c40e1cce14a7c5fe946437a24d.1717699237.git.me@ttaylorr.com>
	<0a16399d14afd527f4db63f2a4a3b0a3cbf112f1.1717699237.git.me@ttaylorr.com>
	<xmqqfrtpluws.fsf@gitster.g> <ZmI3RYSsx6VRHdc9@nand.local>
	<xmqqjzj1k8c8.fsf@gitster.g> <ZmI6SqIFkWz8OPr1@nand.local>
Date: Fri, 14 Jun 2024 11:23:21 -0700
Message-ID: <xmqqa5jnfko6.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 2EDDB8B8-2A7B-11EF-9FF8-DFF1FEA446E2-77302942!pb-smtp21.pobox.com

Taylor Blau <me@ttaylorr.com> writes:

> On Thu, Jun 06, 2024 at 03:35:51PM -0700, Junio C Hamano wrote:
>> Taylor Blau <me@ttaylorr.com> writes:
>>
>> > On Thu, Jun 06, 2024 at 12:42:59PM -0700, Junio C Hamano wrote:
>> >> Can table_size at this point be smaller than 24, which will allow
>> >> (table_size - 24) to be a huge number that st_mult() will
>> >> comfortably fit?
>> >
>> > It could be smaller than 24, but I think we're at the point of
>> > diminishing returns here.
>>
>> I only meant to say that we could easily rewrite
>>
>> 	if (st_mult() > table_size - 24)
>>
>> condition to
>>
>> 	if (st_add(st_mult(), 24) > table_size)
>>
>> and we do not have to think if we have already checked table_size
>> before we reach this point of the control flow.
>
> Ah. Thanks for the clarification. Yes, I think you could do so; I'm
> happy to send another version if you like.

Let's get this thing unstuck; the other larger topic that this topic
builds upon is stuck for too long.
