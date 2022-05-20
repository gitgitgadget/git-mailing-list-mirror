Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E54CC433FE
	for <git@archiver.kernel.org>; Fri, 20 May 2022 20:42:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353515AbiETUl6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 20 May 2022 16:41:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353545AbiETUl4 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 May 2022 16:41:56 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E4341912C7
        for <git@vger.kernel.org>; Fri, 20 May 2022 13:41:54 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 8851019CD98;
        Fri, 20 May 2022 16:41:53 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=jLd9FAfMCC2/HsL6hhn/yKuDdOf0aSnLnedaeW
        O5M/g=; b=jXAVSf+Hxc0QkdvYrFl8o18vggU1xlW4M+FR85IrC4H+TmM+J1YNo+
        kIOqELN1/Ovr5/0AIZ+Fu9lYM21R4eHNoCBwWul/Vy2CGdHq0JJerg94Z6Wkpihf
        c5JDespcDcID1E1Oc/4gGLhC61Hg/sXCniStFDVmfpKE2zowEPpWY=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 80A3919CD97;
        Fri, 20 May 2022 16:41:53 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.247.111.240])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 31C7219CD96;
        Fri, 20 May 2022 16:41:50 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Victoria Dye via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Victoria Dye <vdye@github.com>
Subject: Re: [PATCH] repack: respect --keep-pack with geometric repack
References: <pull.1235.git.1653064572170.gitgitgadget@gmail.com>
        <YofJLv8+x5J7yPmf@nand.local>
Date:   Fri, 20 May 2022 13:41:49 -0700
In-Reply-To: <YofJLv8+x5J7yPmf@nand.local> (Taylor Blau's message of "Fri, 20
        May 2022 13:00:30 -0400")
Message-ID: <xmqqr14oey2a.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4637AE12-D87D-11EC-9B0B-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

>>  	*geometry_p = xcalloc(1, sizeof(struct pack_geometry));
>>  	geometry = *geometry_p;
>>
>> +	string_list_sort(existing_kept_packs);
>
> Would it be worth sorting this as early as in collect_pack_filenames()?
> For our purposes in this patch, this works as-is, but it may be
> defensive to try and minimize the time that list has unsorted contents.

It does not matter too much but after reading the latest one before
coming back to this original thread, I actually thought that sorting
it too early was questionable.  Nobody other than this code cares
about the list being sorted, and if it turns out that the look-up in
the loop need to be optimized, it is plausible that we do not need
this list sorted when we populate a hashmap out of its contents, for
example.

>>  	for (p = get_all_packs(the_repository); p; p = p->next) {
>> -		if (!pack_kept_objects && p->pack_keep)
>> -			continue;
>> +		if (!pack_kept_objects) {
>> +			if (p->pack_keep)
>> +				continue;
>
> (You mentioned this to me off-list, but I'll repeat it here since it
> wasn't obvious to me on first read): this check for `p->pack_keep` isn't
> strictly necessary, since any packs that have their `pack_keep` bit set
> will appear in the `existing_kept_packs` list.
>
> But it does give us a fast path to avoid having to check that list, so
> it's worth checking that bit to avoid a slightly more expensive check
> where possible.

That invites a related but different question.  Doesn't p->pack_keep
and string_list_has_string(existing_kept_packs, name_of_pack(p))
mirror each other?  Can a pack appear on the existing_kept_packs
list without having .pack_keep bit set and under what condition?

It is answered by the comment below, I presume?

>> +			/*
>> +			 * The pack may be kept via the --keep-pack option;
>> +			 * check 'existing_kept_packs' to determine whether to
>> +			 * ignore it.
>> +			 */

OK.  So there are two classes of packs we want to exclude from the
geometry repacking.  Those that already have .pack_keep bit set, and
those that are _are_ newly making into kept packs that do not yet
have .pack_keep bit set.  Makes sense.

