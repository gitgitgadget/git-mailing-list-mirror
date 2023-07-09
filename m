Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 098A5EB64DC
	for <git@archiver.kernel.org>; Sun,  9 Jul 2023 09:30:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230101AbjGIJ20 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 9 Jul 2023 05:28:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbjGIJ2Z (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 9 Jul 2023 05:28:25 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A01B91
        for <git@vger.kernel.org>; Sun,  9 Jul 2023 02:28:25 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 7EDF21A7047;
        Sun,  9 Jul 2023 05:28:22 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type
        :content-transfer-encoding; s=sasl; bh=Kmd8Q4v7Ah6EVnn97u+Pg1fIj
        D30W/gxJKB55qCpoFk=; b=Bv2lYL5anDrx0AsgtkQor2eaJRLPyGtWYtnzZRZBA
        6ZE5Rn+hk9BJM9xvtHrV/kkLX297Jfpl3yJhz9CpRjr6/WpAhZ6exYILekRXfTSu
        f5226bAz/Px3n7IpsM8+KO4tRUoqoGi9+ZhU4HF/Yjo2bktgBMAvwmmEt+TihsUu
        TY=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 66A721A7045;
        Sun,  9 Jul 2023 05:28:22 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.127.75.226])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 9AB891A7044;
        Sun,  9 Jul 2023 05:28:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 2alt/2] dir: match "attr" pathspec magic with correct paths
References: <20230707220457.3655121-1-gitster@pobox.com>
        <20230707220457.3655121-3-gitster@pobox.com>
        <xmqqttuf70bn.fsf_-_@gitster.g>
        <26f81ed0-8d1f-e0be-9696-25ce3938ae09@web.de>
        <xmqqh6qe5boa.fsf@gitster.g>
        <39d5e14d-f2e9-e619-c3e8-e63c7547370b@web.de>
Date:   Sun, 09 Jul 2023 02:28:19 -0700
Message-ID: <xmqqzg454eoc.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: F1AA8748-1E3A-11EE-BCB1-307A8E0A682E-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ren=C3=A9 Scharfe <l.s.r@web.de> writes:

>> This "common leading prefix" optimization has two main features:
>>
>>  * discard the entries in the in-core index that are outside of the
>>    common leading prefix; if you are doing "ls-files one/a one/b",
>>    we know all matches must be from "one/", so first the code
>>    discards all entries outside the "one/" directory from the
>>    in-core index.  This allows us to work on a smaller dataset.
>>
>>  * allow skipping the comparison of the leading bytes when matching
>>    pathspec with path.  When "ls-files" finds the path "one/a/1" in
>>    the in-core index given "one/a" and "one/b" as the pathspec,
>>    knowing that common leading prefix "one/" was found lets the
>>    pathspec matchinery not to bother comparing "one/" part, and
>>    allows it to feed "a/1" down, as long as the pathspec element
>>    "one/a" gets corresponding adjustment to "a".
>> ...
> With your big patch 2:
> ...
> The difference to main is small enough to get lost in the noise.
>
> The one-line fix is nice and surgical, but I like the other one more.
> Gets rid of crusty underutilized code that doesn't even seem to make
> a measurable difference.

Your benchmark matches my intuition, in that the main benefit of the
optimization comes from discarding the in-core cache entries outside
the area covered by the common prefix, and not from being able to
skip comparing a leading bytes.  The value in code simplification
the larger change has may want to be pursued later, but I'd rather
see us make a small "fix" that can be merged down to 'maint' first.

Thanks.
