Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE69AC43334
	for <git@archiver.kernel.org>; Tue,  5 Jul 2022 18:24:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230220AbiGESYA (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 5 Jul 2022 14:24:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229789AbiGESX6 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Jul 2022 14:23:58 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 433CE15FE6
        for <git@vger.kernel.org>; Tue,  5 Jul 2022 11:23:57 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B8F91135840;
        Tue,  5 Jul 2022 14:23:53 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=VfwN05VIXRqbs+zVrm1GAMi7s2lYiB1tEhyh9B
        YnLXw=; b=o5ThxKD0/D5zeVKdsROIKR4ukm4xRMK/E1BjxwegDqd8b01/r0xpVM
        45ZR3/uiME8L3eqMMQAZajB5utmS04MGvZmMjddXgPGQUTQSjRbcQ4Q5thclYy48
        WZOqpNCIXOD2BkpCH2jCeSmE84XbeZOBuydECvMNU1ymXxyIhBtQI=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B0C6913583F;
        Tue,  5 Jul 2022 14:23:53 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.92.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 247EF13583E;
        Tue,  5 Jul 2022 14:23:53 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Teng Long <dyroneteng@gmail.com>
Cc:     avarab@gmail.com, derrickstolee@github.com, git@jeffhostetler.com,
        git@vger.kernel.org, me@ttaylorr.com, tenglong.tl@alibaba-inc.com
Subject: Re: [PATCH v5 3/5] pack-bitmap.c: using error() instead of silently
 returning -1
References: <xmqqmtdwk6li.fsf@gitster.g>
        <20220705090454.10686-1-dyroneteng@gmail.com>
Date:   Tue, 05 Jul 2022 11:23:52 -0700
In-Reply-To: <20220705090454.10686-1-dyroneteng@gmail.com> (Teng Long's
        message of "Tue, 5 Jul 2022 17:04:54 +0800")
Message-ID: <xmqq8rp7ju4n.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9FB65A5C-FC8F-11EC-8938-CB998F0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Teng Long <dyroneteng@gmail.com> writes:

> It's more accurate here with your suggestion. At the same time I
> found there actually exists many similar place like "ignore ENOENT
> silently" in repo. And I think it's not worth to impove them right now
> in this patch, if you want to do that it could in another pathset and
> please tell me.

It is sufficien to just mark it as #leftoverbits to find and fix
places where the code means to ignore only a missing optional file
but ignores all other errors it gets from open/fopen instead.

>> > @@ -394,7 +394,7 @@ static int open_pack_bitmap_1(struct bitmap_index *bitmap_git, struct packed_git
>> >
>> >  	if (!is_pack_valid(packfile)) {
>> >  		close(fd);
>> > -		return -1;
>> > +		return error(_("packfile is invalid"));
>>
>> Same "sometimes redundant" comment applies here, but not due to this
>> part of the code but due to the helpers called from is_pack_valid().
>
> Let me try to know about it, the "helpers" means the place where invoke
> is_pack_valid() like here. In fact, in is_pack_valid() they already
> return the errors in various scenarios, so it would be no need to
> return another error.

Yup.  is_pack_valid() calls open_packed_git() and the helper
functions that are called from that call chain are full of calls to
error() that tell specifically what exactly went wrong.  But ...

>> Namely, packfile.c::open_packed_git_1() is mostly chatty, but is
>> silent upon "unable to open" and "unable to fstat" (which I think is
>> safe to make chatty as well---we do not want to special case ENOENT
>> in open_packed_git(), so "cannot open because it is not there" is an
>> error).

... the error coverage is not complete.  There are some (rare) code
paths that silently "return -1", not "return error(_("..."))".  They
should be updated to say something; otherwise we will silently fail
in these "rare" codepaths.

> "cannot open because it is not there" is an error, but I think it will
> also could be a BUG, actually I'm not very sure for clarify the
> difference bwtween the use of the two, but I will look into it to dig
> something out.

The code may have many reasons to believe that a file should exist
there and try to open it, but it may find the file missing, but I
would suspect that it is never a BUG.  You may have run stat() on
the path earlier and you know it existed, but by the time you try to
open it, some other process may have removed it.  You may have found
the .idx file and expect that the corresponding .pack file to exist,
but the .pack file may be missing.  You may have just written a file
and you expect to be able to open it, but some other process may
have removed it already, or you may have run out of file descriptors
and cannot open it.  These are all runtime errors that deserve to be
reported via error() or die(), but never BUG().

Thanks.
