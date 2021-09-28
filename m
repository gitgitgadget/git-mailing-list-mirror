Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEA53C433F5
	for <git@archiver.kernel.org>; Tue, 28 Sep 2021 17:25:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A4D196128B
	for <git@archiver.kernel.org>; Tue, 28 Sep 2021 17:25:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242055AbhI1R0x (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Sep 2021 13:26:53 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:50614 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229869AbhI1R0w (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Sep 2021 13:26:52 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id B1B001495AF;
        Tue, 28 Sep 2021 13:25:12 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=tqdNMnOkNEig
        mnLuJYcagGPx+WDtIWl223X4+kr0w2U=; b=MSnxsEmypXI7Iyfx27PZMMVf+ppK
        BZiMK+6aP7pNw7x5IOIsEYGa5uuSlsgbrBPqB3q2tom8XL175I78hQTHVZ5S5Rbj
        NY+GEZnTPd7xn3eyuah5oGBK74clU51NwZTtAnMwc53nQF5HBpGcd2KrI/57I79E
        FhvvL475jNlsbLk=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id A95D41495AE;
        Tue, 28 Sep 2021 13:25:12 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 0E4151495AC;
        Tue, 28 Sep 2021 13:25:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Elijah Newren <newren@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jeff King <peff@peff.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Neeraj Singh <neerajsi@microsoft.com>
Subject: Re: What's cooking in git.git (Sep 2021, #08; Mon, 27)
References: <xmqq8rzhmsi7.fsf@gitster.g>
        <CABPp-BGuzd_TH57-1RvwJQD5r3S3ZkJcuiPnU8aWee8pgzUBEw@mail.gmail.com>
        <87v92lxhh4.fsf@evledraar.gmail.com>
Date:   Tue, 28 Sep 2021 10:25:08 -0700
In-Reply-To: <87v92lxhh4.fsf@evledraar.gmail.com> (=?utf-8?B?IsOGdmFyIEFy?=
 =?utf-8?B?bmZqw7Zyw7A=?= Bjarmason"'s
        message of "Tue, 28 Sep 2021 09:45:25 +0200")
Message-ID: <xmqqilykliiz.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 081EB0C6-2081-11EC-8921-F327CE9DA9D6-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> I haven't poked at it much, but haven't you and Neeraj Singh (CC'd)
> independently come up with two slightly different changes in
> tmp-objdir.c to do the same thing? See the tmp-objdir.c part of:
>
> http://lore.kernel.org/git/543ea3569342165363c1602ce36683a54dce7a0b.163=
2527609.git.gitgitgadget@gmail.com
>
> And your:
>
> http://lore.kernel.org/git/67d3b2b09f9ddda616cdd0d1b12ab7afc73670ed.163=
0376800.git.gitgitgadget@gmail.com
>
> I.e. yours has the object database managed outside, his has it added to
> "struct tmp_objdir", but it's the same objdir dance isn't it?

They touch the same tmp-objdir, but unlike the original use in the
receive-pack (i.e. responding to "git push") with the intention to
add the objects collected in them back to the primary, remerge-diff
wants to discard what was added there at the end.  I do not think it
would directly help the bulk-fsync stuff (but I didn't quite see why
bulk-fsync stuff needed to _add_ new functions to tmp-objdir API,
instead of just being a customer of tmp-objdir API), where it wants
to do the same _migrate() dance in the end.
