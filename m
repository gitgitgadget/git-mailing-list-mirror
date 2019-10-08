Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7F7441F4BD
	for <e@80x24.org>; Tue,  8 Oct 2019 21:03:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731078AbfJHVDi (ORCPT <rfc822;e@80x24.org>);
        Tue, 8 Oct 2019 17:03:38 -0400
Received: from bsmtp.bon.at ([213.33.87.14]:10174 "EHLO bsmtp.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731069AbfJHVDi (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Oct 2019 17:03:38 -0400
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp.bon.at (Postfix) with ESMTPSA id 46nqZc3905z5tl9;
        Tue,  8 Oct 2019 23:03:36 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id A5E734AC8;
        Tue,  8 Oct 2019 23:03:35 +0200 (CEST)
Subject: Re: [PATCH 1/1] Add a helper to reverse index_pos_to_insert_pos()
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>
References: <pull.378.git.gitgitgadget@gmail.com>
 <81648344bbab4219c0bfc60d1e5f02473ea7d495.1570517329.git.gitgitgadget@gmail.com>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <75a9c7ce-893c-6341-ba8d-eed3ccba7ee3@kdbg.org>
Date:   Tue, 8 Oct 2019 23:03:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <81648344bbab4219c0bfc60d1e5f02473ea7d495.1570517329.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 08.10.19 um 08:48 schrieb Johannes Schindelin via GitGitGadget:
> We have just introduced the helper `index_pos_to_insert_pos()` to help
> avoiding underflows when returning `-1 - pos` for cases where we want to
> return an insert position, using the ones' complement (as `int`).

We do not want to have it for *all* cases, where we return -1 - pos, but
only for those cases, where the result was actually encoded by
index_pos_to_insert_pos(). That excludes all cases where the argument is
derived from index_name_pos(), and leaves just...

> --- a/rerere.c
> +++ b/rerere.c
> @@ -154,7 +154,7 @@ static struct rerere_dir *find_rerere_dir(const char *hex)
>  		rr_dir->status = NULL;
>  		rr_dir->status_nr = 0;
>  		rr_dir->status_alloc = 0;
> -		pos = -1 - pos;
> +		pos = insert_pos_to_index_pos(pos);

... this one...

>  
>  		/* Make sure the array is big enough ... */
>  		ALLOC_GROW(rerere_dir, rerere_dir_nr + 1, rerere_dir_alloc);
> diff --git a/sha1-name.c b/sha1-name.c
> index 49855ad24f..bee7ce39ee 100644
> --- a/sha1-name.c
> +++ b/sha1-name.c
> @@ -98,7 +98,7 @@ static void find_short_object_filename(struct disambiguate_state *ds)
>  		loose_objects = odb_loose_cache(odb, &ds->bin_pfx);
>  		pos = oid_array_lookup(loose_objects, &ds->bin_pfx);
>  		if (pos < 0)
> -			pos = -1 - pos;
> +			pos = insert_pos_to_index_pos(pos);

... and this one.

>  		while (!ds->ambiguous && pos < loose_objects->nr) {
>  			const struct object_id *oid;
>  			oid = loose_objects->oid + pos;

-- Hannes
