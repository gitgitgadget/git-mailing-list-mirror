Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BCF8C433F5
	for <git@archiver.kernel.org>; Mon, 10 Oct 2022 17:35:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229747AbiJJRfA (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 Oct 2022 13:35:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbiJJRe5 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Oct 2022 13:34:57 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8187F17E01
        for <git@vger.kernel.org>; Mon, 10 Oct 2022 10:34:55 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id EE5491429BF;
        Mon, 10 Oct 2022 13:34:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=M2yaNK6P6V37
        K0J7s7PNCfl9MGJeVM7o80kK6ejko2k=; b=auvuunUDVwtq0ZIjVL8FuL40549n
        Pf8PKPcvzILHI+Y03k73MN3hR3WeXJCfvAxiJMSFTZxDGpOjp7G6v2NWf0A6/GHN
        O/qXgEF/p2CfuW7cWu6TVgSPM5wuiZ5LkX/BPxYQQZ/bb4G+U9S2hseBevCPVynK
        qK0eSUQbBqwbubg=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E50771429BE;
        Mon, 10 Oct 2022 13:34:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 46D851429BD;
        Mon, 10 Oct 2022 13:34:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, orygaw <orygaw@protonmail.com>,
        rsbecker@nexbridge.com, Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH] log: require --grep for --invert-grep and --all-match,
 fix segfault
References: <o2ijhZAUIi7nPTwQmsJfpvPIEeLbhvn1AP8rhW2hCNbC380Z2ogDHzZigqJsHI6RwphsIZR3OSJSy-wYvyWv5un632tKynHKFLFPLPEDH2g=@protonmail.com>
        <patch-1.1-f4b90799fce-20221010T165711Z-avarab@gmail.com>
Date:   Mon, 10 Oct 2022 10:34:53 -0700
In-Reply-To: <patch-1.1-f4b90799fce-20221010T165711Z-avarab@gmail.com>
 (=?utf-8?B?IsOGdmFyCUFybmZqw7Zyw7A=?= Bjarmason"'s message of "Mon, 10 Oct
 2022 18:57:42 +0200")
Message-ID: <xmqq7d174m6a.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: DA1596EE-48C1-11ED-B9A9-2AEEC5D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> Neither the "--invert-grep" option added in [1] nor the earlier
> "--all-match" option added in [2] were intended to be used
> stand-alone.

Mostly yes, but with "to be used" -> "to take effect".

"[alias] lga =3D log --all-match" would be equivalent to "log"
unless the command line starts talking about "--grep", which is
quite handy.

So the real fix would be not to forbid the standalone passing of the
option to the command, but to fix the over-eager freeing of an
unallocated resource, introduced more recently, I would suspect.

Thanks.
