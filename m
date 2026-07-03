Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1762537DE98
	for <git@vger.kernel.org>; Fri,  3 Jul 2026 09:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783070628; cv=none; b=GqaKkTDx4ykQ1fsNE/nRMsWM1G1zIIJ5qzdy46airK4v5ZfdR8nAOzKD9cVw/890xXsPVmHttnAmFs9UiSYn0M/czezyUuxVGJaeSGJEo0Cn2U271KjxRiY/F5z3EbsBjyXu6pmNTM0NI7FOLgXyXkT2Cg+5XoDi3NGfsCT4WDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783070628; c=relaxed/simple;
	bh=NFNMxGIEv5tDk159rM6AtwNJIhMdbZiYJhG9tv2F2Qg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=OFM0NxSDxSk+O66ARB8coTWH7+62gh/i7kuQzbQk0/o12eViQWrE5YR0iM5IZyqNnj/I5gTIxxzthPrONGNc+yGLuKh+oSAyynkDRQ6nQC7TTgaLj4WWDJTASrBT4KIKm8QXu+isK3ynZYfGLtuPeXgkLjWcYZBURxtGODHG0lc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=cq65LXY4; arc=none smtp.client-ip=91.218.175.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="cq65LXY4"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1783070624;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+XRYUqJpmm2rTFKWgZ9mqQzzCp0JJWGRyYVBY5xpt7c=;
	b=cq65LXY4daHxdYxSES++PCcUZBX+3tD7GK2d+MWv+jWfPoSmuNhYoQ0Ars5yujDMpKQomk
	+KdOJVTnKsdSLOpRO+85EfMM2opZIwVL/dFpWSMloOkSbLYPsreaGtyq7U5w5nPZwVMYH1
	yVeaaK2dEYjF3UuHV+/4xMfODo3LXkQ=
From: Toon Claes <toon@iotcl.com>
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: oxsignal <awo@kakao.com>, Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v2 06/12] reftable/block: fix OOB write with bogus
 inflated log size
In-Reply-To: <20260629-pks-reftable-hardening-v2-6-b0228e7d908d@pks.im>
References: <20260629-pks-reftable-hardening-v2-0-b0228e7d908d@pks.im>
 <20260629-pks-reftable-hardening-v2-6-b0228e7d908d@pks.im>
Date: Fri, 03 Jul 2026 11:23:37 +0200
Message-ID: <871pdk4eau.fsf@emacs.iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT

Patrick Steinhardt <ps@pks.im> writes:

> diff --git a/t/unit-tests/u-reftable-block.c b/t/unit-tests/u-reftable-block.c
> index f4e926ce3a..088162483e 100644
> --- a/t/unit-tests/u-reftable-block.c
> +++ b/t/unit-tests/u-reftable-block.c
> @@ -465,3 +465,35 @@ void test_reftable_block__iterator(void)
>  	reftable_block_release(&block);
>  	reftable_buf_release(&data);
>  }
> +
> +void test_reftable_block__corrupt_log_block_size(void)
> +{
> +	struct reftable_block_source source = { 0 };
> +	struct reftable_record rec = {
> +		.type = REFTABLE_BLOCK_TYPE_LOG,
> +		.u.log = {
> +			.refname = (char *) "refs/heads/main",
> +			.update_index = 1,
> +			.value_type = REFTABLE_LOG_UPDATE,
> +		},
> +	};
> +	struct reftable_block block = { 0 };
> +	struct reftable_buf data = REFTABLE_BUF_INIT;
> +
> +	cl_reftable_write_block(&data, REFTABLE_BLOCK_TYPE_LOG, &rec, 1);
> +
> +	/*
> +	 * Log blocks store their inflated size as a big-endian 24-bit integer
> +	 * right after the one-byte block type. Rewrite it to claim a size that
> +	 * is smaller than the block header.
> +	 */
> +	reftable_put_be24((uint8_t *) data.buf + 1, 1);

Can I suggest to make this test a bit more strict:

	/*
	 * Log blocks store their inflated size as a big-endian 24-bit integer
	 * right after the one-byte block type.
	 * First sanity check if the expected value is actually there,
	 * then rewrite it to claim a size that is smaller than the block header.
	 */
	void *p = (uint8_t *) data.buf + 1;
	uint32_t block_size = reftable_get_be24(p);
	cl_assert_equal_i(block_size, 82);
	reftable_put_be24(p, 5);

So first do a sanity check to see if the current block_size is what we
expect, this helps us ensure we are actually reading the correct point
in the buffers. Or does this depend on the architecture?

Then write a size that's just below what the expected value is. By using
a value that's just too small, maybe we can avoid off-by-one errors?

> +
> +	block_source_from_buf(&source, &data);
> +	cl_assert_equal_i(reftable_block_init(&block, &source, 0, 0, data.len,
> +					      REFTABLE_HASH_SIZE_SHA1, REFTABLE_BLOCK_TYPE_LOG),
> +			  REFTABLE_FORMAT_ERROR);
> +
> +	reftable_block_release(&block);
> +	reftable_buf_release(&data);
> +}

-- 
Cheers,
Toon
