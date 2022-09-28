Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26C44C04A95
	for <git@archiver.kernel.org>; Wed, 28 Sep 2022 23:41:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233785AbiI1XlL (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 28 Sep 2022 19:41:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231652AbiI1XlJ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Sep 2022 19:41:09 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDEAE868A0
        for <git@vger.kernel.org>; Wed, 28 Sep 2022 16:41:04 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 2B4B8156D08;
        Wed, 28 Sep 2022 19:41:01 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type
        :content-transfer-encoding; s=sasl; bh=MGwAtdvgLq2vRZ4vMRyshJSID
        ckHuwxwttIJOEsb5Fg=; b=BC3kwi93tkXoEUAzMInBskog9o0m140ojPT+YUdqQ
        RfV3mQj90BDqBfXq2z0i4GbBIn7t2grLI1mFPB/Z8ffy05+Cwckez8KlXKQkmupp
        M2cMUUXJlbF5FkzezIBVmwKs+cYsfv/KAr7Phnk3hF53919cLVCa7tFfyGGGtzRV
        kw=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 1E0D5156D07;
        Wed, 28 Sep 2022 19:41:01 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 2DB22156D06;
        Wed, 28 Sep 2022 19:40:59 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Rub=C3=A9n?= Justo <rjusto@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] branch: do not fail a no-op --edit-desc
References: <xmqqczbftina.fsf@gitster.g>
        <1faa5c44-1a59-7a60-d29b-c4d4e8d0bf92@gmail.com>
Date:   Wed, 28 Sep 2022 16:40:58 -0700
Message-ID: <xmqq1qrvqd85.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 01398580-3F87-11ED-BE9E-2AEEC5D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Rub=C3=A9n Justo <rjusto@gmail.com> writes:

> On 28/9/22 21:15, Junio C Hamano wrote:
>> In a repository on a branch without branch description, try running
>
> On a branch without description, ..
>
>> The simpler solution of course introduces TOCTOU, but you are
>
> Nice to introduce a term that can generate curiosity.
>
>> fooling yourself in your own repository.  Not overwriting the branch
>> description on the same branch you added in another window, while
>> you had this other editor open, may even be a feature ;-)
>
> Not overwriting if there was no description in the first place, otherwi=
se
> will clear.. =C2=BF?

Time-of-check-time-of-use is an established term to describe classes
of "bugs" that arises if you do

    1. check if something is in one state

    2. perform an action to change that something's state

in separate steps, expecting that the result of the check done in
the earlier step is unchanged.  A "bug" is what happens in the
second step, when that expectation is violated.

In our case, in the "check" stage, we set "exists" based on whether
we had the branch.<current>.description configuration variable.

Then later, we use that "exists" condition and expect that nobody
messed with the state of the variable in the meantime.

An example of what happens in the updated code is

 1. We saw the description did not exist.

 2. The user told us to abort editing/setting the description.  We
    assume description does not still exist, and skip the call to
    git_config_set().

Now, what if you added a description for the branch between these
two points in time, perhaps from another window?  Because 2. above
bases its decision not to bother calling git_config_set() (because
!buf.len and !exists are both true), the description you set from
the other window will be kept.  That is the comment "feature ;-)"
refers to.

Of course, this can bite the other way.  If we did have a
description, and the user told us to remove it by giving an empty
editor result, then

 1. We see that the description does exist.

 2. We see the buf.len =3D=3D 0.  Because we think the description
    exists and the user asks to remove it, we call git_config_set()
    will NULL as the value to attempt to remove the variable.

What if you removed the description for the branch between these two
points in time from another window?  We end up triggering the exact
bug that comes from the fact that we use git_config_set(), not the
_gently variant, because we are now removing what does not exist.

But at that point, the user deserves it and the problem falls
squarely into "doctor, it hurts when I twist my arm in this unusual
way! -- well, don't do it then", I would think.

Thinking what happens in the remaining two combinations is left as
an exercise to readers ;-).




