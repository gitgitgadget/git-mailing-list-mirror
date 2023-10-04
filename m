Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB754E7C4E2
	for <git@archiver.kernel.org>; Wed,  4 Oct 2023 17:15:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243653AbjJDRPj (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 4 Oct 2023 13:15:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233488AbjJDRPh (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Oct 2023 13:15:37 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2EAAAD
        for <git@vger.kernel.org>; Wed,  4 Oct 2023 10:15:32 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 65FBA1C079A;
        Wed,  4 Oct 2023 13:15:32 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=lTlR/1h9iqZ2
        7SS5ie9v4tCFDIq6vXyQ4yOFlu3l62k=; b=WQONq+yCiSw97HhqElKnvqKHR/zJ
        q8SgpZZL1R32oD0FDnz7EtwVhOhAPPUEz396zQXyPGij83zN5kCA389miwHCKhF4
        eBM91qT6WncUQIPgyKNXnOQsd9lpaQkdnNbhANidkXBI2Z5w8ck/nj2gEVnKLYVV
        JYpcM4cMwRpqHao=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 5B7F21C0798;
        Wed,  4 Oct 2023 13:15:32 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.165.85])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id AEA4D1C0797;
        Wed,  4 Oct 2023 13:15:31 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?xaB0xJtww6FuIE7Em21lYw==?= <stepnem@smrk.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] test-lib: make sure TEST_DIRECTORY has no trailing slash
In-Reply-To: <20231004190140+0200.740775-stepnem@smrk.net> (=?utf-8?B?IsWg?=
 =?utf-8?B?dMSbcMOhbiBOxJttZWMiJ3M=?=
        message of "Wed, 04 Oct 2023 19:01:40 +0200")
References: <20231003082323.3002663-1-stepnem@smrk.net>
        <xmqqwmw3wgeo.fsf@gitster.g> <xmqqjzs3wer0.fsf@gitster.g>
        <20231004113413+0200.161419-stepnem@smrk.net>
        <xmqqbkdes6lf.fsf@gitster.g>
        <20231004190140+0200.740775-stepnem@smrk.net>
Date:   Wed, 04 Oct 2023 10:15:30 -0700
Message-ID: <xmqqttr6pavh.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 9F6EF642-62D9-11EE-BE88-25B3960A682E-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C5=A0t=C4=9Bp=C3=A1n N=C4=9Bmec <stepnem@smrk.net> writes:

> Yes, this is even simpler and more obvious, although for some reason,
> the subshell version works just as well, i.e., with just
> TEST_DIRECTORY=3D$(cd . && pwd) (no cd in the parent) in test-lib.sh an=
d
>
> cat <<EOF >./tslash.sh
> #!/bin/sh
> test_description=3D'yada yada'
>
> . ./test-lib.sh
>
> test_expect_success 'check TEST_DIRECTORY for trailing slash' '
>         echo "$TEST_DIRECTORY" &&
>         test "$TEST_DIRECTORY" =3D "${TEST_DIRECTORY%/}"
> '
>
> test_done
> EOF

If the only thing you checked was if TEST_DIRECTORY has or does not
have a trailing slash, then it is totally understandable how and why
the chdir inside subshell works.  The value $(pwd) in the subshell
returns, that is assigned to TEST_DIRECTORY, is canonicalized.  But
the outer shell still thinks $(pwd) is with trailing slash, and the
above does not test it.

    test_expect_success 'check $PWD for trailing slash' '
            echo "$PWD" &&
            test "$PWD" =3D "${PWD%/}"
    '

The primary reason why I said I was silly doing it in a subshell was
because I wanted to make sure that any test that refers to $PWD or
$(pwd) later in the code would not get upset the same way with
trailing slash after $PWD or $(pwd).  As long as it is not overdone,
it is a good practice to consider possibilities of similar problems
triggered by the same root cause, which we may not have got bitten
by yet, and preventing it from happening with the same fix.

Thanks.
