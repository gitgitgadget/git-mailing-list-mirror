Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B933AC4338F
	for <git@archiver.kernel.org>; Sat,  7 Aug 2021 07:15:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 93A1260E53
	for <git@archiver.kernel.org>; Sat,  7 Aug 2021 07:15:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231334AbhHGHPo (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 7 Aug 2021 03:15:44 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:56169 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231317AbhHGHPk (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 7 Aug 2021 03:15:40 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 9B49EF2682;
        Sat,  7 Aug 2021 03:15:22 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Oo9Gwv+GF/qqDoTB545xVSRcBChVDUQvL5e7/9
        uHcHc=; b=Qzh4VmjdHXn99/YmDwB/s7i9S/BgRWSztn2LXsCXr3PfwlWYfpozyZ
        pqVRqb9Z8GNYxppxgOCgvG7Q2XuoUxJ8Ctgvxhg7dUplNAgBnvAiBLbVA3Nfu0rv
        9c1Q+DkVX23eaM9XA2mZPs/xm7swQ+i4sE3QnYFxmnAW9A1w5sLpM=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 79F93F2680;
        Sat,  7 Aug 2021 03:15:22 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.3.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id DF21FF267F;
        Sat,  7 Aug 2021 03:15:21 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     ZheNing Hu <adlternative@gmail.com>
Cc:     Git List <git@vger.kernel.org>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Jeff King <peff@peff.net>,
        Christian Couder <christian.couder@gmail.com>
Subject: Re: [GSOC][QUESTION] How to parse the properties of the object at once
References: <CAOLTT8Q8BEKCVwPDypW1w66P9_xP7QC0T-CnLqamqAL4haGzwA@mail.gmail.com>
Date:   Sat, 07 Aug 2021 00:15:20 -0700
In-Reply-To: <CAOLTT8Q8BEKCVwPDypW1w66P9_xP7QC0T-CnLqamqAL4haGzwA@mail.gmail.com>
        (ZheNing Hu's message of "Sat, 7 Aug 2021 14:32:51 +0800")
Message-ID: <xmqqzgttiv3r.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3A680C9A-F74F-11EB-BA17-8B3BC6D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

ZheNing Hu <adlternative@gmail.com> writes:

> This means that I shouldn't touch the content of struct commit. So I see the
> code of `commit-slab`, it seems that it is doing additional parsing.

We should keep what is in "struct commit" and parsing overhead to
the minimum, as it matters to performance (especially when auxiliary
data structures like commit-graph are not available for the part of
history).  If some pieces of data (like "from this byte to the end
is %(body)") do not matter in commit traversal, they are optional,
and (1) we should not always parse them out, instead we should do so
only on demand, and (2) we should not add members for them in the
commit object, but use commit slabs to store them.

As to the slab, it is not like you have to have a slab per these
optional fields you may want to parse.  If for example you need the
authorship ident and timestamp, even if you do not need committer
ident and timestamp, it is plausible to have a type of slab that
holds these four data items together (and only fill parts of them
that are actually requested by the callers).  Also, things that are
strings may want to be stored as a relative offset into the commit
buffer, instead of duplicated copies of string values.


