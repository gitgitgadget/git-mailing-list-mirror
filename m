Return-Path: <SRS0=jwDG=D4=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81B1AC4363A
	for <git@archiver.kernel.org>; Wed, 21 Oct 2020 19:55:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0429F2416E
	for <git@archiver.kernel.org>; Wed, 21 Oct 2020 19:55:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="fWEIzA/Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440812AbgJUTzM (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 21 Oct 2020 15:55:12 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:51009 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2439094AbgJUTzM (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Oct 2020 15:55:12 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id A7C75FDDBE;
        Wed, 21 Oct 2020 15:55:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=0Co7hy4BfgK28iR+J8GAlJvyXko=; b=fWEIzA
        /YKWGascpRd3sviyexpAjkE/aaT0s9TRwqXmXywnYstV7uJlEGJPQm58yN82ohOO
        umOgXATkvznaWazCs0eQiQFpDPnBGHFXJqQui40OzLysKO5mkL0CrWBuPWfWJFTW
        FuGM/B2oatGp7AQp9fBdfmaDv4AWhV++6uJyc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=QTeAABJ/m8m8ufJ9PvxmhOfvgkmb4qKe
        2wJXziuU0WzJGFk72ZRBOK2vnBZ6WXWYfHIbgiwHy2N2+d7XRRaUGMuuE5NfwStD
        tcg0Km1xEeiTFXCRPxsutmgqpq0BYLAXK1bgIIfqUCPRmmk07I2vjPwj8xFMShek
        G95spWXeYGY=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id A0832FDDBD;
        Wed, 21 Oct 2020 15:55:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id D278EFDDBB;
        Wed, 21 Oct 2020 15:55:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH] sequencer: remove duplicate rollback_lock_file() call
References: <pull.894.git.git.1603286675709.gitgitgadget@gmail.com>
        <20201021171727.GA1237181@nand.local>
Date:   Wed, 21 Oct 2020 12:55:05 -0700
In-Reply-To: <20201021171727.GA1237181@nand.local> (Taylor Blau's message of
        "Wed, 21 Oct 2020 13:17:27 -0400")
Message-ID: <xmqqmu0f73s6.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 515B64A8-13D7-11EB-8C35-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

> Hi Elijah,
>
> On Wed, Oct 21, 2020 at 01:24:35PM +0000, Elijah Newren via GitGitGadget wrote:
>> diff --git a/sequencer.c b/sequencer.c
>> index 00acb12496..baff51035e 100644
>> --- a/sequencer.c
>> +++ b/sequencer.c
>> @@ -3689,7 +3689,6 @@ static int do_merge(struct repository *r,
>>  				NULL, 0);
>>  		rollback_lock_file(&lock);
>>
>> -		rollback_lock_file(&lock);
>
> Looks obviously good to me, thanks.
>
>   Reviewed-by: Taylor Blau <me@ttaylorr.com>
>
> Thanks,
> Taylor

Thanks, both.  That's an embarrassing one.
