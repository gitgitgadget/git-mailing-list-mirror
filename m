Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66DBCC433EF
	for <git@archiver.kernel.org>; Fri, 10 Jun 2022 21:33:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348761AbiFJVdS (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Jun 2022 17:33:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243046AbiFJVdQ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Jun 2022 17:33:16 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD9FAD5F
        for <git@vger.kernel.org>; Fri, 10 Jun 2022 14:33:12 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id C3E67193732;
        Fri, 10 Jun 2022 17:33:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=VJ0lAR6Kkm2v
        HJu1x+CQIPE2F2nlWdfTzOkmA22XLpc=; b=MZT+AxTbkLnUHkVZi68xrB+hkC6g
        qWVwQFB6hw0Rh2PoELwFlIEPQPsuv/duS5f/cKhIGp+SC4rkJcH/Kg2NJCoNxrVd
        Wfb64DEX1vzSTV1AyrIdO8nKoKYPEgbjPgXvVvThyFSP7Ji4KhJ9/EvQMF01W6zK
        RNMvSCkSMONiR20=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id BBA05193730;
        Fri, 10 Jun 2022 17:33:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.92.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 64F7019372C;
        Fri, 10 Jun 2022 17:33:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     Han Xin <chiyutianyi@gmail.com>, avarab@gmail.com,
        git@vger.kernel.org, neerajsi@microsoft.com, newren@gmail.com,
        philipoakley@iee.email, stolee@gmail.com, worldhello.net@gmail.com,
        Neeraj Singh <nksingh85@gmail.com>
Subject: Re: [PATCH v14 2/7] object-file.c: do fsync() and close() before
 post-write die()
References: <cover-v13-0.7-00000000000-20220604T095113Z-avarab@gmail.com>
        <cover.1654871915.git.chiyutianyi@gmail.com>
        <a327f484f7f7466597930e87686e7156beabdc45.1654871916.git.chiyutianyi@gmail.com>
        <0b9bc499-18c7-e8ab-5c89-f9e1a98685bc@web.de>
Date:   Fri, 10 Jun 2022 14:33:07 -0700
In-Reply-To: <0b9bc499-18c7-e8ab-5c89-f9e1a98685bc@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
        message of "Fri, 10 Jun 2022 23:10:17 +0200")
Message-ID: <xmqqczfgcigc.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: EBA61ACC-E904-11EC-980D-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ren=C3=A9 Scharfe <l.s.r@web.de> writes:

> Am 10.06.22 um 16:46 schrieb Han Xin:
>> From: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
>>
>> Change write_loose_object() to do an fsync() and close() before the
>> oideq() sanity check at the end. This change re-joins code that was
>> split up by the die() sanity check added in 748af44c63e (sha1_file: be
>> paranoid when creating loose objects, 2010-02-21).
>>
>> I don't think that this change matters in itself, if we called die()
>> it was possible that our data wouldn't fully make it to disk, but in
>> any case we were writing data that we'd consider corrupted. It's
>> possible that a subsequent "git fsck" will be less confused now.
>
> This is done before renaming the file, so git fsck is going to see (at
> most) a tmp_obj_?????? file, which it ignores in either case, right?

Yes, I thought I pointed that out in my review on the previous
round, but I missed that it was still here in this round X-<.

Thanks for noticing.

