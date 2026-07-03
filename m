Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58DE93B19DE
	for <git@vger.kernel.org>; Fri,  3 Jul 2026 09:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783070909; cv=none; b=Rwbvc2FqgSfuc4rYct+sAFqNAsUlJus2v2pWlb5tizK9WAX9ib3qEt9VcbDGa+yLhoMYO7jzGw34T4GtOTxW7TRWI2HOD7j68LlNOpkRj56pFJHh2JESxEV8ZPI7OUw0B2KagjyMdn124RcEAmt/eFunPOvFBmJVUoTudEYlNDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783070909; c=relaxed/simple;
	bh=ePH6db6I+G+Oz9TX2iwvkUeVZtqiaCXEIygCjMfCmCA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=X8i5WW3kDz7Bok+j4l5RIBshChVLDMTEwkknW/TyiN/IUznzzDHcW2rpsooOq6qOEcI5ovxJOBl8d379UNjHvNZO3ZJ6P+rwROo5dHOYNjFSXqI1Fth5E/hZM3xu5K1BuH/CgeBiI0oGpYJacsqJKQBqeeExXk3cHHjkJqLSDnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=WGFxEj8s; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="WGFxEj8s"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1783070905;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Bdd7xPGh7XbztyEhourLiLMhjtWuVWPmdQ6VkRqswaU=;
	b=WGFxEj8sUATqluuHOSKFAj2FoQUWe+XvLVL6yiiHJ70+v+dX8CR+F4LfEhjR9BiHzJVpxI
	KfPtr2k/U/eUCfIFQ026FlycMRe7tfcSzWdUsk00cDKzzUt+31qqliJVLrl3S6fKTbfeo2
	WqmbuQIhHTYMsHhYm4yMsWZEKnqd574=
From: Toon Claes <toon@iotcl.com>
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: oxsignal <awo@kakao.com>, Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v2 07/12] reftable/block: fix OOB read with bogus block
 size
In-Reply-To: <20260629-pks-reftable-hardening-v2-7-b0228e7d908d@pks.im>
References: <20260629-pks-reftable-hardening-v2-0-b0228e7d908d@pks.im>
 <20260629-pks-reftable-hardening-v2-7-b0228e7d908d@pks.im>
Date: Fri, 03 Jul 2026 11:28:21 +0200
Message-ID: <87wlvc2zii.fsf@emacs.iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT

Patrick Steinhardt <ps@pks.im> writes:

> The block size is read from the block header, which is untrusted data.
> We use it without verification to access the restart count at the end of
> the block as well as to compute the restart table offset. With a bogus
> block size that exceeds the data we have actually read this can lead to
> an out-of-bounds read:
>
>   ==1458284==ERROR: AddressSanitizer: SEGV on unknown address 0x7d8ff7de4b7d (pc 0x55555598c339 bp 0x7fffffff4ef0 sp 0x7fffffff4eb0 T0)
>   ==1458284==The signal is caused by a READ memory access.
>       #0 0x55555598c339 in reftable_get_be16 ./build/../reftable/basics.h:118:9
>       #1 0x55555598bee2 in reftable_block_init ./build/../reftable/block.c:344:18
>       #2 0x555555813e0e in test_reftable_block__corrupt_block_size ./build/../t/unit-tests/u-reftable-block.c:540:8
>       #3 0x5555557f684e in clar_run_test ./build/../t/unit-tests/clar/clar.c:335:3
>       #4 0x5555557f2e69 in clar_run_suite ./build/../t/unit-tests/clar/clar.c:431:3
>       #5 0x5555557f2882 in clar_test_run ./build/../t/unit-tests/clar/clar.c:636:4
>       #6 0x5555557f375f in clar_test ./build/../t/unit-tests/clar/clar.c:687:11
>       #7 0x5555557fa49d in cmd_main ./build/../t/unit-tests/unit-test.c:62:8
>       #8 0x55555584b55a in main ./build/../common-main.c:9:11
>       #9 0x7ffff7a2b284 in __libc_start_call_main (/nix/store/57iz36553175g3178pvxjij8z5rcsd4n-glibc-2.42-61/lib/libc.so.6+0x2b284) (BuildId: 8ae0b698f2d4e727f569f64bb166e08ae30bd077)
>       #10 0x7ffff7a2b337 in __libc_start_main@GLIBC_2.2.5 (/nix/store/57iz36553175g3178pvxjij8z5rcsd4n-glibc-2.42-61/lib/libc.so.6+0x2b337) (BuildId: 8ae0b698f2d4e727f569f64bb166e08ae30bd077)
>       #11 0x555555694c24 in _start (./build/t/unit-tests+0x140c24)
>
>   ==1458284==Register values:
>   rax = 0x00007d8ff7de4b7d  rbx = 0x00007fffffff4f00  rcx = 0x0000000000000006  rdx = 0x0000000000000010
>   rdi = 0x00007d8ff7de4b7d  rsi = 0x00007bfff5cf0420  rbp = 0x00007fffffff4ef0  rsp = 0x00007fffffff4eb0
>    r8 = 0x00000f807eb960b8   r9 = 0x0000000000000001  r10 = 0x00007bfff5cf05e7  r11 = 0x000000000000000f
>   r12 = 0x00007fffffff58f8  r13 = 0x0000000000000001  r14 = 0x0000555555ee8160  r15 = 0x0000000000000000
>   AddressSanitizer can not provide additional info.
>
> Verify that the claimed block size fits into the block data before using
> it.
>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  reftable/block.c                |  9 +++++++++
>  t/unit-tests/u-reftable-block.c | 33 +++++++++++++++++++++++++++++++++
>  2 files changed, 42 insertions(+)
>
> diff --git a/reftable/block.c b/reftable/block.c
> index b86cb9ec5a..4d6b11c2e7 100644
> --- a/reftable/block.c
> +++ b/reftable/block.c
> @@ -340,6 +340,15 @@ int reftable_block_init(struct reftable_block *block,
>  		full_block_size = block_size;
>  	}
>  
> +	/*
> +	 * Ensure that we have sufficient data available now to satisfy the
> +	 * claimed block size.
> +	 */
> +	if (block_size > block->block_data.len) {
> +		err = REFTABLE_FORMAT_ERROR;
> +		goto done;
> +	}
> +
>  	restart_count = reftable_get_be16(block->block_data.data + block_size - 2);
>  	restart_off = block_size - 2 - 3 * restart_count;
>  
> diff --git a/t/unit-tests/u-reftable-block.c b/t/unit-tests/u-reftable-block.c
> index 088162483e..43b9d5fb59 100644
> --- a/t/unit-tests/u-reftable-block.c
> +++ b/t/unit-tests/u-reftable-block.c
> @@ -497,3 +497,36 @@ void test_reftable_block__corrupt_log_block_size(void)
>  	reftable_block_release(&block);
>  	reftable_buf_release(&data);
>  }
> +
> +void test_reftable_block__corrupt_block_size(void)
> +{
> +	struct reftable_block_source source = { 0 };
> +	struct reftable_record rec = {
> +		.type = REFTABLE_BLOCK_TYPE_REF,
> +		.u.ref = {
> +			.value_type = REFTABLE_REF_VAL1,
> +			.refname = (char *) "refs/heads/main",
> +		},
> +	};
> +	struct reftable_block block = { 0 };
> +	struct reftable_buf data = REFTABLE_BUF_INIT;
> +
> +	cl_reftable_write_block(&data, REFTABLE_BLOCK_TYPE_REF, &rec, 1);
> +
> +	/*
> +	 * The block size is stored as a big-endian 24-bit integer right after
> +	 * the one-byte block type at the start of the block. Corrupt it to
> +	 * claim a size that is larger than the data we actually have. Reading
> +	 * the restart count and restart table relative to such a bogus block
> +	 * size must not access out-of-bounds memory.
> +	 */
> +	reftable_put_be24((uint8_t *) data.buf + 1, 0xffffff);

Same here, would it make sense to write a size that's `+1` too much?

	uint8_t *p = (uint8_t *)data.buf + 1;
	uint32_t block_size = reftable_get_be24(p);
	cl_assert_equal_i(block_size, 47);
	reftable_put_be24(p, block_size + 1);


> +
> +	block_source_from_buf(&source, &data);
> +	cl_assert_equal_i(reftable_block_init(&block, &source, 0, 0, data.len,
> +					      REFTABLE_HASH_SIZE_SHA1, REFTABLE_BLOCK_TYPE_REF),
> +			  REFTABLE_FORMAT_ERROR);
> +
> +	reftable_block_release(&block);
> +	reftable_buf_release(&data);
> +}
>
> -- 
> 2.55.0.rc2.803.g1fd1e6609c.dirty
>
>

-- 
Cheers,
Toon
