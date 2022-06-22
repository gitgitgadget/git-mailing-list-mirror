Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3D7BC43334
	for <git@archiver.kernel.org>; Wed, 22 Jun 2022 19:58:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359667AbiFVT6t (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Jun 2022 15:58:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347203AbiFVT6s (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Jun 2022 15:58:48 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 507A52F64D
        for <git@vger.kernel.org>; Wed, 22 Jun 2022 12:58:47 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id D1B471AD453;
        Wed, 22 Jun 2022 15:58:46 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ChMTDM/tqdIjhw4aMnj87SRi1OIKVuWNgjNLZ3
        afKx8=; b=BMjJxG6906Or4ijcNcYibBBrXi9tXScOKkTMQXikxBjzMp+ZzbTYcQ
        HYjUum7y9x4nPHkJM51AFErvg6NuBZLCTVI2qt7YyArU721rmG+x6XPrlwYitB1y
        TjVcTtvl0alD8YiEc6rU2A/bHOWOuq9Hlc3Hn0oA6WDyLCUtfmuwk=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id C8CD51AD452;
        Wed, 22 Jun 2022 15:58:46 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 6F7401AD44D;
        Wed, 22 Jun 2022 15:58:43 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        haoyurenzhuxia@gmail.com, git@vger.kernel.org,
        derrickstolee@github.com, dyroneteng@gmail.com
Subject: Re: [RFC PATCH] midx.c: clean up .rev file
References: <20220622115014.53754-1-haoyurenzhuxia@gmail.com>
        <220622.86a6a4lmdv.gmgdl@evledraar.gmail.com>
        <xmqqo7yk60vf.fsf@gitster.g> <YrNb2x2/7Z31XnFJ@nand.local>
Date:   Wed, 22 Jun 2022 12:58:42 -0700
In-Reply-To: <YrNb2x2/7Z31XnFJ@nand.local> (Taylor Blau's message of "Wed, 22
        Jun 2022 14:13:47 -0400")
Message-ID: <xmqqtu8c31xp.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B806CDF0-F265-11EC-96FB-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

>   - the MIDX file itself is written using a lock_file, so it is
>     atomically moved into place, and the temporary file is either
>     removed, or cleaned up automatically with a sigchain handler on
>     process death

Good.

>   - the bitmap (written in bitmap_writer_finish(), which is the path for
>     both single- and multi-pack bitmaps) is written to a temporary file
>     and moved into place after the bitmaps are written.
>
>     ...but this temporary file isn't automatically cleaned up, so it
>     could stick around after process death. Luckily the race window here
>     is pretty small, since all of the bitmaps have been computed already
>     and are held in memory.
>
>     This is probably worth a cleanup on its own, too.

As long as the "temporary file" is clearly a temporary file that
"gc" can recognize and get rid of, it would be OK, I would think.

>   - unless GIT_TEST_MIDX_WRITE_REV=1 is in your environment, we won't
>     *write* a .rev file, hence this is pretty rare to deal with in
>     practice.

OK, but if we were to write one, we should do the same "write into a
temporary, rename it in place" dance, right?  Or is a separate .rev
file is pretty much a thing of last decade that we do not have to
worry too much about?

> So I think there are two things worth doing here:
>
>   - make sure that the temporary file used to stage the .bitmap is a
>     lock_file

Yes.

>   - use a temporary file to stage the .rev file (when forced to write
>     one), and ensure that that too is a lock_file

Yes.

Thanks.
