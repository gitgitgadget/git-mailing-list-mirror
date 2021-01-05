Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5605C433E0
	for <git@archiver.kernel.org>; Tue,  5 Jan 2021 12:06:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6A40A22AAA
	for <git@archiver.kernel.org>; Tue,  5 Jan 2021 12:06:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726794AbhAEMGL (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 5 Jan 2021 07:06:11 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:54269 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725824AbhAEMGK (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Jan 2021 07:06:10 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 430F5108E42;
        Tue,  5 Jan 2021 07:05:27 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type
        :content-transfer-encoding; s=sasl; bh=Q+usUCVhWpouCCyh9wiQMvTL+
        dc=; b=iojfRZlUTNGT3nlBKZKMaRhlA7BJMAA8H31yM99nkxziZRsm0ykpe2x6u
        LPf7OqlYmaqBEpZf5074cGxOBtRpFKmfTyULXT9cRSV5cxjl7whMQm27WVlc2t0s
        xr/ykHT2eXL5gKgjoMgmZUGGW2cqHoqsTVKyij0FV64SV2pLN0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type
        :content-transfer-encoding; q=dns; s=sasl; b=vQZ8UW6ZAQSqKkta+dh
        xYlJu4SuS2QwONOVdrPuZ75ub0Xa5xXkmLl7FRICu7tKuyz2ot52W0fDsMAMB0Tk
        qI6hftKVUGriP1JUPOe8Fwz5m7nO/qd96s7gpxKGKlYKCE+q6oDJIPNYrk102/hV
        wbbwL4gVbWuD7ttgNQlhzwCU=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 3B920108E41;
        Tue,  5 Jan 2021 07:05:27 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 66E7D108E40;
        Tue,  5 Jan 2021 07:05:24 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     Derrick Stolee <stolee@gmail.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, newren@gmail.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH] cache-tree: use ce_namelen() instead of strlen()
References: <pull.829.git.1609356413.gitgitgadget@gmail.com>
        <20ea7050324cdd78b0966f54366b26224dfc7814.1609356414.git.gitgitgadget@gmail.com>
        <daeb59ee-861d-9c8d-3601-6aef1ac3fc94@web.de>
        <3ed37ae6-1f09-bd6b-c9d9-c8089da1af92@gmail.com>
        <a8b5bb13-5c88-d744-b47e-7204e12ad05d@web.de>
Date:   Tue, 05 Jan 2021 04:05:22 -0800
Message-ID: <xmqqlfd7zj0d.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 4AB5C5F0-4F4E-11EB-BC85-E43E2BB96649-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ren=C3=A9 Scharfe <l.s.r@web.de> writes:

> Use the name length field of cache entries instead of calculating its
> value anew.
>
> Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
> ---
> Not sure why it took me so long to spot this.. o_O

That probably is because this does not cause behaviour change.

It used to be that use of ce_namelen() was more important in
learning the length of the string before 7a51ed66 (Make on-disk
index representation separate from in-core one, 2008-01-14) and
7fec10b7 (index: be careful when handling long names, 2008-01-18).
The on-disk field to store the name length has only 12 bits, and
before b60e188c (Strip namelen out of ce_flags into a ce_namelen
field, 2012-07-11), the convention to learn the length of the name
of an in-core cache entry was to see the field and then if it fully
occupies the full 12-bit field, ask the name string itself its
length with strlen().

These days, ce->namelen is a separate field that always gives the
full length after the on-disk index is read, so with this change,
you won't be running strlen() in this part of the function even with
an entry with a long pathname.

>
>  cache-tree.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
>
> diff --git a/cache-tree.c b/cache-tree.c
> index a537a806c1..57cacab195 100644
> --- a/cache-tree.c
> +++ b/cache-tree.c
> @@ -185,10 +185,12 @@ static int verify_cache(struct cache_entry **cach=
e,
>  		 * the cache is sorted.  Also path can appear only once,
>  		 * which means conflicting one would immediately follow.
>  		 */
> -		const char *this_name =3D cache[i]->name;
> -		const char *next_name =3D cache[i+1]->name;
> -		int this_len =3D strlen(this_name);
> -		if (this_len < strlen(next_name) &&
> +		const struct cache_entry *this_ce =3D cache[i];
> +		const struct cache_entry *next_ce =3D cache[i + 1];
> +		const char *this_name =3D this_ce->name;
> +		const char *next_name =3D next_ce->name;
> +		int this_len =3D ce_namelen(this_ce);
> +		if (this_len < ce_namelen(next_ce) &&
>  		    strncmp(this_name, next_name, this_len) =3D=3D 0 &&
>  		    next_name[this_len] =3D=3D '/') {
>  			if (10 < ++funny) {
> --
> 2.30.0
