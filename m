Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BD58C433EF
	for <git@archiver.kernel.org>; Mon, 25 Jul 2022 01:03:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231357AbiGYBDg (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 24 Jul 2022 21:03:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbiGYBDf (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 24 Jul 2022 21:03:35 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB502AE5A
        for <git@vger.kernel.org>; Sun, 24 Jul 2022 18:03:34 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 5FD8519D60D;
        Sun, 24 Jul 2022 21:03:32 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=0f2T9BBn9UD5kQQOLKP+1ceAaieUjwY/HxRe/P
        OOP4I=; b=BzvC2uGZYxV7Z8dqbGzNEGSgUJg8o0sNu7VkyvJs6YIMotooBGmhgX
        yHDXuYL104dtuo/8kiHdKLtWJqGZnlaWMACxVD/PU8Q/5/+r49jWe5S2qrlwpqsA
        F1r5khpk88fpxtshg/MoXaVscEpMkuNiIlrEctsPWQ1mWGvpX0m0k=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 586B319D60C;
        Sun, 24 Jul 2022 21:03:32 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.105.40.190])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 022BA19D60B;
        Sun, 24 Jul 2022 21:03:29 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     ZheNing Hu <adlternative@gmail.com>
Cc:     ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
Subject: Re: [PATCH v8] ls-files: introduce "--format" option
References: <pull.1262.v7.git.1657692472994.gitgitgadget@gmail.com>
        <pull.1262.v8.git.1658334983053.gitgitgadget@gmail.com>
        <xmqqbktj3ct7.fsf@gitster.g>
        <CAOLTT8RjLoooT7t+ucFqa9P=8TiVL3M+ZgcEY7qVhRbjB=9OhA@mail.gmail.com>
        <xmqqsfmr8ygp.fsf@gitster.g>
        <CAOLTT8RqMU-k85LmcpY0wATHSDoWDEQLnPtfuZ2OC2nWN9305A@mail.gmail.com>
Date:   Sun, 24 Jul 2022 18:03:27 -0700
In-Reply-To: <CAOLTT8RqMU-k85LmcpY0wATHSDoWDEQLnPtfuZ2OC2nWN9305A@mail.gmail.com>
        (ZheNing Hu's message of "Sun, 24 Jul 2022 19:08:00 +0800")
Message-ID: <xmqq7d4280m8.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 98495EC4-0BB5-11ED-A3DD-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

ZheNing Hu <adlternative@gmail.com> writes:

>> That was not the point.  By extracting only "%(objectmode)" without
>> having any other clues (like "%(path)") on the same line, the test
>> is assuming that ls-files will always sort its output in the same
>> order regardless of the output format, whether it is "--stage" or
>> "--format=<spec>", and that was what the "is this testing the right
>> thing?" question was about.
>>
>
> Ah, so that we should sort the ls-files output first, and then compare them.

Imagine that there are three paths in the index and "ls-files -s"
gives

    100644 1234... 0 path1
    100644 2345... 0 path2
    100755 3456... 0 path3

but a bug causes "ls-files --format=<spec>" to show entries in a
wrong order, e.g. first for path2 and then for path1 and then for
path3.  If the test used enough fields (like the one that mimics the
full output of "ls-files -s"), then the output may be

    100644 2345... 0 path2
    100644 1234... 0 path1
    100755 3456... 0 path3

and you would notice that it is different from "ls-files -s".

But if the test only used %(objectmode), then the faulty output from
"ls-files --format=%(objectmode)" would be

    100644
    100644
    100755

that matches the "ls-files -s | cut -d' ' -f1"

If you sort, then such a breakage will become even harder to
notice.  If the faulty output showed path3 first and then path2 and
then path1, the raw output from "ls-files --format=%(objectmode)" may
be 100755/100644/100644, but if you sort it, no matter what the
broken order is, you will always get 100644/100644/100755.

So, no, we shouldn't sort.  If ls-files were allowed to show output
in any random order, then sorting the output before comparing is a
good strategy, but that does not apply here.
