Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB1A4C433F5
	for <git@archiver.kernel.org>; Tue, 21 Dec 2021 02:10:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230356AbhLUCKj (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Dec 2021 21:10:39 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:51418 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229558AbhLUCKi (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Dec 2021 21:10:38 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C6A46FE08A;
        Mon, 20 Dec 2021 21:10:37 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=tW6YjZzpJnlB
        3F4i6Nt7Uo1roTlV/q/zJqyrXTn5IEA=; b=wXRPhqoAy5GWRUbNAm/gB5SMycth
        KyznsdisK1kXMiHbLD2rN75A6/vym75/Oq4Vyj5ARImerptHIzmZepcSSuuXYrse
        zLq5ryfdKnYCHGGG44ddCjgoYdtJjQt1QHtQ4cB6tl/V3amReRIk8smZY4DbTips
        bi7LTOOxu0S9GV0=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A5FB8FE088;
        Mon, 20 Dec 2021 21:10:37 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id EDE10FE087;
        Mon, 20 Dec 2021 21:10:36 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Derrick Stolee <stolee@gmail.com>, git@vger.kernel.org,
        Derrick Stolee <derrickstolee@github.com>,
        Adam Spiers <git@adamspiers.org>, Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 03/13] init: unconditionally create the "info" directory
References: <cover-00.13-00000000000-20211212T201308Z-avarab@gmail.com>
        <patch-03.13-784b7947512-20211212T201308Z-avarab@gmail.com>
        <db6f47a3-0df3-505b-b391-6ca289fd61b5@gmail.com>
        <211220.86tuf3utv9.gmgdl@evledraar.gmail.com>
        <d2399072-ce9d-b654-42b4-d08d973c488e@gmail.com>
        <xmqq1r27xfi4.fsf@gitster.g>
        <211221.861r26u4b9.gmgdl@evledraar.gmail.com>
Date:   Mon, 20 Dec 2021 18:10:35 -0800
In-Reply-To: <211221.861r26u4b9.gmgdl@evledraar.gmail.com> (=?utf-8?B?IsOG?=
 =?utf-8?B?dmFyIEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Tue, 21 Dec 2021 02:15:11 +0100")
Message-ID: <xmqqr1a6so6c.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 2FEA14E2-6203-11EC-B492-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> I don't see why we'd consider that as a worthwhile direction to go
> in. The "git-init" documentation states:
>    =20
>     This command creates an empty Git repository - basically a `.git`
>     directory with subdirectories for `objects`, `refs/heads`,
>     `refs/tags`, and template files.=20
>
> I.e. we promise to create "objects", but not "objects/{info,pack}", eve=
n
> though we've done so since f49fb35d0d5 (git-init-db: create "pack"
> subdirectory under objects, 2005-06-27) and d57306c7945 (Create
> objects/info/ directory in init-db., 2005-08-20).

I view it as a documentation bug, though.

The only thing we need to promise is that (1) the directory prepared
by "git init" will be recognised as a repository by the current and
future versions of Git (and hopefully the existing ones, too), and
(2) versions of Git will not barf due to missing directory and stuff
due to end-user mischief around custom templates.  I do not think we
even need refs/heads/ directory and I do not see that, especially
with a presence with "basically" there, the sentence promises that
we will always create refs/tags/ directory.  For (1), only objects/,
refs/ and HEAD is necessary, as long as (2) is satisfied by lazy
creation of leading paths.

We would want to be able to cope with a repository that lost
.git/info directory due to loss of it in custom templates anyway.
Just like we create leading missing directories lazily for any
hierarchy under .git/, we should create .git/info on-demand.

Pre-creating .git/info might be nice, but becomes much less
important after it happens, and that is why I view it as a much
lower priority than what Derrick suggested.
