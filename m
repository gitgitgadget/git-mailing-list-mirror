Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1084CC433EF
	for <git@archiver.kernel.org>; Thu,  9 Dec 2021 21:18:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230374AbhLIVWI (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Dec 2021 16:22:08 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:53090 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbhLIVWH (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Dec 2021 16:22:07 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 26FD516819C;
        Thu,  9 Dec 2021 16:18:33 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=rDyR0maEHJ1cCRoiVCYuWmjjvfIdtdFkjURRuU
        9cgLc=; b=xJt1zI1voWdHWfRX5D+h3sr/AJL3SqT3JVUsj/nkwhpCHhDNwKB4kJ
        sw4Y/xsU+JZlgk5P35jLpEe/AanrFOslv4/k6dMwg5OYh+YthlFGRzs3GjUCd4Cx
        gY5N4OXFYAcjCyq6i7cyHnxZFvzGGW5f/WTSDzN1V0qPD66D6+oK4=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 1FADF16819B;
        Thu,  9 Dec 2021 16:18:33 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 648B316819A;
        Thu,  9 Dec 2021 16:18:29 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Phillip Wood <phillip.wood123@gmail.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Neeraj Singh <nksingh85@gmail.com>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH] git-compat-util(msvc): C11 does not imply support for
 zero-sized arrays
References: <pull.1094.git.1638823724410.gitgitgadget@gmail.com>
        <20211206222539.GA27821@neerajsi-x1.localdomain>
        <nycvar.QRO.7.76.6.2112072217280.90@tvgsbejvaqbjf.bet>
        <f245f2b7-ca00-5497-3d1d-658c4c0fbcb6@gmail.com>
Date:   Thu, 09 Dec 2021 13:18:27 -0800
In-Reply-To: <f245f2b7-ca00-5497-3d1d-658c4c0fbcb6@gmail.com> (Phillip Wood's
        message of "Thu, 9 Dec 2021 11:00:55 +0000")
Message-ID: <xmqqfsr1pjdo.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 8E20863A-5935-11EC-BB33-98D80D944F46-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Phillip Wood <phillip.wood123@gmail.com> writes:

>> the end of a struct isn't triggering a compile error. But having a field
>> _after_ that empty flex array _does_ trigger a compile error:
>> struct MyStruct {
>>      int x;
>>      int flexA[];
>>      char string[256];
>> };
>> Note the added `string` field.

Ick.

If we use the "safer but a bit wasteful" alternative in such a case,
it will become just wrong.  We'll have a single-member array there,
and extra allocation for an instance of MyStruct will only lengthen
the .string member, without allowing the .flexA member to have more
elements.

> Having a field after the flex array is a violation of the C
> standard. Section 6.7.2.1:
>    ... the last member of a structure with more than one named member
>    may have incomplete array type, such a structure (and any union
>    containing, possibly recursively, a member that is such a structure)
>    shall not be a member of a structure or an element of an array.
>
> Note that the wording also forbids
>
> struct A {
> 	int x;
> 	char flex[];
> };
>
> struct B {
> 	struct A a; /* This is forbidden */
> };
>
> There was a proposal a few years ago to relax that restriction [1] but
> it does not seem to be in the latest draft standard.
>
> None of this helps fix the problem, but it does explain why MSVC complains.

Thanks.

In short, the code is wrong, and the compiler is complaining to
avoid us using a wrong code.  If the same code is given to other
compilers that support ANCI C style flexible array member, we are
likely to see the same error.

Which makes the whole thing (including my "let's make the
conditionals to set up FLEX_ARRAY for various compilers easier to
read") much less urgent.

Thanks for a well-written summary.

