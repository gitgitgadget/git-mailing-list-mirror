Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC247C433EF
	for <git@archiver.kernel.org>; Mon,  8 Nov 2021 20:11:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C4C94619E4
	for <git@archiver.kernel.org>; Mon,  8 Nov 2021 20:11:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238475AbhKHUOU (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 Nov 2021 15:14:20 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:54229 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231251AbhKHUOT (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Nov 2021 15:14:19 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 29F25168F75;
        Mon,  8 Nov 2021 15:11:35 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=ea6TdpXBW/Zn
        QqcWw4iGWHQkjt4Z1FUEssxQ5InTtdQ=; b=REeUILzzx4PCDsspT6fg305Tl9FQ
        zyo6WLJpDbldx6k8qzavJTKNP5bFNff7hEzPDgFUvSzcBSdW7os/773Z3u08QZDa
        EG9vVzUyjrzi3meACSt8/xyBWVYlJj8HaCfjk3ObRX+bMA6KP6F9TF9qumUXgGB2
        2qKN4qGeUFJeu1A=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 21F3F168F74;
        Mon,  8 Nov 2021 15:11:35 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 84871168F73;
        Mon,  8 Nov 2021 15:11:32 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     John Cai <jcai@gitlab.com>,
        John Cai via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, John Cai <johncai86@gmail.com>
Subject: Re: [PATCH 1/2] cat-file: force flush of stdout on empty string
References: <pull.1124.git.git.1636149400.gitgitgadget@gmail.com>
        <2d687baeed82e7b90d383bad8e209f50e0ce8c87.1636149400.git.gitgitgadget@gmail.com>
        <xmqqsfwaumlc.fsf@gitster.g>
        <211106.86k0hmgc8q.gmgdl@evledraar.gmail.com>
        <20211108034254.ycdhvkdng63abput@Johns-MacBook-Pro-3.local>
        <211108.86h7cmfw33.gmgdl@evledraar.gmail.com>
Date:   Mon, 08 Nov 2021 12:11:31 -0800
In-Reply-To: <211108.86h7cmfw33.gmgdl@evledraar.gmail.com> (=?utf-8?B?IsOG?=
 =?utf-8?B?dmFyIEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Mon, 08 Nov 2021 16:15:38 +0100")
Message-ID: <xmqqk0hitnkc.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 1114C1C4-40D0-11EC-9D7C-98D80D944F46-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

>> I think overall this approach is cleaner and makes sense. My only
>> question is, are there more commands in the future that will need some
>> special command syntax? Just wondering whether YAGNI applies here.
>
> An obvious addition is to at least add the ability to set the various
> options on the fly, i.e. now you need to use --batch-check, and then
> kill it and restart if you'd like the content with --batch, ditto for
> --textconv.
>
> E.g. the gitaly backend for gitlab.com keeps two cat-filfe processes
> around just to flip-flop between those two, sometimes you want the
> content, sometimes you're just checking if the object exists.
>
> I'd also like to add something to expose the likes of -e and -t
> directly, i.e. even with --batch-check you often want to just check
> existence, but get the size too, you could supply a format, but like th=
e
> above you sometimes want the size or whatever, and killing/starting a
> new process just for that is a hassle...

Yeah, with "plug" and "unplug" instruction you do not have to keep
issuing "flush" when you want to go interactive, and other things
become easy to do, so even though it would make it a bit more
verbose to require "object " prefix for the kind of lines that were
historically the only ones accepted by the command, I think it is a
good direction to go in.

Thanks.
