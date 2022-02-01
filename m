Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65575C433F5
	for <git@archiver.kernel.org>; Tue,  1 Feb 2022 17:58:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235079AbiBAR6g (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Feb 2022 12:58:36 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:54647 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235063AbiBAR6f (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Feb 2022 12:58:35 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 1A2C417385C;
        Tue,  1 Feb 2022 12:58:35 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=rwocWaFmpsSL/LJYctZ7Z1ZKvG1YorbNLOPDK6
        4NfS0=; b=twSfZluW/D1Lf2PlZIh+kstujh8SQbIo0cSnRZoyZIcyulA88f+qOt
        8Wasy1aMSeWLNPPKEItY7nDCAvvGobSF901BJ1MpU3X3obQWC1lvgyhU4UcSqGzw
        NJHvFIt8LPdZZ2aawYbjKY05Kb5mGAL1wTOpbue2wf7PTOD1n3jPo=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 12EE717385B;
        Tue,  1 Feb 2022 12:58:35 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 8483417385A;
        Tue,  1 Feb 2022 12:58:32 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     =?utf-8?Q?Jean-No=C3=ABl?= Avila via GitGitGadget 
        <gitgitgadget@gmail.com>, git@vger.kernel.org,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?utf-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>
Subject: Re: [PATCH v4 1/4] i18n: factorize more 'incompatible options'
 messages
References: <pull.1123.v3.git.1643580113.gitgitgadget@gmail.com>
        <pull.1123.v4.git.1643666870.gitgitgadget@gmail.com>
        <2eac2ef502b86d0c15513c8d0e69928ce2140b1f.1643666870.git.gitgitgadget@gmail.com>
        <xmqqv8xzh6iw.fsf@gitster.g>
        <f8202cc7-be5c-5efa-2a3b-987114356c6b@kdbg.org>
Date:   Tue, 01 Feb 2022 09:58:31 -0800
In-Reply-To: <f8202cc7-be5c-5efa-2a3b-987114356c6b@kdbg.org> (Johannes Sixt's
        message of "Tue, 1 Feb 2022 08:01:30 +0100")
Message-ID: <xmqqee4mfozc.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 91BDEC92-8388-11EC-A0F2-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Sixt <j6t@kdbg.org> writes:

>> Otherwise make it "static inline"?  Or just
>> 
>> #define die_for_incompatible_opt3(o1,n1,o2,n2,o3,n3) \
>> 	die_for_incompatible_opt4((o1), (n1), \
>> 				  (o2), (n2), \
>> 				  (o3), (n3), \
>> 				  0, "")
>> 
>> perhaps?
>
> Please no macros where they are not a clear advantage. Make it a
> function, either static inline, or out-of-line (the latter would be my
> personal preference in this case because the function is not called in a
> hot path).

In this particular case, my personal preference is actually a macro,
since 

 * there is no type safety lost

 * I find that it make it the most clear that 

   - the opt3 variant is a mere convenience wrapper, which does not
     even deserve an entry in the symbol table, of the real thing, and

   - our intention is to keep them closely in sync by not even
     giving future developers a pair of { braces }, in which they
     are tempted into writing extra code before or after calling the
     opt4 variant and make them diverge.

But it is not very strong preference.

A "static inline" wrapper would result in the same code as a macro,
and I'd be almost equally happy with it.  The code is almost already
written, and fixing it is just a matter of inserting "static " in
front.  My preference between "static inline" and macro is not
strong enough to insist on rewriting ;-)

An out-of-line wrapper has a slight disadvantage that it is not
immediately obvious that one is a mere wrapper of the other thing by
just looking at what is in the *.h file, but I am OK with it as
well.  If the original patch were written as an out-of-line wrapper,
my preference is not strong enough to insist on rewriting, either.

Thanks.
