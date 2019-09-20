Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8FEC61F463
	for <e@80x24.org>; Fri, 20 Sep 2019 20:38:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728982AbfITUib (ORCPT <rfc822;e@80x24.org>);
        Fri, 20 Sep 2019 16:38:31 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:62720 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727963AbfITUib (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Sep 2019 16:38:31 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 5CC7380A4A;
        Fri, 20 Sep 2019 16:38:29 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=w48JckkKKGkug4otSnc/uK1oNzs=; b=Tv/Csw
        Cs7SjCDO3FipbJbKfYvYSsZmrnHyrRLm3LBlP5Jxru6rM2r8a5QJTFtxhgtNAW7c
        joeubsBMO+l30N4uA8k5NU5slU8hUCSNXGQRzAGw4cMeahOQPQBF1PCHD+5UCUae
        1Oe2t6PGJaXkVquoeYqTAA7G16qEHhGeudHWI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Lab2RIjR/ZwtZ1FGCKZT9FL1yt8xrnAw
        jpNgWXfIqa7Q8EIho3Bd0wrHcGapg1MBJ8xa0MFi+T/1NIAW7NDQ1F7eND3cT1oP
        KeFCvG89/7bFljuZCXT2B3GMOiUZ8LfJx0STYKNyCW65r9ip5+5nKYfmLr0WlCTX
        MCQHeNJHn4c=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 53B0F80A48;
        Fri, 20 Sep 2019 16:38:29 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 832D680A47;
        Fri, 20 Sep 2019 16:38:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, newren@gmail.com, szeder.dev@gmail.com
Subject: Re: [PATCH v2] merge-recursive: symlink's descendants not in way
References: <xmqqzhiyvqhe.fsf@gitster-ct.c.googlers.com>
        <20190920202506.74644-1-jonathantanmy@google.com>
Date:   Fri, 20 Sep 2019 13:38:24 -0700
In-Reply-To: <20190920202506.74644-1-jonathantanmy@google.com> (Jonathan Tan's
        message of "Fri, 20 Sep 2019 13:25:06 -0700")
Message-ID: <xmqq8sqiu2in.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 98E3B0F2-DBE6-11E9-9131-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

>> OK.  We notice that we need to newly create foo/bar but we
>> incorrectly find that there is "foo/bar" already because of the
>> careless use of bare lstat(2) makes "bar" visible as if it were also
>> "foo/bar".  I wonder if the current code would be confused the same
>> way if the side branch added "foo/bar/file", or the confusion would
>> be even worse---it is not dir_in_way() and a different codepath
>> would be affected, no?
>
> I don't think there is a different codepath to be affected - as far as I
> can tell, dir_in_way() is the only cause (at least of this particular
> error).

OK, so existing code already realizes that "foo/bar/file" added in
the side branch is the one that must survive, and the "bar/file" in
the current branch does not fool it into thinking that "foo/bar/file"
is also on our end, and needs to be merged as an add-add conflict.
It was only the dir-in-the-way logic that was not careful enough?

In that case, thanks for a very good news and for a careful analysis.
