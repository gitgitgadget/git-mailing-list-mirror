Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F959C433F5
	for <git@archiver.kernel.org>; Thu, 21 Apr 2022 18:47:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1391529AbiDUSuc (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Apr 2022 14:50:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1386752AbiDUSu3 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Apr 2022 14:50:29 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA5254BFEE
        for <git@vger.kernel.org>; Thu, 21 Apr 2022 11:47:39 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 425DF1943A7;
        Thu, 21 Apr 2022 14:47:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=irMkevTUgq0cerePHY7IEK3urQUkdWj4Ppg7YA
        HgPRs=; b=UriOSIdUzVvin5JBXzxS3lOvLfRGCqJLAKzbhflF5L3fLLtINRcW3U
        l18ht18obEro7PrnF8x0k0xh063EThkPsdCqVIpJrfYCBXBVJzE/FbTP7kJqRlIa
        BXaSGjWCt+77rshd4NeKx2jQ+D5CjU6zuM6rSgDqlDRnF0wCP/EBI=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 2521D1943A5;
        Thu, 21 Apr 2022 14:47:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.105.84.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 8CAF11943A4;
        Thu, 21 Apr 2022 14:47:35 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     Taylor Blau <me@ttaylorr.com>, Glen Choo <chooglen@google.com>,
        Git List <git@vger.kernel.org>, justin@justinsteven.com,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        "Randall S. Becker" <rsbecker@nexbridge.com>
Subject: Re: Bare repositories in the working tree are a security risk
References: <kl6lsfqpygsj.fsf@chooglen-macbookpro.roam.corp.google.com>
        <kl6lwnfp7tbc.fsf@chooglen-macbookpro.roam.corp.google.com>
        <Ylobp7sntKeWTLDX@nand.local>
        <CAJoAoZkgnnvdymuBsM9Ja3+eYSnyohr=FQZMVX_uzZ_pkQhgaw@mail.gmail.com>
        <CAJoAoZkf6VuAOwX9j8Zc0x4HqJRJ5zQgqfmu+8Zs1kVx88dGpg@mail.gmail.com>
Date:   Thu, 21 Apr 2022 11:47:34 -0700
In-Reply-To: <CAJoAoZkf6VuAOwX9j8Zc0x4HqJRJ5zQgqfmu+8Zs1kVx88dGpg@mail.gmail.com>
        (Emily Shaffer's message of "Thu, 21 Apr 2022 11:29:15 -0700")
Message-ID: <xmqq4k2mi88p.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 828FE4EC-C1A3-11EC-9E3F-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Emily Shaffer <emilyshaffer@google.com> writes:

>> Nice - a more strict spin on proposal 3 from above, if I understand it
>> right. Rather than allowing any and all bare repos, avoid someone
>> sneaking in a malicious one next to legitimate ones by using an
>> allowlist. Seems reasonable to me.
>
> Ah, another thing I forgot to mention. There has been a little
> discussion in the past about isolating "safe" parts of config (and
> gitdir) from "unsafe" parts, e.g. "which configs and embedded scripts
> are executables", to help better protect from zipfile-type attacks,
> which are very similar to this kind of attack. I wonder if it makes
> sense to consider that sort of thing as a needswork for this bugfix?
> e.g. "/* NEEDSWORK: Only ignore unsafe configs and hooks instead of
> ignoring the entire embedded config and hooks in the future */"?

There have been such discussions in the past and they all went
nowhere because such safe-listing fundamentally does not work.  What
you consider "safe" today may turn out to be "unsafe" and in a later
version of Git will stop honoring it, and for those who depended on
it being listed as "safe", such a security fix will be a regression.

Disabling the whole thing if the file can be tainted is the only
sensible way forward without promising users that they will be hurt
by such changes/regressions in the future, I would think.

So, no, I do not think such a NEEDSWORK comment is welcome.

Thanks.


