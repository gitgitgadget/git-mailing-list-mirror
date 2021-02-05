Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30FC2C433E0
	for <git@archiver.kernel.org>; Fri,  5 Feb 2021 00:06:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0BA1D64FB5
	for <git@archiver.kernel.org>; Fri,  5 Feb 2021 00:06:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231591AbhBEAGT (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 4 Feb 2021 19:06:19 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:52428 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231448AbhBEAGO (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Feb 2021 19:06:14 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id DF089AAA16;
        Thu,  4 Feb 2021 19:05:29 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=LkBYs4mu8JBMfV2MWHrxDM4vpUA=; b=T6IFjD
        XowSQ1d7gS4wYaP4qTXy+CL1NhwOQusyZ9cTzmoarWMGKx9mfQtNX5SbQKPjmAO/
        OJKdGQU7548aEpEF7w3frU07rYobl1X3eiaW4C7YlOyx1ShmuRvsEkgNcj8KZDG4
        ZvxGU8XF6+qpsO99FJ0ikyLonNjGbSj6i702E=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=CJ6X9NA5uJAMe2POO2GtR7kFw9hWfCHl
        elhrTVUV9xxdB7j0OEANrs4inOP3bEla3eJFBFVdSvI8o77XiLF9DuH2j7hk4Bcc
        14jv3HeritPjz3I+9c2Me2JPlM6lYJ2J1aapyL+xl+k+ZpPnGVqQ1TaR2/n27cs2
        kw08uB5i4eU=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D492AAAA14;
        Thu,  4 Feb 2021 19:05:29 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 54FE1AAA13;
        Thu,  4 Feb 2021 19:05:29 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, me@ttaylorr.com, l.s.r@web.de,
        szeder.dev@gmail.com, Chris Torek <chris.torek@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH v2 16/17] chunk-format: restore duplicate chunk checks
References: <pull.848.git.1611676886.gitgitgadget@gmail.com>
        <pull.848.v2.git.1611759716.gitgitgadget@gmail.com>
        <669eeec707ab92a3e5983ad12baddc2c15012d43.1611759716.git.gitgitgadget@gmail.com>
Date:   Thu, 04 Feb 2021 16:05:28 -0800
In-Reply-To: <669eeec707ab92a3e5983ad12baddc2c15012d43.1611759716.git.gitgitgadget@gmail.com>
        (Derrick Stolee via GitGitGadget's message of "Wed, 27 Jan 2021
        15:01:55 +0000")
Message-ID: <xmqq4kir4bw7.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: DB3F457E-6745-11EB-A6E3-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Derrick Stolee <dstolee@microsoft.com>
>
> Before refactoring into the chunk-format API, the commit-graph parsing
> logic included checks for duplicate chunks. It is unlikely that we would
> desire a chunk-based file format that allows duplicate chunk IDs in the
> table of contents, so add duplicate checks into
> read_table_of_contents().

Makes sense.  This answers a question I had while reading one of the
previous steps about the design, I think.

However...

> diff --git a/chunk-format.c b/chunk-format.c
> index 74501084cf8..1ee875df423 100644
> --- a/chunk-format.c
> +++ b/chunk-format.c
> @@ -14,6 +14,7 @@ struct chunk_info {
>  	chunk_write_fn write_fn;
>  
>  	const void *start;
> +	unsigned found:1;

This defines a .found member ...

> @@ -98,6 +99,7 @@ int read_table_of_contents(struct chunkfile *cf,
>  			   uint64_t toc_offset,
>  			   int toc_length)
>  {
> +	int i;
>  	uint32_t chunk_id;
>  	const unsigned char *table_of_contents = mfile + toc_offset;
>  
> @@ -124,6 +126,14 @@ int read_table_of_contents(struct chunkfile *cf,
>  			return -1;
>  		}
>  
> +		for (i = 0; i < cf->chunks_nr; i++) {
> +			if (cf->chunks[i].id == chunk_id) {
> +				error(_("duplicate chunk ID %"PRIx32" found"),
> +					chunk_id);
> +				return -1;
> +			}
> +		}
> +
>  		cf->chunks[cf->chunks_nr].id = chunk_id;
>  		cf->chunks[cf->chunks_nr].start = mfile + chunk_offset;
>  		cf->chunks[cf->chunks_nr].size = next_chunk_offset - chunk_offset;

... and no new code touches it.

The way duplicate is found is by having a inner loop that checks the
IDs of chunks we've seen so far (quadratic, but presumably that
would not matter as long as we'd be dealing with just half a dozen
chunk types).

Is the .found bit used for something else and needs to be added in a
different step?
