Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3EE591F464
	for <e@80x24.org>; Mon, 30 Sep 2019 16:58:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729217AbfI3Q6h (ORCPT <rfc822;e@80x24.org>);
        Mon, 30 Sep 2019 12:58:37 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:61868 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727025AbfI3Q6h (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Sep 2019 12:58:37 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id CB60E26B25;
        Mon, 30 Sep 2019 12:58:34 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=HfuS3WpG3zQEtkGp+t6Ci5trASw=; b=txMuOo
        37oaHvlbkaq0lweP9MCEr4Q/dEM/7RA6hKrheG9Riw7DDolIz85cIxOJy8o6ZNlE
        sIQTpX4oJBhKGyEaz9Nw7tagThhjWj+djO8ZicT/mz4NWbCRROmxrcmxoDzPd5jJ
        Dxm1xwVKoiLMw1kz5j3OIDzwNyFR7MHIVBuMk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=I/5ZQn10b91wXI/7n36UpNLa7Xmko/lP
        DMvcafXGg1cZETef7kyxvNcDZYLBx//P45EB4eC5VhOCWfG6KKBoTdBjMnitLUIU
        k0rjCntjsBoCDfCJtf7sS4UaWZms9bZGDT+dDrKNDPS0nkKIqrzp/abHz36qa9QZ
        UrxEnviQ2Ak=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C35A526B24;
        Mon, 30 Sep 2019 12:58:34 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 1CAA126B23;
        Mon, 30 Sep 2019 12:58:34 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Wong <e@80x24.org>
Cc:     Derrick Stolee <stolee@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>, git@vger.kernel.org
Subject: Re: [PATCH v2 18/19] OFFSETOF_VAR macro to simplify hashmap iterators
References: <20190924010324.22619-1-e@80x24.org>
        <20190924010324.22619-19-e@80x24.org>
Date:   Tue, 01 Oct 2019 01:58:33 +0900
In-Reply-To: <20190924010324.22619-19-e@80x24.org> (Eric Wong's message of
        "Tue, 24 Sep 2019 01:03:23 +0000")
Message-ID: <xmqqy2y5hgau.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 89B9EE60-E3A3-11E9-87AD-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Wong <e@80x24.org> writes:

> While we cannot rely on a `__typeof__' operator being portable
> to use with `offsetof'; we can calculate the pointer offset
> using an existing pointer and the address of a member using
> pointer arithmetic.

> +/*
> + * like offsetof(), but takes a pointer to type instead of the type

It actually takes "a pointer to a variable of the type".  I had to
read the above twice to guess what is going on.

> + * @ptr is subject to multiple evaluation since we can't rely on TYPEOF()
> + */
> +#define OFFSETOF_VAR(ptr, member) \
> +	((uintptr_t)&(ptr)->member - (uintptr_t)(ptr))
> +

This unfortunately has funny interactions with using uninitialized
variables.  "make CC=clang config.o" gives something like this:

config.c:1944:50: error: variable 'entry' is uninitialized when used here
      [-Werror,-Wuninitialized]
        hashmap_for_each_entry(&cs->config_hash, &iter, entry,
                                                        ^~~~~
./hashmap.h:453:20: note: expanded from macro 'hashmap_for_each_entry'
                                                OFFSETOF_VAR(var, member)); \
                                                             ^~~
./git-compat-util.h:1346:16: note: expanded from macro 'OFFSETOF_VAR'
        ((uintptr_t)&(ptr)->member - (uintptr_t)(ptr))
                      ^~~
./hashmap.h:445:61: note: expanded from macro 'hashmap_iter_first_entry_offset'
        container_of_or_null_offset(hashmap_iter_first(map, iter), offset)
                                                                   ^~~~~~
config.c:1939:34: note: initialize the variable 'entry' to silence this warning
        struct config_set_element *entry;
                                        ^
                                         = NULL

Personally, I feel the workaround suggested by the compiler is just
as bogus as the warning itself X-<.  Casting NULL as if it were a
pointer to an object of type typeof(*ptr), treating it as if it is a
valid address, and doing raw address arith is just as bogus as doing
the same raw address arith on an uninitialized ptr, isn't it?

Anyway...
