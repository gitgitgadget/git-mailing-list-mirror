Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 542B536C
	for <git@vger.kernel.org>; Thu,  9 May 2024 00:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715213811; cv=none; b=J6h7sfbvVxQdT4gC0N0diAeFZOvxWVJBudiwVbU5mMQedmMlEhgOS1E7PysAA1u0uYw1/2ST8rf6YwZR4wE1vTpKNYrD8QQHQz7U63SYC4RMFeJrg2366/LBTHEeE/rnlM3x1zKJ81o3M2TYC/Ub0wBy6X77FMMZA2mlgVj+7ug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715213811; c=relaxed/simple;
	bh=WWsobL87FF3xVNpYyGWAwWJwIwcUxBnqAHEAcDPzXe0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=TGJryvJbRcZR4hjRvgDFPI33UMfJg1M7EJZrJuqKkAuItud28w/ISEysec2Jgadrs3A/qeUgxDM5R6VcGSHLAXqL4MpMq1C7krhMbyvGGiOCTfLiF0qhj9V6wBs7t8NcFbC74me6rZkASGJMV/QVFZJcf2kK+H8ZwjdBT/qMHmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=bWt41m1W; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="bWt41m1W"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 09FCA36DAC;
	Wed,  8 May 2024 20:16:49 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=WWsobL87FF3xVNpYyGWAwWJwIwcUxBnqAHEAcD
	PzXe0=; b=bWt41m1Wr9L2I0LBK/wKKLlkSe0vM1eujCqksjPx0DtJe0vWSxXgMb
	bLpXpfw0HzJjCvPUrpsnlEpDGRVZ+nrV2F6Q074nLNs0B+/mi2SuzAISOpytznra
	UALFWJRos3PLqTsdCbr8LdxNnhNLkMPwhd0MYLDIy/v00nY7ojhgo=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 0172536DAB;
	Wed,  8 May 2024 20:16:49 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 5F30036DAA;
	Wed,  8 May 2024 20:16:48 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 00/13] reftable: prepare for re-seekable iterators
In-Reply-To: <xmqqwmo3x44s.fsf@gitster.g> (Junio C. Hamano's message of "Wed,
	08 May 2024 16:42:11 -0700")
References: <cover.1715166175.git.ps@pks.im> <xmqqwmo3x44s.fsf@gitster.g>
Date: Wed, 08 May 2024 17:16:47 -0700
Message-ID: <xmqqmsozx2j4.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 6D24CD36-0D99-11EF-B3FA-78DCEB2EC81B-77302942!pb-smtp1.pobox.com

Junio C Hamano <gitster@pobox.com> writes:

> diff --git c/reftable/reader.c w/reftable/reader.c
> index 2ea830bdb6..fd516e01db 100644
> --- c/reftable/reader.c
> +++ w/reftable/reader.c
> @@ -841,7 +841,7 @@ int reftable_reader_print_blocks(const char *tablename)
>  		},
>  	};
>  	struct reftable_block_source src = { 0 };
> -	struct table_iter ti = TABLE_ITER_INIT;
> +	struct table_iter *ti;
>  	struct reftable_reader *r = NULL;
>  	size_t i;
>  	int err;

... an unusually early error could skip everything here ...

> @@ -880,6 +883,6 @@ int reftable_reader_print_blocks(const char *tablename)
>  
>  done:
>  	reftable_reader_free(r);
> -	table_iter_close(&ti);
> +	table_iter_close(ti);

... and cause this to break.  In the version of the merge-fix I
used, *ti is initialized to NULL and the _close() is called only
when ti is not NULL.

>  	return err;
>  }
