Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53C0AC47082
	for <git@archiver.kernel.org>; Tue,  8 Jun 2021 06:50:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2D6E46108D
	for <git@archiver.kernel.org>; Tue,  8 Jun 2021 06:50:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230223AbhFHGwY (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Jun 2021 02:52:24 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:51786 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbhFHGwX (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Jun 2021 02:52:23 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 5AE3F144D26;
        Tue,  8 Jun 2021 02:50:29 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=t75jCungff8F+Zhpt6E5ALDiHbMDh0oe9iDGFFSeylk=; b=DPLs
        XjZldJ9L2dQKGbTwOw6B+cAMPRFHazQNYkr9znXLCdje/CD6j3vriAYDwd/FAm8l
        SqUWeKn9xZEr5mdZu7si+rsXjE7dYgwwrwxBNffq4gjJ3DhECyxCJgh+BkTOfKHy
        +9zo40wvR2T6gmDpMonL5tbYECuZxSmH+NZBN5I=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 539E8144D24;
        Tue,  8 Jun 2021 02:50:29 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.196.172.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id A3652144D22;
        Tue,  8 Jun 2021 02:50:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     ZheNing Hu <adlternative@gmail.com>
Cc:     ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>,
        Hariom Verma <hariom18599@gmail.com>
Subject: Re: [PATCH 4/6] [GSOC] ref-filter: add %(rest) atom and --rest option
References: <pull.972.git.1622884415.gitgitgadget@gmail.com>
        <ccdd18ad508824aa206a02c479229d0ede69522d.1622884415.git.gitgitgadget@gmail.com>
        <xmqq7dj6w7a6.fsf@gitster.g>
        <CAOLTT8S+5m+-XF-AcQi9t8njTvyDYzHt=BU+4OPcvTT27RP6dw@mail.gmail.com>
Date:   Tue, 08 Jun 2021 15:50:25 +0900
Message-ID: <xmqqo8cgq28e.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: CE62FE40-C825-11EB-A9D9-FA9E2DDBB1FC-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

ZheNing Hu <adlternative@gmail.com> writes:

> First of all, although %(rest) is meaningless in ordinary circumstances,
> ref-filter must learn %(rest), it is impossible for us to leave the parsing
> of %(rest) in cat-file.c alone.

Oh, there is no question about that.

> Then, `--rest` is a strategy that make %(rest) can use in `git for-each-ref`
> or `git branch -l`.

If there is no need to expose %(rest) to the users who write
--format for these two commands, it would be much better to detect
attempted use of %(rest) and error out.

> This sounds like it might help `cat-file` to reject some useless atoms
> like %(refname).

Yes.

> So something like:
>
> $ git for-each-ref --format="%(objectname) %(objectsize)"
> --refject-atoms="%(objectsize) %(objectname)"
>
> will fail.

I don't understand.  Why do you even need to add --reject?  Why
would any user would want to use it with for-each-ref?

Without any end-user input, %(rest) for for-each-ref would not make
sense, and %(refname) for cat-file --batch would not make sense, I
would imagine, so there is no need to be able to tell --reject=rest
to for-each-ref.  It is not like giving --no-reject=rest to for-each-ref
and make it interpolate to an empty string is a useful feature anyway,
so I do not see a need for such an option.
