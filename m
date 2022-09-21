Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB740ECAAD8
	for <git@archiver.kernel.org>; Wed, 21 Sep 2022 16:59:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229992AbiIUQ7Q (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 21 Sep 2022 12:59:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232621AbiIUQ64 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Sep 2022 12:58:56 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46685B90
        for <git@vger.kernel.org>; Wed, 21 Sep 2022 09:58:55 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 6F2F11519E4;
        Wed, 21 Sep 2022 12:58:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=GyZoWMf5oGXE8wxdKT2Msh9kf/I5sEGho3u8W0
        8PkLQ=; b=kxHv14A/HniLqmfz3ymPWJwUJZaIFA2cEHbTiX3T7eodjksKPTefGq
        iuPLb5qjNRZl4BFD8F9vX6caDMMxMjwZ6YrSaffFgQQ7X4rx92MgqLfWFZv+UVFo
        vRkLfVNb9TZYQJMK23Bx/RmDtyQVTAS+/1TaCaEcuY17nYzdtdM/A=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 674F81519E3;
        Wed, 21 Sep 2022 12:58:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id C97D71519E2;
        Wed, 21 Sep 2022 12:58:53 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     Abhradeep Chakraborty via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>,
        Kaartic Sivaram <kaartic.sivaraam@gmail.com>,
        Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
Subject: Re: [PATCH 2/5] roaring.[ch]: apply Git specific changes to the
 roaring API
References: <pull.1357.git.1663609659.gitgitgadget@gmail.com>
        <38ec2360f4fbfe65fa2d9f1e9cfb7d4944d1714f.1663609659.git.gitgitgadget@gmail.com>
        <b727c25c-469f-ca56-bbd6-82f82c762523@github.com>
        <xmqqr10781lx.fsf@gitster.g>
        <990f84f9-fdd9-0d0a-4fc0-d0dbd19ee5a9@github.com>
Date:   Wed, 21 Sep 2022 09:58:52 -0700
In-Reply-To: <990f84f9-fdd9-0d0a-4fc0-d0dbd19ee5a9@github.com> (Derrick
        Stolee's message of "Tue, 20 Sep 2022 08:19:14 -0400")
Message-ID: <xmqq5yhg64vn.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: AC7F8566-39CE-11ED-8701-307A8E0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <derrickstolee@github.com> writes:

>> Hmph.... could "a typedef can become a place to give definitive
>> documentation for the class of callback functions" be a good reason
>> why we would want one?  I dunno.
>> 
>> In the posted patch, readers cannot tell what kind of three
>> parameters they are supposed to give to write_fn().
>
> This is exactly my reasoning. Having a clear definition gives us an
> opportunity to document what each parameter is for, even if it is
> just a variable name.

Yeah, I completely agree with you on that line of reasoning.

> In the unlikely event that we needed to modify this callback
> signature, changing it in one place makes it clear that we cover
> all connected uses instead of tracking all of these anonymous
> functions across multiple methods.

Well, the compiler will help flagging a caller that forgot to
convert, even if there is no typedef.  

The parameter list may not have to be updated for a function that
takes a callback function of this type as its parameter if you did
not use a typedef, but where it in turn makes a call to that
callback function, the compiler will notice the argument mismatch,
which you have to adjust to the new calling convention anyway.

What is somewhat sad is that even with typedef, the implementation
of a callback function cannot use the type, but the longhand that
underlies the typedef, to define it, but that is not something we
can fix, or are interested in fixing ;-).

Thanks.
