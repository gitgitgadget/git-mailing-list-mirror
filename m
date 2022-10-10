Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F22DC433F5
	for <git@archiver.kernel.org>; Mon, 10 Oct 2022 16:55:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229641AbiJJQzn (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 Oct 2022 12:55:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229616AbiJJQzm (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Oct 2022 12:55:42 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C2EB1D666
        for <git@vger.kernel.org>; Mon, 10 Oct 2022 09:55:41 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 4EC19142556;
        Mon, 10 Oct 2022 12:55:40 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=ACwMV7icfdwL
        GXd7HF/awv1KmhXNNRajxmD4A5pr4ng=; b=BmJ6hAsZdTWgwm89NiGN7VBrRGZI
        HBfmThlCVNkjOr2pxiXo11KuYu+sCVzE01Ve3RaFFojDUf6CC0AzVW2li652h36z
        j+M81wizcX58/53Z645czw9TlZ2ZYjCdkL8CmsNypRJxChCdAcp1p8yPBf5/yhJA
        3EBZSMDjw5D13xY=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 46A56142555;
        Mon, 10 Oct 2022 12:55:40 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id AAC50142554;
        Mon, 10 Oct 2022 12:55:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Rub=C3=A9n?= Justo <rjusto@gmail.com>
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v5] branch: support for shortcuts like @{-1}, completed
References: <pull.1346.git.1662388460.gitgitgadget@gmail.com>
        <93b0b442-b277-66a6-3f5f-5a498593aa07@gmail.com>
        <7abdb5a9-5707-7897-4196-8d2892beeb81@gmail.com>
        <2e164aea-7dd8-5018-474a-01643553ea49@gmail.com>
        <de200fa0-379d-c1ce-8446-9e4292d0b66a@gmail.com>
        <xmqqa6647qx2.fsf@gitster.g>
        <dacb1f40-2765-5978-1131-f78ba919e6e6@gmail.com>
        <xmqq4jwc5x7y.fsf@gitster.g>
        <bf4a45cb-2f44-88bd-e12e-98ca31d5bbd4@gmail.com>
Date:   Mon, 10 Oct 2022 09:55:38 -0700
In-Reply-To: <bf4a45cb-2f44-88bd-e12e-98ca31d5bbd4@gmail.com>
 (=?utf-8?Q?=22Rub=C3=A9n?= Justo"'s
        message of "Mon, 10 Oct 2022 08:05:26 +0200")
Message-ID: <xmqqzge34nzp.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 5EA37544-48BC-11ED-BF34-2AEEC5D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Rub=C3=A9n Justo <rjusto@gmail.com> writes:

>> If we have a big common clean-up after each operation, then, falling
>> through in the success case might be good, but that is not what I am
>> seeing here.  So...
>>=20
>
> I would like to see some kind of free(head) in a clean-up to not get
> distracted with that.  Not a proper leak though and the leak checkers
> does not refer to that as leak.  So not important.  We can go with the
> unconditional return and let the dust settle.

"head" is not leaking, as a pointer to it is head in a location that
is still in scope (namely, a file-scope global variable) when the
program exits.

In fact, the only thing the code before or after this patch does
after leaving this top-level if/elseif/else cascade is to return 0
and doing nothing else.  Inserting free(head) would be an unneeded
distraction for human developers (doing such a patch, reviewing, and
even worse, having to read the resulting code in the coming years)
and waste of computer resources (exiting the process will reclaim
such a piece of memory just fine).

