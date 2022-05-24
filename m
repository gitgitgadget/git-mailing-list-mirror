Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E462C433F5
	for <git@archiver.kernel.org>; Tue, 24 May 2022 20:06:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235145AbiEXUGO (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 May 2022 16:06:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236868AbiEXUGL (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 May 2022 16:06:11 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0ECBE6548
        for <git@vger.kernel.org>; Tue, 24 May 2022 13:06:08 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 53A2912B177;
        Tue, 24 May 2022 16:06:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=NEpIElIYzBz/
        fjVdecPe8nwWfVvOgjUANrrMk2p7iUM=; b=DJ+PEFYVTc2SAG65ZAvbxcQInMMd
        BdSrpTWgm1abtcRDTy8oYVrd3Lhs7fr9OR4q1Z/f0aI3/6MjTruZz0XAbEBLghnx
        htDIm3EgAw2VG49+d6I1O6e6PUxkxRBrrNsKRv0aEGUOgz5MG55APUU9J0XdgFvG
        15YkJyJZV3KfDbM=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C8DB912B176;
        Tue, 24 May 2022 16:06:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.92.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 3CCED12B175;
        Tue, 24 May 2022 16:06:05 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 3/4] http.c: avoid danging pointer to local variable
 `finished`
References: <pull.1238.git.1653351786.gitgitgadget@gmail.com>
        <4a4e0aa0a49a54eea88f9c2d8e1db6a697012718.1653351786.git.gitgitgadget@gmail.com>
        <220524.86fskzxsvq.gmgdl@evledraar.gmail.com>
Date:   Tue, 24 May 2022 13:06:02 -0700
In-Reply-To: <220524.86fskzxsvq.gmgdl@evledraar.gmail.com> (=?utf-8?B?IsOG?=
 =?utf-8?B?dmFyIEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Tue, 24 May 2022 09:58:51 +0200")
Message-ID: <xmqq35gyhf11.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: F17693D4-DB9C-11EC-B10F-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> On Tue, May 24 2022, Johannes Schindelin via GitGitGadget wrote:
>
>> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>> [...]
>> Let's drop that local variable and introduce a new flag in the slot th=
at
>> is used to indicate that even while the slot is no longer in use, it i=
s
>> still reserved until further notice. It is the responsibility of
>> `run_active_slot()` to clear that flag once it is done with that slot.
>>
>> Initial-patch-by: Junio C Hamano <gitster@pobox.com>
>
> Don't you mean by me?
> I.e. https://lore.kernel.org/git/patch-1.1-1cec367e805-20220126T212921Z=
-avarab@gmail.com/

Most likely, but this version is so distant from the "clear
slot->finished before leaving run_active_slot()" Dscho and I were
recently discussing, that I do not think it can be said to have been
derived from that one.  This is completely a different patch that
makes different changes.

The "clear slot->finished", by the way, is what I think is the right
thing to do, especially that the objective is to squelch the false
positive warning from a new compiler.  If there is a way to annotate
the line for the compiler to tell it not to warn about it, that would
have been even better.

> This seems to be derived from that, or perhaps you just came up with
> something similar independently. Junio then came up with the smaller
> https://lore.kernel.org/git/xmqq8rv2nggn.fsf@gitster.g/

I actually do not think so.  Yours is revert of the existing fix the
compiler is confused about, and I have a feeling that if the original
fix is still relevant, the problem the original fix wanted to address
will resurface as a regression.

If I am reading the patch correctly, Dscho's is to avoid [*] reusing
a slot while any run_active_slot() is still waiting for its
completion.  The approach would solve the problem the original fix
wanted to solve in a different way.  Personally I do not think such
a surgery is necessary only to squelch false positives from a new
warning compiler, though.


[Footnote]=20

 * I said "is to avoid", not "avoids", because I haven't studied the
   patch with sufficient degree of carefulness to say for sure, even
   though I can see that is the intent.

