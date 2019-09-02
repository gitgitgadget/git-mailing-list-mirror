Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,PI_IMPORTANCE_HIGH,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
	SPF_NONE shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D96D01F461
	for <e@80x24.org>; Mon,  2 Sep 2019 18:30:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726697AbfIBSaB (ORCPT <rfc822;e@80x24.org>);
        Mon, 2 Sep 2019 14:30:01 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:63208 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726395AbfIBSaA (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Sep 2019 14:30:00 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 9C8B6156F4E;
        Mon,  2 Sep 2019 14:29:58 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=dYMMQRtZqr++g00KiLHSw7AZFk8=; b=W8xLht
        6lE2cxds+D0a4PVwXPHYA34ERKt2wZzY3Loxr4I8OoelD0lREGbRtyvdQzQVNP8L
        SKqMoQoAecEhCEyVAxnFM3c4TZekxzOSBqKd9x+k2L92kJHcCX3mZjHFhxeArG2t
        5DYRs9a+Xj5VURw/WWjWK/Sc3xLUej2RYBKAg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=eeMzeFRPQKtIinYZit30WGclWyeJ+Jr0
        hy1tNHLS2eLYycL28GIoyEwtpNyk1hIjKui4HUbHeuVzq6dEtQePD1vwFffdLDM5
        q3y5EocZMm8TNFXv2TWvvpJkCzRwzVbyU0N+Z9tfT5uotY1mtaJ3+wdJPF9lb4Nq
        /bNhp5Lenrk=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 92FFC156F4D;
        Mon,  2 Sep 2019 14:29:58 -0400 (EDT)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 05F9B156F4A;
        Mon,  2 Sep 2019 14:29:57 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Phillip Wood <phillip.wood123@gmail.com>
Cc:     Matt R via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Matt R <mattr94@gmail.com>
Subject: Re: [PATCH 1/1] rebase -r: let `label` generate safer labels
References: <pull.327.git.gitgitgadget@gmail.com>
        <4a02c38442dd8a4c0381adc8db0dce81c253da09.1567432900.git.gitgitgadget@gmail.com>
        <444f3ec4-abdf-1aa9-e8a8-8b5346b939e8@gmail.com>
Importance: high
Date:   Mon, 02 Sep 2019 11:29:56 -0700
In-Reply-To: <444f3ec4-abdf-1aa9-e8a8-8b5346b939e8@gmail.com> (Phillip Wood's
        message of "Mon, 2 Sep 2019 18:57:55 +0100")
Message-ID: <xmqq5zmav9ej.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: AAD2AFF6-CDAF-11E9-9D7C-46F8B7964D18-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Phillip Wood <phillip.wood123@gmail.com> writes:

> Being picking I'll point out that ':' is not a valid in refs
> either. Looking at
> https://docs.microsoft.com/en-us/windows/win32/fileio/naming-a-file I
> think only " and | are not allowed on NTFS/FAT but are valid in refs
> (see the man page for git check-ref-format for all the details). So
> the main limitation is actually what git allows in refs.

Yeah, trying to use the contents of the log message without
sufficient sanitization is looking for trouble.

>>   		for (p1 = label.buf; *p1; p1++)
>> -			if (isspace(*p1))
>> +			if (!(*p1 & 0x80) && !isalnum(*p1))
>>   				*(char *)p1 = '-';
>
> I'm sightly concerned that this opens the possibility for unexpected
> effects if two different labels get sanitized to the same string. I
> suspect it's unlikely to happen in practice but doing something like
> percent encoding non-alphanumeric characters would avoid the problem
> entirely.

I'd rather see 'x' used instead of '-' (double-or-more dashes and
leading dash in refnames may currently be allowed but double-or-more
exes and leading ex would be much more likely to stay valid) if we
just want to redact invalid characters.

I see there are "lets make sure it is unique by suffixing "-%d" in
other codepaths; would that help if this piece of code yields a
label that is not unique?
