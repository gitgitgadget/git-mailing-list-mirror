Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E1BCC433F5
	for <git@archiver.kernel.org>; Fri,  7 Jan 2022 20:56:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229605AbiAGU43 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 7 Jan 2022 15:56:29 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:59777 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbiAGU42 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Jan 2022 15:56:28 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 23AF5F9477;
        Fri,  7 Jan 2022 15:56:27 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=jGaMJW6nF8R6IJkf8JevYMR+mELumFWMLNoMbp
        Y0OlM=; b=R+xVqN6QOtHpOjY2TYDERBwZYIYkYHsh8QrYPo5vCqTRITYOdaWEmw
        fVHHzUwdI/kiQNUVhV2ZNwYLJmQj1MAYZ0fC2I0TkBpzETWf49QtjuGoXK/uJIZc
        aPHSgj0MtutwOo+eEnn0D6gKXO1PjM7hg/Ba+vSTr4DhQ7RFL4CjY=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 1A05AF9475;
        Fri,  7 Jan 2022 15:56:27 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 7EECAF9474;
        Fri,  7 Jan 2022 15:56:26 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Christian Couder <chriscool@tuxfamily.org>,
        Taylor Blau <me@ttaylorr.com>,
        Johannes Altmanninger <aclopte@gmail.com>
Subject: Re: [PATCH v2 4/8] merge-tree: implement real merges
References: <pull.1114.git.git.1640927044.gitgitgadget@gmail.com>
        <pull.1114.v2.git.git.1641403655.gitgitgadget@gmail.com>
        <1710ba4a9e432e2a854579c4c929e7f2cfc92211.1641403655.git.gitgitgadget@gmail.com>
        <nycvar.QRO.7.76.6.2201071602110.339@tvgsbejvaqbjf.bet>
        <CABPp-BFUJ6pU_CKM7ccnFvi0nkeeGfd2GETdksKLaz=B_=BZAQ@mail.gmail.com>
Date:   Fri, 07 Jan 2022 12:56:25 -0800
In-Reply-To: <CABPp-BFUJ6pU_CKM7ccnFvi0nkeeGfd2GETdksKLaz=B_=BZAQ@mail.gmail.com>
        (Elijah Newren's message of "Fri, 7 Jan 2022 09:26:31 -0800")
Message-ID: <xmqqmtk78dty.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 479A8106-6FFC-11EC-B231-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

>>    'git merge-tree' [--write-tree] <branch1> <branch2>
>>    'git merge-tree' [--demo-trivial-merge] <base-tree> <branch1> <branch2>
>>
>> That way, the old mode can still function, and can even at some stage be
>> deprecated and eventually removed.
>
> Ooh, interesting.

I wondered if we can _also_ extend the trivial-merge mode so that we
do not have to call it "demo".

The internal result is expressed in this way:

    struct merge_list {
            struct merge_list *next;
            struct merge_list *link;	/* other stages for this object */

            unsigned int stage : 2;
            unsigned int mode;
            const char *path;
            struct blob *blob;
    };

because the command was not designed to resolve content level
merges, but show the half-resolved state with the "stage" number.
The "explanation" the command gives on the result is truly trivial,
but there is no reason for it to stay that way.
