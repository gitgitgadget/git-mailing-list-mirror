Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28419C433F5
	for <git@archiver.kernel.org>; Fri, 22 Apr 2022 16:13:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378053AbiDVQQ2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Apr 2022 12:16:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377448AbiDVQQ1 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Apr 2022 12:16:27 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 322545E175
        for <git@vger.kernel.org>; Fri, 22 Apr 2022 09:13:33 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 66AF0179207;
        Fri, 22 Apr 2022 12:13:32 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=T6JJfqOALDcY
        V5Ci10507gK1W6+6wRUnDlfNRMjn3p0=; b=r96caV2uKRfRWoCb/nebkedJgu5L
        LIL+l+ITtfJowJX2KVDZxFjpQIZqrMYTeRYsFW4ynV3NuHOakKt1Sub8doUOX9Cl
        K3njoN7h71EN/qEvCRG35ftEOv8PgzydVVC37pJ8Q6Ha9XpDPbNPsWOOKv347/I1
        h7QpIYCKFV7mTzo=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 5F110179206;
        Fri, 22 Apr 2022 12:13:32 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.105.84.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id DDDDB179205;
        Fri, 22 Apr 2022 12:13:28 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Attila Csosz <csosza@designsoftware.com>, git@vger.kernel.org
Subject: Re: Git bug report - disk errors on Windows after push
References: <4026b85f-8cae-bcca-af14-e886e80725d4@designsoftware.com>
        <Yl2h5I0apzWhpVtr@camp.crustytoothpaste.net>
        <220422.868rrx5uju.gmgdl@evledraar.gmail.com>
Date:   Fri, 22 Apr 2022 09:13:27 -0700
In-Reply-To: <220422.868rrx5uju.gmgdl@evledraar.gmail.com> (=?utf-8?B?IsOG?=
 =?utf-8?B?dmFyIEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Fri, 22 Apr 2022 11:27:23 +0200")
Message-ID: <xmqq1qxpcd08.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 25878782-C257-11EC-9D38-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> For something like an external disk that may have its power cable yanke=
d
> I'd give it about even odds that it's HW v.s. git's own FS syncing logi=
c
> being at fault.

Given that the original report had this:

    Disk errors. After pushing to a directory (my origin field is C:\Work
    for example) the git repository will be corrupted.
    Moreover causing disk errors not only in the target git bare
    repository. I've loosed some other files.

that clearly stated that the corruption spreads outside repositories
managed (and written and fsynced) by Git, it does not seem likely
that Git's relying on "closing is enough as sync daemon will
eventually flush them" is the primary source of corruption.

The recent "are we fsyncing correctly?" topic is about how likely we
would survive in the presense of actions like unplugging without
unmounting.  It does not help a bit against flaky hardware, and even
when it helps, it is merely making the damage caused by such actions
less severe.
