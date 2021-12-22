Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 693A4C433EF
	for <git@archiver.kernel.org>; Wed, 22 Dec 2021 22:51:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241953AbhLVWvK (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Dec 2021 17:51:10 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:64153 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229665AbhLVWvK (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Dec 2021 17:51:10 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 948F1162691;
        Wed, 22 Dec 2021 17:51:09 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=6x83g9j+AT4Fzemdj0F3MDEQf8ySEPvJsgJtb4DgjsU=; b=sp10
        Y+Z8M0zNrzJ59VGjFPcmXw59U1YuBN3rMspwoqHFPYphwPbJPgmTTZ7aZ0xtW/R5
        qoQ10PP3ia+W1lqrQ5Zq0hL0LoGBBv/6oHlSX5n9FO3Pne08gPjGsE/TMq3f2RuC
        tjgDaLnNm84WnfmpCTQ2IfzwhJnmz3jiVtQccGk=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 8CED7162690;
        Wed, 22 Dec 2021 17:51:09 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id E4EA416268D;
        Wed, 22 Dec 2021 17:51:05 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Han-Wen Nienhuys <hanwen@google.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Han-Wen Nienhuys <hanwenn@gmail.com>
Subject: Re: [PATCH v5 02/16] reftable: fix resource leak in block.c error path
References: <pull.1152.v4.git.git.1639482476.gitgitgadget@gmail.com>
        <pull.1152.v5.git.git.1640199396.gitgitgadget@gmail.com>
        <9ab631a3b29addaa54415139e7f60a79a19a6edb.1640199396.git.gitgitgadget@gmail.com>
Date:   Wed, 22 Dec 2021 14:51:04 -0800
Message-ID: <xmqqtuf0fe3r.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A571DCDC-6379-11EC-ABA3-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com> writes:

> diff --git a/reftable/reader.c b/reftable/reader.c
> index 006709a645a..0d16b098f5e 100644
> --- a/reftable/reader.c
> +++ b/reftable/reader.c
> @@ -290,28 +290,34 @@ int reader_init_block_reader(struct reftable_reader *r, struct block_reader *br,
>  
>  	err = reader_get_block(r, &block, next_off, guess_block_size);
>  	if (err < 0)
> -		return err;
> +		goto done;
>  
>  	block_size = extract_block_size(block.data, &block_typ, next_off,
>  					r->version);
> -	if (block_size < 0)
> -		return block_size;
> -
> +	if (block_size < 0) {
> +		err = block_size;
> +		goto done;
> +	}
>  	if (want_typ != BLOCK_TYPE_ANY && block_typ != want_typ) {
> -		reftable_block_done(&block);
> -		return 1;
> +		err = 1;
> +		goto done;
>  	}
>  
>  	if (block_size > guess_block_size) {
>  		reftable_block_done(&block);
>  		err = reader_get_block(r, &block, next_off, block_size);
>  		if (err < 0) {
> -			return err;
> +			goto done;
>  		}
>  	}
>  
> -	return block_reader_init(br, &block, header_off, r->block_size,
> -				 hash_size(r->hash_id));
> +	err = block_reader_init(br, &block, header_off, r->block_size,
> +				hash_size(r->hash_id));
> +done:
> +	if (err)

Is the convention for reader_init() different from all other
functions?  It makes reader wonder why this is not

	if (err < 0)

even though it is not wrong per-se (as long as "zero means success"
is a part of the return value convention).

> +		reftable_block_done(&block);
> +
> +	return err;
>  }

This one is new in this round.  All look good, other than that one
check for error return.

> diff --git a/reftable/readwrite_test.c b/reftable/readwrite_test.c
> index 5f6bcc2f775..6e88182a83a 100644
> --- a/reftable/readwrite_test.c
> +++ b/reftable/readwrite_test.c
> @@ -254,6 +254,71 @@ static void test_log_write_read(void)
>  	reader_close(&rd);
>  }
>  
> +static void test_log_zlib_corruption(void)
> +{
> +	struct reftable_write_options opts = {
> +		.block_size = 256,
> +	};
> +	struct reftable_iterator it = { 0 };
> +	struct reftable_reader rd = { 0 };
> +	struct reftable_block_source source = { 0 };
> +	struct strbuf buf = STRBUF_INIT;
> +	struct reftable_writer *w =
> +		reftable_new_writer(&strbuf_add_void, &buf, &opts);
> +	const struct reftable_stats *stats = NULL;
> +	uint8_t hash1[GIT_SHA1_RAWSZ] = { 1 };
> +	uint8_t hash2[GIT_SHA1_RAWSZ] = { 2 };

Will this code be exercised when compiling with SHA256 support?  If
not, this is perfectly fine, but otherwise, this needs to be MAX,
not SHA1, no?

> +	char message[100] = { 0 };

You're filling this to the sizeof(message)-1, so we can afford to
leave it uninitialized.

> +	int err, i, n;
> +
> +	struct reftable_log_record log = {
> +		.refname = "refname",
> +		.value_type = REFTABLE_LOG_UPDATE,
> +		.value = {
> +			.update = {
> +				.new_hash = hash1,
> +				.old_hash = hash2,
> +				.name = "My Name",
> +				.email = "myname@invalid",
> +				.message = message,
> +			},
> +		},
> +	};
> +
> +	for (i = 0; i < sizeof(message)-1; i++)

Style: SP around "-" on both sides.

> +		message[i] = (uint8_t)(rand() % 64 + ' ');
> +
> +	reftable_writer_set_limits(w, 1, 1);
