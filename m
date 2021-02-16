Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 479D3C433DB
	for <git@archiver.kernel.org>; Tue, 16 Feb 2021 06:43:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1067B64E00
	for <git@archiver.kernel.org>; Tue, 16 Feb 2021 06:43:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229996AbhBPGn3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Feb 2021 01:43:29 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:55346 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229710AbhBPGn2 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Feb 2021 01:43:28 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 4227B112876;
        Tue, 16 Feb 2021 01:42:44 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=adAnJ61uy9PfM30CLmtOC1HbAdg=; b=DnXxT3
        EDFgLWlSGURAJKyYoj2Qp53hkvoJiR/TAoXejwTofBSrebFY2Ir25qBgZxNu0uQJ
        NmYqGnLtuAEQ1AHycScKG7PcvlZnp3Pvk/BYJbEtttqwZWTBLemIHxDGOPD6/C0/
        3eY6FtAYDI87OmTYRkZF3tD0pIucFwvrXessE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=P+1pHzdvzhBkeQ9f9dwD7ZuJZ3ReLPRQ
        vBfpMuzjG2Ei8D98Yure0nCV9tHsh0rNdRGglIJsvaPXYu01Epr4POC1kNpxax2Y
        b+xIsbpw2etFLK1VNBbbSz0kqDoWOCV7NNSqJqgyT2EoCIxuq6iD/ky6slqeDb1a
        b/XXGXI01IA=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 2EF79112874;
        Tue, 16 Feb 2021 01:42:44 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.243.138.161])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 6927D112873;
        Tue, 16 Feb 2021 01:42:41 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 8/9] stash show: teach --include-untracked and
 --only-untracked
References: <cover.1612258145.git.liu.denton@gmail.com>
        <cover.1612855690.git.liu.denton@gmail.com>
        <88d47912595b5650fbca595a6dd5b7b943a93301.1612855690.git.liu.denton@gmail.com>
        <xmqqa6sc4avx.fsf@gitster.c.googlers.com>
        <YCs46VzamjuDrQR9@generichostname>
Date:   Mon, 15 Feb 2021 22:42:39 -0800
In-Reply-To: <YCs46VzamjuDrQR9@generichostname> (Denton Liu's message of "Mon,
        15 Feb 2021 19:15:53 -0800")
Message-ID: <xmqq8s7osecg.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2AD0AFD0-7022-11EB-ABC7-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Denton Liu <liu.denton@gmail.com> writes:

> Hi Junio,
>
> On Tue, Feb 09, 2021 at 11:53:06PM -0800, Junio C Hamano wrote:
>> > Do this via something like
>> >
>> > 	GIT_INDEX_FILE=... git read-tree stash stash^3
>> >
>> > and diffing the resulting tree object against the stash base.
>> 
>> That explains the implementation, but does not make it clear what
>> the implementation wants to achieve.  So we read the tree from stash
>> (i.e. working tree) into a temporary index, and then overlay the
>> tree of stash^3 (i.e. untracked) on top---which means the resulting
>> "index" has the state of the working tree plus the untracked cruft
>> in it.  And comparing that with "stash base" (by the way is that a
>> term well understood?  I borrowed it for the above review comment,
>> which shows that there certainly is need for such a term) would show
>
> I'm not sure if it's a well-understood term but I can't think of any
> other meanings for the term so it doesn't seem very ambiguous.

Thanks.  I was hoping to hear either "Yes, glossary defines it like
this" or "I believe it is an unambiguous good term; let's add it to
the glossary".

> I'll send out my revised patch later today and I was unable to figure
> out an easy way of doing this.

OK.

