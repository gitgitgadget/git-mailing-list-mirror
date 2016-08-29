Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C53FE1FD99
	for <e@80x24.org>; Mon, 29 Aug 2016 23:02:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756886AbcH2XCC (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 Aug 2016 19:02:02 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:52977 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1755915AbcH2XCB (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Aug 2016 19:02:01 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 678563A5DC;
        Mon, 29 Aug 2016 19:01:59 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=kbNr5qP8WnpfOWrjneDPdhZxRZM=; b=ABHhP3
        SS2SyucFumsKwNiUpU9uBYuY4pTQqrz/AfMQGr7bECkijuEm8wxhDsPM1T8arsAr
        USQ4IAuO5AVQ7WpQLvS8kt+yMx+03cF7YrLhTvNP5Pi79faWdMJ8KU4kg6YK9JN9
        MwIASRGfFUVozFDi94ipBHwTj/sJqU8ttz3z0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=I2JbWOiZ7MB5cY5twrRrvxdaIzHokX8e
        KQOTsL5u2RKg05OOImQROCQ1pf5i7yHNBiemrKzIMGS35qK9/h1ys87NTWJSm7yW
        1nAlNqpZ4dirjAKq8WJvzZdteM9LaskTibEIKGTKCiis3OcP9m2WB/K839Kt9chL
        lfNxDnEVJPE=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 6086E3A5DB;
        Mon, 29 Aug 2016 19:01:59 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id DCF163A5DA;
        Mon, 29 Aug 2016 19:01:58 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 4/6] require_clean_work_tree: ensure that the index was read
References: <cover.1472137582.git.johannes.schindelin@gmx.de>
        <4122fc996a0076c2426d5e1325f2ce2810ef4f9b.1472137582.git.johannes.schindelin@gmx.de>
Date:   Mon, 29 Aug 2016 16:01:56 -0700
In-Reply-To: <4122fc996a0076c2426d5e1325f2ce2810ef4f9b.1472137582.git.johannes.schindelin@gmx.de>
        (Johannes Schindelin's message of "Thu, 25 Aug 2016 17:06:59 +0200
        (CEST)")
Message-ID: <xmqqmvjv6uxn.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 96D77AD4-6E3C-11E6-B9B3-F7BB12518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

> The function would otherwise pretend to work fine, but totally ignore
> the working directory.

s/^T/Unless the caller has already read the index, t/;

I am not sure if it should be left as the responsibility of the
caller (i.e. check the_index.initialized to bark at a caller that
forgets to read from an index) or it is OK to unconditionally read
from $GIT_INDEX_FILE in a truly libified function.  A caller that
wants to read from a custom (temporary) index file can choose to
make sure it does read_inddex_from() from its custom file before
calling this function, but if it forgets to do so, the penalty is
severe than ordinary callers who would have read from the normal
index file anyway.

Even though the word-lego issue would make this particular API not
yet suitable, "who is responsible for reading the index" is an
orthogonal issue that we can discuss even on this version, so I
thought I'd bring it up.

>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  wt-status.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/wt-status.c b/wt-status.c
> index 792dda9..33dd76f 100644
> --- a/wt-status.c
> +++ b/wt-status.c
> @@ -1804,6 +1804,13 @@ int require_clean_work_tree(const char *action, const char *hint, int gently)
>  	struct lock_file *lock_file = xcalloc(1, sizeof(*lock_file));
>  	int err = 0;
>  
> +	if (read_cache() < 0) {
> +		error(_("Could not read index"));
> +		if (gently)
> +			return -1;
> +		exit(1);
> +	}
> +
>  	hold_locked_index(lock_file, 0);
>  	refresh_cache(REFRESH_QUIET);
>  	update_index_if_able(&the_index, lock_file);
