Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A321C4338F
	for <git@archiver.kernel.org>; Tue,  3 Aug 2021 21:47:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4573260231
	for <git@archiver.kernel.org>; Tue,  3 Aug 2021 21:47:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230124AbhHCVrw (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 3 Aug 2021 17:47:52 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:56456 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229577AbhHCVro (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Aug 2021 17:47:44 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 42624DAC51;
        Tue,  3 Aug 2021 17:47:31 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=hVcJ0J200IapaW1iQtaMt0qWqls4Ui11/HKbWu
        2KM+o=; b=IR0mPJ6MKzsglrcF71iEXkwcPIVUOauPta2C0lCiuY4LdeXQdARfjh
        +srY551j65u/Y0UIlHEZ0CpWYIZ/sWcdaeuGj5cZi8u+odKUGqnY/rs5RkaxsCq0
        0JUHzBlhUqGN4P/58P4lN76AO47pvSEnoz6344T89pYFs41icxKws=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 38F13DAC50;
        Tue,  3 Aug 2021 17:47:31 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.71.182])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id AF2DFDAC4E;
        Tue,  3 Aug 2021 17:47:30 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Patrick Steinhardt <ps@pks.im>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Chris Torek <chris.torek@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH v3 1/4] connected: do not sort input revisions
References: <cover.1624858240.git.ps@pks.im> <cover.1627896460.git.ps@pks.im>
        <1fd83f726a04dfb5be27c74cb116618cb76be923.1627896460.git.ps@pks.im>
        <xmqqa6lzwu31.fsf@gitster.g> <YQkEdYi/7vrS9ydC@ncase>
Date:   Tue, 03 Aug 2021 14:47:30 -0700
In-Reply-To: <YQkEdYi/7vrS9ydC@ncase> (Patrick Steinhardt's message of "Tue, 3
        Aug 2021 10:55:17 +0200")
Message-ID: <xmqqr1fatd3h.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 6727581A-F4A4-11EB-92CA-FD8818BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Patrick Steinhardt <ps@pks.im> writes:

>> I however suspect that in the longer term it may be cleaner to get
>> rid of REVSISION_WALK_NO_WALK_UNSORTED if we do this.  The knob that
>> controls if we sort the initial traversal tips and the knob that
>> controls if we walk from these tips used to be tied to --no-walk
>> only because ca92e59e30b wanted to affect only no-walk case, but
>> with your new finding, it clearly is not limited to the no-walk case
>> to want to avoid sorting.
>
> Right. The question also is what to do when the user calls `git rev-list
> --no-walk=sorted --unsorted-input`. Do we sort? Don't we? Should we mark
> these options as incompatible with each other and bail out? I guess just
> bailing out would be the easiest solution for now.

I'd say so.  Even without the future clean-up to get rid of the
NO_WALK_UNSORTED, the issue already exists with this series, and
when in doubt, it is easiest to start tight and take our time to
figure out what the right behaviour should be while we initially
do not allow both to be used at the same time.
