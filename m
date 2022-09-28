Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50747C32771
	for <git@archiver.kernel.org>; Wed, 28 Sep 2022 17:51:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234695AbiI1RvH (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 28 Sep 2022 13:51:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232792AbiI1RvD (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Sep 2022 13:51:03 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 169B2D07B5
        for <git@vger.kernel.org>; Wed, 28 Sep 2022 10:51:00 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B3150145C42;
        Wed, 28 Sep 2022 13:50:59 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type
        :content-transfer-encoding; s=sasl; bh=sJx+cdh1DYJQv05GYLvWnsTmA
        gVcy8cWYne6/n25hRY=; b=I45SzLzLkKbOsxy7EydL66GlBbeb/Y6mpUP7y6NPM
        MV6yQtq07opjMAtIXLqbokO6SOcwa/yC3Wjbyi8Zc5LAvTrhvULJbu43Ywwvtm4U
        1DnK90Z3PlBRXJ9GJy/C/k+gSY0+TAbHmDTMewOeEjFAFtdLfmW0h1xblxJJRbMg
        bI=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id AA9EF145C41;
        Wed, 28 Sep 2022 13:50:59 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 1FB16145C40;
        Wed, 28 Sep 2022 13:50:59 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Rub=C3=A9n?= Justo <rjusto@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] branch: description for non-existent branch errors
References: <c333cc4b-12a1-82b6-0961-1c42080dad15@gmail.com>
        <858edf12-67b1-5e2c-dd2e-3eb476530803@gmail.com>
        <xmqqleq6ovh4.fsf@gitster.g>
        <26a5cbe2-d821-e7f6-e56f-4ad90ef2cf2d@gmail.com>
        <xmqqedvw1mmu.fsf@gitster.g>
Date:   Wed, 28 Sep 2022 10:50:58 -0700
Message-ID: <xmqqzgejtmkd.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 1C36DA08-3F56-11ED-AE83-307A8E0A682E-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Rub=C3=A9n Justo <rjusto@gmail.com> writes:
>
>> I pointed out in the first mail of this thread, there is already a pat=
ch in
>> 'seen' that touches builtin/branch.c [1].  I would like to keep the pa=
tches
>> separated, but I don't know how to proceed: make the change from 'seen=
', keep
>> it from 'master'... Maybe you can give me some guidance in this.
>
> I do not see much problem in keeping them separated.  My trial merge
> of the result of applying this patch on top of 'master', with the
> other topic that has the "branch description for nth prior checkout"
> patch does show a minor textual conflict, but the resolution does
> not look too bad.
>
> Check near the topic branch of 'seen' after I push out today's
> integration result in a few hours and see if they look reasonable.
>
> Thanks.

Ah, I forgot to mention.  As to the error messages that begin with a
capital letter, to be consistent with violating messages that are
already there in builtin/branch.c, let's keep them as they are in
your patch.  We can and should clean them up later, perhaps soon
after the patch under discussion matures, but I agree with you that
it can be left outside the scope of this patch.

But stepping back a bit, in the longer term, we might want to change
the behaviour of "git branch --edit-description", at least when no
branch is specified on the command line and we are on an unborn
branch.  It is merely the matter of setting a variable in the
configuration file, so there may not be a strong reason to forbid

    $ git init trash
    $ cd trash
    $ git branch --edit-description
    $ git commit --allow-empty -m initial

while allowing the same sequence with the last two commands reversed.

After all, renaming a branch with "branch -m" does not to require an
existing ref that points at a commit, i.e.

    $ git init -b master trash
    $ cd trash
    $ git config branch.master.description "describes master"
    $ git branch -m master main

does work fine and you end up with branch.main.description at the
end.
