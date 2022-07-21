Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95CEAC433EF
	for <git@archiver.kernel.org>; Thu, 21 Jul 2022 16:17:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233984AbiGUQRt (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Jul 2022 12:17:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233718AbiGUQRM (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Jul 2022 12:17:12 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27F365581
        for <git@vger.kernel.org>; Thu, 21 Jul 2022 09:16:17 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id C12191AC6C1;
        Thu, 21 Jul 2022 12:16:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=8xHmY+i1w0h/
        cnYIUmMh/aWvMdc8lwnOMREW+bRZLZc=; b=vfe+OqJtC1ChArjex7am4Mo0Nz2J
        3V582PLzSjQ3DSeXsmXjXj87vJHgvrHSrs7Dh/jYz3StBJ5NmlOi1zEa955VmctD
        exktsrDAUPPMIdTzgpyS84cYkkItK22ZgocY4Mmup9NKYFlLgxv6CTVsigXVeLuE
        imOTIFy/Z3bkXzk=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id B90AE1AC6C0;
        Thu, 21 Jul 2022 12:16:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.105.40.190])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 9FFA81AC6BE;
        Thu, 21 Jul 2022 12:16:01 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, ZheNing Hu <adlternative@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH v3 5/7] merge: make restore_state() restore staged state
 too
References: <pull.1231.v2.git.1655621424.gitgitgadget@gmail.com>
        <pull.1231.v3.git.1658391391.gitgitgadget@gmail.com>
        <91c495c770e3f7f91ae655a503bdd1cd99935e40.1658391391.git.gitgitgadget@gmail.com>
Date:   Thu, 21 Jul 2022 09:16:00 -0700
In-Reply-To: <91c495c770e3f7f91ae655a503bdd1cd99935e40.1658391391.git.gitgitgadget@gmail.com>
        (Elijah Newren via GitGitGadget's message of "Thu, 21 Jul 2022
        08:16:29 +0000")
Message-ID: <xmqqfsiul9vj.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 69C078DC-0910-11ED-93B5-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:

>   4) Merge strategies can make changes to the index and working tree,
>      and have no expectation to clean up after themselves, *even* if
>      they bail out and say they are not an appropriate handler for
>      the merge in question.  (The `octopus` merge strategy does this,
>      for example.)

I personally consider this is a bug in `octopus` (and I can do so
without offending anybody, as `octopus` was what I did), but because
the point of having pluggable merge strategies is to allow end users
and third parties write their own.  So save-and-restore dance would
be a prudent approach to the issue than forbidding this "buggy"
behaviour.

> Unfortunately, if users had staged changes before calling `git merge`,
> builtin/merge.c could do the following:
>
> =C2=A0 =C2=A0* stash the changes, in order to clean up after the strate=
gies
> =C2=A0 =C2=A0* try all the merge strategies in turn, each of which repo=
rt they
>      cannot function due to the index not matching HEAD
> =C2=A0 =C2=A0* restore the changes via "git stash apply"

>  	test_seq 0 10 >a &&
>  	git add a &&
> +	git rev-parse :a >expect &&
> ...
> +	# Changes to "a" should remain staged
> +	git rev-parse :a >actual &&
> +	test_cmp expect actual

Makes sense.

Thanks.
