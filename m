Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E51BC2B9F8
	for <git@archiver.kernel.org>; Tue, 25 May 2021 05:48:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2460C6140F
	for <git@archiver.kernel.org>; Tue, 25 May 2021 05:48:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230511AbhEYFt3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 25 May 2021 01:49:29 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:62324 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230218AbhEYFt2 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 May 2021 01:49:28 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 55E4C129910;
        Tue, 25 May 2021 01:47:59 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=wncNs/rxeT+06OoGt/L4AFmnqPuBN2WRqApU9Q
        msvCc=; b=mNAaa7rYZEDlMMQeo5G27DE1dC+p540HIsplPAvgdBamdVLgJBRUeR
        ZnTG4T4RbkPCWrXDKaYrlfMUAlrescPQ8uN0HVdSDK3MZQmASQlMFVzRMVMCN+O0
        ouG3dIPWmB1UzPZ2fQPwQ0ckjDEprNlPBGTK2X6MObfEMigxN9Uyg=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 4E66E12990F;
        Tue, 25 May 2021 01:47:59 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.73.10.127])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 7D2A512990D;
        Tue, 25 May 2021 01:47:56 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>,
        Hariom Verma <hariom18599@gmail.com>,
        Karthik Nayak <karthik.188@gmail.com>,
        ZheNing Hu <adlternative@gmail.com>
Subject: Re: [PATCH 2/3] [GSOC] ref-filter: support %(contents) for blob, tree
References: <pull.959.git.1621763612.gitgitgadget@gmail.com>
        <19413cfdb1ea50de401ab958b954a550b6514688.1621763612.git.gitgitgadget@gmail.com>
        <xmqqfsybh0bn.fsf@gitster.g>
Date:   Tue, 25 May 2021 14:47:54 +0900
In-Reply-To: <xmqqfsybh0bn.fsf@gitster.g> (Junio C. Hamano's message of "Tue,
        25 May 2021 14:03:24 +0900")
Message-ID: <xmqqa6ojgy9h.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C155D01A-BD1C-11EB-AAE7-D5C30F5B5667-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> As I already said, I do not think %(contents) mixes well with this
> use for trees and blobs where you give the raw bytes, since
> %(contents) for commit and tag objects was never about the full byte
> sequence of the object.  It was to give the unstructured part meant
> for human consumption, stripping the structured "header" part of the
> object.

To extend on this point a bit (even though this is not all that
urgent during the prerelease freeze), conceptually, the %(content)
field is understood in the larger picture like this:

+--- (the whole thing) ----------------------------------------------+
|                                                                    |
| +--- "header" ---------------------------------------------------+ |
| | tree 678c03dca0a26afd746e8c8bb9e4aadc8bf479b1                  | |
| | parent 378c7c6ad48c4ccddf9b534616a0e86f28440bd3                | |
| | author Junio C Hamano <gitster@pobox.com> 1621675665 +0900     | |
| | committer Junio C Hamano <gitster@pobox.com> 1621675741 +0900  | |
| +----------------------------------------------------------------+ |
|                                                                    |
| +--- "contents" -------------------------------------------------+ |
| |                                                                | |
| | +--- "subject" ----------------------------------------------+ | |
| | | Git 2.32-rc1                                               | | |
| | +------------------------------------------------------------+ | |
| |                                                                | |
| | +--- "body" -------------------------------------------------+ | |
| | | Signed-off-by: Junio C Hamano <gitster@pobox.com>          | | |
| | +------------------------------------------------------------+ | |
| |                                                                | |
| +----------------------------------------------------------------+ |
|                                                                    |
+--------------------------------------------------------------------+

Even though %(header), when it is invented, would make perfect sense
for commits and tags, it will never make sense for trees and blobs.
Which means "contents", which is "the whole thing except for the
header part", would not, either.

There is no %(placeholder) to ask for "the whole thing", and that is
what you want to use for cat-file --batch if I am not mistaken, and
adding one would be a good idea.  There is no %(header) yet, either,
but if somebody needs it for their scripts, it is clear where it fits
in the picture.

