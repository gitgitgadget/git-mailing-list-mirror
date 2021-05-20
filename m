Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BD97C433B4
	for <git@archiver.kernel.org>; Thu, 20 May 2021 05:02:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3BC9760E0C
	for <git@archiver.kernel.org>; Thu, 20 May 2021 05:02:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229534AbhETFDs (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 May 2021 01:03:48 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:61817 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbhETFDs (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 May 2021 01:03:48 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E4708D3DC4;
        Thu, 20 May 2021 01:02:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=xGO65wLLrOSCWp/po8wwS/1XrIkkWbOtWgPbFj
        yBQcI=; b=mfekA/F8Ut482iaO3Ckq4Jfqd3nZmaI8h8osTfDL8cPbdtLxypdkhs
        HHGEcA+/UGrKAhzp3XitbZ/ds5+uZwZih1qkCCshCat1x8pgcyAvgYCl11MiQEoq
        vog2kM2Aa2VcHXFgHhiB2siyartxLZNwRYN6bSDcOKZZd8pfWdOpg=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id DB43AD3DC3;
        Thu, 20 May 2021 01:02:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.73.10.127])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 59630D3DC2;
        Thu, 20 May 2021 01:02:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] revisions(7): clarify that most commands take a single
 revision range
References: <xmqqv97g2svd.fsf@gitster.g>
        <ab2d8b16-42db-9675-083a-efa7cfca6e4c@gmail.com>
        <xmqqh7iyuhlp.fsf@gitster.g>
Date:   Thu, 20 May 2021 14:02:25 +0900
In-Reply-To: <xmqqh7iyuhlp.fsf@gitster.g> (Junio C. Hamano's message of "Thu,
        20 May 2021 13:58:10 +0900")
Message-ID: <xmqqcztmuhem.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 91FA0C0C-B928-11EB-A3FD-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Bagas Sanjaya <bagasdotme@gmail.com> writes:
>
>> On 18/05/21 18.17, Junio C Hamano wrote:
>>> ...
>>> +In other words, writing two "two-dot range notation" next to each
>>> +other, e.g.
>>> +
>>> +    $ git log A..B C..D
>>> +
>>> +does *not* specify two revision ranges for most commands.  Instead
>>> +it will name a single connected set of commits, i.e. those that are
>>> +reachable from either B or D but are reachable from neither A or C.
>>> +In a linear history like this:
>>> +
>>> +    ---A---B---o---o---C---D
>>> +
>>
>> So "git log A..B C..D" is same as "A..D", right?
>
> A..B C..D is equivalent to ^A ^C B D, and in order to be part of the
> set it represents, a commit must not be reachable from A, must not
> be reachable from C, and must be reachable from B or D.
>
> In the picture, A, B and two o's are all reachable from C, therefore
> are not part of the set A..B C..D represents.  Neither is C, as it
> is reachable from C.  That leaves only D in the resulting range.
>
> A..D is a set of connected five commits, B o o C D in the above
> picture.
>
> So, no.
>
> The confusion we often see goes more like "The set A..B contains B
> (and nothing else), and C..D contains D (and nothing else), hence
> 'git log A..B C..D' would show B and D".  But that is not what
> happens because "git log" (like most other commands) takes just a
> "range" that is "A..B C..D", which is a set of connected commits
> each of whose member is reachable from one of the "positive"
> endpoints (like B and D) and is not reachable from any of the
> "negative" endpoints (like A and C).

Well, apparently the proposed text may have failed to educate you
about what a "revision range" is and how it works, so it is not good
enough, so I'll postpone merging the change down further and see if
somebody else can come up with a better description.

Thanks.
