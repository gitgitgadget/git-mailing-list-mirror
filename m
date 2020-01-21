Return-Path: <SRS0=4+BP=3K=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED7E6C2D0CE
	for <git@archiver.kernel.org>; Tue, 21 Jan 2020 22:02:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD8AA24125
	for <git@archiver.kernel.org>; Tue, 21 Jan 2020 22:02:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="QGa4S/Zj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728894AbgAUWCz (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Jan 2020 17:02:55 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:64642 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728799AbgAUWCz (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Jan 2020 17:02:55 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 45B8B18B98;
        Tue, 21 Jan 2020 17:02:53 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=pnsSX1vT+Clu4MWCM3nI3C/9zug=; b=QGa4S/
        ZjDWFHikWTpeZW9wemihNIrZphm+T6mp7K6fOnT9ivj9eUNlSQ6eDUK/iDnnuojU
        IG+8yCDAVXV8ym3l2aChQIVbyXDbsA2z71YBNvC0dvqHg/E2H2Yz0jdaMAcuhj4P
        e4+1ZFaRTdTfV/MnAaYNnJxWGGjSet61HEWBA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=bi/mqcuxO7ZVVVqrRcklKlSSCbEYDNsb
        mpB+frgVXHAczXCTGwYejqHtQ/r9zdjXkhTqQl6NCJNMr3d+0U63mJB+SV/P6tpg
        L8sn9IQ+54FiXLBumVmY5LDpii5+7eNR8aryUyuCF4ax/T6nI8JJipwy73jyqOpJ
        xjDzxym7nK0=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 3C2DD18B97;
        Tue, 21 Jan 2020 17:02:53 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 78A8018B96;
        Tue, 21 Jan 2020 17:02:51 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Alban Gruin <alban.gruin@gmail.com>
Subject: Re: [PATCH v2 2/3] rebase -i: re-fix short SHA-1 collision
References: <pull.529.git.1579209506.gitgitgadget@gmail.com>
        <pull.529.v2.git.1579304283.gitgitgadget@gmail.com>
        <102fa568dc09c1faa2d36903ccb7e1b285dd50b2.1579304283.git.gitgitgadget@gmail.com>
        <CAPig+cT8t39UvnF2i6CDoHW4kfEGr-CRFxZKOCstCTU0YzrCgQ@mail.gmail.com>
        <nycvar.QRO.7.76.6.2001202103221.46@tvgsbejvaqbjf.bet>
        <CAPig+cR2T26nJ1G5n82r_Xi8Y84k211n6bhBxG4Ku27vaW1pWA@mail.gmail.com>
Date:   Tue, 21 Jan 2020 14:02:50 -0800
In-Reply-To: <CAPig+cR2T26nJ1G5n82r_Xi8Y84k211n6bhBxG4Ku27vaW1pWA@mail.gmail.com>
        (Eric Sunshine's message of "Mon, 20 Jan 2020 15:08:15 -0500")
Message-ID: <xmqqpnfc8o39.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C4A62382-3C99-11EA-A3F6-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Sunshine <sunshine@sunshineco.com> writes:

> On Mon, Jan 20, 2020 at 3:04 PM Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
>> On Mon, 20 Jan 2020, Eric Sunshine wrote:
>> > On Fri, Jan 17, 2020 at 6:38 PM Johannes Schindelin via GitGitGadget
>> > <gitgitgadget@gmail.com> wrote:
>> > > +       test $colliding_sha1 = "$(git rev-parse HEAD | cut -c 1-7)" &&
>> >
>> > How much do we care that this is introducing new code with git
>> > upstream of a pipe (considering recent efforts to eradicate such
>> > usage)? Same question regarding several other new instances introduce
>> > by this patch.
>>
>> I would argue that the test case will fail if the `git` call fails. So I
>> am not overly concerned if that `git` call is upstream of a pipe.
>
> Unless the git command crashes _after_ it produces the correct output...

True.  Doesn't rev-parse have an appropriate option for this kind of
thing that gets rid of the need for "cut" in the first place?
