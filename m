Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5318AC04A68
	for <git@archiver.kernel.org>; Thu, 28 Jul 2022 17:11:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230081AbiG1RLI (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 28 Jul 2022 13:11:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbiG1RLH (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Jul 2022 13:11:07 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C508F5C94F
        for <git@vger.kernel.org>; Thu, 28 Jul 2022 10:11:06 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 71F9814D492;
        Thu, 28 Jul 2022 13:11:04 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=4Y9BwOz5hO5/
        Wx+hqnFTjuwmZXe+H0sV867558S8bIA=; b=YPp9BL21ifnQEB1ONNCu+5BZxR4F
        6tNs9Ih624Bqc5s9hckHsCOSnO5JyirHRNxG5Fon1PVxE6GjIWkINNoz09225QKZ
        XvIWpuJ6LxglEhuTgoqN3MxK/nGApkjzEN7uoqzjXRrx3SW7UGBzWT/ZPTo6pfIl
        nY0rvmexsquU7dc=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 34CDF14D491;
        Thu, 28 Jul 2022 13:11:04 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.105.40.190])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 7529414D48D;
        Thu, 28 Jul 2022 13:11:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     =?utf-8?B?TGHEj2EgVGVzYcWZw61r?= <lada.tesarik@olc.cz>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Lost file after git merge
References: <HE1PR0501MB24096E2FBDB66318A2FDADAAF8969@HE1PR0501MB2409.eurprd05.prod.outlook.com>
        <220728.865yjhl8wk.gmgdl@evledraar.gmail.com>
Date:   Thu, 28 Jul 2022 10:11:00 -0700
In-Reply-To: <220728.865yjhl8wk.gmgdl@evledraar.gmail.com> (=?utf-8?B?IsOG?=
 =?utf-8?B?dmFyIEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Thu, 28 Jul 2022 14:17:51 +0200")
Message-ID: <xmqqilnhcgd7.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 42172532-0E98-11ED-8B86-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> On Thu, Jul 28 2022, La=C4=8Fa Tesa=C5=99=C3=ADk wrote:
>
>> 1. I added a file called 'new_file' to a master branch.
>> 2. Then I created branch feature/2 and deleted the file in master
>> 3. Then I deleted the file in branch feature/2 as well.
>> 4. I created 'new_file' on branch feature/2 again.

It heavily depends on how this creation is done, i.e. what went into
the created file.  Imagine that a file existed with content A at
commit 0, both commits 1 and 2 removed it on their forked history,
and then commit 3 added exactly the same content A to the same path:

          1---3
         /     \
    ----0---2---4---->

When you are about to merge 2 and 3 to create 4, what would a
three-way merge see?

    0 had content A at path P
    2 said "no we do not want content A at path P"
    3 said "we are happy with content A at path P"

So the net result is that 0-->3 "one side did not touch A at P" and
0-->2 "one side removed A at P". =20

Three-way merge between X and Y is all about taking what X did if Y
didn't have any opinion on what X touched.  This is exactly that
case.  The history 0--->3 didn't have any opinion on what should be
in P or whether P should exist, and that is why there is no change
between these two endpoints.  The history 0--->2 does care---it feels
that it is detrimental to the project to have P hence it removed.

So the end result will remove P, if 3 added identical content as
existed at 0 and removed at 1.

If 3 added something different, then the picture becomes entirely
different.  The history 0--->3 no longer has "no opinion".  It
strongly believes that P having content A at 0 was wrong, and it
should have content B, hence it changed it.  Now when that opinion
collides with the opinion of the history 0--->2 that says it is
wrong to have content A at path P, the person who is creating the
merge at 4 needs to think and resolve.
