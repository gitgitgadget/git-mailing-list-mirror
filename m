Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF7831AB6E2
	for <git@vger.kernel.org>; Tue, 24 Sep 2024 16:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727197170; cv=none; b=NGZwGELn49/JAqeIgSzU2cyYkW9oOLCHv74NANAmCm9FNBQ8VoCuLlVLXG+GMQOZKKqf5UDhyhLViEDa5o8DTVEw7U9JYNT7hJFqO1wI6u6E0IxLMLSTI2iODsk13mVWHicZ9ffLRkAYdS4c0vuzIP8SRkVkkRT4kKTcJXUvqQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727197170; c=relaxed/simple;
	bh=D4j49Mx/KGW1l9y2bRoxqFF7sevSe3HO3Eb+3ro/g0s=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=jstOxk+9qlPDqj+I4CKAs2HGKettQvteU6sjylKem84Kg+6ai6xP3iYFJ4MXm8Dx1Qtfj74OnpYTl6Q1WRaMD9yb9WeR8Gjn3upxYqiuzEp+sD57ozAhnuZm+Zc29IuIxYvf72ipT8DISstpMv6E1ohxCB/DpUXuNLJuFg8Rd9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=I4Lj0kh3; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="I4Lj0kh3"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id A24563606F;
	Tue, 24 Sep 2024 12:59:26 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=D4j49Mx/KGW1l9y2bRoxqFF7sevSe3HO3Eb+3r
	o/g0s=; b=I4Lj0kh3ZvhyjuHDQfKVWOyU7wYZmvY1OWrajZm0BkFylLnxfWjF9P
	cfmW73VPyBCPUtF44ctlsdeh7U+e3DClx1rj4TtWrMjr6/GzEKoGny26HhZ+PA9G
	EzAZlrrBF3qWYfQZvtwjfZKAifvT+V7ecxxSvVAfHVgqndVVJ7y3s=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 9AC3D3606E;
	Tue, 24 Sep 2024 12:59:26 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.108.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 1141A3606D;
	Tue, 24 Sep 2024 12:59:25 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  Edward Thomson <ethomson@edwardthomson.com>
Subject: Re: [PATCH v2 04/22] reftable/basics: handle allocation failures in
 `reftable_calloc()`
In-Reply-To: <f6ad92ffd01c442dacd3ac6aa448891028636636.1727158127.git.ps@pks.im>
	(Patrick Steinhardt's message of "Tue, 24 Sep 2024 08:32:00 +0200")
References: <cover.1726489647.git.ps@pks.im> <cover.1727158127.git.ps@pks.im>
	<f6ad92ffd01c442dacd3ac6aa448891028636636.1727158127.git.ps@pks.im>
Date: Tue, 24 Sep 2024 09:59:24 -0700
Message-ID: <xmqqikulugwj.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 5AEBD8CA-7A96-11EF-BCFA-2BAEEB2EC81B-77302942!pb-smtp1.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

>  void *reftable_calloc(size_t nelem, size_t elsize)
>  {
> -	size_t sz = st_mult(nelem, elsize);
> -	void *p = reftable_malloc(sz);
> -	memset(p, 0, sz);
> +	void *p;
> +
> +	if (nelem && elsize > SIZE_MAX / nelem)
> +		return NULL;

Now it is open coded, it strikes me that the check is a bit overly
conservative.

If we are trying to allocate slightly than half of SIZE_MAX by
asking elsize==1 and nelem==(SIZE_MAX / 2 + 10), we'd say that
(elsize * nelem) would not fit size_t and fail the allocation.

For the purpose of this caller, it is not a practical issue, as it
is likely that you'd not be able to obtain slightly more than half
your address space out of a single allocation anyway.

But it illustrates why open coding is not necessarily an excellent
idea in the longer term, doesn't it?  When unsigned_mult_overflows()
is updated to avoid such a false positive, how would we remember
that we need to update this copy we?

> +	p = reftable_malloc(nelem * elsize);
> +	if (!p)
> +		return NULL;
> +
> +	memset(p, 0, nelem * elsize);
>  	return p;
>  }
