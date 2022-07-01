Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EDD0C43334
	for <git@archiver.kernel.org>; Fri,  1 Jul 2022 18:58:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231724AbiGAS66 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 1 Jul 2022 14:58:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231273AbiGAS65 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Jul 2022 14:58:57 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACC3F21E13
        for <git@vger.kernel.org>; Fri,  1 Jul 2022 11:58:55 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 7369513D147;
        Fri,  1 Jul 2022 14:58:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=JX/m0CymCZfP
        QAlnloGouwtxegJ/NxjTnYIc7lAnlko=; b=uOQV/Dk3d/2nnf3pGb+t6YtqqhEC
        yQdO6KGDM23s58Fv5bDOwLoObjrFNuJ0/KaZZRVZ16MietDTBBDh72CUkuzLV6a2
        sH9hch3nJGyDplBwiTRMrp1uKcUIAs+O5PKt8185T/eN9DuSnfNUP5111vQWnhkt
        GeZu4dn1rUu5ooQ=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 69A3713D146;
        Fri,  1 Jul 2022 14:58:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id C9CA813D144;
        Fri,  1 Jul 2022 14:58:53 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 00/11] built-ins: fix common memory leaks
References: <cover-00.11-00000000000-20220630T175714Z-avarab@gmail.com>
        <cover-v2-00.11-00000000000-20220701T104017Z-avarab@gmail.com>
Date:   Fri, 01 Jul 2022 11:58:52 -0700
In-Reply-To: <cover-v2-00.11-00000000000-20220701T104017Z-avarab@gmail.com>
        (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Fri, 1 Jul
 2022 12:42:49
        +0200")
Message-ID: <xmqqh7408xsj.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: DA287508-F96F-11EC-89AF-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

>  * Replace 8/11, maybe that solution is going overboard, we could also
>    just drop it from this series...

The "solution" part is to forbid merge_working_tree() to use
anything that relies on the topts before it bails out due to
unmerged_cache(), that could be done with only a minor reordering of
the logic.

And I think that is a reasonable thing to do---if we are looking at
an unmerged index, we would not want to run unpack-trees on it at
all, so setting up the topts structure does not make much sense
before we fully know we cannot bail out early.

On the other hand, it does make the patch go near overboard to
extract the topt initialization logic for this single user into a
static helper function.  If we later find out that my "that is a
reasonable thing to do" above is not true, or some setting of topts
members need to become conditional, we would probably need to undo
that part of this patch.

The latter "going overboard" part is the majority of change.  We
definitely should *not* discard the essence of this step to stop
leaking, but should think about stopping at the smaller change,
perhaps?

Having said that, all the other patches in the series looked good.

Thanks, will queue.

