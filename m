Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BDAEC433F5
	for <git@archiver.kernel.org>; Thu, 21 Apr 2022 19:12:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1391815AbiDUTO4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Apr 2022 15:14:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1387659AbiDUTOz (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Apr 2022 15:14:55 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4815A4CD5D
        for <git@vger.kernel.org>; Thu, 21 Apr 2022 12:12:04 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id D86C11948DF;
        Thu, 21 Apr 2022 15:12:03 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=j1M7ZPw6rpUXb/A1VRwLZg9sDu2bRoMSZPyNfF
        hLDJM=; b=n0txN0o8GVkXt2FKyOBEe91xQrUmwsx+2o5QjcaPci6TxXckL4zQmp
        flRVS6KpBfuAmmdIDnba1+QxnZtD9ACwI2e14DS7iWZqQErqToGfbL3YiA9Qb106
        1vI8sZTQ1LgW7Vi+Wr4xHeds3jsI+79HEM8wlwNlnUu7MEYElQ5mI=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id CB6591948DE;
        Thu, 21 Apr 2022 15:12:03 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.105.84.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id B65B21948D6;
        Thu, 21 Apr 2022 15:11:59 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Carlo Arenas <carenas@gmail.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        Phillip Wood <phillip.wood@talktalk.net>
Subject: Re: [PATCH v2] CI: select CC based on CC_PACKAGE (again)
References: <patch-1.1-d89ad4d5b7c-20220421T130310Z-avarab@gmail.com>
        <patch-v2-1.1-92acf9420a9-20220421T174733Z-avarab@gmail.com>
        <CAPUEspggNfra_C8PBcVqjZrxxnswg27WFLg2kT6JOCMB8f0FGg@mail.gmail.com>
Date:   Thu, 21 Apr 2022 12:11:58 -0700
In-Reply-To: <CAPUEspggNfra_C8PBcVqjZrxxnswg27WFLg2kT6JOCMB8f0FGg@mail.gmail.com>
        (Carlo Arenas's message of "Thu, 21 Apr 2022 12:05:20 -0700")
Message-ID: <xmqqv8v2gsjl.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: EB4630B0-C1A6-11EC-ADE8-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Carlo Arenas <carenas@gmail.com> writes:

>> -       CC="${CC:-gcc}"
>> +       CC="${CC_PACKAGE:-${CC:-gcc}}"
>
> minor nitpick, but most likely still relevant considering your other
> "bashism" fixes.
> the POSIX syntax doesn't use ":" (documented in CodingGuidelines)

You are reading the guideline wrong, I am afraid.

This is not a substring substitution, ${foo:0:3} picking three
characters from the beginning of foo.

It is "If CC_PACKAGE is UNSET OR SET TO EMPTY, then use the fallback
value that is ${CC:-gcc}", which is a bog standard bourne shell that
predates POSIX.  The colon before "-" is what adds "OR SET TO EMPTY"
part; without the colon, i.e. "${CC_PACKAGE-${CC-gcc}}", then you
get the same without "OR SET TO EMPTY" part.

And we do use that form.
