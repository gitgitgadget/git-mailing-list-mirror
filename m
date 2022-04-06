Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49CE4C433EF
	for <git@archiver.kernel.org>; Wed,  6 Apr 2022 18:13:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240466AbiDFSPk (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 6 Apr 2022 14:15:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240470AbiDFSPP (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Apr 2022 14:15:15 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F074723CC4B
        for <git@vger.kernel.org>; Wed,  6 Apr 2022 09:52:59 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 268CB1304C5;
        Wed,  6 Apr 2022 12:52:59 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=IrtGeTefxpoy
        /loc0PBbzzwqqyj7j0C/dBRmYvxflGM=; b=g88PHievdgPTs+yGq3UWpRDWfcDL
        p1KXOG98x5nGB16FoaeShM/YDH8aQsdMXdU3ah9+I4VWqRTP6qI8OB3sv6lxncjf
        tvTm3IT1BXJMsyZ9w2j4qSSAWFuYQ/MN3kTG8aRxuBR+Hpm3nvJ1LbnX8w7jQCVy
        ra8tz9BygT/rIQI=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 1DF371304C4;
        Wed,  6 Apr 2022 12:52:59 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.185.214.157])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 824761304C3;
        Wed,  6 Apr 2022 12:52:58 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Edmundo Carmona Antoranz <eantoranz@gmail.com>, whydoubt@gmail.com,
        git@vger.kernel.org
Subject: Re: [PATCH v3] blame: report correct number of lines in progress
 when using ranges
References: <20220405165806.842520-1-eantoranz@gmail.com>
        <220406.86wng2eh0l.gmgdl@evledraar.gmail.com>
Date:   Wed, 06 Apr 2022 09:52:57 -0700
In-Reply-To: <220406.86wng2eh0l.gmgdl@evledraar.gmail.com> (=?utf-8?B?IsOG?=
 =?utf-8?B?dmFyIEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Wed, 06 Apr 2022 10:35:43 +0200")
Message-ID: <xmqq7d82yx06.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 0353EF1E-B5CA-11EC-8BE2-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> Are the small number of missing steps above expected? E.g. 1-2/7 and 5/=
7
> in the last tets above, ditto the rest?
>
> Mm, yes, looking at assign_blame() in blame.c we'll "skip" some.
>
> So if we ever change that algorithm we'll need to adjust these, but it'=
s
> probably good to notice that then, even if the test_cmp here does
> implicitly encode a bit of internal implementation details, i.e. when
> exactly we update the progress bar.

I do not think that is something we want to test, or distract the
developers by forcing them to update the skipping hardcoded in the
test.

Is it easy to grab the last progress message from the output?  What
we care, and have cared in the past, is that we expect that the 100%
is paired with the number of lines in the ranges, and the progress
actually ends at 100% (we had different bugs that did not bring the
meter to 100% at the end), so checking that end result would be what
matters most, e.g.

    tr '\015' '\012' output | tail -n 1

or something?

