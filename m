Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77DE1C4332F
	for <git@archiver.kernel.org>; Fri, 14 Oct 2022 15:53:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229471AbiJNPxz (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 Oct 2022 11:53:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229785AbiJNPxx (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Oct 2022 11:53:53 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFA771D5856
        for <git@vger.kernel.org>; Fri, 14 Oct 2022 08:53:52 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 02B71144B7B;
        Fri, 14 Oct 2022 11:53:52 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=/s+0EcDVEnzn
        d5IlLoGeM+sOh3as5iFEbRb7hmA9HDw=; b=SnQzHGOjQvcjCz4ZeMxPgcDd/VET
        yZKjmamErWeEkXXq0+L1j0mkFfDgEnaLtV+pDV/9sy1pgZSLqMcXDzAHU1TzIzEP
        IyrCbftTPAOljes3+RBIE4PaNibXwcuM/iPotufhPyj3IQwDq0ili4Hnq+a/qShY
        bxkkGNsypIeBZqc=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id EE450144B7A;
        Fri, 14 Oct 2022 11:53:51 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 592A3144B77;
        Fri, 14 Oct 2022 11:53:51 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     phillip.wood@dunelm.org.uk, git@vger.kernel.org,
        Calvin Wan <calvinwan@google.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v3 00/15] run-command API: pass functions & opts via struct
References: <cover-v2-00.22-00000000000-20221012T084850Z-avarab@gmail.com>
        <cover-v3-00.15-00000000000-20221012T205712Z-avarab@gmail.com>
        <06bc6ffe-3f64-481e-5c54-156a39865e25@dunelm.org.uk>
        <221014.86y1tijv3b.gmgdl@evledraar.gmail.com>
Date:   Fri, 14 Oct 2022 08:53:50 -0700
In-Reply-To: <221014.86y1tijv3b.gmgdl@evledraar.gmail.com> (=?utf-8?B?IsOG?=
 =?utf-8?B?dmFyIEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Fri, 14 Oct 2022 16:50:41 +0200")
Message-ID: <xmqq5ygmbdv5.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 65F32618-4BD8-11ED-A5DB-2AEEC5D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> You also had a related concern in 04/05 (which I'm taking the liberty o=
f
> replying ot here):
>
> 	https://lore.kernel.org/git/a7463bc5-9a92-8f0f-c0ee-e72fbbeedc09@dunel=
m.org.uk/
>
> So, first I disagree with it "going in the wrong direction". We've been
> converting more things to size_t. For e.g. an "int nr_processes" we can
> expect that we'll want to e.g. have a corresponding "struct string_list=
"
> whose "nr" is a "size_t" (or similar aggregate types).

I do not quite see why that is relevant.  We may create list of
textual descriptions from list of processes, so we expect to be able
to loop "for (int i =3D 0; i < nr_processes; i++)" and access i-th
element of the corresponding string_list.  As long as int is
narrower than size_t (and it is wide enough to count the processes
we are going to ever spawn) there is no issue, no?  Also using
signed type is so much more convenient to signal an error (imagine
asking for a process's i that is between 0..nr_processes with some
other key in your database, and having to answer "no such process
known to me").

> By mixing the two we're mixing types forever with associated warnings (=
&
> suppressions).

That is a complaint about shortcomings of the tool that gives
irrelevant warning, no?  It is not a good reason to make the code
worse.  Compilers, editors, and linters are to serve the code, not
the other way around.

