Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51D0AC433FE
	for <git@archiver.kernel.org>; Sat,  8 Oct 2022 04:23:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229519AbiJHEXY (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 8 Oct 2022 00:23:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbiJHEXW (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 8 Oct 2022 00:23:22 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA2D2D77D7
        for <git@vger.kernel.org>; Fri,  7 Oct 2022 21:23:21 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 675DC1A9629;
        Sat,  8 Oct 2022 00:23:21 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=ei1u5ZHX2cjQ
        lqxpeuquQRsFoi7v6xxbApDA8IytDX8=; b=dKgoSRrgB4GQbL5FunLVbASobcnv
        K3wQwfw/BHWzVyzesfr5g5Qlz/+cthtrbUHqLIScUQIunqW3t3lMft1PFlVKtLmu
        SU3bTpK5SlUjgC29/BBIWg3TyB4TKGSYaNIapzcuyvW0XZIopamC70sou1wntEA3
        p0/EB7Tn+Oi51fI=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 603CE1A9628;
        Sat,  8 Oct 2022 00:23:21 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 878201A9627;
        Sat,  8 Oct 2022 00:23:18 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     =?utf-8?Q?Rub=C3=A9n?= Justo <rjusto@gmail.com>,
        Git List <git@vger.kernel.org>
Subject: Re: [PATCH v4] branch: support for shortcuts like @{-1}, completed
References: <pull.1346.git.1662388460.gitgitgadget@gmail.com>
        <93b0b442-b277-66a6-3f5f-5a498593aa07@gmail.com>
        <7abdb5a9-5707-7897-4196-8d2892beeb81@gmail.com>
        <2e164aea-7dd8-5018-474a-01643553ea49@gmail.com>
        <CAPig+cSX9jSPc_fJc0tuiER1-AqnbFGOk0r1tXEkv9gycVH-CA@mail.gmail.com>
Date:   Fri, 07 Oct 2022 21:23:17 -0700
In-Reply-To: <CAPig+cSX9jSPc_fJc0tuiER1-AqnbFGOk0r1tXEkv9gycVH-CA@mail.gmail.com>
        (Eric Sunshine's message of "Fri, 7 Oct 2022 23:17:34 -0400")
Message-ID: <xmqqzge7aqq2.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: EF97B446-46C0-11ED-B528-B31D44D1D7AA-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Sunshine <sunshine@sunshineco.com> writes:

> On Fri, Oct 7, 2022 at 9:36 PM Rub=C3=A9n Justo <rjusto@gmail.com> wrot=
e:
>> branch command with options "edit-description", "set-upstream-to" and
>> "unset-upstream" expects a branch name.  Since ae5a6c3684 (checkout:
>> implement "@{-N}" shortcut name for N-th last branch, 2009-01-17) a
>> branch can be specified using shortcuts like @{-1}.  Those shortcuts
>> need to be resolved when considering the arguments.
>> [...]
>> Signed-off-by: Rub=C3=A9n Justo <rjusto@gmail.com>
>> ---
>> diff --git a/t/t3204-branch-name-interpretation.sh b/t/t3204-branch-na=
me-interpretation.sh
>> @@ -133,4 +133,28 @@ test_expect_success 'checkout does not treat remo=
te @{upstream} as a branch' '
>> +test_expect_success 'edit-description via @{-1}' '
>> +       git checkout -b desc-branch &&
>> +       git checkout -b non-desc-branch &&
>> +       write_script editor <<-\EOF &&
>> +               echo "Branch description" >"$1"
>> +       EOF
>> +       EDITOR=3D./editor git branch --edit-description @{-1} &&
>> +       test_must_fail git config branch.non-desc-branch.description &=
&
>> +       git config branch.desc-branch.description >actual &&
>> +       echo "Branch description\n" >expect &&
>
> Is the intention here with the embedded "\n" that `echo` should emit
> two newlines? If so, interpreting "\n" specially is not POSIX behavior
> for `echo`, thus we probably don't want to rely upon it.

Good eyes.  You are correct that "echo" and "\n" do not play well
together.

Thanks.
