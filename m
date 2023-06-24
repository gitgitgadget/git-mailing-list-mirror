Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBD1CEB64DA
	for <git@archiver.kernel.org>; Sat, 24 Jun 2023 22:20:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229532AbjFXWT2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 24 Jun 2023 18:19:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjFXWT1 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 24 Jun 2023 18:19:27 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17BCA10D3
        for <git@vger.kernel.org>; Sat, 24 Jun 2023 15:19:25 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 847F221586;
        Sat, 24 Jun 2023 18:19:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=0MTbn3sn5k1u5tE+uin8MgKnm0Yi1VPAIMim5yV9734=; b=KL6z
        slmRdeK/ZhchJ4lXvSJrZ/C4iOPGdUG9wdY8xEcR7WVk6Yd0Uv51PROzp1uSAaTe
        yrKNei5OtFnAF0cQAJrjQW4zu9Blz56MhkaT1UzAiMxfz+G4w40UwW2UrHflBid5
        VG2BPF/5kSrSRutqn4EphEJsWkn1w3lPJZGfCOs=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 680F421585;
        Sat, 24 Jun 2023 18:19:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.105.62.77])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 7D88221580;
        Sat, 24 Jun 2023 18:19:21 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Phillip Wood <phillip.wood123@gmail.com>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        David C Black <david.black@doulos.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Bug: git add does not process gitignore properly
References: <CWLP265MB3841D32521E79202079DB7F58C22A@CWLP265MB3841.GBRP265.PROD.OUTLOOK.COM>
        <CAPig+cQ1qzO5txhZhki4UrvLBThdgo-aknBmEkNSjFhR9WXLRg@mail.gmail.com>
        <d748b4bb-6be2-4936-04d0-f0edcf228dfb@gmail.com>
Date:   Sat, 24 Jun 2023 15:19:20 -0700
Message-ID: <xmqqjzvs7bbr.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2B1AB822-12DD-11EE-88F1-C2DA088D43B2-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Phillip Wood <phillip.wood123@gmail.com> writes:

> I think the usual way around this is to use patterns like
>
> 	/extern/*
> 	!/extern/bin/
> 	!/extern/ABOUT.md
>
> see the example on the gitignore man page.

Thanks for a very good suggestion.

The behaviour may be somewhat counter-intuitive, especially when you
have "/extern/" followed by "!/extern/blah" in the same file.  The
original rationale for this was because the behaviour becomes
consistent between the cases where

 (1) these two patterns appear in the same top-level .gitignore
     file, and

 (2) "/extern/" is in the top-level .gitignore file and "!/bin/" is
     in ".gitignore" file in the "extern/" directory

which ought to be the moral equivalents.

There have been at least two attempts to change this, but without
much success.

 - 57534ee7 (dir.c: don't exclude whole dir prematurely if neg
   pattern may match, 2015-09-21) tried but it caused breakages
   reported on the list [*1*, *2*] and got reverted at 8c722360
   (Revert "dir.c: don't exclude whole dir prematurely if neg
   pattern may match", 2016-01-08).

 - 5e57f9c3 (Merge branch 'nd/exclusion-regression-fix', 2016-02-24)
   was a merge of another attempt, which again had to be reverted at
   5cee3493 (Revert "Merge branch 'nd/exclusion-regression-fix'",
   2016-03-18).

It is dubious if it is worth making another attempt to change it.
"Fixing" this and still keeping consistency between the two ways to
spell the same pair of rules would mean that even "/extern/" in the
".gitignore" file in a higher level tells us not to bother with the
"extern" directory, we would have to look for "extern/.gitignore"
just in case it unignores something, which would probably make it
unacceptably costly.  It would be quite a backward incompatible
change, too.


[References]
*1* Git 2.7.0 gitignore behaviour regression:
https://lore.kernel.org/git/20160107234455.GB265296@vauxhall.crustytoothpaste.net/

*2* Behavior change in 2.7.0: With core.sparseCheckout some files have
    the skip-worktree bit set after a checkout.:
https://lore.kernel.org/git/trinity-5caa2985-5cf1-453b-9a9e-bcce057f8615-1452249323061@3capp-gmx-bs51/
