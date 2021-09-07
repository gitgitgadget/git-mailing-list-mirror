Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25686C433EF
	for <git@archiver.kernel.org>; Tue,  7 Sep 2021 18:32:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 02F2461108
	for <git@archiver.kernel.org>; Tue,  7 Sep 2021 18:32:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345846AbhIGSd7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Sep 2021 14:33:59 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:53865 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236461AbhIGSd7 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Sep 2021 14:33:59 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 984EE15F65F;
        Tue,  7 Sep 2021 14:32:52 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=GO9a9d1f0rJiqUS56xHVuNW+Cw3YIDZCEvjOIg
        m3tn8=; b=XoTCJEOS9zLCC7EQ5uQoLm8bBtyFHcdioo2D6nA8qrhC3tsMKs3gl9
        w2cykRfStbBkIXyS0Z7Tgm77FWuAYPM2C9eYpXqeLxmJ6PTgPG2mjgMP1dQiV+2R
        OJdYMayHvFBKBZKgcRb2YrWzJAYqLENt16Q+emKLT090T2W4gx/vw=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 90BBB15F65E;
        Tue,  7 Sep 2021 14:32:52 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.196.172.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id C347A15F65D;
        Tue,  7 Sep 2021 14:32:48 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Miriam R." <mirucam@gmail.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git <git@vger.kernel.org>,
        Tanushree Tumane <tanushreetumane@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v6 5/6] bisect--helper: reimplement `bisect_run` shell
References: <20210902090421.93113-1-mirucam@gmail.com>
        <20210902090421.93113-6-mirucam@gmail.com>
        <xmqqtuj2h7cp.fsf@gitster.g>
        <nycvar.QRO.7.76.6.2109060923390.55@tvgsbejvaqbjf.bet>
        <CAN7CjDANWsWwPcAG2cftAiadwaWZNXBtL=Q8MrqH2xVMj7kUOg@mail.gmail.com>
Date:   Tue, 07 Sep 2021 11:32:47 -0700
In-Reply-To: <CAN7CjDANWsWwPcAG2cftAiadwaWZNXBtL=Q8MrqH2xVMj7kUOg@mail.gmail.com>
        (Miriam R.'s message of "Mon, 6 Sep 2021 10:34:35 +0200")
Message-ID: <xmqqlf48b5io.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 00A50944-100A-11EC-91D8-F327CE9DA9D6-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Miriam R." <mirucam@gmail.com> writes:

>> However, I still don't like that we play such a `dup2()` game. I gave it a
>> quick try to avoid it (see the diff below, which corresponds to the commit
>> I pushed up as `git-bisect-work-part4-v7` to
>> https://github.com/dscho/git), which still could benefit from a bit of
>> polishing (maybe we should rethink the object model and extend/rename
>> `bisect_terms` to `bisect_state` and accumulate more fields, such as
>> `out_fd`.
>>
>> Obviously this will need to be cleaned up, and while I would _love_ to see
>> this make it into your next iteration, ultimately it is up to you, Miriam,
>> to decide whether you want to build on my diff (quite possibly making the
>> entire object model of the bisect part of Git's code more elegant and more
>> maintainable), and up to you, Junio, to decide whether you would be
>> willing to accept the patch series without this refactoring.

If the code paths involved are shallow and narrow enough that not
too many existing callers need to start passing FILE *stdout down
(from the looks of your illustration patch, it does not seem to be
too bad), I do not mind a series that is a bit longer than the
current 6-patch series that has a preliminary enhancement step that
allows callers to pass their own "FILE *" for output destination
before the main part of the topic.

Thanks.
