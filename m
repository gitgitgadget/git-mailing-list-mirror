Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 34C411F404
	for <e@80x24.org>; Fri,  7 Sep 2018 04:17:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726032AbeIGI4F (ORCPT <rfc822;e@80x24.org>);
        Fri, 7 Sep 2018 04:56:05 -0400
Received: from mout.web.de ([212.227.17.12]:56741 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725948AbeIGI4E (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Sep 2018 04:56:04 -0400
Received: from localhost ([195.198.252.176]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MA5v3-1g8oMq3phB-00BIGh; Fri, 07
 Sep 2018 06:16:58 +0200
Date:   Fri, 7 Sep 2018 06:16:57 +0200
From:   Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
To:     Ben Peart <benpeart@microsoft.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        "gitster@pobox.com" <gitster@pobox.com>,
        "pclouds@gmail.com" <pclouds@gmail.com>,
        Ben Peart <Ben.Peart@microsoft.com>
Subject: Re: [PATCH v3 4/4] read-cache: speed up index load through
 parallelization
Message-ID: <20180907041657.GA12835@tor.lan>
References: <20180823154053.20212-1-benpeart@microsoft.com>
 <20180906210227.54368-1-benpeart@microsoft.com>
 <20180906210227.54368-5-benpeart@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180906210227.54368-5-benpeart@microsoft.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Provags-ID: V03:K1:EfseqpaVE0wKZfxe2Jdbx9y+oW/321n7rYsfUJKmOFPkAA0VAVj
 e5JkIy5xwp+I5bFnX3m4qllFzvYQAUvPYiJLLwabyvvBKJNzIFRaHMni+WVT1qTOhXpeIqy
 RLjisBiy3fuOlNrAldOoupDG6JdjK3x2I0/ME5g4gX9f8qVuvBv+MZptiLyNZoPqx9gZrsn
 S+ttXqc23JmNHDpNlezFw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:OT82Y8EMxs0=:G/g/1Bj2rYcPRUo3c9d/Fq
 +/IsTCAAv2R+tsEPbrxogGg5oSL56F4ZEfD4pRWnLajZpZeeF/qodkiF5ZbhkMl83cERqH+L1
 Hr2RfdxRlqsmVX7idSeea+9YFYrR9QreGtG+DvHlC1RVB1wY5ZuO1UJHPaW33g+I4IsMqdVuR
 nWSM81cKjGrdPFareZNz3WiYegNUYn3H1i2omPCn8SAlKhKzxdlXLkIUPzVSOFo+W1BmFXhKe
 LL2cy3B2zgkliQhZjHGuauICOiq3vFSfrErkQHVRQOHlLOCrWFlQ3/on0vyx2KqT/HNS5UThN
 LbGtUomLvP3I8yDy8dNftm+9cVZy0Z3pQBU6mZMFBNSDxOukSqbew1vuSaPZtXLu+qBxyY1+L
 ToYzWvaFdAxzYGybjVkXVC8d2bOnvY5sh6lxvAwo2aHkuQdgFvx+6zIhAxWHDp/Ga0z1QeU8P
 p2XmgaAXeXBP2AbwvWxnsUQehjWDwuG8yxf8k7zDoowt5uXlRktE9nxJrN5ny/vng4v2GhH5N
 467by3nJjygpyGSkkW2QAQGz6IJjQ67WChZvjitVN1CekWShzGbaNfS+aSvSonxcBbtTp5Uge
 Fin3RxyYtNUKIXNSbIZQJtnGKC+ebEsIuImOjeaOR/2hkkD2gQYuXJSVtjjAM1x65okSRZBpX
 d0OSYdyqvdlJ6rdhq0mkJv5/JwZ/FaOc1erG/I/6CGTef67ONY9MOtmv6FPZ3RBO/FqMwJlME
 ZLAxywifWjefO0pY9+XKyNtYH8xQJeGZFLdHQe/9umzBXgnGvi42e7fmE7s=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> diff --git a/read-cache.c b/read-cache.c
> index fcc776aaf0..8537a55750 100644
> --- a/read-cache.c
> +++ b/read-cache.c
> @@ -1941,20 +1941,212 @@ static void *load_index_extensions(void *_data)
>  	return NULL;
>  }
>  
> +/*
> + * A helper function that will load the specified range of cache entries
> + * from the memory mapped file and add them to the given index.
> + */
> +static unsigned long load_cache_entry_block(struct index_state *istate,
> +			struct mem_pool *ce_mem_pool, int offset, int nr, void *mmap,
> +			unsigned long start_offset, struct strbuf *previous_name)
> +{
> +	int i;
> +	unsigned long src_offset = start_offset;

I read an unsigned long here:
should that be a size_t instead ?

(And probably even everywhere else in this patch)

> +
> +	for (i = offset; i < offset + nr; i++) {
> +		struct ondisk_cache_entry *disk_ce;
> +		struct cache_entry *ce;
> +		unsigned long consumed;
> +
> +		disk_ce = (struct ondisk_cache_entry *)((char *)mmap + src_offset);
> +		ce = create_from_disk(ce_mem_pool, disk_ce, &consumed, previous_name);
> +		set_index_entry(istate, i, ce);
> +
> +		src_offset += consumed;
> +	}
> +	return src_offset - start_offset;
> +}
> +
> +static unsigned long load_all_cache_entries(struct index_state *istate,
> +			void *mmap, size_t mmap_size, unsigned long src_offset)
> +{
> +	struct strbuf previous_name_buf = STRBUF_INIT, *previous_name;
> +	unsigned long consumed;
> +
> +	if (istate->version == 4) {
> +		previous_name = &previous_name_buf;
> +		mem_pool_init(&istate->ce_mem_pool,
> +				estimate_cache_size_from_compressed(istate->cache_nr));
> +	} else {
> +		previous_name = NULL;
> +		mem_pool_init(&istate->ce_mem_pool,
> +				estimate_cache_size(mmap_size, istate->cache_nr));
> +	}
> +
> +	consumed = load_cache_entry_block(istate, istate->ce_mem_pool,
> +					0, istate->cache_nr, mmap, src_offset, previous_name);
> +	strbuf_release(&previous_name_buf);
> +	return consumed;
> +}
> +
> +#ifndef NO_PTHREADS
> +
