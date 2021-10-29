Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28B9BC433F5
	for <git@archiver.kernel.org>; Fri, 29 Oct 2021 23:17:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 04E8260FC0
	for <git@archiver.kernel.org>; Fri, 29 Oct 2021 23:17:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231497AbhJ2XUT (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 29 Oct 2021 19:20:19 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:52200 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbhJ2XUS (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Oct 2021 19:20:18 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 6AF4F16C046;
        Fri, 29 Oct 2021 19:17:49 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=X0wnYqXmAkedJByBiRmqbKCv6EO3s03FuuSuSaeIp0o=; b=gsH5
        xSKziun6SCekFiSvATqsOZFuE8FP12H5X10DSH0+dUeJnue7zhWtrIfopzxPYno4
        8dJpVJp5YdWpTMZVtxG3d3uB08cxBmFv0BpH9B1c+YUFej6ehb9642QKd0ufEzX4
        MiROTi4Ew45k71EyMemB8jeulfKyZ/95Jj8vsPU=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 61F7216C045;
        Fri, 29 Oct 2021 19:17:49 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id EADE616C044;
        Fri, 29 Oct 2021 19:17:45 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Matt Cooper via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Carlo Arenas <carenas@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Matt Cooper <vtbassmatt@gmail.com>
Subject: Re: [PATCH v3 5/8] odb: teach read_blob_entry to use size_t
References: <pull.1068.v2.git.1635454237.gitgitgadget@gmail.com>
        <pull.1068.v3.git.1635515959.gitgitgadget@gmail.com>
        <dbef8168bc7044dbc8471c5ecc7146cf3e979263.1635515959.git.gitgitgadget@gmail.com>
Date:   Fri, 29 Oct 2021 16:17:44 -0700
Message-ID: <xmqqwnlvfmjr.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 6CD3D348-390E-11EC-B0DB-F327CE9DA9D6-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Matt Cooper via GitGitGadget" <gitgitgadget@gmail.com> writes:

> -void *read_blob_entry(const struct cache_entry *ce, unsigned long *size)
> +void *read_blob_entry(const struct cache_entry *ce, size_t *size)
>  {
>  	enum object_type type;
> -	void *blob_data = read_object_file(&ce->oid, &type, size);
> +	unsigned long ul;
> +	void *blob_data = read_object_file(&ce->oid, &type, &ul);
>  
> +	*size = ul;

It is a bit curious place to draw the line; we want to make sure
that blob_entry can hold huge data, but in this step we do not mind
read_object_file() is not capable of going full 64-bit?

I guess I'll see soon enough why by reading later steps.  I can see
that for the purpose of making write_entry() aware of the size_t,
this is necessary at the minimum.

Looking good.

>  	if (blob_data) {
>  		if (type == OBJ_BLOB)
>  			return blob_data;
> @@ -270,7 +272,7 @@ static int write_entry(struct cache_entry *ce, char *path, struct conv_attrs *ca
>  	int fd, ret, fstat_done = 0;
>  	char *new_blob;
>  	struct strbuf buf = STRBUF_INIT;
> -	unsigned long size;
> +	size_t size;
>  	ssize_t wrote;
>  	size_t newsize = 0;
>  	struct stat st;
> diff --git a/entry.h b/entry.h
> index b8c0e170dc7..61ee8c17604 100644
> --- a/entry.h
> +++ b/entry.h
> @@ -51,7 +51,7 @@ int finish_delayed_checkout(struct checkout *state, int *nr_checkouts);
>   */
>  void unlink_entry(const struct cache_entry *ce);
>  
> -void *read_blob_entry(const struct cache_entry *ce, unsigned long *size);
> +void *read_blob_entry(const struct cache_entry *ce, size_t *size);
>  int fstat_checkout_output(int fd, const struct checkout *state, struct stat *st);
>  void update_ce_after_write(const struct checkout *state, struct cache_entry *ce,
>  			   struct stat *st);
> diff --git a/parallel-checkout.c b/parallel-checkout.c
> index 6b1af32bb3d..b6f4a25642e 100644
> --- a/parallel-checkout.c
> +++ b/parallel-checkout.c
> @@ -261,7 +261,7 @@ static int write_pc_item_to_fd(struct parallel_checkout_item *pc_item, int fd,
>  	struct stream_filter *filter;
>  	struct strbuf buf = STRBUF_INIT;
>  	char *blob;
> -	unsigned long size;
> +	size_t size;
>  	ssize_t wrote;
>  
>  	/* Sanity check */
> diff --git a/t/t1051-large-conversion.sh b/t/t1051-large-conversion.sh
> index bff86c13208..8b23d862600 100755
> --- a/t/t1051-large-conversion.sh
> +++ b/t/t1051-large-conversion.sh
> @@ -85,7 +85,7 @@ test_expect_success 'ident converts on output' '
>  
>  # This smudge filter prepends 5GB of zeros to the file it checks out. This
>  # ensures that smudging doesn't mangle large files on 64-bit Windows.
> -test_expect_failure EXPENSIVE,SIZE_T_IS_64BIT,!LONG_IS_64BIT \
> +test_expect_success EXPENSIVE,SIZE_T_IS_64BIT,!LONG_IS_64BIT \
>  		'files over 4GB convert on output' '
>  	test_commit test small "a small file" &&
>  	test_config filter.makelarge.smudge \
