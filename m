Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B57822331
	for <git@vger.kernel.org>; Fri, 20 Sep 2024 18:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726855820; cv=none; b=DR0t52oPN+uyBlUCsIH2QBgD3SzPIswh96W2Agul4u2SAjIHlmJVMpCLghdqha/O1aGFrjQvKrxqUcC/CKzEg7/V57APAyJgGgfCxIvaHn++DCR8MtlPBhA1hoSMcj+9TFpyx5RaY+Sx+IzZHlHPCEYmDbVj593ngAsTyozaEiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726855820; c=relaxed/simple;
	bh=pVezgskd5ggC8q+vHGik+nSkRgK6SBEfWehHzC35ZgU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=quliF5z/ZEQCof0absm4AAlYqUVR1ictZ/jBISd0mtbFHxLUdUP8WrXXIyNx65t/b3sij3qt7odtts3JXDbNzl7wq7vpyMQgTvPyi6HhAEoMAn/bFAXDw0G0DKvU+H6gQKmufxPnHFg6jOGJaWy27nRWp7mMj1JWgSQMJ5K85rw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=NYCdWPte; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="NYCdWPte"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 4BC3836EC8;
	Fri, 20 Sep 2024 14:10:17 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=pVezgskd5ggC8q+vHGik+nSkRgK6SBEfWehHzC
	35ZgU=; b=NYCdWPteRA8gXcvjXnRphYLTB86yolRxY+1ExuI0GNaTBDoKmxB/dt
	aUZk/cZ1FnclNIHpppyT8l7KCJTwaVpV27A4FVlID/4K3NmkCVmqjNuEretAGGrM
	/gYn9+wiHrIANMpUQx9F4LBUGQ+b6RJu1L094xMc5DmAz+bh9MCbs=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 3FE0536EC7;
	Fri, 20 Sep 2024 14:10:17 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.108.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 40CE936E98;
	Fri, 20 Sep 2024 14:10:16 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  karthik nayak <karthik.188@gmail.com>,  Eric
 Sunshine <sunshine@sunshineco.com>,  James Liu <james@jamesliu.io>
Subject: Re: [PATCH v3 2/3] reftable/stack: allow locking of outdated stacks
In-Reply-To: <6130565498e51ce3228d6fe5bc5f0b83c0db9182.1726653185.git.ps@pks.im>
	(Patrick Steinhardt's message of "Wed, 18 Sep 2024 11:59:31 +0200")
References: <cover.1726578382.git.ps@pks.im> <cover.1726653185.git.ps@pks.im>
	<6130565498e51ce3228d6fe5bc5f0b83c0db9182.1726653185.git.ps@pks.im>
Date: Fri, 20 Sep 2024 11:10:14 -0700
Message-ID: <xmqqzfo2gprt.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 9695EFB4-777B-11EF-833B-2BAEEB2EC81B-77302942!pb-smtp1.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

>  int reftable_stack_new_addition(struct reftable_addition **dest,
> -				struct reftable_stack *st);
> +				struct reftable_stack *st,
> +				int flags);

We usually use "unsigned" for a flag word, i.e., a collection of
flag bits.

> @@ -1314,6 +1376,7 @@ int cmd_main(int argc UNUSED, const char *argv[] UNUSED)
>  	TEST(t_reftable_stack_reload_with_missing_table(), "stack iteration with garbage tables");
>  	TEST(t_reftable_stack_tombstone(), "'tombstone' refs in stack");
>  	TEST(t_reftable_stack_transaction_api(), "update transaction to stack");
> +	TEST(t_reftable_stack_transaction_with_reload(), "transaction with reload");
>  	TEST(t_reftable_stack_transaction_api_performs_auto_compaction(), "update transaction triggers auto-compaction");
>  	TEST(t_reftable_stack_update_index_check(), "update transactions with equal update indices");
>  	TEST(t_reftable_stack_uptodate(), "stack must be reloaded before ref update");

Looking good.
