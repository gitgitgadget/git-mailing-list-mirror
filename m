Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 532112047F
	for <e@80x24.org>; Wed, 20 Sep 2017 01:38:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751595AbdITBin (ORCPT <rfc822;e@80x24.org>);
        Tue, 19 Sep 2017 21:38:43 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:63950 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751336AbdITBim (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Sep 2017 21:38:42 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 2D8C79396E;
        Tue, 19 Sep 2017 21:38:41 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=vKkZYWoIZIwIgG90EdxR3Q7KnIk=; b=fxxlCm
        Gkap4xVfTp5ruaMX72aVe6n7EqQyL4uB8pgXPPo3d1thrOO7Yb1IAY4XrH8ewzWn
        4M5eLieR1TOZcwkdJuaaU0aAreqUBGUG9pRJMaQFYS7afn/+nx8QGj0W2sP2JfUJ
        XbBbhgM8Vrr+NvfanDeM532WRLpME34uf7ES4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=HAXZMldEZUGJQW8EnhaYFQnH+C1kUBdg
        l9/aAMnyApk0xPJqxMr1wDx8hB01PnXjfgiblkjjLbPtpXcm8fMqs5Kjw9/E/nWp
        It8LiW1Bk/iul4tQJYPCi8vxKobyntzztw4a6481EUaW4wO/TPR4oMEzJafryxT/
        0lUSxxeF3kQ=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 255379396D;
        Tue, 19 Sep 2017 21:38:41 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 8B1BE9396B;
        Tue, 19 Sep 2017 21:38:40 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
Cc:     Michael Haggerty <mhagger@alum.mit.edu>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Alex Riesen <raa.lkml@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH] for_each_string_list_item(): behave correctly for empty list
References: <cb2d4d71c7c1db452b86c8076c153cabe7384e28.1505490776.git.mhagger@alum.mit.edu>
        <20170915184323.GU27425@aiede.mtv.corp.google.com>
        <b8951886-feab-a87a-9683-3c155cfa98a8@alum.mit.edu>
        <b03c7b09-853f-a2ed-f73e-7d946c90cedb@gmail.com>
Date:   Wed, 20 Sep 2017 10:38:39 +0900
In-Reply-To: <b03c7b09-853f-a2ed-f73e-7d946c90cedb@gmail.com> (Kaartic
        Sivaraam's message of "Tue, 19 Sep 2017 20:08:06 +0530")
Message-ID: <xmqq4lryqhcw.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 6E1FB3A2-9DA4-11E7-8E0E-9D2B0D78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Kaartic Sivaraam <kaarticsivaraam91196@gmail.com> writes:

> On Saturday 16 September 2017 09:36 AM, Michael Haggerty wrote:
>>> Does the following alternate fix work?  I think I prefer it because
>>> it doesn't require introducing a new global. [...]
>>>   #define for_each_string_list_item(item,list) \
>>> -	for (item = (list)->items; item < (list)->items + (list)->nr; ++item)
>>> +	for (item = (list)->items; \
>>> +	     (list)->items && item < (list)->items + (list)->nr; \
>>> +	     ++item)
>> This is the possibility that I was referring to as "add[ing] overhead to
>> each iteration of the loop". I'd rather not add an extra test-and-branch
>> to every iteration of a loop in which `list->items` is *not* NULL, which
>> your solution appears to do. Or are compilers routinely able to optimize
>> the check out?
>
> It seems at least 'gcc' is able to optimize this out even with a -O1
> and 'clang' optimizes this out with a -O2. Taking a sneak peek at
> the 'Makefile' shows that our default is -O2.

But doesn't the versions of gcc and clang currently available do the
right thing with the current code without this change anyway?  I've
been operating under the assumption that this is to future-proof the
code even when the compilers change to use the "NULL+0 is undefined"
as an excuse to make demons fly out of your nose, so unfortunately I
do not think it is not so huge a plus to find that the current
compilers do the right thing to the code with proposed updates.

