Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62802C433F5
	for <git@archiver.kernel.org>; Tue, 26 Apr 2022 15:27:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352241AbiDZPaG (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 26 Apr 2022 11:30:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236449AbiDZPaF (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Apr 2022 11:30:05 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EACDAE4E
        for <git@vger.kernel.org>; Tue, 26 Apr 2022 08:26:53 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 62170124E18;
        Tue, 26 Apr 2022 11:26:52 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ODUwg7IeN1lpo2y8o42UVc1XN7u9gA1XjsoTGF
        Mp2Bg=; b=IeHd/7pJTEEb5+CcdEs/NTyKDWtwDJRElS7fPqPrqvj4HZjDp5ZIRe
        HGvMFT88K9mmR+j1oWobcVi8L/HNVys+Aq7X5tMtBg9xTdPL8Wg3pJ2NIjWQn4S+
        0L2ikrH+rrKFIRv9Musetu1wurwYDTjW0gnaAZ/ljW9Vr8KMV3hDg=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 58572124E17;
        Tue, 26 Apr 2022 11:26:52 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.105.84.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id C3615124E16;
        Tue, 26 Apr 2022 11:26:51 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Phillip Wood <phillip.wood123@gmail.com>
Cc:     git@vger.kernel.org,
        Matthias =?utf-8?Q?A=C3=9Fhauer?= <mha1993@live.de>,
        =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH] 2.36 gitk/diff-tree --stdin regression fix
References: <xmqqh76j3i3r.fsf@gitster.g> <xmqqbkwpvyyc.fsf@gitster.g>
        <83a76d46-5069-d6c7-b8b3-f3a063637abb@gmail.com>
        <6ac7e164-c4ba-0ffc-a8a4-4cede1d4e7ae@gmail.com>
Date:   Tue, 26 Apr 2022 08:26:50 -0700
In-Reply-To: <6ac7e164-c4ba-0ffc-a8a4-4cede1d4e7ae@gmail.com> (Phillip Wood's
        message of "Tue, 26 Apr 2022 14:45:58 +0100")
Message-ID: <xmqqo80nsw5h.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4BFA62EC-C575-11EC-AA92-CB998F0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I wonder if we would have caught a regression like the one if we
used FREE_AND_NULL more sparingly.  For example, if we prematurely
called clear_pathspec(), the second iteration, because there is
free-and-null of pathspec->items and resetting pathspec->nr to 0,
would behave very normally as if there is no pathspec.  If we just
freed things, without NULLing them out or resetting .nr to 0, the
second iteration would try to access garbage and hopefully we will
catch a crash before such a code would have escaped the lab.

In any case, based on what I heard here, it appears that mimicking
"git log" does may probably be a better way to deal with this
regression?  As you said, all the other things diff_free() calls are
unwanted while "diff-tree --stdin" is still working, just like
"log"?

Thanks.

