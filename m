Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C16E1ABEB9
	for <git@vger.kernel.org>; Fri,  2 Aug 2024 21:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722632751; cv=none; b=Yt0xrFuMCco1a+Pi4FCTO5gK3sXqMziejnwteJ5ffJQBlyeUEc2pu6WpNTlZdC3jcBqaozZDxp/XZh2GxBFgf7gRulWoMIAxA0Dorr7Zt7e2njkPUP6ea+dcu8LVFkhO2R+a6VhCHaBLYIr/cSelENXI+6XwHVkIY8dLrgJq8sA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722632751; c=relaxed/simple;
	bh=Y7UV8f+keHq/tZzc3z+/0Ul3ljBtTby+a4W68EFf6n4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=LcUZHHIhdm5Avcim+HfzBc3DYx3gfTHzGjD0PJGKpFrsDCJub3zAEOcOB1umR8SShw80lH5lNJnUlMAWj/U2c1qS0FVBxzXjX3Geph5yc7Y6c7JzLehtid5OFCa0FrH3Oxj0JssfjsEno1giwscQWiRQR0h5Gm/UDoPrg1zLrBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=gALhleRb; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="gALhleRb"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id ACCFD1C771;
	Fri,  2 Aug 2024 17:05:49 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=Y7UV8f+keHq/tZzc3z+/0Ul3ljBtTby+a4W68E
	Ff6n4=; b=gALhleRbfLP57CjIbqVbvGjAG5xGMgZai4pnQFBjrNCtcNZ2dv2bNx
	Vyv+jB1oTpiJaYUHL1xwtPr2JpWMWSNkLr7uDWIW/MaE3bO7R0IoIG5UlSu8G3u4
	4NGYiqUbECMo1y7W3+9N0hcucxeZrifqqFVzsDBmif9rRKJsiGhCA=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id A5D401C770;
	Fri,  2 Aug 2024 17:05:49 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.108.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 99F6E1C76F;
	Fri,  2 Aug 2024 17:05:45 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 2/8] reftable/stack: test compaction with already-locked
 tables
In-Reply-To: <123fb9d80eecbd3690280991e0415cbb718b7202.1722435214.git.ps@pks.im>
	(Patrick Steinhardt's message of "Wed, 31 Jul 2024 16:14:57 +0200")
References: <cover.1722435214.git.ps@pks.im>
	<123fb9d80eecbd3690280991e0415cbb718b7202.1722435214.git.ps@pks.im>
Date: Fri, 02 Aug 2024 14:05:43 -0700
Message-ID: <xmqqle1ebpp4.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 FC5502B6-5112-11EF-B3AB-9625FCCAB05B-77302942!pb-smtp21.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

> +static void test_reftable_stack_auto_compaction_with_locked_tables(void)
> +{
> +	struct reftable_write_options opts = {
> +		.disable_auto_compact = 1,
> +	};
> +	struct reftable_stack *st = NULL;
> +	struct strbuf buf = STRBUF_INIT;
> +	char *dir = get_tmp_dir(__LINE__);
> +	int err;
> +
> +	err = reftable_new_stack(&st, dir, &opts);
> +	EXPECT_ERR(err);
> +
> +	for (size_t i = 0; i < 5; i++) {
> +		struct reftable_ref_record ref = {
> +			.update_index = reftable_stack_next_update_index(st),
> +			.value_type = REFTABLE_REF_VAL1,
> +			.value.val1 = { i },
> +		};

As val1 is an array of unsigned char, i cannot reasonably go beyond
255, but that is perfectly fine.  We are preparing 5 original tables
to compact, and that might grow to 17 tables over time, but 255 ought
to be more than enough.

> +
> +		strbuf_reset(&buf);
> +		strbuf_addf(&buf, "refs/heads/branch-%04" PRIuMAX, (uintmax_t) i);

Yet we are prepared to handle i that is beyond any usual integer ;-)

I am tempted to suggest using the bog-standard int for everything
for the sake of consistency within this loop, but it does not matter
all that much in a standalone test program ;-)

> +		ref.refname = buf.buf;
> +
> +		err = reftable_stack_add(st, &write_test_ref, &ref);
> +		EXPECT_ERR(err);
> +	}
> +	EXPECT(st->merged->stack_len == 5);
> +
> +	/*
> +	 * Given that all tables we have written should be roughly the same
> +	 * size, we expect that auto-compaction will want to compact all of the
> +	 * tables. Locking any of the tables will keep it from doing so.
> +	 */
> +	strbuf_reset(&buf);
> +	strbuf_addf(&buf, "%s/%s.lock", dir, st->readers[2]->name);
> +	write_file_buf(buf.buf, "", 0);

OK.  [2] is just a random number pulled out of 0..5?

> +static void test_reftable_stack_compaction_with_locked_tables(void)
> +{
> +	struct reftable_write_options opts = {
> +		.disable_auto_compact = 1,
> +	};
> +	struct reftable_stack *st = NULL;
> +	struct strbuf buf = STRBUF_INIT;
> +	char *dir = get_tmp_dir(__LINE__);
> +	int err;
> +
> +	err = reftable_new_stack(&st, dir, &opts);
> +	EXPECT_ERR(err);
> +
> +	for (size_t i = 0; i < 3; i++) {
> +...
> +	}
> +	EXPECT(st->merged->stack_len == 3);

Hmph, this somehow looks familiar.  The only difference is how many
tables are compacted with which one locked, and whether it is
compact_all() or auto_compact() that triggers the compaction
behaviour, right?

I wonder if we want to factor out the commonality into a shared
function, or it is too much trouble only for two duplicates and we
can worry about it when we were about to add the third one?

Thanks.
