Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0BAD23778
	for <git@vger.kernel.org>; Thu, 21 Mar 2024 16:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711038160; cv=none; b=p3S2cRJqF1sxqL526ApuwkkSu71b90I09Uk0eM8kWcdfAB/0Ayztgc7g3Iq4Rvg73JbXSK23M3BNKzs1C820VlF/bD7PZq0gCwIfiEL/trDuQnD2Zq9IAVeyPrUFX4un7T2D3kx7KFAPA0GPH1TQtBMYkwjTCq28WqfNlhLrsvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711038160; c=relaxed/simple;
	bh=9QHiI1nz5o6eA3g8BeojweQD5DPHlSUCaKXenpdUavU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=aP9VFtSfsgdmmY0q/wFLVPC3heiEtgevMV/o+N2HEhxHDGk8zmvWQEar7qoCB+FY+DuKFw5LMLUxHdjWgbK8USJVXIM3INIKikZJ+tAcjw96VUDcvA2mHIRxaVmg8nNz9FopmHpRLxfhUBYjteb+ltf9oCcMlEdLl7v8sHslUdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=NjGYyXHn; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="NjGYyXHn"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id A73951EFAC2;
	Thu, 21 Mar 2024 12:22:37 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=9QHiI1nz5o6eA3g8BeojweQD5DPHlSUCaKXenp
	dUavU=; b=NjGYyXHnfXGkKowxGe/d0OmsLj+EVvjLIUM1BnIx3LK4Q02piBN4Ol
	wJhOv0ye+KINUFe8mqUyvuoDeXadfDCHcBrxvld5ovgEAyCUOVEEqoNbTWw/vaY7
	G6LkePoGRUHEJTHm21P8/vz+OgnKtTMqsYEzM+71WRkoP3Qp3nvyY=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 9E2011EFAC1;
	Thu, 21 Mar 2024 12:22:37 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id ED5BC1EFAC0;
	Thu, 21 Mar 2024 12:22:36 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Dirk Gouders <dirk@gouders.net>
Cc: Brian Lyles <brianmlyles@gmail.com>,  git@vger.kernel.org,
  newren@gmail.com,  me@ttaylorr.com,  phillip.wood123@gmail.com,  Phillip
 Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH v4 4/7] sequencer: handle unborn branch with
 `--allow-empty`
In-Reply-To: <ghttkzykru.fsf@gouders.net> (Dirk Gouders's message of "Thu, 21
	Mar 2024 10:52:21 +0100")
References: <20240119060721.3734775-2-brianmlyles@gmail.com>
	<20240320233724.214369-5-brianmlyles@gmail.com>
	<ghttkzykru.fsf@gouders.net>
Date: Thu, 21 Mar 2024 09:22:35 -0700
Message-ID: <xmqqh6gzblmc.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 3AF35D84-E79F-11EE-A0E2-78DCEB2EC81B-77302942!pb-smtp1.pobox.com

Dirk Gouders <dirk@gouders.net> writes:

> Brian Lyles <brianmlyles@gmail.com> writes:
>
>> +	if (!resolve_ref_unsafe("HEAD", RESOLVE_REF_READING, &head_oid, NULL)) {
>> +		/*
>> +		 * Check to see if this is an unborn branch
>> +		 */
> In the above example, there is a short but outstanding comment that
> announces a check (and if I understood correctly by [1] it is a kind of
> trick that could deserve some more information) and it does _not_
> comment on the result.  Of course, I have an idea where the correct
> place for a comment /* This is an unborn branch -- handle it as if... */
> could be, but I'm not sure.

You mean "Check to see if this is an unborn branch, and if so, use
an empty tree to compare against, instead of the tree of the HEAD
that does not yet exist"?

I think that is possible, but the use of the_hash_algo->empty_tree
indicates that clearly enough.  But we need to stop somewhere and
what we see above may be a reasonable place to do so.

If anything, we may want to say why we want to continue as if we had
an empty tree (as opposed to fail and return with an error()), or
the tree to compare with is computed here for what purpose.  But the
name of the function may tell what this whole computation and
comparison is for, so it probably is not needed, either.


