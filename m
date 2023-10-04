Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A08CBE7C4E9
	for <git@archiver.kernel.org>; Wed,  4 Oct 2023 17:40:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233440AbjJDRky (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 4 Oct 2023 13:40:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233139AbjJDRkx (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Oct 2023 13:40:53 -0400
Received: from mail.smrk.net (mail.smrk.net [IPv6:2001:19f0:6c01:2788:5400:4ff:fe27:adaa])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA7BE9E
        for <git@vger.kernel.org>; Wed,  4 Oct 2023 10:40:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=smrk.net; s=20221002;
        t=1696441247;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=goYOQLduXsVeQ/QevPJiep+tyt5XyTjEHOzEJV9Qfeg=;
        b=daEAq21xy1z2uGvaK0ZlnQ7+0u7V7IZcROL7HT4AiyRdr+86U7bnECcLi4YFCsy58fQAl1
        w9cJ9d4U9WN9og8vMF7E6sp1K1Bcl8sT1WMv3oj7uuBy2Dp/FobEdzQzzv6YEgZrlqgjNz
        a4bHJx7rRV6+Bc3zpv1U19nA82EOGEAdQ3qhaZP9oJBbyP7MI8zS0uRzIbhRememYx2eha
        rkiLLtw0FIIO+HVm/YFxjXell0PK2z79ECuVSOJgtoileZAX/1PBTJv6jVDLFcff634jJD
        wTomabXirEYkyHAUsLTAzQ+annxj4mTQZ09SxC7QTG48FKb/UjaypFzeTCcL7Q==
Received: from localhost (<unknown> [192.168.5.2])
        by smrk (OpenSMTPD) with ESMTPSA id ca2e90cc (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Wed, 4 Oct 2023 19:40:46 +0200 (CEST)
From:   =?utf-8?B?xaB0xJtww6FuIE7Em21lYw==?= <stepnem@smrk.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] test-lib: make sure TEST_DIRECTORY has no trailing slash
In-Reply-To: <xmqqttr6pavh.fsf@gitster.g> (Junio C. Hamano's message of "Wed,
        04 Oct 2023 10:15:30 -0700")
References: <20231003082323.3002663-1-stepnem@smrk.net>
        <xmqqwmw3wgeo.fsf@gitster.g> <xmqqjzs3wer0.fsf@gitster.g>
        <20231004113413+0200.161419-stepnem@smrk.net>
        <xmqqbkdes6lf.fsf@gitster.g>
        <20231004190140+0200.740775-stepnem@smrk.net>
        <xmqqttr6pavh.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Date:   Wed, 04 Oct 2023 19:40:46 +0200
Message-ID: <20231004194046+0200.353534-stepnem@smrk.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, 04 Oct 2023 10:15:30 -0700
Junio C. Hamano wrote:

> =C5=A0t=C4=9Bp=C3=A1n N=C4=9Bmec <stepnem@smrk.net> writes:
>
>> Yes, this is even simpler and more obvious, although for some reason,
>> the subshell version works just as well, i.e., with just
>> TEST_DIRECTORY=3D$(cd . && pwd) (no cd in the parent) in test-lib.sh and
>>
>> cat <<EOF >./tslash.sh
>> #!/bin/sh
>> test_description=3D'yada yada'
>>
>> . ./test-lib.sh
>>
>> test_expect_success 'check TEST_DIRECTORY for trailing slash' '
>>         echo "$TEST_DIRECTORY" &&
>>         test "$TEST_DIRECTORY" =3D "${TEST_DIRECTORY%/}"
>> '
>>
>> test_done
>> EOF
>
> If the only thing you checked was if TEST_DIRECTORY has or does not
> have a trailing slash, then it is totally understandable how and why
> the chdir inside subshell works.  The value $(pwd) in the subshell
> returns, that is assigned to TEST_DIRECTORY, is canonicalized.  But
> the outer shell still thinks $(pwd) is with trailing slash, and the
> above does not test it.

Oh my, of course... thanks.

>
>     test_expect_success 'check $PWD for trailing slash' '
>             echo "$PWD" &&
>             test "$PWD" =3D "${PWD%/}"
>     '

> The primary reason why I said I was silly doing it in a subshell was
> because I wanted to make sure that any test that refers to $PWD or
> $(pwd) later in the code would not get upset the same way with
> trailing slash after $PWD or $(pwd).

The $PWD inside the test is the trash directory, though, so that's not
the problematic $PWD with a trailing slash any more, so I guess this
problem can't really happen in a test that follows the '. ./test-lib.sh'
(which does cd -P "$TRASH_DIRECTORY") convention?

--=20
=C5=A0t=C4=9Bp=C3=A1n
