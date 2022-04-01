Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B0B4C433EF
	for <git@archiver.kernel.org>; Fri,  1 Apr 2022 19:32:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351166AbiDATem (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 1 Apr 2022 15:34:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346921AbiDATel (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Apr 2022 15:34:41 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6119176678
        for <git@vger.kernel.org>; Fri,  1 Apr 2022 12:32:50 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 0CE94191269;
        Fri,  1 Apr 2022 15:32:50 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=uf3d3Uj8ZRA1
        wH0VojGOlfw37b8AdXUWZudc4omR3rk=; b=Y0qbUFSTUgESLnESzvGpKwTOpcVf
        +0gFZ5ywNQoeBqJVTT73kzIpJgPav8IyDx2q8t5ItfHYGsmXFadx9swkxGxDlm43
        KBm9a1x9yGNelQkHHvAMau2bsy8WUPVOFe7WK4KGbrnDVM3CPDFNmCMl9rmP81zM
        Te6jgobxpUBEuYA=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 05C87191268;
        Fri,  1 Apr 2022 15:32:50 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.227.145.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 668CC191267;
        Fri,  1 Apr 2022 15:32:47 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Phillip Wood <phillip.wood123@gmail.com>, git@vger.kernel.org,
        Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH v4 04/27] format-patch: don't leak "extra_headers" or
 "ref_message_ids"
References: <cover-v3-00.27-00000000000-20220325T171340Z-avarab@gmail.com>
        <cover-v4-00.27-00000000000-20220331T005325Z-avarab@gmail.com>
        <patch-v4-04.27-69f0aabe38f-20220331T005325Z-avarab@gmail.com>
        <851584aa-a31d-7446-4994-e641f298f0cd@gmail.com>
        <220401.868rsoogxf.gmgdl@evledraar.gmail.com>
Date:   Fri, 01 Apr 2022 12:32:46 -0700
In-Reply-To: <220401.868rsoogxf.gmgdl@evledraar.gmail.com> (=?utf-8?B?IsOG?=
 =?utf-8?B?dmFyIEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Fri, 01 Apr 2022 19:16:38 +0200")
Message-ID: <xmqq35iwwqe9.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 82AF3DDA-B1F2-11EC-82B0-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> The below patch fails tests, it's just a quick (and obviously flawed)
> search/replacement that I hacked up to get the removal of these from
> revision.h to compile, which shows that it's just something between
> log.c and log-tree.c, pretty much.

Given that the way most end-users see log-tree.c in action is via
log.c (is there a useful entry point into log-tree that bypasses
log.c that implements end-user actions?), I would actually think it
is that extra_headers is quite an integral part of rev_info
structure, which is how the revision traversal API passes
information relevant to the current traversal around various layors
of the implementation.  So, I am not sure what the above experiment
shows us.

> Anyway, while I'm 100% in agreement with you that this *should* be fixe=
d
> I'd really like to do the bare minimum to address leaks in this initial
> iteration.
>
> I.e. you're right that this relatively fragile, and I'm also concern
> about catching memory errors.

As long as we know there are yet more work to do (are we leaving
NEEDSWORK comments as we go, by the way?), I think that's fine.  We
cannot go all the way in one go for a large code base like revisions
API, and we can leave a small corner "not quite optimial", and we can
even leave it in "sometimes still leaks" status, as long as we never
make anything to free too much by mistake.
