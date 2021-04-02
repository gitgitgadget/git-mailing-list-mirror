Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02C53C433B4
	for <git@archiver.kernel.org>; Fri,  2 Apr 2021 21:31:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C9C906115C
	for <git@archiver.kernel.org>; Fri,  2 Apr 2021 21:31:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235668AbhDBVbn (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 2 Apr 2021 17:31:43 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:56537 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234821AbhDBVbl (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Apr 2021 17:31:41 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 098EAC8CA3;
        Fri,  2 Apr 2021 17:31:40 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=Mn+KSZuhF7xc
        T6jLaqd21mcy7VE=; b=sdFfYic4CcJy5tmsI2zLizxOUfaPaK3BwnNOduSCdJ+z
        0twPTVyPw5U8CX8e9OzgrtKVtYVKgMtXC/pSgd7vjz6P6GIQ2vJK441Ql3tiQD+B
        ROI6trXCvnMFIMQVVRWHN0YpiwXKIu0PGkVQrsAZkQ1elUqX1v3NH1BwWa3z6kA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=MKuSZ9
        vpCbUVgiXwEN91MyFksrb9sLghv4jBGRcpikNButkSBq97ClBwc6Js1bkmBE18Ce
        uN/+hXs5qf1TADKzk+liggwa2w3sp1wu7Dm9Rh3xq00FL32VNG9jZBBF63/dzpi2
        0kyZPqt/2qO2O+WlZZslbxIV4JtzKT2yuADCo=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 01878C8CA2;
        Fri,  2 Apr 2021 17:31:40 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 89101C8CA1;
        Fri,  2 Apr 2021 17:31:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Emily Shaffer <emilyshaffer@google.com>
Subject: Re: [PATCH 1/2] git-send-email: replace "map" in void context with
 "for"
References: <YGTt2cNwq3BlpB7n@google.com>
        <cover-0.3-00000000000-20210402T112946Z-avarab@gmail.com>
        <patch-1.3-bea11504a67-20210402T112946Z-avarab@gmail.com>
Date:   Fri, 02 Apr 2021 14:31:38 -0700
In-Reply-To: <patch-1.3-bea11504a67-20210402T112946Z-avarab@gmail.com>
 (=?utf-8?B?IsOGdmFyCUFybmZqw7Zyw7A=?= Bjarmason"'s message of "Fri, 2 Apr
 2021 13:34:33 +0200")
Message-ID: <xmqqo8ew2x1h.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: CF6893B8-93FA-11EB-83BC-D152C8D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> While using "map" instead of "for" or "map" instead of "grep" and
> vice-versa makes for interesting trivia questions when interviewing
> Perl programmers, it doesn't make for very readable code. Let's
> refactor this loop initially added in 8fd5bb7f44b (git send-email: add
> --annotate option, 2008-11-11) to be a for-loop instead.

;-)

Will queue.  Thanks.
