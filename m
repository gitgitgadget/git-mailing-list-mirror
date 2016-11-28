Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C99F71FBB0
	for <e@80x24.org>; Mon, 28 Nov 2016 18:42:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752859AbcK1SmH (ORCPT <rfc822;e@80x24.org>);
        Mon, 28 Nov 2016 13:42:07 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:62520 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750971AbcK1SmF (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Nov 2016 13:42:05 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 4BE5352DE8;
        Mon, 28 Nov 2016 13:42:04 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=hLU9Xp2M/1fkRGHj+M2l/MzaVqo=; b=IVenSQ
        /sPkwt8dS3g3WRKTOefx60iRkyE2ULtghbHmP6L1BCKBn3FZyIYqVYGYQ+q+x57d
        MIHJ44NiZFMQBu8P3nnlMbnCDMqsyZhd0eJRQWgfIBkAyQsk5jtrrIG0gfFIsDJc
        kctW3l8tYiOqiJgJhS2YZK8sFK8W1hnzh5hKM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=hjm/Vwvn3DYlzaddsBQhPCsjKePfowZo
        5bYUq51wtUutM67jjPQzqBlUYinXA/sP7RPcu6ghP9X4lYJbIUckuVK6FRS1ox/R
        4AR/InosW+2XaES0TLR+fdsb35q8lwH2yMdAvicoINpQzhew/qntrgxzDGveDF92
        zeyfvMa0JHw=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 4466352DE7;
        Mon, 28 Nov 2016 13:42:04 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id B90C452DE4;
        Mon, 28 Nov 2016 13:42:03 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org, Markus Klein <markus.klein@reelworx.at>
Subject: Re: [PATCH v2 2/2] Avoid a segmentation fault with renaming merges
References: <cover.1480091758.git.johannes.schindelin@gmx.de>
        <cover.1480164459.git.johannes.schindelin@gmx.de>
        <d1571a25e8f3860a2867b00994d4d6938aa602ec.1480164459.git.johannes.schindelin@gmx.de>
        <alpine.DEB.2.20.1611261348420.117539@virtualbox>
Date:   Mon, 28 Nov 2016 10:42:02 -0800
In-Reply-To: <alpine.DEB.2.20.1611261348420.117539@virtualbox> (Johannes
        Schindelin's message of "Sat, 26 Nov 2016 13:53:09 +0100 (CET)")
Message-ID: <xmqqmvgjjvk5.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5B003D02-B59A-11E6-9008-E98412518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> On Sat, 26 Nov 2016, Johannes Schindelin wrote:
>
>> diff --git a/merge-recursive.c b/merge-recursive.c
>> index 9041c2f149..609061f58a 100644
>> --- a/merge-recursive.c
>> +++ b/merge-recursive.c
>> @@ -235,6 +235,8 @@ static int add_cacheinfo(struct merge_options *o,
>>  		struct cache_entry *nce;
>>  
>>  		nce = refresh_cache_entry(ce, CE_MATCH_REFRESH | CE_MATCH_IGNORE_MISSING);
>> +		if (!nce)
>> +			return err(o, _("addinfo: '%s' is not up-to-date"), path);
>>  		if (nce != ce)
>>  			ret = add_cache_entry(nce, options);
>>  	}
>
> BTW I was not quite sure why we need to refresh the cache entry here, and
> 1335d76e45 (merge: avoid "safer crlf" during recording of merge results,
> 2016-07-08) has a commit message for which I need some time to wrap my
> head around.

This callsite used to call make_cache_entry() with CE_MATCH_REFRESH,
which creates a new cache entry, calls refresh_cache_ent, and
returns the cache entry"; the log message attempts to explain why we
avoid passing CE_MATCH_REFRESH and instead first add it as a merged
entry and then refresh it (and re-add it if ce got changed).  We
used to leave the old (possibly conflicted) entries for the same
path in the index while refreshing the new cache entry, which has
correctly converted result, and the old entries got in the way,
attempting a wrong eol conversion and declaring that the new entry
out-of-date.  By adding the correctly converted result as a merged
entry, which gets rid of the old entries, the refresh operation will
not be corrupted by them.

> Also, an error here may be overkill. Maybe we should simply change the "if
> (nce != ce)" to an "if (nce && nce != ce)" here, as a locally-modified
> file will give a nicer message later, anyway.

Looking at the commit you blamed, what happened in this case before
that change was that

 (1) make_cache_entry() would have called refresh_cache_entry() with
     CE_MATCH_REFRESH and returned a NULL;

 (2) merge-recursive.c::add_cacheinfo() noticed NULL and did

     return error(_("addinfo_cache failed for path '%s'"), path)

But the updated code forgot that refresh_cache_entry() could return
NULL.  So 1335d76e45 ("merge: avoid "safer crlf" during recording of
merge results", 2016-07-08) was not a faithful rewrite.

So I agree that your patch is the right fix; using the old message
lost by mistake in 1335d76e45 may have made it more clear that this
is a fix for a misconversion in that commit, though.

In any case, this does not seem like a new regression (1/2 applied
on v2.10.0 dies the same way), so I am inclined to queue these two
but not ship in the upcoming release for now.

Thanks.

