Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 456A5C433B4
	for <git@archiver.kernel.org>; Wed,  5 May 2021 00:31:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1296D613CD
	for <git@archiver.kernel.org>; Wed,  5 May 2021 00:31:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231441AbhEEAcD (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 May 2021 20:32:03 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:64549 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231434AbhEEAcD (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 May 2021 20:32:03 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 832D5126587;
        Tue,  4 May 2021 20:31:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=38MoY/uwmLbr936KHmzEC+pl9HVCLuGc4Nk/dN
        wUWi0=; b=ee3QYNZo5BU4xFUoOkRv27wgt0oR4swutVCHKOBdBRD4GMiEGdYklC
        VW2QljLXn4XfufFGm0nkxADOcU1Jrs8Y9Ua6vhXUcZ9HVCbQYUn+MvjonUCUYNN6
        oQjMR6DCMfRu6oW0kumUfI6ECEZJ7Xvn6GwsyyrPaxSdgGpSD7B5Y=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 7B10C126586;
        Tue,  4 May 2021 20:31:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id B0872126584;
        Tue,  4 May 2021 20:31:04 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH 1/2] patience diff: remove unnecessary string comparisons
References: <pull.948.git.1620120345.gitgitgadget@gmail.com>
        <a339d1cf9b9ffd6365fca3efda8fb7e10346dda4.1620120345.git.gitgitgadget@gmail.com>
Date:   Wed, 05 May 2021 09:31:02 +0900
In-Reply-To: <a339d1cf9b9ffd6365fca3efda8fb7e10346dda4.1620120345.git.gitgitgadget@gmail.com>
        (Phillip Wood via GitGitGadget's message of "Tue, 04 May 2021 09:25:44
        +0000")
Message-ID: <xmqqpmy658e1.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2D29DD48-AD39-11EB-B37B-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>
> xdl_prepare_env() calls xdl_classify_record() which arranges for the
> hashes of non-matching lines to be different so lines can be tested
> for equality by comparing just their hashes.

Hmph, that is a bit different from what I read from the comment in
the post context of the first hunk, though.

	/*
	 * After xdl_prepare_env() (or more precisely, due to
	 * xdl_classify_record()), the "ha" member of the records (AKA lines)
	 * is _not_ the hash anymore, but a linearized version of it.  In
	 * other words, the "ha" member is guaranteed to start with 0 and
	 * the second record's ha can only be 0 or 1, etc.
	 *
	 * So we multiply ha by 2 in the hope that the hashing was
	 * "unique enough".
	 */

The words "home" and "enough" hints to me that the "ha" member is
not hash, but "lineralized version of it" (whatever it means) does
not guarantee that two records with the same "ha" are identical, or
does it?

Well, I should just go read xdl_classify_record() to see what it
really does, but if it eliminates collisions, then the patch is a
clear and obvious improvement.

Thanks.

> diff --git a/xdiff/xpatience.c b/xdiff/xpatience.c
> index 20699a6f6054..db2d53e89cb0 100644
> --- a/xdiff/xpatience.c
> +++ b/xdiff/xpatience.c
> @@ -90,7 +90,7 @@ static void insert_record(xpparam_t const *xpp, int line, struct hashmap *map,
>  {
>  	xrecord_t **records = pass == 1 ?
>  		map->env->xdf1.recs : map->env->xdf2.recs;
> -	xrecord_t *record = records[line - 1], *other;
> +	xrecord_t *record = records[line - 1];
>  	/*
>  	 * After xdl_prepare_env() (or more precisely, due to
>  	 * xdl_classify_record()), the "ha" member of the records (AKA lines)
> @@ -104,11 +104,7 @@ static void insert_record(xpparam_t const *xpp, int line, struct hashmap *map,
>  	int index = (int)((record->ha << 1) % map->alloc);
>  
>  	while (map->entries[index].line1) {
> -		other = map->env->xdf1.recs[map->entries[index].line1 - 1];
> -		if (map->entries[index].hash != record->ha ||
> -				!xdl_recmatch(record->ptr, record->size,
> -					other->ptr, other->size,
> -					map->xpp->flags)) {
> +		if (map->entries[index].hash != record->ha) {
>  			if (++index >= map->alloc)
>  				index = 0;
>  			continue;
> @@ -253,8 +249,7 @@ static int match(struct hashmap *map, int line1, int line2)
>  {
>  	xrecord_t *record1 = map->env->xdf1.recs[line1 - 1];
>  	xrecord_t *record2 = map->env->xdf2.recs[line2 - 1];
> -	return xdl_recmatch(record1->ptr, record1->size,
> -		record2->ptr, record2->size, map->xpp->flags);
> +	return record1->ha == record2->ha;
>  }
>  
>  static int patience_diff(mmfile_t *file1, mmfile_t *file2,
