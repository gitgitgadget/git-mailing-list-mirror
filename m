Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEAECC433F5
	for <git@archiver.kernel.org>; Wed, 16 Feb 2022 18:49:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237845AbiBPSuK (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Feb 2022 13:50:10 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:55180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237719AbiBPSuJ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Feb 2022 13:50:09 -0500
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07B0A2AE061
        for <git@vger.kernel.org>; Wed, 16 Feb 2022 10:49:56 -0800 (PST)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id B0E8117C0CC;
        Wed, 16 Feb 2022 13:49:56 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=NS7QbJHnzJtG
        /+3YIGMDjIdNk6vT0k1LXuDDydvFJu4=; b=BZFwLm5LgmZJGO0AoNvHSwyveJ9l
        RjTX9sh0l55cUvHv0G8/oVjDri7PiHoRsn6zHUITXfJA9/kCJ2MPZoSRG0J9BMsj
        y3Zw14kvXiGxUo9qRO/SfiMTLfMwZ2U1qEgNgxxAzxXHEB9gcJkud0qfZLjOCOud
        nFIZxs3i8TRzIck=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id A8B7417C0CB;
        Wed, 16 Feb 2022 13:49:56 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.185.212.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 1138B17C0C9;
        Wed, 16 Feb 2022 13:49:54 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Victoria Dye <vdye@github.com>
Cc:     Elijah Newren <newren@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <stolee@gmail.com>,
        Lessley Dennington <lessleydennington@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH v3 5/5] sparse-checkout: reject arguments in cone-mode
 that look like patterns
References: <pull.1118.v2.git.1644913943.gitgitgadget@gmail.com>
        <pull.1118.v3.git.1644985283.gitgitgadget@gmail.com>
        <2008542d0c718bbe43388297307a791f94bc73e1.1644985283.git.gitgitgadget@gmail.com>
        <220216.8635kjuob0.gmgdl@evledraar.gmail.com>
        <CABPp-BEBX4tWwqkG=7+rcZa_EJzOC2+Rg214av_+-yymHTQGQw@mail.gmail.com>
        <af439020-8314-9171-4300-94a5102c8a38@github.com>
Date:   Wed, 16 Feb 2022 10:49:52 -0800
In-Reply-To: <af439020-8314-9171-4300-94a5102c8a38@github.com> (Victoria Dye's
        message of "Wed, 16 Feb 2022 09:20:08 -0800")
Message-ID: <xmqqpmnmsl2n.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 3AABF5CA-8F59-11EC-B335-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Victoria Dye <vdye@github.com> writes:

>> I considered strtok, but strtok & strtok_r are documented as modifying
>> their argument.  Perhaps they don't modify the argument if they don't
>> find any of the listed tokens, but I didn't want to rely on that since
>> I found no guarantees in the documentation.
>
> Maybe `strpbrk` would work? Unless I'm misunderstanding, it should
> consolidate the condition to one line without potentially modifying the
> arguments. E.g.:=20
>
> 	if (!strpbrk(argv[i], "*?[]"))
> 		die(_("specify directories rather than patterns.  If your directory r=
eally has any of '*?[]' in it, pass --skip-checks"));

Yes, either that or strspn() are good match for the problem (I
suspect =C3=86var actually meant strspn() not strtok() in the first
place, though ;-).

